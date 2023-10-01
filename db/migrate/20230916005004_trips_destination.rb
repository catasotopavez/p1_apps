class TripsDestination < ActiveRecord::Migration[7.0]
  def change
    create_table :trip_destinations do |t|
      t.references :trip
      t.references :destination

      t.timestamps
    end
  end
end
