class Reservation < ApplicationRecord
  validates :name, presence: true
  validate :date_before_start
  validate :start_time_not_sunday
  validate :start_time_not_saturday


  def date_before_start
    errors.add(:start_time, "は過去の日時を選択できません") if
    start_time < Date.today
  end

  def start_time_not_sunday
    errors.add(:start_time, "は日曜日を選択できません") if start_time.sunday?
  end

  def start_time_not_saturday
    errors.add(:start_time, "は土曜日を選択できません") if start_time.saturday?
  end
end
