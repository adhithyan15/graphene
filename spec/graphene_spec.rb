require "../lib/graphenelib"

Graph = Graphenelib::Graph

describe Graph do
  before do
    @graph = Graph.new()
  end
  it "should return an empty graph on creation" do
    expect(@graph.length).to eq(0)
  end
  it "should raise an error if you try to add a nil object as a new node" do
    expect{@graph.add_node(nil)}.to raise_error(Graphenelib::NewNodeObjectCannotBeNilError)
  end
  it "should raise an error if duplicate elements are added into the Graph" do
    @graph.add_node(5)
    expect{@graph.add_node(5)}.to raise_error(Graphenelib::NodeObjectNotUniqueError)
  end
  it "should raise an error .puts is provided as a custom key" do
    expect{@graph.add_node(7,".puts")}.to raise_error(Graphenelib::FieldOrMethodNonExistentError)
  end
end
