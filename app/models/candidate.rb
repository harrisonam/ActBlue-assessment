class Candidate < ApplicationRecord
    belongs_to :poll
    has_many :votes, dependent: :destroy

    validates_presence_of :name
end
