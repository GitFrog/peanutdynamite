module SessionsHelper

  def signed_in?
    !current_user.nil?
  end

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def current_user=(user)  #this is your 'set' for a Property
    @current_user = user
  end

  def current_user          #this is you 'get for a Property
    @current_user ||= user_from_remember_token
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end


end
