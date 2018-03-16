module DisableCache
  extend ActiveSupport::Concern

  included do |*args|
    bl1 = 1
  end

  private

  def disable_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
