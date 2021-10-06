# frozen_string_literal: true

class BaseAction
  private

  def invalid?(movie_data)
    movie_data[:response] == 'False'
  end

  def log_warning
    Rails.logger.warn "#{Time.current} Request returned an error in the response"
  end
end
