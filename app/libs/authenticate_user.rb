class AuthenticateUser

  def self.grant_access(request_headers:, body:)
    begin
      validates_user_tokens_present()
      verify_mandatory_headers(request_headers: request_headers)
      validates_content_type(content_type: request_headers[:"Content-Type"])
      email = ENV['OCTO_EVENTS_USER_EMAIL']
      password = ENV['OCTO_EVENTS_USER_PASSWORD']
      if ((email == request_headers[:'User-Email']) && password == request_headers[:'User-Password'])
        results = [:ok, 'User tokens are valid']
      else
        results = [:error, 'User tokens are invalid']
      end
    rescue ArgumentError => e
      results = [:error, e.message]
    end
    results
  end

  private

  # this method will verify that the content_type is json to be able to do a
  # JSON parse
  def self.validates_content_type(content_type:)
    raise ArgumentError, "The #{content_type} is not a valid format" unless content_type == 'application/json'
  end

  # this method will verify that the mandatory headers for authentication and
  # for save type event are present in the header
  def self.verify_mandatory_headers(request_headers:)
    mandatory_headers = %i[Content-Type User-Email User-Password]
    mandatory_headers.each do |mandatory_header|
      unless request_headers.key?(mandatory_header)
        raise ArgumentError, "The #{mandatory_header} header is mandatory"
      end
      if request_headers[mandatory_header].nil? || request_headers[mandatory_header].empty?
        raise ArgumentError, "The #{mandatory_header} header must have a value"
      end
    end
  end

  def self.validates_user_tokens_present
    if((ENV['OCTO_EVENTS_USER_EMAIL'].nil? || ENV['OCTO_EVENTS_USER_EMAIL'].empty?) ||
       (ENV['OCTO_EVENTS_USER_PASSWORD'].nil? || ENV['OCTO_EVENTS_USER_PASSWORD'].empty?))
       raise ArgumentError, 'You have not set a ENV[OCTO_EVENTS_USER_EMAIL] or ENV[OCTO_EVENTS_USER_PASSWORD]'
    end
  end
end
