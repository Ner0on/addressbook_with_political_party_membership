require 'test_helper'

class AddressbooksControllerTest < ActionController::TestCase
  setup do
    @addressbook = addressbooks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:addressbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create addressbook" do
    assert_difference('Addressbook.count') do
      post :create, addressbook: { name: @addressbook.name }
    end

    assert_redirected_to addressbook_path(assigns(:addressbook))
  end

  test "should show addressbook" do
    get :show, id: @addressbook
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @addressbook
    assert_response :success
  end

  test "should update addressbook" do
    patch :update, id: @addressbook, addressbook: { name: @addressbook.name }
    assert_redirected_to addressbook_path(assigns(:addressbook))
  end

  test "should destroy addressbook" do
    assert_difference('Addressbook.count', -1) do
      delete :destroy, id: @addressbook
    end

    assert_redirected_to addressbooks_path
  end
end
