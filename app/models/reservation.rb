class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :menu
  validates :user_id, presence: true
  validates :menu_id, presence: true
  validates :name,    presence: true
  validate :date_before_start
  validate :start_time_not_sunday
  validate :start_time_not_saturday
  validate :time_only
  validates :start_time, uniqueness: { message: 'は他のユーザーが予約しています' }
  scope :future_reservations, -> do
    where("start_time > ?", Date.today).order(start_time: :desc)
  end
  scope :reservations_history, -> (count) { order(start_time: :desc).limit(count) }

  def date_before_start
    errors.add(:start_time, "は過去の日付を選択できません") if start_time < Date.today
  end

  def start_time_not_sunday
    errors.add(:start_time, "は日曜日を選択できません") if start_time.sunday?
  end

  def start_time_not_saturday
    errors.add(:start_time, "は土曜日を選択できません") if start_time.saturday?
  end
  
  def time_only
    if hour_only_1 && min_only
      true
    elsif hour_only_2 && min_only
      true
    else
      errors.add(:start_time, "(時間)は13:15もしくは19:15になります")
    end
  end

  def hour_only_1
    start_time.hour == 19
  end

  def hour_only_2
    start_time.hour == 13
  end

  def min_only
    start_time.min == 15
  end
end
