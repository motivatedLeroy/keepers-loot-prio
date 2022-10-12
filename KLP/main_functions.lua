function search_for_item(itemname)
 for index, value in next, Run_loot_table do
  if value["loot_id"] == itemname then
   return value["prio"]
  end
 end
end