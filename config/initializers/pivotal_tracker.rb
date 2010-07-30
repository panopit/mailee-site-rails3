# Be sure to restart your server when you modify this file.

PivotalTracker::Client.token = YAML::load(open("#{Rails.root}/config/config.yml"))[:token]

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# MaileeSiteRails3::Application.config.session_store :active_record_store
