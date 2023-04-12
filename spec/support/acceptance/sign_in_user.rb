def sign_in_use(email, password)
  visit("/")

  click_button("Login / Register")

  within "form#login-form" do
    fill_in "Email", with: email
    fill_in "Password", with: password
  end

  click_button("Login")
end
