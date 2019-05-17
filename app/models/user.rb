class User < ApplicationRecord
  has_many :qbanks
  has_many :tests
  has_many :results
  has_many :answers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :confirmable, :lockable, :timeoutable, :trackable,
  :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :image, AvatarUploader, :dependent => :destroy

  HUMANIZED_ATTRIBUTES = {
    :fullName => "Họ tên",
    :year_birthday => "Ngày sinh",
    :address => "Địa chỉ",
    :gender => "Giới tính",
    :password => "Mật khẩu",
    :image => "Ảnh đại diện"
  }

  def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  validates :fullName, format: { with: /\A[\p{alpha}\s]+\z/,
  message: "không được để trống và chỉ bao gồm chữ cái" }

  validates :gender, presence: {message: "chưa được chọn"}

  validates :year_birthday, presence: {message: "chưa được chọn"}

  validates :address, format: { with: /\A[\p{Word}\d\s+-_,]+\z/, 
    #\A là bắt đầu chuỗi, \z là kết thúc chuỗi, \s là khoẳng trắng, \p{Word} là bao gồm các chữ cái và số
    message: "không được để trống và chỉ bao gồm chữ và số"}

    validates_processing_of :image
    validate :image_size_validation


    validate :password_complexity

    def password_complexity
      if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}/)
        errors.add :password, "phải có ít nhất một chữ hoa, một chữ thường và một số!"
      end
    end



    def image_size_validation
      errors[:image] << "Nên nhỏ hơn 1MB" if image.size > 1.megabytes
    end

    def self.new_with_session params, session
      super.tap do |user|
        if data = session["devise.facebook_data"] &&
          session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

    def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
	    user.fullName = auth.info.name   # assuming the user model has a name
	    user.remote_image_url = auth.info.image # assuming the user model has an image
	    user.year_birthday = auth.extra.raw_info.birthday if auth.extra.raw_info.birthday.present?
	    user.gender = auth.extra.raw_info.gender if auth.extra.raw_info.gender.present?
	    user.address = auth.extra.raw_info.location.name if auth.extra.raw_info.location.present?
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    user.skip_confirmation!
	  end
  end

  def password_required?
  	super && provider.blank?
  end

# Đổi mật khẩu cho những người dùng đăng nhập bằng facebook, tức là không có mật khẩu.
  # def update_with_password(params, *option)
  # 	if encrypted_password.blank?
  # 		update_attributes(params, *option)
  # 	else
  # 		super
  # 	end
  # end

end
