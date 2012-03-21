class RenameStartToStartTime < ActiveRecord::Migration
  def up
    rename_column :timestamps, :start, :starttime
  end

  def down
  end
end
