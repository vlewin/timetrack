class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
      t.date :date
      t.integer :duration, default: Timetrack::HOURS_OF_WORK
      t.integer :reason, default: 0, null: false
      t.integer :user_id
    end
  end
end
