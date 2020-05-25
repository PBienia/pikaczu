class Project < ApplicationRecord
has_many :pinouts

#validates : name, presence: true
end
