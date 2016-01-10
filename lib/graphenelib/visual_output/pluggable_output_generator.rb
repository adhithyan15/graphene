module GrapheneLib
  ##
  # VisualOutput module allows users to see a visual representation of their
  # Graph network through the use of one or more pluggable output generators.
  # There are only three formats that are being considered for output
  # generation
  #
  # * pdf
  # * jpg/png
  # * interactive html
  #
  # To help in the creation of pluggable output generators, this module
  # provides an interface class called PluggableOutputGenerator. This module
  # is not being designed with visualizing really large networks. Producing
  # accurate visualizations of really large networks is a very difficult task
  # and that is not the primary goal of Graphene. So if you try to visualize
  # really large networks, you will see crashes or performance degradation.
  module VisualOutput
    ##
    # PluggableOutputGenerator class provides the base set of methods
    # that each of its inheritants need to implement. It also does some
    # basic error checking for the other inheriting generators. There
    # are some guidelines provided below for how to implement your own
    # output generator if you don't like the bundled ones.
    class PluggableOutputGenerator
    end
  end
end
