class CurrentRequest
  FIELDS = [
    :locale,
    :remote_ip
  ]

  class << self
    FIELDS.each do |field|
      define_method("#{field}") do
        RequestStore.store[field]
      end
      define_method("#{field}=") do |val|
        RequestStore.store[field] = val
      end
    end
  end
end