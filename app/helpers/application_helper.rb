module ApplicationHelper

  def link_to_my_profile
    if current_user.tutor?
      if current_user.profile.completed_profile?
        link_to 'My Profile', tutor_path(current_user.profile)
      else
        link_to 'My Profile', edit_tutor_path(current_user.profile)
      end
    elsif current_user.student?
      link_to 'My Profile', student_path(current_user.profile)
    end
  end

  def link_to_my_schedule
    if current_user.tutor?
      link_to "My Schedule", sales_path
    elsif current_user.student?
      link_to "My Schedule", purchases_path
    end
  end

  def format_time(time)
    time.strftime('%H:%M')
  end

  def format_lesson_day(lesson, viewer = current_user)
    viewer_lesson_time(lesson, viewer).to_date
  end

  def format_lesson_time(lesson, viewer = current_user)
    viewer_lesson_time(lesson, viewer).strftime('%H:%M')
  end

  def viewer_lesson_time(lesson, viewer = current_user)
    date           = lesson.day
    time_part      = lesson.start_time

    time = date.strftime('%Y-%m-%d ') + time_part.strftime('%H:%M')
    time = Time.zone.parse time

    tutor_zone_s   = if lesson.tutor.try(:timezone).present?
                       lesson.tutor.timezone
                     else
                       default_zone_abbr
                     end
    tutor_offset   = ActiveSupport::TimeZone[tutor_zone_s].try :utc_offset

    viewer_zone_s  = if viewer.try(:timezone).present?
                       viewer.timezone
                     else
                       default_zone_abbr
                     end
    viewer_offset  = ActiveSupport::TimeZone[viewer_zone_s].try :utc_offset

    time + viewer_offset - tutor_offset
  end

  def timezones
    ActiveSupport::TimeZone.us_zones.reverse +
      [ActiveSupport::TimeZone['Tokyo'], ActiveSupport::TimeZone['Beijing']]
  end

  def user_zone_s
    (user_zone.to_s.presence || default_zone_s)
      .gsub(/\(|\)/, '')
  end

  def user_zone
    if current_user && current_user.timezone.present?
      ActiveSupport::TimeZone[current_user.timezone]
    end
  end

  def default_zone_abbr; 'Eastern Time (US & Canada)' end
  def default_zone; ActiveSupport::TimeZone[default_zone_abbr] end
  def default_zone_s; default_zone.to_s end
end
