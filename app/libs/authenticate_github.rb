# frozen_string_literal: true

class AuthenticateGithub
  def self.authenticate_request(request_headers:, body:)
    begin
      validates_github_token_present()
      verify_mandatory_headers(request_headers: request_headers)
      validates_content_type(content_type: request_headers[:"Content-Type"])
      key = ENV['GITHUB_TOKEN']
      sha1 = "sha1=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), key, body)}"
      sha256 = "sha256=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), key, body)}"
      if(sha1 == request_headers[:"X-Hub-Signature"] &&
        sha256 == request_headers[:"X-Hub-Signature-256"])
        results = [:ok, 'Github tokens are valid']
      else
        results = [:error, 'Github tokens are invalid']
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

    mandatory_headers = %i[Content-Type X-Github-Event X-Hub-Signature X-Hub-Signature-256]
    mandatory_headers.each do |mandatory_header|

      unless request_headers.key?(mandatory_header)
        raise ArgumentError, "The #{mandatory_header} header is mandatory"
      end
      if request_headers[mandatory_header].nil? || request_headers[mandatory_header].empty?
        raise ArgumentError, "The #{mandatory_header} header must have a value"
      end
    end
  end

  def self.validates_github_token_present
    if ENV['GITHUB_TOKEN'].nil? || ENV['GITHUB_TOKEN'].empty?
      raise ArgumentError, 'You have not set a ENV[\'GITHUB_TOKEN\']'
    end
  end
end
