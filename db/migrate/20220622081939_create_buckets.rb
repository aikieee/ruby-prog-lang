class CreateBuckets < ActiveRecord::Migration[7.0]
  def change                            # database that stores information about the buckets that have been created
    create_table :buckets do |t|
      t.string :name
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
