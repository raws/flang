task "assets:precompile" => "assets:stub_mongomapper"

task "assets:stub_mongomapper" do
  def MongoMapper.setup(*args)
    true
  end
end
