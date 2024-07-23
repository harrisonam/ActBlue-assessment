class Candidate < ApplicationRecord
    belongs_to :poll
    validates_presence_of :name
end
