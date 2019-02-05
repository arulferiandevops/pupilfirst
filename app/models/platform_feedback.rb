class PlatformFeedback < ApplicationRecord
  belongs_to :founder
  has_one :karma_point, as: :source, inverse_of: :source, dependent: :restrict_with_error
  has_one_attached :attachment

  scope :scored, -> { where.not(promoter_score: nil) }

  mount_uploader :attachment, PlatformFeedbackAttachmentUploader

  def self.types_of_feedback
    %w[Feature Suggestion Bug Other]
  end

  validates :feedback_type, presence: true, inclusion: types_of_feedback
  validates :founder_id, presence: true

  def attachment_filename
    attachment.sanitized_file.original_filename
  end
end
