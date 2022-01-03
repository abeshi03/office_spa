module ReservationSpport
  # 予約が成功する
  def create_reservation
    fill_in "フルネーム(必ずご自身のお名前)", with: reservation.name
    select_date("2030,12,21", from: "日時(開始時間は原則13:15 or 19:15になります)")
    select_time("13", "15", from: "日時(開始時間は原則13:15 or 19:15になります)")
    select menu_second.name, from: "reservation_menu_id"
    click_on "登録する"
  end
end
RSpec.configure do |config|
  config.include ReservationSpport
end
