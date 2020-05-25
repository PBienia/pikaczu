class Pinout < ApplicationRecord
  belongs_to :project
  scope :proj, ->(project) { where(project_id: project) }
#  validates :pin_dut_name, presence: true
#  validates :pin_dut presence: true
#  validates :pin_setup, presence: true
#  validates :pin_setup_name presence: true
#  validates :project, presence: true
end
