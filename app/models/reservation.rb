class Reservation < ApplicationRecord
  validates :name, presence: true
  validate :date_before_start
  validate :start_time_not_sunday
  validate :start_time_not_saturday
  validate :time_only_1


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
  
  def time_only_1
    if hour_only_1 && min_only
      true
    elsif hour_only_2 && min_only
      true
    else
      errors.add(:start_time, "予約時間は13:15もしくは19:15になります")
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
