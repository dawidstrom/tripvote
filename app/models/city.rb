class City < ApplicationRecord
  validates :name, presence: true
  has_one :voteable_item, :as => :item, :dependent => :destroy
  
end
