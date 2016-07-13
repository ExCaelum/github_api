require "test_helper"

class UserLogsInWithGithubTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = GithubApi::Application
    stub_omniauth
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Github Login"
    assert_equal "/", current_path
    assert page.has_content?("ExCaelum")
    assert page.has_link?("Logout")
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "1234",
      extra: {
        raw_info: {
          name: "Parker",
          login: "ExCaelum"
        }
      },
      credentials: {
        token: "123456789"
      }
    })
  end
end
