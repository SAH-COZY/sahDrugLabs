function file_exists(name)
    if io.popen("if exist resources/[server]/[little_scripts-DONTCARE]/sahDrugLabs/admin_list.json (echo 1)"):read'*l'=='1' then return true end
end