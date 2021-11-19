# frozen_string_literal: true

When(/^проверяю отсутствие пользователя по id (\d+) в списке$/)  do
|id|
  users_full_information = $rest_wrap.get('/users')

  $logger.info('Ошибка. Данного пользователя нет в базе.')
  @scenario_data.users_full_info = users_full_information
end

When(/^пытаюсь добить пользователя с логином (\w+\.\w+) но без параметров$/) do
|login|
  expect {
    id = find_id(login)
    response = $rest_wrap.post('/users')
  }.to raise_error(RuntimeError)
  $logger.info("Ошибка. Не возможно добавить без параметров.")
end

When(/^пытаюсь изменить параметры не существующего пользователя по логину (\w+\.\w+) на имя (\w+), фамилию (\w+), пароль ([\d\w@!#]+)$/) do
|login, name, surname, password|
  expect {
    id = find_id(login)
    response = $rest_wrap.put('/users/' + id.to_s,
                              name: name,
                              surname: surname,
                              password: password)
  }.to raise_error(RuntimeError)
  $logger.info("Ошибка. Невозможно выполнить изменения, пользователя нет в базе.")
end

When(/^пытаюсь удалить пользователя с несуществующим логином (\w+.\w+)$/) do |login|
  expect {
    id = find_id(login)
    response = $rest_wrap.delete('/users/' + id.to_s)
  }.to raise_error(RuntimeError)
  $logger.info("Ошибка. Невозможно удалить, пользователя нет в базе.")
end