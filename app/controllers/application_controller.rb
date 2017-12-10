class ApplicationController < ActionController::Base
  #ataques de CSRF (CrossSite Request Forgery) consiste na manipulacao de Cookies. Como
  #a autenticacao e TokenBased, nao e necessario efetuar a validacao abaixo. 
  protect_from_forgery #with: :exception
end
