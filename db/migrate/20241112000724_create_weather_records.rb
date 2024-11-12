class CreateWeatherRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :weather_records do |t|
      t.string :endpoint, null: false
      t.jsonb :query, null: false
      t.jsonb :data, null: false

      t.timestamps
    end

    add_index :weather_records, [ :endpoint, :query ], unique: true
  end
end
