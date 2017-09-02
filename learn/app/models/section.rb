# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text
#  azure      :string
#  link       :string
#  position   :integer          default(0)
#  klass_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Section < ApplicationRecord
    validates :klass_id, presence: true
    belongs_to :klass
end
