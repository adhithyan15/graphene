# See graphenelib.rb for modeule level documentation.
module Graphenelib
  ##
  # A nil value cannot be inserted into the Graph as a Node
  # So if a nil value is detected, then NewNodeObjectCannotBeNilError
  # will be thrown.
  class NewNodeObjectCannotBeNilError < StandardError
  end

  ##
  # If the input parameter is provided with anything other than
  # an object, the InputNotObjectError will be raised
  class InputNotObjectError < StandardError
  end

  ##
  # An input object to add_node method has to have a .hash method
  # to get the hash code or a custom key has to be provided
  # with the object to be used in Graph algorithms. If both of them
  # are absent, then you will get ObjectHasNoHashMethodError
  class ObjectHasNoHashMethodError < StandardError
  end

  ##
  # Nodes in the Graph must have unique keys. So if an Object has a
  # key that is already present in the Graph, the NodeObjectNotUniqueError
  # will be raised.
  class NodeObjectNotUniqueError < StandardError
  end

  ##
  # The custom key provided to the add_node method started with a
  # a '.' indicating that it was a name for a field or method
  # on the object provided as input. When trying to confirm that
  # Ruby reported that no such field or method was found on that object.
  # So this error was raised because of that. The error explanation
  # message should provide you the key in question for you to
  # identify and correct.
  class FieldOrMethodNonExistentError < StandardError
  end

  ##
  # Nodes in Graphs can be any objects. This is a great feature for
  # the users as they can represent any arbitrary data in Graph nodes.
  # But it presents a major headache for me as I will be unable to
  # design algorithms which can take into account this complexity.
  # My initial thought was that we could use the .hash method
  # which should theoretically generate unique hash values for each node
  # But most people are not going to bother with overriding the .hash
  # method in their own objects to produce unique values. So the compromise
  # was that people can define their own key parameter which will be used
  # in algorithms to search and sort nodes if they aren't satisfied with
  # the .hash method. The users can hard code the key or they can just
  # define a method in their classes to output the key and present the
  # name of that method to the add_node method for automatic evaluation.
  # This compromise leads to major security issue. Hardcoding the key
  # has no safety issues. It is the second option of allowing arbitrary
  # method names that causes severe security issues. To convert a String
  # into a method call, one has to use the .send method on the Object and
  # present it the name of the method as a String and pass in the parameters.
  # Since Ruby mixes the Kernel module into base class Object, all Kernel
  # methods are accesible through all Objects and their methods. This is
  # what allows us to use puts, raise and other nice goodies that we are used
  # to in Ruby inside method calls. This is also a big security flaw if not
  # handled properly. If arbitrary strings are just passed into the .send method
  # of an object, then an attacker can send in `exit!`, `abort` or other
  # kernel methods and can cause serious damage. This is why Graphene implements
  # a layer of safety in which all of the Kernel's methods are forbidden
  # from being called through the way of key parameter. If someone tries to
  # call a kernel method through this process, the SecruityViolationError
  # will be raised.
  class SecruityViolationError < StandardError
  end

  ##
  # If non String value is specified for the key parameter, then
  # KeyValueNotStringError will be raised.
  class KeyValueNotStringError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But
  # the key has to be a non nil Object. If the key is nil, then the
  # GraphDataKeyIsNilError will be thrown.
  class GraphDataAdditionKeyIsNilError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But
  # the key has to be a String. If the key is not a String, then the
  # GraphDataKeyIsNotStringError will be thrown.
  class GraphDataAdditionKeyIsNotStringError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But
  # the key has to be a String with out any spaces. This restriction allows
  # users to access the value of the key just by calling obj.key. If you pass
  # in a key with spaces, then you cannot really access it through this way.
  # So GraphDataKeyStringHasSpacesError will be thrown is spaces were found
  # in the passed in key parameter.
  class GraphDataAdditionKeyStringHasSpacesError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But
  # the key has to have a value that doesn't collide with the names
  # of instance methods of the class. By colliding we mean that the value
  # specified in the key parameter (minus spaces in the front and back) is
  # already the name of an instance method for the Object of a specific class
  # in question. If there is a collision, then
  # GraphDataKeyStringCollidesWithInstanceMethodNamesError will be
  # raised.
  class GraphDataAdditionKeyCollidesWithInstanceMethodNamesError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But if a key
  # has been already added with some value and the user tries to add the key
  # again, the value of the key is updated to the new value. But a
  # User can request the data stored in the Graph object to be non updatable
  # by passing a true value along with the key and value parameter. If a user
  # has passed in this parameter and tries to add an already existing
  # key, then the GraphDataValueNonUpdatableError will be raised.
  class GraphDataAdditionValueIsNilError < StandardError
  end

  ##
  # Arbitrary data can be stored on the Graph as key value pairs. But
  # the value has to be a non nil Object. If the value is nil, then the
  # GraphDataValueIsNilError will be thrown.
  class GraphDataAdditionValueNonUpdatableError < StandardError
  end

  ##
  # To remove data from the Graph's arbitrary data storage, you need to
  # provide a String key. If a nil is provided as an input to the key, then
  # GraphDataRemovalKeyNilError will be thrown.
  class GraphDataRemovalKeyNilError < StandardError
  end

  ##
  # To remove data from the Graph's arbitrary data storage, you need to
  # provide a String key. If a non String value is provided as an input to the key,
  # then GraphDataRemovalKeyNotStringError will be thrown.
  class GraphDataRemovalKeyNotStringError < StandardError
  end

  ##
  # To remove data from the Graph's arbitrary data storage, you need to
  # provide a String key that is present on the Graph. If you provide a key
  # that doesn't exist on the Graph, then GraphDataRemovalKeyNotFoundError
  # will be raised. 
  class GraphDataRemovalKeyNotFoundError < StandardError
  end

  ##
  # You need a specify a key that is already present on the Graph object to view
  # data associated with that key. If an invalid key is presented in the view_data
  # method, then the GraphDataViewingKeyNotFoundError will be thrown.
  class GraphDataViewingKeyNotFoundError < StandardError
  end

  ##
  # Graph base class was designed to provide a set of defaults and
  # method scaffolds for the UnDirectedGraph and DirectedGraph classes.
  # So Graph base class provides but doesn't implement some methods
  # and leave to its inheritants to implement those methods. But
  # for some reason, the users continue to call these methods
  # on the Graph class. So an error needs to be thrown to tell
  # them to not use the Graph class on its own and use its Inheritants
  class DontUseGraphClassError < StandardError
  end
end
