require 'test_helper'

class SentencesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create, :sentence => { :title => 'Some title', :body => 'Some title'}
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
