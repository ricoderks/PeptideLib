#' @title Create all possible peptides
#' @description Create all possible peptides.
#'
#' @param pep_seq the peptide sequence
#'
#' @return A list with all 3 parts and all new combinations.
#'
#' @noRd
#'
#' @author Rico Derks
#'
create_peptides <- function(pep_seq) {
  # define all possible amino acids
  all_aa <- "GASPVTLINDQKEMHFRYWC"

  # amino acids used for X
  used_aa <- "GASPVTLINDQKEMHFRYW"

  ## sanity checks
  if(is.null(pep_seq)) {
    stop("'pep_seq' needs to be a peptide sequence!")
  }
  # check if pep_seq is a correct peptide sequence
  if(!grepl(pattern = paste0("^[", paste0(all_aa, "X"), "]+$"), x = pep_seq)) {
    stop("'pep_seq' contains characters which do not represent a peptide sequence!")
  }

  ## split the peptide sequence
  first_part <- gsub(x = pep_seq,
                     pattern = paste0("^([", all_aa, "]*)X*.*$"),
                     replacement = "\\1")
  middle_part <- gsub(x = pep_seq,
                      pattern = paste0("^.*X{1,}([", all_aa, "]+)X{1,}.*$"),
                      replacement = "\\1")
  # get the last part of the peptide
  last_part <- gsub(x = pep_seq,
                    pattern = paste0("^.*X([", all_aa, "]*)$"),
                    replacement = "\\1")

  # get the first few X's
  x1 <- gsub(x = pep_seq,
             pattern = paste0("^[", all_aa, "]*([X]{1,})", middle_part, "([X]{1,})[", all_aa, "]*$"),
             replacement = "\\1")
  # get the last few X's
  x2 <- gsub(x = pep_seq,
             pattern = paste0("^[", all_aa, "]*([X]{1,})", middle_part, "([X]{1,})[", all_aa, "]*$"),
             replacement = "\\2")

  # total number of X's
  tot_x <- nchar(x1) + nchar(x2)

  # initialize amino acid list
  aa_list <- vector(mode = "list", length = tot_x)

  # make the amino acid list for each X
  for (a in 1:tot_x) {
    aa_list[[a]] <- strsplit(x = used_aa,
                             split = "")[[1]]
  }

  # create all combinations
  all_X_combs <- as.matrix.data.frame(expand.grid(aa_list,
                                                  stringsAsFactors = FALSE))

  # make the sequence for first X('s) en last X('s).
  all_X_combs <- t(apply(all_X_combs, 1, function(x) {
    cbind(paste0(x[1:nchar(x1)], collapse = ""),
          paste0(x[(nchar(x1) + 1):tot_x ], collapse = ""))
  }))

  # make all new peptide sequences and convert to data.frame for writing
  new_peptide_seq <- data.frame(peptides = paste0(first_part,
                                                  all_X_combs[, 1],
                                                  middle_part,
                                                  all_X_combs[, 2],
                                                  last_part))

  # return everything as a list
  return(list(first = first_part,
              middle = middle_part,
              last = last_part,
              all_peptides = new_peptide_seq))
}
