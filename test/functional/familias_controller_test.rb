require File.dirname(__FILE__) + '/../test_helper'

class FamiliasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:familias)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_familia
    assert_difference('Familia.count') do
      post :create, :familia => { }
    end

    assert_redirected_to familia_path(assigns(:familia))
  end

  def test_should_show_familia
    get :show, :id => familias(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => familias(:one).id
    assert_response :success
  end

  def test_should_update_familia
    put :update, :id => familias(:one).id, :familia => { }
    assert_redirected_to familia_path(assigns(:familia))
  end

  def test_should_destroy_familia
    assert_difference('Familia.count', -1) do
      delete :destroy, :id => familias(:one).id
    end

    assert_redirected_to familias_path
  end
end
