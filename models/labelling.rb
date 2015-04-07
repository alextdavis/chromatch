class Labelling < Sequel::Model
  # --- Associations ---

  many_to_one :user
  many_to_one :label

  # --- Hooks ---

  # --- Validation ---
  def validate
    super

    validates_presence [:label_id, :user_id, :weight]
  end

  # --- Class Methods ---

  # --- Instance Methods ---
end
