class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username].to_s.strip
    password = params[:password].to_s

    password_file = Rails.root.join("Password.txt")

    user = File.readlines(password_file).filter_map do |line|
      details = line.strip.split(",", -1)
      next unless details.length == 3

      saved_username, saved_password, role = details
      next if saved_username.strip.empty?

      if saved_username.strip == username &&
         saved_password == password
        {
          username: saved_username.strip,
          role: role.strip
        }
      end
    end.first

    if user
      session[:username] = user[:username]
      session[:role] = user[:role]

      redirect_to home_path
    else
      flash.now[:alert] = "Invalid username or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Successfully logged out!"
  end
end
