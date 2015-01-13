get_csv_files <- function(directory, id = 1:332) {
  csv_files = character()
  
  for (i in id) {
    csv_files <- c(csv_files, paste(src_dir, '/', directory, '/', sprintf("%03d", i), '.csv', sep=''))
  }
  #print(csv_files)
  csv_files
}
