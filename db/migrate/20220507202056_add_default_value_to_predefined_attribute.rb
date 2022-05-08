class AddDefaultValueToPredefinedAttribute < ActiveRecord::Migration[6.1]
  def change
     change_column :expences, :predefined, :boolean, default: false
  end
end
