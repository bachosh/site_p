class CreateFiltercoparts < ActiveRecord::Migration[5.1]
  def change
    create_table :filtercoparts do |t|
      t.string :record_status
      t.string :vechile_type
      t.string :year
      t.string :make
      t.string :model_group
      t.string :model_detail
      t.string :damage_description
      t.string :lot_cond
      t.integer :odometer
      t.string :engine
      t.string :drive
      t.string :transmission
      t.string :fuel_type
      t.string :runs_drives
      t.string :location_city
      t.string :buy_it_now_price

      t.timestamps
    end
  end
end
