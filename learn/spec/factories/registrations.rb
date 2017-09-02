# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  semester   :string           not null
#  year       :integer          not null
#  capacity   :integer          not null
#  is_open    :boolean          default(FALSE)
#  klass_id   :integer          not null
#  teacher_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :registration do
    
  end
end
