class CreateTimetracks < ActiveRecord::Migration
  def change
    create_table :timetracks do |t|
      t.date :date
      t.timestamp :start
      t.timestamp :finish
      t.float :duration, :precision => 10, :scale => 3
      t.integer :user_id
    end
  end
end
