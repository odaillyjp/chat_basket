class AddStatusToAttendances < ActiveRecord::Migration[5.0]
  def up
    add_column :attendances, :status, :integer

    ActiveRecord::Base.connection.execute('UPDATE attendances SET status = 0;')

    change_column_null :attendances, :status, false
    add_index :attendances, :status
  end

  def down
    remove_index :attendances, :status
    remove_column :attendances, :status
  end
end
