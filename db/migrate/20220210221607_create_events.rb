class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.date :date
      t.string :name
      t.string :location
      t.datetime :start_time
      t.datetime :finish_time
      t.string :description
      t.integer :type

      t.timestamps
    end
  end
end
