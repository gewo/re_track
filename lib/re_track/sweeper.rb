module ReTrack
  module Sweeper
    extend ActiveSupport::Concern

    mattr_accessor :rt_model_instance_names

    included do
      after_action :rt_after_action, only: :create
    end

    module ClassMethods
      def re_track(record_instance_name)
        (@rt_record_instance_names ||= []) << record_instance_name
      end

      def rt_record_instance_names
        (@rt_record_instance_names ||= []).uniq
      end
    end

    private

      def rt_after_action
        rt_records.each { |record| rt_after_create record }
        true
      end

      def rt_records
        self.class.rt_record_instance_names.map do |name|
          instance_variable_get "@#{name}"
        end
      end

      def rt_create_referer_tracking!(record)
        rt = ReTrack::RefererTracking.new
        rt.trackable = record

        session[:retrack].each_pair do |key, value|
          rt[key] = value if rt.attribute_names.include?(key.to_s)
        end

        rt.save!
      end

      def rt_after_create(record)
        return unless record.persisted?
        rt_create_referer_tracking!(record) if session && session[:retrack]
      rescue => e
        Rails.logger.info(
          "ReTrack::Sweeper.after_create error saving record: #{e}")
      end
  end
end
