Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :email, :null => false, :unique => true
      String :name, :null => false
      String :phone
      String :position

    end
  end

  down do
    drop_table :users
  end
end
