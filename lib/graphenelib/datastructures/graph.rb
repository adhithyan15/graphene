module GrapheneLib
  module DataStructures
    ##
    # The graph class is the base class for the different types of graphs
    # to be supported by Graphene.
    #
    # For people unfamiliar with Graph data structures, a Graph is made
    # up of a set of nodes (containing some information) and a set of
    # connections between those nodes.
    #
    # @author Adhithya Rajasekaran <adhithyan15 at gmail dotcom>
    # @note Don't create objects from this class. Use the inherited classes like
    #       UnDirectedGraph or DirectedGraph. This is just an interface class.
    class Graph
      # As a very first step, we need to have access to the errors that will be
      # used this class. All the error messages reside in the
      # Graphenelib::Errors module. So we need to mixin the
      # GraphManipulationErrors module that contains all the errors that
      # correspond to creating and manipulating Graphs.
      include GrapheneLib::Errors::GraphErrors

      # The methods are implemented in the following order
      # * Class Level Methods
      # * Instance Level Methods

      # Class Level Methods

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

      # Instance Level Methods

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

        # arbitrary_data stores arbitrary key value pairs at the Graph
        # level.
        @arbitrary_data = {}

        # length stores the number of nodes present in the
        @length = 0
      end

      ##
      # add_node method is a placeholder method for implementing the logic
      # to add new nodes into a graph. Graph class doesn't implement
      # the add_node method.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def add_node(input, key = '')
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # remove_node method is a placeholder method for implementing logic
      # to remove a node from the Graph. Graph class doesn't implement the body
      # of the remove node method.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def remove_node(input_node)
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # add_edge method is a placeholder method for implementing logic to add
      # an edge between two nodes. The edges can be directed, undirected or multi
      # edged. The edges can also store arbitrary data in them. This is useful
      # for storing things like weights and other descriptors useful in
      # implementing certain algorithms.
      #
      # Graph class doesn't implement the body of the add_edge method.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.
      def add_edge(node_1, node_2, edge_attributes = {})
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # remove_edge method is a placeholder method for implementing logic to
      # remove an edge between two nodes.
      #
      # Graph class doesn't implement the body of the remove_edge method.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.
      def remove_edge(node_1, node_2)
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # add_data method allows you to add any arbitrary key value pairs into the
      # Graph object. You can use this store any arbitrary data that you might
      # want to store at the graph level. Some things that I can think of are
      # source of data stored in the Graph and other attribution related things.
      # If the key is already present in the Graph, then the value will be
      # updated with the new value. The arbitrary data is stored in a HashTable
      # in the Graph class and can be accessed as a method name on the Graph
      # Object through the use of the awesome method_missing feature in Ruby.
      #
      # => animal_kingdom = Graph.new
      # => animal_kingdom.add_data('data_src','https://www.wikipedia.org/')
      # => puts animal_kingdom.data_src
      # => https://www.wikipedia.org/
      #
      # There are some restrictions on the key name. It has to be a String.
      # It cannot contain any spaces. It cannot collide with the already
      # available instance method names. If there are spaces in the front and
      # rear of the key, then those will be automatically removed when
      # the key is being added to the Graph as data.
      #
      # The value parameter has to be non nil Object.
      #
      # @param key [String] The key for the arbitrary value.
      # @param value [Object] The value can be Object type. Cannot be null.
      # @param no_update [Boolean] If a key is already present in the Graph,
      #        then it will be updated with the new value. If you don't want
      #        that behavior, please force this parameter to be true. It will
      #        throw an exception instead of updating the previous value.
      # @return [nil] If the addition of data is successful, then it will not
      #         return anything.
      # @raise [GraphDataAdditionKeyIsNilError] The key parameter provided is nil.
      # @raise [GraphDataAdditionKeyIsNotStringError] The key parameter provided
      #        is not String.
      # @raise [GraphDataAdditionKeyStringHasSpacesError] The key parameter
      #        should be a single word. But multiple words were detected
      #        in the provided key paramter.
      # @raise [GraphDataAdditionKeyCollidesWithInstanceMethodNamesError] Read
      #        the full error description of the error page. But the error
      #        name leads you in the right direction.
      # @raise [GraphDataAdditionValueIsNilError] The value parameter provided is
      #        nil.
      # @raise [GraphDataAdditionValueNonUpdatableError] The key you provided
      #        already exists. Because of your specification of no_update = true,
      #        this error is being thrown. Please rescue this exception and deal
      #        with it.

      def add_data(key, value, no_update = false)
        # Doing a nil check first
        if key.nil?
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the key you have specified is nil. You need'
          error_message += ' to provide a non nil Object for that parameter.'
          error_message += ' Please fix this issue before proceeding!'
          fail GraphDataAdditionKeyIsNilError, error_message
        end

        # Next checking to see if the provided key is actually a String
        unless key.is_a?(String)
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the key you have specified doesn\'t seem to be'
          error_message += ' a String. You need to specify a String as the key'
          error_message += ' so that you will be able to retrieve it later. You'
          error_message += ' cannot really retrieve a non String object through'
          error_message += ' obj.key. Please fix this issue before proceeding!'
          fail GraphDataAdditionKeyIsNotStringError, error_message
        end

        # Next there are two checks done
        # First check is to see if the key is a single word or multiple words.
        # keys have to be single words to be used as method names.
        if key.lstrip.rstrip.split.count > 1
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the key you have specified has spaces in between.'
          error_message += ' This is not valid. Please remove the spaces'
          error_message += ' in between. If you need to use multiple words,'
          error_message += ' consider using underscores. Please fix this issue'
          error_message += ' before proceeding!'
          fail GraphDataAdditionKeyStringHasSpacesError, error_message
        # Second check is to see if the method names collide with the key name
      elsif self.methods.include?(key.lstrip.rstrip.to_sym)
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the key' + key + 'you have specified collides'
          error_message += ' with the name of an instance method of the Object.'
          error_message += ' That is not allowed. Choose a different key value. '
          error_message += ' To get a list of instance methods, run'
          error_message += ' {class_name}.instance_methods. That should give'
          error_message += ' give you a list of methods to avoid. Thanks!'
          err = error_message
          fail GraphDataAdditionKeyCollidesWithInstanceMethodNamesError, err
        end

        # The only check for the value is to see if the value is nil or not
        if value.nil?
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the value you have specified is nil. You need'
          error_message += ' to provide a non nil Object as a value to a key.'
          error_message += ' Please fix this issue before proceeding!'
          fail GraphDataAdditionValueIsNilError, error_message
        end

        # If the key parameter has whitespace before and after, then those
        # spaces will be removed.
        if no_update == false
          @arbitrary_data[key.lstrip.rstrip] = value
          return @arbitrary_data[key.lstrip.rstrip]
        else
          error_message = 'You are trying to add some data to the Graph object.'
          error_message += ' But the key you have specified is already exists'
          error_message += ' in the Graph data. Based on your request (through'
          error_message += ' the no_update parameter being true), we are raising'
          error_message += ' this exception. Please rescue this exception and '
          error_message += ' and deal with it gracefully!'
          fail GraphDataAdditionValueNonUpdatableError, error_message
        end
      end

      ##
      # remove_data removes some key from the Graph object. It
      # returns the data mapped to the key being removed. If the key doesn't
      # exist, it throws a GraphDataRemovalKeyNotFoundError
      #
      # @param key [String] The key to be removed from the Graph object
      # @return [Object] The copy of the data mapped to the key
      # @raise [GraphDataRemovalKeyNilError] The provided key parameter is nil
      # @raise [GraphDataRemovalKeyNotStringError] The provided key parameter is
      #        not a String.
      # @raise [GraphDataRemovalKeyNotFoundError] The provided key parameter was
      #        not found in the Graph object.
      def remove_data(key)
        # Output will hold the copy of the data mapped to the key being deleted
        output = nil

        # First check to see if the key nil and the second check to see if the
        # key parameter is a String.
        if key.nil?
          error_message = 'You are trying to remove some data to the Graph'
          error_message += ' object. But the key you have specified is nil.'
          error_message += ' You have to provide a String key as an input to'
          error_message += ' this method. Please fix this issue before'
          error_message += ' proceeding.'
          fail GraphDataRemovalKeyNilError, error_message
        elsif !key.is_a?(String)
          error_message = 'You are trying to remove some data to the Graph'
          error_message += ' object. But the key you have specified is not a'
          error_message += ' String. You have to provide a non-nil key as an'
          error_message += ' input to this method. Please fix this issue before'
          error_message += ' proceeding.'
          fail GraphDataRemovalKeyNotStringError, error_message
        end

        if @arbitrary_data[key.lstrip.rstrip].nil?
          error_message = 'You are trying to remove some data to the Graph'
          error_message += ' object. But the key you have specified is not'
          error_message += ' found on the Graph object. Make sure that you'
          error_message += ' are specifying a valid key that is present on'
          error_message += ' the Graph. You can view all the data stored on'
          error_message += ' Graph by calling {obj}.view_data.'
          fail GraphDataRemovalKeyNotFoundError, error_message
        else
          output = @arbitrary_data.delete(key.lstrip.rstrip)
        end

        return output
      end

      ##
      # view_data method returns the entire Hash of arbitrary data stored as
      # key value pairs. You can also request a specific key by passing in a
      # valid key parameter into the method. If you have stored a lot of
      # data in the Graph itself, this Hash might be huge. So your performance
      # might degrade. Users can expect the same behavior as this method
      # if they end up calling {obj}.{key} directly on the object itself.
      #
      # @param key [String] The key whose value will be outputted (optional)
      # @return [Object] If no key is passed in, the entire data stored
      #         will be returned as a Hash of key/value pairs. If a key is
      #         passed in an Object that was mapped to the key will be returned
      # @raise [GraphDataViewingKeyNotFoundError] The key specified is not
      #        present on the Graph.

      def view_data(key = '')
        # Empty key means nothing was passed in. So we can safely return the
        # entire arbitrary data hash.
        if key == ''
          return @arbitrary_data
        elsif @arbitrary_data[key.lstrip.rstrip].nil?
          error_message = 'You are trying to view some data stored in the Graph'
          error_message += ' object. But the key you have specified is not'
          error_message += ' found on the Graph object. Make sure that you'
          error_message += ' are specifying a valid key that is present on'
          error_message += ' the Graph. You can view all the data stored on'
          error_message += ' Graph by calling {obj}.view_data.'
          fail GraphDataViewingKeyNotFoundError, error_message
        else
          return @arbitrary_data[key.lstrip.rstrip]
        end
      end

      ##
      # To offer some syntactic sugar for users, the design doc specifies that
      # users should be able to access any data that they store at the Graph
      # level just by calling {obj}.{key}. This is can be achieved by using
      # the method_missing feature in Ruby. Since the {obj}.{key} will be a
      # call to a method that doesn't exist at the instance method level, it
      # will usually trigger an error message. But before the error message is
      # triggered, the method_missing method will be called. So if we override
      # the method_missing method for the object instance, then we should be
      # able to implement the feature described above. method_missing takes
      # standard arguments that are well documented in Ruby docs. So I will not
      # be redocumenting them here. If the key is not found, then the regular
      # ruby error of NoMethodError is shown.

      def method_missing(m, *args, &block)
        if @arbitrary_data[m.to_s].nil?
          super
        else
          return @arbitrary_data[m.to_s]
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
      # or not.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def directed?
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # undirected? method is a placeholder method to be overridden by the
      # specific Graph Classes that are going to inherit this class. It
      # is supposed to tell you whether the graph object is undirected
      # or not.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def undirected?
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

      ##
      # exists? method tells you whether or not a Node exists in the Graph.
      # This is yet another placeholder method that the inheriting classes
      # will override. So no implementation has been provided.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def exists?(input_node)
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end


      ##
      # visual_output method is another placeholder method to be overridden by
      # the specific Graph classes that are going to inherit this class. It is
      # is supposed to output a visual representation of the Graph. The output
      # will be a PDF file or a JPG based on what ever you need. The output
      # will be generated through one of the pluggable backends.
      #
      # @raise [DontUseGraphClassError] Graph class is designed as an interface
      #        class. So please use its inheritants.

      def visual_output(format = 'pdf')
        error_message = 'Graph class is supposed to be an interface class. '
        error_message += ' But Ruby doesn\'t provide interface classes. So'
        error_message += ' Graph is designed as a regular class. But don\'t'
        error_message += ' use it on its own. Use its inheritants like'
        error_message += ' UnDirectedGraph or DirectedGraph as they implement'
        error_message += ' a lot of features. Thanks!'
        fail DontUseGraphClassError, error_message
      end

    end
  end
end
