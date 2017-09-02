# == Schema Information
#
# Table name: klasses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  subject    :string           not null
#  level      :integer          not null
#  credits    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Klass < ApplicationRecord
  validates :name, :subject, :level, :credits, presence: true
  has_many :registrations
  has_many :sections
end
