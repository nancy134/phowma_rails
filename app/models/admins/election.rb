class Admins::Election < ApplicationRecord

  has_many :election_results, class_name: 'Admins::ElectionResult'
  belongs_to :office, class_name:"Admins::Office"
  validates_presence_of :office

  accepts_nested_attributes_for :office
  before_validation :set_selected_office

  #attr_accessor :position, :office_attributes
  #attr_accessor :state_id, :office_attributes
  #attr_accessor :district_id, :office_attributes
  attr_accessor :incumbent_id

  has_many :campaigns, class_name: "Admins::Campaign"
  has_many :politicians, through: :campaigns

  enum election_type: [:primary, :general, :runoff]
  def election_name
    return "test" 
  end

  def set_selected_office
    if (incumbent_id)
      self.office = Admins::Office.find(incumbent_id)
    end
    if (office_id)
      self.office = Admins::Office.find(office_id)
    end
  end
end
