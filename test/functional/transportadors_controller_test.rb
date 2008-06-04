require File.dirname(__FILE__) + '/../test_helper'

class TransportadorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:transportadors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_transportador
    assert_difference('Transportador.count') do
      post :create, :transportador => { }
    end

    assert_redirected_to transportador_path(assigns(:transportador))
  end

  def test_should_show_transportador
    get :show, :id => transportadors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => transportadors(:one).id
    assert_response :success
  end

  def test_should_update_transportador
    put :update, :id => transportadors(:one).id, :transportador => { }
    assert_redirected_to transportador_path(assigns(:transportador))
  end

  def test_should_destroy_transportador
    assert_difference('Transportador.count', -1) do
      delete :destroy, :id => transportadors(:one).id
    end

    assert_redirected_to transportadors_path
  end
end
