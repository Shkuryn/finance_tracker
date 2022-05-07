class AddDefaultValueToPredefinedAttribute < ActiveRecord::Migration[6.1]
  def change
    def up
      change_column :expences, :predefined, :boolean, default: false
    end
  end
end
