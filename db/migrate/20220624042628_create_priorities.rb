class CreatePriorities < ActiveRecord::Migration[7.0]
  def self.up                                                   # database that stores information of the different degrees of priorities of the tasks
    create_table :priorities do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :priorities
  end
end
