class User < Sequel::Model
  plugin :validation_helpers
  # --- Associations ---

  one_to_many :expertises
  one_to_many :labellings
  many_to_many :bookmarks, :left_key => :bookmarked_id, :right_key => :bookmarker_id, :join_table => :bookmarkings, :class => self

  # --- Hooks ---

  # --- Validation ---
  def validate
    super

    validates_presence [:uid, :email, :name]
    validates_unique [:uid, :email]
  end

  # --- Class Methods ---

  # --- Instance Methods ---

  def generate_token
    self.update({:token => SecureRandom.hex})
  end

  def has_bookmarked(bookmarked_id)
    if self.bookmarks != []
      return !!self.bookmarks.with(:bookmarked_id => bookmarked_id)
    else
      return false
    end
  end

  def is_bookmarked_by(bookmarker_id)
    self.bookmarks[bookmarker_id]
  end

end