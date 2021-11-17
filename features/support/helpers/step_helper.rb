# frozen_string_literal: true

def find_user_id(users_information:, user_login:)
  users_id = []
  users_information.each do |user|
    next unless user['login'] == user_login

    users_id << user['id']
  end
  users_id.uniq!

  if users_id.size != 1
    raise "Логин пользователя неуникален! Найдено пользователей с аналогичным логином: #{users_id.size}, id: #{users_id.inspect}"
  end

  users_id.first
end

#Находим id по логину
def find_id(login)
  if @scenario_data.users_id[login].nil?
    @scenario_data.users_id[login] = find_user_id(users_information: @scenario_data
                                                                         .users_full_info,
                                                  user_login: login)
  end
  @scenario_data.users_id[login]
end