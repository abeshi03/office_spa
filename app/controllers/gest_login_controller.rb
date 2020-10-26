class GestLoginController < ApplicationController
  def new_gest
    user = User.find_or_create_by!(name: "guest", email: 'guest@example.com') do |u|
      u.password = SecureRandom.urlsafe_base64
    end
    log_in user
    redirect_to top_path
  end

  def new_admin_gest
    admin = User.find_or_create_by!(name: "管理者", email: 'admin@example.com', admin: true) do |u|
      u.password = SecureRandom.urlsafe_base64
    end
    log_in admin
    redirect_to top_path
  end
end
