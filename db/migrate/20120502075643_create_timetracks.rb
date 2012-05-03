class CreateTimetracks < ActiveRecord::Migration
  def change
    create_table :timetracks do |t|
      t.date :date
      t.datetime :start
      t.datetime :finish
      t.float :duration, :precision => 10, :scale => 3
    end
  end
end
