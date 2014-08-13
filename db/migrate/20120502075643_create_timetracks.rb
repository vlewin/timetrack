class CreateTimetracks < ActiveRecord::Migration
  def change
    create_table :timetracks do |t|
      t.date :date
      t.time :start
      t.time :finish
      t.integer :pause
      t.integer :duration
      t.integer :user_id
    end
  end
end
