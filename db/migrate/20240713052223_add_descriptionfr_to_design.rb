class AddDescriptionfrToDesign < ActiveRecord::Migration[7.1]
  def change
    add_column :designs, :descriptionfr, :string
  end
end
