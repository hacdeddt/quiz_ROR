require 'carrierwave/orm/activerecord'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
