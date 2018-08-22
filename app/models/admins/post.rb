class Admins::Post < ApplicationRecord
  belongs_to :politician, class_name: 'Admins::Politician'

  enum social_type: [:twitter, :facebook]

  def isToday
    self.social_date.to_date == Date.today
  end
  def isYesterday
    self.social_date.to_date == (Date.today - 1.day)
  end
end
