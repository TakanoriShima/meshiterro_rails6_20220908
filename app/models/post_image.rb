class PostImage < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  # ---- 下記1行を追加してください ---- #
  has_many :post_comments, dependent: :destroy
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  has_many :favorites, dependent: :destroy

  # ---- 以下を追加してください ---- #
  validates :shop_name, presence: true
  validates :image, presence: true, blob: { content_type: :image }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
