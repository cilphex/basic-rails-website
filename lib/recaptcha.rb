class Recaptcha
  URL  = 'https://www.google.com'
  PATH = '/recaptcha/api/siteverify'

  def self.verify(code, remote_ip: nil)
    success = false
    errors = []
    res = connection.get(PATH, {
      secret: ENV['RECAPTCHA_SECRET'],
      response: code,
      remoteip: remote_ip
    })
    res.body.symbolize_keys!

    success = res.status == 200 ? res.body[:success] : false

    if res.status != 200
      errors = ["Returned with status #{res.status}"]
    elsif res.body[:'error-codes'].present?
      errors = res.body[:'error-codes']
    end

    [success, errors]
  end

  private

  def self.connection
    @connection ||= Faraday.new(url: URL) do |c|
      c.request :url_encoded
      c.response :json
      c.adapter Faraday.default_adapter
    end
  end
end