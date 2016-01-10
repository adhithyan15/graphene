module GrapheneLib
  module DataStructures
    ##
    # Node class is a thin wrapper around the Objects passed in by the
    # users to enhance those objects' functionality and also provide a
    # a number of useful methods for Graph algorithms.
    #
    # Each Node object has the following attributes
    # * data - The user provided Object is stored in this field
    # * custom_key - The original user provided key if any. Defaults to ''
    # * derived_key - The derived key either from calling .hash method or
    #   the custom key.
    # * node_data - A Hash to store arbitrary data at the Node level.
    # * graph - A reference to the Graph object to which this Node belongs
    #   to.
    class Node
      ##
      # initialize method takes in four arguments namely - input_data,
      # custom_key, derived_key and the reference to the graph object.
      # It returns nothing.
      #
      # @param input_data [Object] User provided data for the node
      # @param input_custom_key [String] User provided custom key for the node
      # @param input_derived_key [String] Actual key derived either from the
      #        the .hash method or through the processing of the custom_key
      # @param graph_ref [Graph] Reference to the parent Graph object to
      #        which this node belongs to.
      # @return [nil] Returns nothing. Initializes a new Node object.
      def initialize(input_data, input_custom_key, input_derived_key, graph_ref)
        @data = input_data
        @custom_key = input_custom_key
        @derived_key = input_derived_key
        @node_data = {}
        @graph = graph_ref
      end
    end
  end
end
