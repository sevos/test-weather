class CreateWeatherStatuses < ActiveRecord::Migration
  def change
    create_table :weather_statuses do |t|
      t.float :lon
      t.float :lat
      t.json :response

      t.timestamps null: false
    end
  end
end
