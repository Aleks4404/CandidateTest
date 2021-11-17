# frozen_string_literal: true

When(/^захожу на страницу "(.+?)"$/) do |url|
  visit url
  $logger.info("Страница #{url} открыта")
  sleep 1
end

When(/^перехожу на вкладку скачать$/) do
  find(:xpath, "//div[1]/div/div/div[1]/a[1]").click
  $logger.info("Открыта страница загрузки")
  sleep 5
end

When(/^скачиваю последнюю стабильную версию$/) do
  download_stable
  $logger.info("Скачивание завершено")
end

When(/^проверяю скачанный файл что находится в нужной директории$/) do
  check_downloaded
  $logger.info("Файл находится в: #{$tmp_folder}")
  $logger.info("Название файла: #{$contents}")
  $logger.info("Версия установщика: #{$ver_downloaded}")
end

When(/^я проверяю имя скачанного файла совпадает с именем файла-установщика$/) do
  compare_vers
end

When(/^удаляю скачанный файл$/) do
  FileUtils.rm_rf('features/tmp/')
  $logger.info('Временные файлы удалены')
end