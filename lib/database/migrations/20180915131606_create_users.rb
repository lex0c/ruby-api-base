Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :first_name, null: false, size: 255
      String :last_name, null: false, size: 255
      String :email, null: false, size: 255
      String :password, null: false, size: 255
      unique :email
    end
  end

  down do
    drop_table(:users)
  end
end
