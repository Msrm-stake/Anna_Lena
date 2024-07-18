class AddDescriptionfrToPublication < ActiveRecord::Migration[7.1]
  def change
    add_column :publications, :descriptionfr, :string
  end
end
