class CreateCoparts < ActiveRecord::Migration[5.1]
  def change
    create_table :coparts do |t|
      t.string :record_status
      t.string :lot_n
      t.text :row_hash
      t.string :lot_img_fld

      t.timestamps
    end
  end
end
