####################### COPART #######################
# gamshvebis skripti
# rails runner -e production  copart_csv.rb
# cron magaliti
# */2 * * * * /bin/bash -l -c 'cd /www/geocell && bin/rails runner -e production '\''Sendingjob.send'\'''

## START
csv_folder_name = File.join Rails.root, 'csv_storage', 'fld-' + Date.today.to_s
FileUtils.mkdir_p(csv_folder_name) unless File.exist?(csv_folder_name) 

profile = Selenium::WebDriver::Firefox::Profile.new
#profile['browser.download.dir'] = '/tmp/webdriver-downloads'
profile['browser.download.dir'] = csv_folder_name
profile['browser.download.folderList'] = 2
profile['browser.helperApps.neverAsk.saveToDisk'] = "text/plain, application/octet-stream , application/csv"
#profile['browser.download.manager.showAlertOnComplete'] = false

browser = Watir::Browser.start('https://www.copart.com/login/',:firefox, profile: profile)
browser.text_field(name: "username").set "joocha2@gmail.com"
browser.text_field(name: "password").set "1OA7dXdR"
#browser.button(type: "submit").click
browser.button("data-uname"=>"loginSigninmemberbutton").click
sleep 1 

browser.goto("https://www.copart.com/downloadSalesData/")
browser.button(:xpath => '//*[@id="csv"]/div[2]/div[1]/div/div/button').click
sleep 260
browser.close
## end #################### 