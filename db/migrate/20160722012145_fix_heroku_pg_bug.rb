class FixHerokuPgBug < ActiveRecord::Migration[5.0]
  def change
    change_column :attendances, :status, 'integer USING CAST(status AS integer)'
  end
end
