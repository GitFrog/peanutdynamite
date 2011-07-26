class User < ActiveRecord::Base

  has_many :recipefavourites
  has_many :recipes, :through => :recipefavourites
  has_many :stories

  attr_accessor :password
  attr_accessible :name, :bookname, :email, :password, :password_confirmation

  #email_regex = ""

  validates :name,  :presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false }
                    #:format => { :with => email_regex }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }

  before_save :encrypt_password

  def has_favourite_get_rating(recipe)
    fav = recipefavourites.find_by_recipe_id(recipe)
    if fav != nil
      return fav.rating
    else
      return nil
    end
  end

  def add_keeper!(recipe)
    self.recipefavourites.create!(:recipe_id => recipe.id, :rating => "keeper")
  end

  def add_maybe!(recipe)
    self.recipefavourites.create!(:recipe_id => recipe.id, :rating => "maybe")
  end
  
  def switch_pile!(recipe)
    fav = self.recipefavourites.find_by_recipe_id(recipe)
    if fav(:rating => "keeper")
      fav.update_attributes(:keeper => "maybe")
    else fav(:rating => "maybe")
      fav.update_attributes(:rating => "keeper")
    end
  end

  def remove_favourite(recipe)
    self.recipefavourites.find_by_recipe_id(recipe).destroy
  end
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email,submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end

    private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
