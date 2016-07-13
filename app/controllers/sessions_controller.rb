class SessionsController < ApplicationController

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to root_path
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end





# def create
#   if request.env["omniauth.auth"]
#     connection = Faraday.new("https://api.github.com")
#     connection.headers["Authorization"] = "token " + request.env["omniauth.auth"].credentials.token
#     @repositories = JSON.parse(connection.get("/user/repos").body)
#     render :index
#   else
#     redirect_to root_path
#   end
# end
