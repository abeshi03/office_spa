module LoginSupport
  def log_in_as(user)
    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログインする"
  end

  def login_destination
    log_in_as user
    expect(current_path).to eq top_path
  end

  def sign_in_as(user)
    post login_path, params: { session: { email: user.email, password: user.password } }
  end

  def not_open_page
    expect(page).to have_content "ログインしていません"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
