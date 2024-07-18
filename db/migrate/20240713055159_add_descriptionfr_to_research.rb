class AddDescriptionfrToResearch < ActiveRecord::Migration[7.1]
  def change
    add_column :researches, :descriptionfr, :string
  end
end
