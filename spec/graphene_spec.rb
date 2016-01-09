require "../lib/graphenelib"

Graph = Graphenelib::Graph

# Graph class is designed as an interface class with only a few methods
# implemented fully to spec. So most of the following tests will be to
# to test errors when trying to manipulate plain Graph objects.

describe Graph do
  before do
    @graph = Graph.new()
  end
  it "should raise an error if you try to add a node to Graph" do
    expect{@graph.add_node(5)}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if you try to remove a node from Graph" do
    expect{@graph.remove_node(5)}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if you try to add an edge between nodes" do
    expect{@graph.add_edge(5,6)}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if you try to remove an edge between nodes" do
    expect{@graph.remove_edge(5,6)}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if you try to add data to Graph using a nil key" do
    expect{@graph.add_data(nil,6)}.to raise_error(Graphenelib::GraphDataAdditionKeyIsNilError)
  end
  it "should raise an error if you try to add data to Graph using a non String key" do
    expect{@graph.add_data(5,6)}.to raise_error(Graphenelib::GraphDataAdditionKeyIsNotStringError)
  end
  it "should raise an error if you try to add data to Graph using a multiword key" do
    expect{@graph.add_data("Hello World",6)}.to raise_error(Graphenelib::GraphDataAdditionKeyStringHasSpacesError)
  end
  it "should raise an error if you try to add data to Graph using to_s as key" do
    expect{@graph.add_data("to_s",6)}.to raise_error(Graphenelib::GraphDataAdditionKeyCollidesWithInstanceMethodNamesError)
  end
  it "should raise an error if you try to add data to Graph using nil as value" do
    expect{@graph.add_data("hello",nil)}.to raise_error(Graphenelib::GraphDataAdditionValueIsNilError)
  end
  it "should return 6 if you pass in `hello` as key and 6 as value to add_data" do
    expect(@graph.add_data("hello",6)).to eq(6)
  end
  it "should raise an error if you pass in `hello` as key and 6 as value again with no_update equals true" do
    expect{@graph.add_data("hello",6,true)}.to raise_error(Graphenelib::GraphDataAdditionValueNonUpdatableError)
  end
  it "should raise an error if you pass in nil as the key parameter into remove_data" do
    expect{@graph.remove_data(nil)}.to raise_error(Graphenelib::GraphDataRemovalKeyNilError)
  end
  it "should raise an error if you pass in 6 as the key parameter into remove_data" do
    expect{@graph.remove_data(6)}.to raise_error(Graphenelib::GraphDataRemovalKeyNotStringError)
  end
  it "should raise an error if you pass in `world` as the key parameter into remove_data" do
    expect{@graph.remove_data("world")}.to raise_error(Graphenelib::GraphDataRemovalKeyNotFoundError)
  end
  it "should return 6 when you pass in `hello` into the remove_data method" do
    @graph.add_data("hello",6)
    expect(@graph.remove_data("hello")).to eq(6)
  end
  it "should return a Hash object with data when view_data without any key parameter is called" do
    @graph.add_data("hello",6)
    expect(@graph.view_data).to eq({"hello" => 6})
  end
  it "should return 6 if the key `hello` is passed into view_data" do
    @graph.add_data("hello",6)
    expect(@graph.view_data("hello")).to eq(6)
  end
  it "should return 6 if the key `hello` is passed into view_data" do
    @graph.add_data("hello",6)
    expect(@graph.view_data("hello")).to eq(6)
  end
  it "should raise an error if the key `world` is passed into view_data" do
    @graph.add_data("hello",6)
    expect{@graph.view_data("world")}.to raise_error(Graphenelib::GraphDataViewingKeyNotFoundError)
  end
  it "should return 6 if the key `hello` is passed through message call" do
    @graph.add_data("hello",6)
    expect(@graph.hello).to eq(6)
  end
  it "should raise an error if the key `world` is passed through message call" do
    expect{@graph.world}.to raise_error(NoMethodError)
  end
  it "should return a length of 0" do
    expect(@graph.length).to eq(0)
  end
  it "should raise an error if a `.directed?` method is called" do
    expect{@graph.directed?}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if a `.undirected?` method is called" do
    expect{@graph.undirected?}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if a `.exists?` method is called" do
    expect{@graph.exists?(5)}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
  it "should raise an error if a `.visual_output` method is called" do
    expect{@graph.visual_output}.to raise_error(Graphenelib::DontUseGraphClassError)
  end
end
