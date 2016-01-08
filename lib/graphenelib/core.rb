module Graphenelib
  ##
  # The graph class is the base class for the different types of graphs
  # to be supported by Graphene.
  #
  # For people unfamiliar with Graph data structures, a Graph is made
  # up of a set of nodes (containing some information) and a set of
  # connections between those nodes.
  #
  # @author Adhithya Rajasekaran <adhithyan15 at gmail dotcom>
  class Graph
    ##
    # Inorder to initialize a brand new Graph object, you don't need
    # to pass anything in. The Graph class uses the adjacency list
    # representation of Graphs. The current (naive) implementation
    # uses a Hash Table to implement this adjacency list. This will
    # be improved in the future. The adjacency list doesn't actually
    # store the node objects. It just stores the keys. The
    # actual objects are stored in another Hashtable.
    def initialize
      # adjacency_list (Hash object) will store the keys of the nodes added
      # to graph in an array with the key of the node that
      # they are adjacent to.
      @adjacency_list = {}

      # top_level nodes are the nodes that start the graph and other nodes
      # will be connected to these nodes. This key value pair is
      # necessary as the different graph algorithms require starting points
      # to walk the graphs.
      @adjacency_list['top_level'] = []

      # storage (hash object) stores the actual nodes and maps them to their
      # keys.
      @storage = {}

      # field or method name custom key reverse lookup storage
      @field_or_method_lookup = {}

      # length stores the number of nodes present in the
      @length = 0
    end

    ##
    # add_node method allows you to add a new node into the Graph.
    #
    # The node can be of any object type. Graphene doesn't do
    # typechecking on these objects. So it is your responsibility
    # to make sure that they are indeed valid objects for your use
    # case. The object's .hash method will be called and the returned
    # value will be used as the key by default. If you don't want
    # that behavior, please indicate a custom key by using the key
    # field. You can specify a custom key for each object that you
    # want to be added as a Node.
    #
    # The custom key will be used while searching and sorting elements '
    # in the Graph.The key can be a plain String value or it could indicate
    # the field or method name of the Object that you have passed in.
    # If you are intending to pass in a method or a field name of an
    # object, add "." in front of the String. If you don't do that
    # Graphene will interpret that as a custom String key that you
    # have passed into the add_node method.
    #
    # @param input [Object] A valid Ruby object.
    # @param key [String] A custom key for use in Graph algorithms (optional)
    # @return [nil] Nothing is returned.
    # @note Due to space restrictions imposed by rubocop, I am not able to
    #       provide detailed documentation for the errors here. But I have
    #       documented them heavily in their declaration files. So please
    #       read their entire documentation there. Thanks
    # @raise [NewNodeObjectCannotBeNilError] Nil object as input.
    # @raise [ObjectHasNoHashMethodError] No .hash method present in the input

    def add_node(input, key = '')
      # First check will be to see if the input is nil. Nil inputs are not
      # allowed as it doesn't make sense for the value of a node to be nil
      # value.
      if input.nil?
        error_message = 'A nil object was passed into the add_node method.'
        error_message += ' Nil objects cannot be added as nodes to a Graph.'
        error_message += ' Please pass in a non-nil object to add_node method.'
        fail NewNodeObjectCannotBeNilError, error_message
      else
        # The next check is to see if a key value is specified.
        if key == ''
          # If the key is empty, then we need to check and see if the
          # object responds to .hash method. If not, a error has to be
          # raised.
          unless input.respond_to? :hash
            error_message = 'The input object doesn\'t have a .hash method'
            error_message += 'and no custom key has been specified. Either '
            error_message += 'modify the object\'s class to have a .hash'
            error_message += 'method or pass in a custom key.'
            fail ObjectHasNoHashMethodError, error_message
          end

          # If the object does have a Hash method, then the .hash method
          # will be called and its hash code will be converted to String and
          # the object will be stored in the storage hash object.
          hashcode = input.hash.to_s

          # Uniqueness of all nodes in the Graph is being enforced currently.
          # This restriction might be eased in future releases.
          if @storage[hashcode].nil?
            @storage[hashcode] = input
          else
            error_message = 'An object with hashcode (key) ' + hashcode
            error_message += 'is already present on a Node this Graph. All '
            error_message += 'node objects in a Graph need to have unique '
            error_message += 'hashcodes. Please fix this issue before '
            error_message += 'proceeding.'
            fail NodeObjectNotUniqueError, error_message
          end
        elsif key.is_a?(String)
          # key parameter needs to be a String. The above condition verifies
          # that. If it is a String, then it can only be of two formats.
          # The first one being the plain string and the second one being
          # the name of the field or method that can be used to get the
          # actual custom key. Let us make sure that we have only those
          # kinds of Strings in the passed in key parameter.

          if key[0] == '.'
            # In this case we have a method or field value key
            # This needs to be checked to make sure that the provided
            # key actually corresponds to a field name or a method name

            # The only part we are really interested in is the letters
            # after the "." So redefining key without the first "."
            key = key[1..-1]
            
            unless input.respond_to?(key)
              error_message = "The value of key parameter (#{key}) passed into "
              error_message += 'the add_node method seemed to refer to a field '
              error_message += ' or method name in the input object. But when'
              error_message += ' tried to confirm that, no such field name or'
              error_message += ' method name was found. Can you please verify'
              error_message += ' that you have provided a valid field or method'
              error_message += ' method name.'
              fail FieldOrMethodNonExistentError, error_message
            end

            # The next check is once more a Security check. Since we are
            # going to be calling the user inputted field or method name
            # on the object, the user has the potential to cause severe
            # damage. So a list of method calls will be forbidden as they
            # can cause denial of service attacks. For more details, read
            # http://docs.ruby-lang.org/en/2.2.0/security_rdoc.html
            # Most of these methods are from the Kernel module which
            # all object inherit. So they will be banned.
            forbidden_commands_hash = Graph.forbidden_commands

            if forbidden_commands_hash[key]
              error_message = 'The value for key parameter passed into the '
              error_message += 'add_node method is forbidden for security '
              error_message += 'reasons. This incident will be reported.'
              fail SecruityViolationError, error_message
            end

            # There are two more checks that need to be carried out
            # before this field/method name can be added to Storage.
            # The first check will be to see if the field/method name
            # call returns a String

            unless input.send(key).is_a?(String)
              error_message = 'The field/method name passed into the key field'
              error_message += ' was executed. But it returned a non String'
              error_message += ' value. Please make sure that the name of field'
              error_message += '/method you passed in returns a String.'
              fail KeyValueNotStringError, error_message
            end

            # The second and final check is to see if the key is already
            # present

            hashcode = input.send(key)
            if @storage[hashcode].nil?
              @storage[hashcode] = input
              @field_or_method_lookup[hashcode] = key
            else
              error_message = 'An object with field/method name ' + key
              error_message += 'is already present on a Node this Graph. All '
              error_message += 'node objects in a Graph need to have unique '
              error_message += 'keys. Please fix this issue before '
              error_message += 'proceeding.'
              fail NodeObjectNotUniqueError, error_message
            end
          else
            # If the String value for key parameter doesn't have a "."
            # as the first character, then it must be a plain String
            # value. The only check that needs to happen is the
            # check for Uniqueness

            hashcode = key
            if @storage[hashcode].nil?
              @storage[hashcode] = input
            else
              error_message = 'An object with key ' + key
              error_message += 'is already present on a Node this Graph. All '
              error_message += 'node objects in a Graph need to have unique '
              error_message += 'keys. Please fix this issue before '
              error_message += 'proceeding.'
              fail NodeObjectNotUniqueError, error_message
            end

          end

        else
          error_message = 'The key parameter passed into the add_node'
          error_message += ' method is forbidden for security reasons.'
          error_message += ' This incident will be reported.'
          fail KeyValueNotStringError, error_message
        end
      end
    end

    ##
    # length method returns the total number of nodes added through
    # the add_node method. If you add a new Graph object as a node
    # there is no way for the class to know that as there is no
    # type checking done. You can force recomputation of the entire
    # Graph (including Graph objects on the node), pass in force
    # equal to true.
    #
    # @param force [Boolean] force recomputation of length through BFS
    # @return [Integer] Total number of nodes in the Graph

    def length(force = false)
      return @length
    end

    ##
    # directed? method is a placeholder method to be overridden by the
    # specific Graph Classes that are going to inherit this class. It
    # is supposed to tell you whether the graph object is directed
    # or not. Since a Graph is not directed by default, this method
    # will return false.
    #
    # @return [Boolean] Returns a boolean indicating a directed graph or not

    def directed?
      return false
    end

    ##
    # visual_output method is another placeholder method to be overridden by
    # the specific Graph classes that are going to inherit this class. It is
    # is supposed to output a picture representation of the Graph. The output
    # will be a PDF file or a JPG based on what ever you need. The output
    # will be generated through one of the pluggable backends.
    #
    # @param format [String] The format of the output. Supported - pdf, jpg
    # @return [nil] You should see `output.{format}` in your folder.

    def visual_output(format = 'pdf')

    end

    ##
    # forbidden_commands method is static method that returns a list of
    # forbidden commands that might be passed into the user inputted field
    # and method name for the add_node method. This is a static method as
    # duplicating this data across all the instances doesn't make sense.
    # @return [Hash] Hash of forbidden commands
    def self.forbidden_commands
      forbidden_commands_hash = {}
      forbidden_commands += %w(abort at_exit autoload autoload?)
      forbidden_commands += %w(binding block_given? callcc)
      forbidden_commands += %w(caller_locations catch chomp)
      forbidden_commands += %w(chop eval exec exit exit!)
      forbidden_commands += %w(fail fork format gets global_variables)
      forbidden_commands += %w(gsub iterator? lambda load local_variables)
      forbidden_commands += %w(loop open p printf print proc putc puts)
      forbidden_commands += %w(raise rand readline readlines require)
      forbidden_commands += %w(require_relative select set_trace_func)
      forbidden_commands += %w(sleep spawn sprintf srand sub syscall)
      forbidden_commands += %w(system test throw trace_var trap)
      forbidden_commands += %w(untrace_var warn)

      forbidden_commands.each do |command|
        forbidden_commands_hash[command] = true
      end
    end
  end
end