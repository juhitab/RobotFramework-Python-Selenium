# python file to store all the locators of the page/s
# create python variables to be used in place of the locator strategy (name:nameAttribute) in robot files
loginEmail = 'id:email'
loginPassword = 'id:password'
loginButton = 'name:submit'

# home page
logoutButton = "xpath://input[@value='Log out']"
editProfile = 'Edit Profile'    # link text

# edit profile page
titleDrpdn = 'id:user_title'
surname = 'id:user_surname'
firstname = 'id:user_firstname'
phone = 'id:user_phone'    
birth_year = 'id:user_dateofbirth_1i'
birth_month = 'id:user_dateofbirth_2i'
birth_day = 'id:user_dateofbirth_3i'
licenseTypeName = 'user[licencetype]'
licensePeriod = 'id:user_licenceperiod' 
occupation = 'user_occupation_id'   # may not use id: --default
address_street = 'user_address_attributes_street'   # may not use id: --default
address_city = 'user_address_attributes_city'
address_country = 'user_address_attributes_county'
postcode = 'user_address_attributes_postcode'
updateUserBtn = 'name:commit'
