Rails.application.config.generators do |g| # rubocop:disable Style/FrozenStringLiteralComment
  g.test_framework :rspec
  g.fixture_replacement :factory_bot
  g.factory_bot dir: 'spec/factories'
  g.controller_specs false
  g.request_specs true
  g.helper_specs false
  g.feature_specs true
  g.mailer_specs true
  g.model_specs true
  g.observer_specs false
  g.routing_specs false
  g.view_specs false
  g.orm :active_record, primary_key_type: :uuid
end
