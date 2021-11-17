# frozen_string_literal: true

$tmp_folder = 'features/tmp'
$contents = ''
$ver_stable = ''
$ver_downloaded = ''

def check_stable
    find(:xpath, "//li[1]//ul[1]//li[1]//a[1]").text.scan(/\d+/)[0...3]
end

def download_stable
  find(:xpath, "//li[1]//ul[1]//li[1]//a[1]").click
  sleep 10
end

def check_downloaded
  $contents =  Dir.glob("#{$tmp_folder}/*").select{ |f| File.file? f }.map{ |f| File.basename f }
  $ver_downloaded = $contents.join.scan(/\d+/)[0...3]
end

def compare_vers
  if
    $ver_stable == $ver_downloaded
    then
    $logger.info('Загруженная версия совпадает с последней стабильной')
  else
    $logger.info("Загруженная версия: #{$ver_downloaded} не совпадает с последней стабильной:#{$ver_stable} " )
  end
end

def cleanup
  FileUtils.rm_rf('features/tmp/')
  $logger.info('Временные файлы очищены')
end