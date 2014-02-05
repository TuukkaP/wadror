class ChangeBeerStyleToAssociateToStyleModel < ActiveRecord::Migration
  def change
    remove_column :beers, :style
    add_column :beers, :style_id, :integer
    #rename_column :beers, :style, :style_id
    #change_column :beers, :style_id, :integer
  end
end
