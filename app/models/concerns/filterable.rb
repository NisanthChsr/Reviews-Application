module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filter_attributes)
      results = self.where(nil)
      filter_attributes.keys.each do |attribute|
        results = results.where("#{attribute} like ?","%#{filter_attributes[attribute]}%") if filter_attributes[attribute].present?
      end
      results
    end
  end
end
