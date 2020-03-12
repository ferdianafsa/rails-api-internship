# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  content    :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :integer
#

class Report < ApplicationRecord
  belongs_to :student
  has_rich_text :content
  has_one_attached :document

  validates :content , :subject, presence: true



  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |report|
        csv << report.attributes.values_at(*column_names)
      end
    end
  end



end
