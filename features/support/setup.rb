require 'rake'

Before('@omni_valid_login_setup') do
  OmniAuth.config.test_mode = true
  omniauth_hash = {
      :provider => "google_oauth2",
      :uid => "123456789",
      :info => {
          :name => "John Doe",
          :email => "john@ait.asia",
          :first_name => "John",
          :last_name => "Doe",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
      },
      :credentials => {
          :token => "token",
          :refresh_token => "another_token",
          :expires_at => 1354920555,
          :expires => true
      }
  }
  OmniAuth.config.add_mock(:google_oauth2, omniauth_hash)
end

After('@omni_invalid_login_setup') do
  OmniAuth.config.test_mode = false
end

Before('@omni_invalid_login_setup') do
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = :invalid_hd
end

After('@omni_invalid_login_setup') do
  OmniAuth.config.test_mode = false
end

Before('@create_idea') do
  @user = FactoryGirl.create(:member, email: 'member1005566@ait.asia')
  @committee = FactoryGirl.create(:committee, name: 'Committee')
  FactoryGirl.create(:new_idea, user: @user, is_closed: false, restrict_display: false, committee: @committee)
end

After('@create_idea') do
  DatabaseCleaner.clean
end



