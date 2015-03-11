Sequel.migration do
  up do
    create_table :labellings do
      primary_key :id

      foreign_key :label_id, :labels, :null => false
      foreign_key :user_id, :users, :null => false
      Float :weight, :null => false
    end
  end
  down do
    drop_table :labellings
  end
end
