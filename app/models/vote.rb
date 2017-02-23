class Vote < ApplicationRecord
  has_one :user
  has_one :voteable_item
end
