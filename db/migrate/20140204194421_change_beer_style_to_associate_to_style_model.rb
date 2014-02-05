class ChangeBeerStyleToAssociateToStyleModel < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :style_id
    change_column :beers, :style_id, :integer
  end
end
