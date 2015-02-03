Sequel.migration do
  up do
    create_table :bookmarkings do
      primary_key :id

      foreign_key :bookmarker_id, :users, :null => false
      foreign_key :bookmarked_id, :users, :null => false
    end
  end

  down do
    drop_table :bookmarkings
  end
end
