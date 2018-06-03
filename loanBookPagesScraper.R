# This script downloads pages from a loaned book in archive.org using R

# install.packages(c("httr", "jpeg")
library("jpeg")
library("httr")

# -------------------------------- download multiple images in a loop ---------
# get all these headers & cookies by examining Headers in a browser( eg F12 in Chrome)
# this is not an exhaustive list, if you see any more headers, cookies, add them here
headerAccept <- "image/webp,image/apng,image/*,*/*;q=0.8"
headerEncoding <- "gzip, deflate, br"
headerLang <- "en-US,en;q=0.9"
headerCache <- "max-age=0"
headerConnection <- "keep-alive"
headerHost <- "ia802304.us.archive.org"
# headerUpgradeInsecure <- "1"
headerReferrer <- "https://archive.org/stream/modernfrenchcour00dond"
headerAgent <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"

cookieTest <- 1
cookieAuth <- "%2F%2Farchive.org%2Fservices%2Fborrow%2FXXX%3Fmode%3Dauth"

# ----------- get your own!! -----------------
cookiePhpSess <- "..." # eg "sglhw88lwjhklh"
cookieLoggedInSign <- "..." # eg "sglhw88lwjhklh-iugius"
cookieLoggedInUser <- "..." # eg "tyry.popo@gxxx.com"
cookieLoanNum <- 123456 # change this
cookieLoanName <- "..." # eg. "fgijwt3"

# THIS EXPIRES FROM TIME TO TIME !!
cookieLoanID <-  "..." # eg "doijiwpi"

# from, to are oage numbers
for(i in seq(from=1, to=20)){
  imgNum <- formatC(i, width = 4, format = "d", flag = "0")
  imgUrl <- paste0("https://ia802304.us.archive.org/BookReader/BookReaderImages.php?zip=/1/items/modernfrenchcour00dond/modernfrenchcour00dond_jp2.zip&file=modernfrenchcour00dond_jp2/modernfrenchcour00dond_",
                   imgNum,
                   ".jp2&scale=6.311195445920304&rotate=0")
  
  req <- GET(url = imgUrl,
             add_headers("Accept" = headerAccept,
                         "Accept-Encoding" = headerEncoding,
                         "Accept-Language" = headerLang,
                         "Cache-Control" = headerCache,
                         "Connection" = headerConnection,
                         "Host"= headerHost,
                         # "Upgrade-Insecure-Requests" = headerUpgradeInsecure, 
                         "Referer" = headerReferrer,
                         "User-Agent" = headerAgent),
             set_cookies("test-cookie" = cookieTest,
                         "PHPSESSID" = cookiePhpSess,
                         "logged-in-sig" = cookieLoggedInSign,
                         "logged-in-user" = cookieLoggedInUser,
                         "br-loan-modernfrenchcour00dond" = cookieLoanNum,
                         "ol-auth-url" = ,
                         cookieLoanName = cookieLoanID)
  )
  
  if(req$status_code == 200){
    writeJPEG(image = content(req), target = paste0("pages/Page", imgNum, ".jpg"))
  }
}