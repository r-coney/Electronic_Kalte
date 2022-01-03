require 'rails_helper'

module TestHelper
  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: user.password } } 
  end

  def sign_in(user)
    visit login_path
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end
end