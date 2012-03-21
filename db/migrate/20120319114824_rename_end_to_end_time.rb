class RenameEndToEndTime < ActiveRecord::Migration
  def up
    rename_column :timestamps, :end, :endtime
  end

  def down
  end
end
