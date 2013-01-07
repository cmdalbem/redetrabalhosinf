class ApplicationController < ActionController::Base
  protect_from_forgery

  # Shouldn't we use method_names like this? Camel case is for classes and stuff
  def checkLogged
    if not user_signed_in?
      redirect_to new_user_session_path, alert: 'Deves estar logado pra fazer isso.'
      return
    end
  end

  def checkAuthorization(owner)
    if !owner.authorizes?(current_user)
      redirect_to root_path, alert: 'Desculpe, nao tens permissao pra fazer isso.'
    end
  end

  def check_admin
    if not (current_user && current_user.admin)
        not_found
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

end
