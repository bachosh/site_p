# read copart csv
require "csv"
csv_folder_name = File.join Rails.root, 'csv_storage', 'fld-' + Date.today.to_s
csv_file_pth = File.join csv_folder_name , "salesdata.csv"
#CSV.parse(csv_file_pth.read.gsub /\r/, '')
#CSV.parse(csv_file_pth.read.gsub /"/, '')
rowhash = {}

Filtercopart.where(record_status: "A").each do |filtercopart|	
puts "filtercopart loop"
counter = 0

CSV.foreach( csv_file_pth , :headers => true) do |row|
begin	
puts "--------------------------NEW CSV ROW--------------------------"

puts row[7]
puts row [8]
isgood = false
isbad = false

row.each do |col|
puts "NEW CSV ROW COL"
puts col

rowhash[col[0]]=col[1] 

puts col[0]

fl_column=Filterlink.find_by(csv_header_name: col[0].to_s).column_name


  if !fl_column.nil?
  fil_column_val=filtercopart.send fl_column 

  if !fil_column_val.nil? && !fil_column_val.empty? && fil_column_val == col[1]
  	then isgood = true
  elsif !fil_column_val.nil? && !fil_column_val.empty? && fil_column_val != col[1] 
    then 
      isbad = true
  end   	 

puts "fl_column"
puts fl_column
puts "-------"
puts col[0]
puts "-------"
puts fil_column_val
puts "-------"
puts col[1]   
puts "+++++++++"     
  end #!fl_column.nil? 

end #col

puts "is good? " + isgood.to_s
puts "is bad? " + isbad.to_s
if isgood  && !isbad and !rowhash["Lot number"].nil? && !rowhash["Image URL"].nil?
 puts rowhash["Lot number"]
 puts rowhash["Image URL"]

puts "## Download Image ###################################################################"
## images 1 ##################################################################################
require 'open-uri'
profile = Selenium::WebDriver::Firefox::Profile.new
#profile['browser.download.dir'] = '/tmp/webdriver-downloads'
profile['browser.download.folderList'] = 2
profile['browser.helperApps.neverAsk.saveToDisk'] = "text/plain, application/octet-stream , application/csv , application/json"
#profile['browser.download.manager.showAlertOnComplete'] = false

browser = Watir::Browser.start('https://www.copart.com/login/',:firefox, profile: profile)
browser.text_field(name: "username").set "joocha2@gmail.com"
browser.text_field(name: "password").set "1OA7dXdR"
#browser.button(type: "submit").click
browser.button("data-uname"=>"loginSigninmemberbutton").click
sleep 10 

@doc = Nokogiri::HTML(open(rowhash["Image URL"])) 
hh = {}
pic_src=[]
j = 1

pic_folder_name = File.join Rails.root, 'pic_storage', 'fld-' + Date.today.to_s  , rowhash["Lot number"] 
FileUtils.mkdir_p(pic_folder_name) unless File.exist?(pic_folder_name) 

if @doc.css.empty?
  then
  isHdImage = 'no exists'
  jss=JSON[@doc.text]
  jss["lotImages"].each do |jcurs|
  #puts jcurs["link"][1]["isHdImage"].to_s+"===="+jcurs["link"][0]["url"]
    jcurs["link"].each do |jcurs2|
       puts "*********" 
       puts jcurs2["isHdImage"]
       puts jcurs2["url"] 
       puts "*********" 
       if jcurs2["isHdImage"]
        then
        isHdImage = 'exists'
        browser.goto(jcurs2["url"] )
        image_src=browser.image.src
        image_name = "img#{ j }.jpg"
        #File.open("#{pic_folder_name}/image#{j}.jpg", 'wb') do |f|
        File.open(File.join(pic_folder_name, image_name), 'wb') do |f|  
         f.write open(image_src).read
        end # File.ope
        j = j+1
       end # if

    end  #jcurs2
  end  #jcurs

if isHdImage == 'no exists'

jss["lotImages"].each do |jcurs|
  #puts jcurs["link"][1]["isHdImage"].to_s+"===="+jcurs["link"][0]["url"]
    jcurs["link"].each do |jcurs2|
       puts "*********" 
       puts jcurs2["isThumbNail"]
       puts jcurs2["url"] 
       puts "*********" 
       if !jcurs2["isThumbNail"]
        then
        browser.goto(jcurs2["url"] )
        image_src=browser.image.src
        image_name = "img#{ j }.jpg"
        #File.open("#{pic_folder_name}/image#{j}.jpg", 'wb') do |f|
        File.open(File.join(pic_folder_name, image_name), 'wb') do |f|  
         f.write open(image_src).read
        end # File.ope
        j = j+1
       end # if

    end  #jcurs2
  end  #jcurs


end # if isHdImage == 'no exists'
end # if
browser.close

Copart.create(record_status: "N", lot_n: rowhash["Lot number"], row_hash: rowhash, lot_img_fld: pic_folder_name )

###########################################################
 else
 puts "wrong lot"
end #if not bad 

end  # begin
  counter += 1
  puts "#{counter} read success"
end    # CSV.foreach  row

end # Filtercopart


