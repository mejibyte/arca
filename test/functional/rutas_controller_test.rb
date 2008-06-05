require File.dirname(__FILE__) + '/../test_helper'

class RutasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:rutas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_ruta
    assert_difference('Ruta.count') do
      post :create, :ruta => { }
    end

    assert_redirected_to ruta_path(assigns(:ruta))
  end

  def test_should_show_ruta
    get :show, :id => rutas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => rutas(:one).id
    assert_response :success
  end

  def test_should_update_ruta
    put :update, :id => rutas(:one).id, :ruta => { }
    assert_redirected_to ruta_path(assigns(:ruta))
  end

  def test_should_destroy_ruta
    assert_difference('Ruta.count', -1) do
      delete :destroy, :id => rutas(:one).id
    end

    assert_redirected_to rutas_path
  end
end
