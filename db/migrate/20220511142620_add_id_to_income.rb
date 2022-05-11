class AddIdToIncome < ActiveRecord::Migration[6.1]
  def change
    def change
      add_column :incomes, :id, :primary_key
    end
  end
end
