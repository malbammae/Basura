class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :ensure_login





  protected
  def ensure_login
    @usuario =Usuario.last
    @dias = ['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado']
  end
end
