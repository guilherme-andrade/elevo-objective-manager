class CreateObjectives < ActiveRecord::Migration[6.1]
  def up
    create_table :objectives do |t|
      t.integer :weight, null: false
      t.string :title

      t.timestamps
    end
    execute "ALTER TABLE objectives ADD CONSTRAINT check_weight CHECK (weight BETWEEN 0 AND 100)"
  end

  def down
    drop_table :objectives
    execute "ALTER TABLE objectives DROP CONSTRAINT check_weight"
  end
end
