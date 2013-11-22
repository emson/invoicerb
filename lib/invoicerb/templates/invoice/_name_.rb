# --- Generated invoicerb metafile ---
# Pleaes edit this file to generate your PDF invoice from.
#
# date defaults to today's date, just 
# append a string date to set your own:
#   e.g. date '2011-11-11'
date
invoice_id 'BCC00001'
client "Big Client Company" do
  # quantity can have a unit value e.g. 23cm
  # price can take other currency values e.g. USD, YEN, EUR
  # discount will calculate the % of the total price * quantity if % suffix is provided
  #   otherwise it will subtract the discount from the total price * quanitity
  # quantity, description,            price,    discount
  job '1',    "Build web page",       'GBP100', '10%'
  job '1',    "Set up servers",       'GBP60',  '0'
  job '2',    "Purchase domain name", 'GBP30',  'GBP10'
end

