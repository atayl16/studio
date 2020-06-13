require 'rails_helper'

RSpec.describe "artifacts/index", type: :view do
  before(:each) do
    assign(:artifacts, [
      Artifact.create!(
        :name => "Name",
        :key => "Key",
        :user => nil
      ),
      Artifact.create!(
        :name => "Name",
        :key => "Key",
        :user => nil
      )
    ])
  end

  it "renders a list of artifacts" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
