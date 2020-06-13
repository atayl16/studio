require 'rails_helper'

RSpec.describe "artifacts/edit", type: :view do
  before(:each) do
    @artifact = assign(:artifact, Artifact.create!(
      :name => "MyString",
      :key => "MyString",
      :user => nil
    ))
  end

  it "renders the edit artifact form" do
    render

    assert_select "form[action=?][method=?]", artifact_path(@artifact), "post" do

      assert_select "input[name=?]", "artifact[name]"

      assert_select "input[name=?]", "artifact[key]"

      assert_select "input[name=?]", "artifact[user_id]"
    end
  end
end
