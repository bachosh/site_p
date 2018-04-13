class Copartjob 
####################### COPART #######################
# gamshvebis skripti
### rails runner -e production  copart_csv.rb
## START

def abc
 puts "Hello World"
end

def self.d_csv
puts "Start D_CSV Job"
	csv_folder_name = File.join Rails.root, 'csv_storage', 'fld-' + Date.today.to_s
	FileUtils.mkdir_p(csv_folder_name) unless File.exist?(csv_folder_name) 

ENV['DISPLAY'] = ":0"
puts "Starting Firefox"
	profile = Selenium::WebDriver::Firefox::Profile.new
	profile['browser.download.dir'] = csv_folder_name
	profile['browser.download.folderList'] = 2
	profile['browser.helperApps.neverAsk.saveToDisk'] = "text/plain, application/octet-stream , application/csv"
	#profile['browser.download.manager.showAlertOnComplete'] = false

	browser = Watir::Browser.start('https://www.copart.com/login/',:firefox, profile: profile)
	browser.text_field(name: "username").set "joocha2@gmail.com"
	browser.text_field(name: "password").set "1OA7dXdR"
	#browser.button(type: "submit").click
	browser.button("data-uname"=>"loginSigninmemberbutton").click
	#sleep 10 

	browser.goto("https://www.copart.com/downloadSalesData/")
	browser.button(:xpath => '//*[@id="csv"]/div[2]/div[1]/div/div/button').click
puts "Start file download"
    sleep 480	
    browser.close
end #d_csv



def self.run_filter
# read copart csv
# rails runner -e production  copart_worker_1.rb
ENV['DISPLAY'] = ":0"
require "csv"
csv_folder_name = File.join Rails.root, 'csv_storage', 'fld-' + Date.today.to_s
csv_file_pth = File.join csv_folder_name , "salesdata.csv"


puts "Starting Firefox"
	profile = Selenium::WebDriver::Firefox::Profile.new
	profile['browser.download.dir'] = csv_folder_name
	profile['browser.download.folderList'] = 2
	profile['browser.helperApps.neverAsk.saveToDisk'] = "text/plain, application/octet-stream , application/csv"
	#profile['browser.download.manager.showAlertOnComplete'] = false

	browser = Watir::Browser.start('https://www.copart.com/login/',:firefox, profile: profile)
	browser.text_field(name: "username").set "joocha2@gmail.com"
	browser.text_field(name: "password").set "1OA7dXdR"
	browser.button("data-uname"=>"loginSigninmemberbutton").click
        sleep 10 

#CSV.parse(csv_file_pth.read.gsub /\r/, '')
#CSV.parse(csv_file_pth.read.gsub /"/, '')
rowhash = {}
fl=File.open(csv_file_pth).first
hdr=CSV.parse(fl)[0]

Filterlink.update_all(csv_header_numb: 9999)

nn = 0
hdr.each do |n|
#puts n
headr_n = Filterlink.find_by(csv_header_name: n)
if !headr_n.nil?
 headr_n.csv_header_numb = nn 
 headr_n.save
end
nn = nn + 1 
end


Filtercopart.where(record_status: "A").each do |filtercopart|	
#puts "-------------------------filtercopart loop------------------------"
counter = 0


File.open(csv_file_pth).each do |line| # `foreach` instead of `open..each` does the same
begin  
puts "@@@@@@@@@@@@@@@@@@@@@@@@@@----NEW FILE LINE-----@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"  	

rownum = 0

CSV.parse(line) do |row|	
#puts "--------------------------NEW CSV ROW--------------------------"
@isgood = false
@isbad = false
row.each do |csv_column_val| 
#puts "--------------------------NEW csv_column_val-------------------------"	

col = Filterlink.find_by(csv_header_numb: rownum)

if !col.nil?
 fcolname = col.column_name
 csv_colname = col.csv_header_name
 rowhash[csv_colname] = csv_column_val
end  #if 

if !fcolname.nil? and !fcolname.empty?
  fil_column_val=filtercopart.send fcolname
  if !fil_column_val.nil?  
    #puts "sadziebo parametri: " + fcolname
    #puts "filter value: " + fil_column_val
    #puts "CSV file value: " + csv_column_val

   if  !csv_column_val.nil? && !csv_column_val.empty?
	if !fil_column_val.empty? and  fil_column_val != csv_column_val  
	  @isbad = true 	
	elsif !fil_column_val.nil? and fil_column_val == csv_column_val and @isbad == false
	  @isgood = true	
	end   #if 
   end # if	
	   
  end #if 
else 
  rownum = rownum + 1	
  next  # es CSV col ar gvainteresebs  
end #if 


puts "is good? " + @isgood.to_s
puts "is bad? " + @isbad.to_s

#puts "--------------------------------------------- "
rownum = rownum + 1

end # csv_column_val

if @isgood  && !@isbad and !rowhash["Lot number"].nil? && !rowhash["Image URL"].nil?
 #puts rowhash["Lot number"]
 #puts rowhash["Image URL"]

puts "## Download Image ###################################################################"
## images 1 ##################################################################################
require 'open-uri'

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
       #puts "*********" 
       #puts jcurs2["isHdImage"]
       #puts jcurs2["url"] 
       #puts "*********" 
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
       #puts "*********" 
       #puts jcurs2["isThumbNail"]
       #puts jcurs2["url"] 
       #puts "*********" 
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
#browser.close

Copart.create(record_status: "N", lot_n: rowhash["Lot number"], row_hash: rowhash, lot_img_fld: pic_folder_name )

###########################################################
 else
 #puts "wrong lot"
end #if not bad 

end # pars line row

#rescue Exception => er
rescue CSV::MalformedCSVError => er
	puts er.message
	counter += 1
next
end  # begin
  counter += 1
  puts "#{counter} read success"
end # FILE line csv  

end # Filtercopart
browser.close
end # run filter
end # class
