Sequel.migration do
  up do
    create_table :labels do
      primary_key :id

      String :name, :null => false
    end
  end
  down do
    drop_table :labels
  end
end
