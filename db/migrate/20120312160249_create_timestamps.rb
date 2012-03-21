class CreateTimestamps < ActiveRecord::Migration
  def change
    create_table :timestamps do |t|
      t.date :date
      t.string :start
      t.string :end
      t.float :duration, :precision => 10, :scale => 3
      t.timestamps
    end
  end
end
