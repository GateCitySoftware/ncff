class ValidatedCache
  VALID_EXPIRATION_TIMES = [5.minutes, 15.minutes, 30.minutes, 1.hour, 1.day]

  def self.fetch(key, options = {}, &block)
    new.fetch(key, options, &block)
  end

  def initialize(cache = Rails.cache)
    @cache = cache
  end

  def fetch(key, options = {}, &block)
    validate_expiration_time(options[:expires_in])
    @cache.fetch(key, options, &block)
  end

  private

  def validate_expiration_time(expires_in)
    return if VALID_EXPIRATION_TIMES.include?(expires_in)

    raise ArgumentError, "Invalid expiration time. Must be one of: #{VALID_EXPIRATION_TIMES.join(', ')}"
  end
end
