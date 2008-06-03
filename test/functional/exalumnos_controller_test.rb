require File.dirname(__FILE__) + '/../test_helper'

class ExalumnosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:exalumnos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_exalumno
    assert_difference('Exalumno.count') do
      post :create, :exalumno => { }
    end

    assert_redirected_to exalumno_path(assigns(:exalumno))
  end

  def test_should_show_exalumno
    get :show, :id => exalumnos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => exalumnos(:one).id
    assert_response :success
  end

  def test_should_update_exalumno
    put :update, :id => exalumnos(:one).id, :exalumno => { }
    assert_redirected_to exalumno_path(assigns(:exalumno))
  end

  def test_should_destroy_exalumno
    assert_difference('Exalumno.count', -1) do
      delete :destroy, :id => exalumnos(:one).id
    end

    assert_redirected_to exalumnos_path
  end
end
