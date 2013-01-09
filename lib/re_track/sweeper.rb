class ReTrack::Sweeper < ActionController::Caching::Sweeper
  def after_create(record)
    if session && session['retrack']
      rt = ReTrack::RefererTracking.new
      rt.trackable = record

      session[:retrack].each_pair do |key, value|
        rt[key] = value if rt.attribute_names.include?(key.to_s)
      end

      rt.save!
    end
  rescue => e
    Rails.logger.info(
      "ReTrack::Sweeper.after_create error saving record: #{e}")
  end
end
