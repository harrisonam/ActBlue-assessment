class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|

      t.timestamps
    end
  end
end
