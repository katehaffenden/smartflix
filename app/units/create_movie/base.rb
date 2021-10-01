# frozen_string_literal: true

module CreateMovie
  class Base
    EXCLUDED_ATTRIBUTES = %i[director actors awards poster country ratings writer type dvd boxoffice production
                             metascore response imdbrating imdbvotes imdbid website].freeze
    private_constant :EXCLUDED_ATTRIBUTES

    private

    def invalid?(response)
      response.body.include?('False')
    end

    def log_warning
      Rails.logger.warn "#{Time.current} Request returned an error in the response"
    end

    def prepare_movie_attributes(response)
      response = response.transform_keys! { |k| k.downcase.to_sym }
      response.except!(*EXCLUDED_ATTRIBUTES)
    end
  end
end
