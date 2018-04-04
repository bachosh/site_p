class AddImagesLocationToCopflt < ActiveRecord::Migration[5.1]
  def change
  	add_column :copartflts, :image_location, :string
  end
end
