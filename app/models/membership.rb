# == Schema Information
#
# Table name: memberships
#
#  id            :integer          not null, primary key
#  fetprofile_id :string(255)
#  gremium_id    :string(255)
#  start         :date
#  stop          :date
#  typ           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Membership < ActiveRecord::Base
  TYPEN={-2=>"VorsitzendeR", -1=>"stv VorsitzendeR", 0=>"2. stv VorsitzendeR", 1=>"Mitglied",2=> "Ersatzmitglied",3=>"VerantwortlicheR"}
  attr_accessible :fetprofile_id, :gremium_id, :start, :stop, :typ
  belongs_to :fetprofile
  belongs_to :gremium
  scope :active, -> {where("stop >= ? OR stop IS NULL", Time.now.to_date)}
  validates :typ, :presence=>true
  validates :fetprofile, :presence=>true
  validates :start, :presence=>true
end
