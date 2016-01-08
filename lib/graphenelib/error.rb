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

  # If non String value is specified for the key parameter, then
  # KeyValueNotStringError will be raised.
  class KeyValueNotStringError < StandardError
  end
end
