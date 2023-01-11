#' @title Create all possible peptides
#' @description Create all possible peptides.
#'
#' @param pep_seq the peptide sequence.
#' @param aa which amino acids to use for X.
#'
#' @details The peptide sequence should follow the format: ...X..X... or ...X..
#'
#' @return A list with all 3 parts and all new combinations.
#'
#' @noRd
#'
#' @author Rico Derks
#'
create_peptides <- function(pep_seq = NULL, aa = NULL) {
  # define all possible amino acids
  all_aa <- "GASPVTLINDQKEMHFRYWC"

  # create a character vector of the amino acids
  aa <- paste0(aa, collapse = "")

  ## sanity checks
  if(is.null(pep_seq)) {
    stop("'pep_seq' needs to be a peptide sequence!")
  }
  # check if pep_seq is a correct peptide sequence
  if(!grepl(pattern = paste0("^[", paste0(all_aa, "X"), "]+$"), x = pep_seq)) {
    stop("'pep_seq' contains characters which do not represent a peptide sequence!")
  }
  # check if aa contains amino acids
  if(!grepl(pattern = paste0("^[", paste0(all_aa, "X"), "]+$"), x = aa)) {
    stop("'aa' contains characters which do not represent an amino acid!")
  }
  # check if peptide sequence is ...X...X... as a minimum
  if(!grepl(pattern = paste0("^[", all_aa, "]+X{1,}[", all_aa, "]*X{0,}[", all_aa, "]+$"), x = pep_seq)) {
    stop("'pep_seq' doesn't contain the minimum pattern ...X...X... or ...X...!")
  }

  # determine how many sites with X's are in the peptide sequence
  num_x_site <- length(gregexpr(pattern = "[X]+", text = pep_seq)[[1]])

  ## split the peptide sequence
  first_part <- gsub(x = pep_seq,
                     pattern = paste0("^([", all_aa, "]*)X*.*$"),
                     replacement = "\\1")
  # if the format is ...X. there is no middle part
  if(num_x_site == 2) {
    middle_part <- gsub(x = pep_seq,
                        pattern = paste0("^[", all_aa, "]+X{1,}([", all_aa, "]+)X{1,}[", all_aa, "]+$"),
                        replacement = "\\1")
  } else {
    middle_part <- ""
  }
  # get the last part of the peptide
  last_part <- gsub(x = pep_seq,
                    pattern = paste0("^.*X([", all_aa, "]*)$"),
                    replacement = "\\1")


  # define the pattern
  x_pattern <- paste0("^[", all_aa, "]*([X]{1,})", middle_part, "([X]{0,})[", all_aa, "]*$")
  # get the first few X's
  x1 <- nchar(gsub(x = pep_seq,
                   pattern = x_pattern,
                   replacement = "\\1"))
  # get the last few X's
  x2 <- nchar(gsub(x = pep_seq,
                   pattern = x_pattern,
                   replacement = "\\2"))
  # total number of X's
  tot_x <- x1 + x2

  # initialize amino acid list
  aa_list <- vector(mode = "list", length = tot_x)

  # make the amino acid list for each X
  for (a in 1:tot_x) {
    aa_list[[a]] <- strsplit(x = aa,
                             split = "")[[1]]
  }

  # create all combinations
  all_X_combs <- expand.grid(aa_list,
                             stringsAsFactors = FALSE)

  # make the sequence for first X('s) en last X('s).
  if(num_x_site == 2) {
    # check how many columns there are in part1 and paste multiple columns if needed
    if(x1 == 1) {
      part1 <- all_X_combs[, 1:x1]
    } else {
      part1 <- do.call(paste, c(all_X_combs[, 1:x1], sep =""))
    }
    # check how many columns there are in part2 and paste multiple columns if needed
    if(tot_x - (x1 + 1) == 0) {
      part2 <- all_X_combs[, (x1 + 1):tot_x]
    } else {
      part2 <- do.call(paste, c(all_X_combs[, (x1 + 1):tot_x], sep =""))
    }

    all_combs <- cbind(part1, part2)
  } else {
    # check how many columns there are in part1 and paste multiple columns if needed
    if(x1 == 1) {
      all_combs <- all_X_combs[, 1:x1]
    } else {
      all_combs <- do.call(paste, c(all_X_combs[, 1:x1], sep =""))
    }
  }

  # make all new peptide sequences and convert to data.frame for writing
  if(num_x_site == 2) {
    new_peptide_seq <- data.frame(peptides = paste0(first_part,
                                                    all_combs[, 1],
                                                    middle_part,
                                                    all_combs[, 2],
                                                    last_part))
  } else {
    new_peptide_seq <- data.frame(peptides = paste0(first_part,
                                                    all_combs,
                                                    last_part))
  }

  # return everything as a list
  return(list(first = first_part,
              middle = middle_part,
              last = last_part,
              all_peptides = new_peptide_seq))
}
