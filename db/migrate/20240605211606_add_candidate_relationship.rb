class AddCandidateRelationship < ActiveRecord::Migration[7.1]
  def change
    add_reference :candidates, :poll, foreign_key: true
  end
end
