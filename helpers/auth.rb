class Chromatch < Sinatra::Base
  helpers do
    # Return current_user record if logged in
    def current_user
      @current_user ||= User.first(:token => session[:user]) if session[:user]
    end

    # check if user is logged in?
    def logged_in?
      !!current_user
    end

    # Require login to view page
    def login_required
      if logged_in?
        return true
      else
        flash[:info]          = 'Login required to view this page'
        session[:redirect_to] = request.fullpath #TODO: Use query string instead.
        redirect '/login'
        return false
      end
    end

    # Check user has admin flag
    def is_admin?
      return (logged_in? && current_user.admin?)
    end

    # Require admin flag to view page
    def admin_required
      if is_admin?
        return true
      else
        flash[:info] = 'Admin required to view this page'
        redirect '/'
        return false
      end
    end

    # Check logged in user is the owner    # was used this for blog editing.
    def is_owner?(owner_id)
      return (logged_in? and is_admin? || current_user.id.to_i==owner_id.to_i)
    end

    # Require ownership to view page
    def owner_required(owner_id)
      if is_owner?(owner_id)
        return true
      else
        flash[:info] = 'You do not own this document.'
        redirect '/'
        return false
      end
    end
  end
end
