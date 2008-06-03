require File.dirname(__FILE__) + '/../test_helper'

class TelefonosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:telefonos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_telefono
    assert_difference('Telefono.count') do
      post :create, :telefono => { }
    end

    assert_redirected_to telefono_path(assigns(:telefono))
  end

  def test_should_show_telefono
    get :show, :id => telefonos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => telefonos(:one).id
    assert_response :success
  end

  def test_should_update_telefono
    put :update, :id => telefonos(:one).id, :telefono => { }
    assert_redirected_to telefono_path(assigns(:telefono))
  end

  def test_should_destroy_telefono
    assert_difference('Telefono.count', -1) do
      delete :destroy, :id => telefonos(:one).id
    end

    assert_redirected_to telefonos_path
  end
end
