class CreateTimetracks < ActiveRecord::Migration
  def change
    create_table :timetracks do |t|
      t.date :date
      t.time :start
      t.time :finish
      t.float :duration, :precision => 10, :scale => 2
      t.integer :user_id
    end
  end
end
