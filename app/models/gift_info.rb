class GiftInfo < ActiveRecord::Base
  belongs_to :order, :foreign_key => :uuid

  def from
    self.from_name || self.from_email
  end

  def to
    self.to_name || self.to_email
  end
end