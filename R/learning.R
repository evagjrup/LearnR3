# Basis of R --------------------------------------------------------------

colnames(airquality)
head(airquality)
str(airquality)
summary(airquality)

## If you wrote your code in a non-stylish matter, you can either highlight
## your code and press cmd+shift+A or simply put the curser at the end of
## the code, press cmd+shift+P and choose "style active file"

1+1
mean(2:6)

# Loading packages --------------------------------------------------------

library(tidyverse)

r3::check_git_config()


# Comitting ---------------------------------------------------------------

# This will be used for testing out Git


# GitHub setup ------------------------------------------------------------

usethis::gh_token_help()
usethis::create_github_token()

# !!!Personal token: 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

gitcreds::gitcreds_set()
## Fill in prompt in console
usethis::git_sitrep()
## Diagnostic tool

usethis::use_github()
