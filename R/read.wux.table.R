
# ----------------------------------------------------------------
# $Author: thm $
# $Date: 2011-11-23 11:11:32 +0100 (Wed, 23 Nov 2011) $
# $Rev: 183 $
# ----------------------------------------------------------------

read.wux.table <- function(file, ...){
  ## Reads in the WUX data.frame csv file saved on harddisk
  ##
  ## Args:
  ##   file: Character filename
  ##   ...: further args used in read.table
  ##
  ## History:
  ##   2011-09-29 | original code

  data.frame.out <- read.table(file, sep = ";", header = TRUE, ...)

  return(data.frame.out)
}


                            
