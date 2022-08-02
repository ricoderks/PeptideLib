test_that("input", {
  expect_error(create_peptides(aa = "GASPVTLINDQKEMHFRYWC"),
               regexp = "'pep_seq' needs to be a peptide sequence!")
  expect_error(create_peptides(pep_seq = "GASPVTLINDQKEMHFRYWCZ",
                               aa = "GASPVTLINDQKEMHFRYWC"),
               regexp = "'pep_seq' contains characters which do not represent a peptide sequence!")
  expect_error(create_peptides(pep_seq = "GASPVTLINDQKEMHFRYWC"),
               regexp = "'aa' contains characters which do not represent an amino acid!")
  expect_error(create_peptides(pep_seq = "GASPVTLINDQKEMHFRYWC",
                               aa = "GASPVTLINDQKEMHFRYWCZ"),
               regexp = "'aa' contains characters which do not represent an amino acid!")
})

test_that("output", {
  expect_equal(create_peptides(pep_seq = "GASXPPXGAS",
                               aa = "TY"),
               list(first = "GAS",
                    middle = "PP",
                    last = "GAS",
                    all_peptides = data.frame(peptides = c("GASTPPTGAS", "GASYPPTGAS", "GASTPPYGAS", "GASYPPYGAS"))))
  expect_equal(create_peptides(pep_seq = "GASXXPPXXGAS",
                               aa = "TY"),
               list(first = "GAS",
                    middle = "PP",
                    last = "GAS",
                    all_peptides = data.frame(peptides = c("GASTTPPTTGAS", "GASYTPPTTGAS", "GASTYPPTTGAS", "GASYYPPTTGAS",
                                                           "GASTTPPYTGAS", "GASYTPPYTGAS", "GASTYPPYTGAS", "GASYYPPYTGAS",
                                                           "GASTTPPTYGAS", "GASYTPPTYGAS", "GASTYPPTYGAS", "GASYYPPTYGAS",
                                                           "GASTTPPYYGAS", "GASYTPPYYGAS", "GASTYPPYYGAS", "GASYYPPYYGAS"))))
  expect_equal(create_peptides(pep_seq = "GASXPPXXGAS",
                               aa = "TY"),
               list(first = "GAS",
                    middle = "PP",
                    last = "GAS",
                    all_peptides = data.frame(peptides = c("GASTPPTTGAS", "GASYPPTTGAS", "GASTPPYTGAS", "GASYPPYTGAS",
                                                           "GASTPPTYGAS", "GASYPPTYGAS", "GASTPPYYGAS", "GASYPPYYGAS"))))
  expect_equal(create_peptides(pep_seq = "GASXXPPXGAS",
                               aa = "TY"),
               list(first = "GAS",
                    middle = "PP",
                    last = "GAS",
                    all_peptides = data.frame(peptides = c("GASTTPPTGAS", "GASYTPPTGAS", "GASTYPPTGAS", "GASYYPPTGAS",
                                                           "GASTTPPYGAS", "GASYTPPYGAS", "GASTYPPYGAS", "GASYYPPYGAS"))))
  expect_type(create_peptides(pep_seq = "GASXPPXGAS",
                              aa = "TY"),
              "list")
  expect_type(create_peptides(pep_seq = "GASXXPPXXGAS",
                              aa = "TY"),
              "list")
  expect_type(create_peptides(pep_seq = "GASXXPPXGAS",
                              aa = "TY"),
              "list")
  expect_type(create_peptides(pep_seq = "GASXPPXXGAS",
                              aa = "TY"),
              "list")
})
