class VoteableItem < ApplicationRecord
  belongs_to :item, :polymorphic => true, :dependent => :destroy
  has_many :votes
end
