class AddActivityToBrewery < ActiveRecord::Migration
  def up
    add_column :breweries, :active, :boolean
  end

  def down
    remove_column :breweries, :active
  end
end
