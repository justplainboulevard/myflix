
include CommonSteps

module SessionSteps

  def sign_in(user)

    ensure_on signin_path
    fill_in 'Email address', with: user.email_address
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end
end
