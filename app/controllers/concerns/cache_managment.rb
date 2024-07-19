# CacheManagement Concern
#
# This concern provides methods for managing cached data with validation.
#
# Usage Examples:
#
#    def some_method
#      cache_fetch(cache_key_for('tags_with_count'), expires_in: 30.minutes) do
#        # Your original block here
#      end
#    end

module CacheMagement
  # Fetches data from the cache or executes the provided block if not found
  #
  # @param key [String] The cache key
  # @param expires_in [ActiveSupport::Duration] The expiration time for the cached data
  # @yield The block to execute if the data is not found in the cache
  # @return The cached data or the result of the block execution
  def cache_fetch(key, expires_in:, &block)
    cache.fetch(key, expires_in:, &block)
  end

  # Generates a cache key for a given model and arguments
  #
  # @param model [String, Symbol] The model name or identifier
  # @param args [Array] Additional arguments to be included in the cache key
  # @return [String] A formatted cache key
  def cache_key_for(model, *args)
    "#{model}/#{args.join('/')}"
  end

  # Retrieves or initializes the cache object
  #
  # @return [ValidatedCache] The cache object
  def cache
    @cache ||= ValidatedCache.cache
  end
end
