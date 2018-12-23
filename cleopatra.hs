#!/usr/bin/env stack
-- stack --install-ghc runghc

import System.Environment
import System.Process

main :: IO ()
main = do
    -- TODO Pattern match failure if no args were given
    command:args <- getArgs
    command # args

(#) :: String -> [String] -> IO ()

"--help" # _ = putStrLn "\
    \Cleopatra 0.3.0\n\
    \Yvan SRAKA <yvan@sraka.pw>\n\
    \Micro virtual environment for YeAST\n\
    \\n\
    \USAGE:\n\
    \    cleopatra <COMMAND>...\n\
    \\n\
    \FLAGS:\n\
    \    -h, --help       Prints help information\nString\
    \    -V, --version    Prints version information\n\
    \\n\
    \COMMANDS:\n\
    \    add <program>    Aliase YeAST to be call instead of <program> inside\
                        \ virtual environment\n\
    \    remove <program> Remove alias set for <program>\n\
    \    glue             Enter the virtual environment by opening a new shell\
                        \ where ./cleopatra folder is in PATH\n\
    \    unglue           Exit the virtual environment without leaving current\
                        \ opened shell"
"-h" # _ = "--help" # []

"--version" # _ = putStrLn "Cleopatra 0.1.0"
"-V" # _ = "--version" # []

"add" # (x:xs) = do
    _ <- system ("mkdir -p .cleopatra \
             \ && echo \"YEAST_CONTEXT=$(which " ++ x ++ ") yeast \\$@\" \
                 \ > .cleopatra/" ++ x ++ " \
             \ && chmod +x .cleopatra/" ++ x)
    -- TODO putStrLn
    "add" # xs
"add" # [] = return ()

"remove" # (x:xs) = do
    _ <- system ("rm .cleopatra/" ++ x)
    -- TODO putStrLn
    "remove" # xs
"remove" # [] = return ()

"glue" # _ = do
    -- TODO putStrLn
    _ <- system "PATH=.cleopatra:$PATH $SHELL"
    return ()

"unglue" # _ = do
    -- TODO Ctrl+D instruction
    _ <- system "export PATH=${PATH%:.cleopatra/}"
    return ()

cmd # _ = putStrLn ("\x1b[31merror:\x1b[0m \
    \Found argument '" ++ cmd ++ "' which wasn't expected, or isn't valid in \
    \this context")
