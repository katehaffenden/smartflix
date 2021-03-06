# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  # This is the directory where VCR will store its "cassettes", i.e. its
  # recorded HTTP interactions.
  c.cassette_library_dir = 'spec/cassettes'
  c.allow_http_connections_when_no_cassette = false
  # This line makes it so VCR and WebMock know how to talk to each other.
  c.hook_into :webmock

  # This line makes VCR ignore requests to localhost. This is necessary
  # even if WebMock's allow_localhost is set to true.
  c.ignore_localhost = true
  c.default_cassette_options = { record: :once,
                                 match_requests_on: [:body, :host, :method]}
  c.filter_sensitive_data('apikey') { ENV['OMDB_KEY'] }
end
