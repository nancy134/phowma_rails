class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::ElectionResult'
  belongs_to :office, class_name:"Admins::Office"
  validates_presence_of :office

  accepts_nested_attributes_for :office
  before_validation :set_selected_office
  #validates_associated :office

  attr_accessor :position, :office_attributes
  attr_accessor :state_id, :office_attributes
  attr_accessor :district_id, :office_attributes
  attr_accessor :politician_id, :office_attributes

  has_many :campaigns, class_name: "Admins::Campaign"
  has_many :politicians, through: :campaigns

  enum election_type: [:primary, :general, :runoff]
  def election_name
    return self.position + " " + self.year.to_s
  end

  def set_selected_office
    #self.office = Admins::Office.where(position: office_attributes[:position], state_id: office_attributes[:state_id], district_id: office_attributes[:district_id], politician_id: office_attributes[:politician_id]).first

    self.office = Admins::Office.find(office_id)
    Rails.logger.debug "NANCY: office: #{self.office}"
  end
end
