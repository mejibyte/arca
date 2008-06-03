require File.dirname(__FILE__) + '/../test_helper'

class FaltaDeAsistenciasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:falta_de_asistencias)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_falta_de_asistencia
    assert_difference('FaltaDeAsistencia.count') do
      post :create, :falta_de_asistencia => { }
    end

    assert_redirected_to falta_de_asistencia_path(assigns(:falta_de_asistencia))
  end

  def test_should_show_falta_de_asistencia
    get :show, :id => falta_de_asistencias(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => falta_de_asistencias(:one).id
    assert_response :success
  end

  def test_should_update_falta_de_asistencia
    put :update, :id => falta_de_asistencias(:one).id, :falta_de_asistencia => { }
    assert_redirected_to falta_de_asistencia_path(assigns(:falta_de_asistencia))
  end

  def test_should_destroy_falta_de_asistencia
    assert_difference('FaltaDeAsistencia.count', -1) do
      delete :destroy, :id => falta_de_asistencias(:one).id
    end

    assert_redirected_to falta_de_asistencias_path
  end
end
