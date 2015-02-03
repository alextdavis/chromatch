Sequel.migration do
  up do
    create_table :expertises do
      primary_key :id

      String :statement, :null => false
      String :source, :null => false

      foreign_key :user_id, :users, :null => false
    end
  end

  down do
    drop_table :expertises
  end
end
