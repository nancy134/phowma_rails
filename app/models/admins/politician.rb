class Admins::Politician < ApplicationRecord

  require 'csv'

  belongs_to :state, class_name: 'Admins::State'
  belongs_to :district, class_name: 'Admins::District'
  has_one :election, class_name: 'Admins::Election'

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100#"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  enum party: [:democrat, :republican, :independent, :vacant]
  enum position: [:senator, :representative, :governor]
  enum office_status: [:in, :seeking, :out]

  has_many :campaigns, class_name: "Admins::Campaign"
  has_many :elections, through: :campaigns

  has_many :posts, -> {order(social_date: :desc).limit(1)}, class_name: 'Admins::Post'

  def self.import(file)
    CSV.foreach(file.path, headers: true, :row_sep => :auto) do |row|
      politician_hash = row.to_hash

      if (politician_hash["state"].length == 2)
        state = Admins::State.where(abbreviation: politician_hash["state"]).first
      else
        state = Admins::State.where(name: politician_hash["state"]).first
      end
      if (state)
        politician_hash["state_id"] = state.id
      else
        return
      end
      politician_hash.delete("state")

      if (politician_hash["district"])
        district = Admins::District.where(number: politician_hash["district"],state_id: state.id).first
        if (district)
          politician_hash["district_id"] = district.id
        end
        politician_hash.delete("district")
      end

      politician = Admins::Politician.where(id: politician_hash["id"])

      if politician.count == 1
        politician.first.update_attributes(politician_hash)
      else
        Admins::Politician.create!(politician_hash)
      end
    end
  end

  def avatar_thumb
    "http:" + avatar.url(:thumb)
  end
  def avatar_medium
    "http:" + avatar.url(:medium)
  end

end

