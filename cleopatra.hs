#!/usr/bin/env stack
-- stack --install-ghc runghc

import Data.Maybe
import System.Environment
import System.Process

main :: IO ()
main = do
    args <- getArgs
    rule args

rule :: [String] -> IO ()

rule ("--help":_) = putStrLn "\
    \Cleopatra 0.2.0\n\
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

rule ("--version":_) = putStrLn "Cleopatra 0.1.0"
rule ("-V":_) = rule ("--version":[])

rule ("add":x:xs) = do
    _ <- system ("mkdir -p .cleopatra \
             \ && echo \"YEAST_CONTEXT=$(which " ++ x ++ ") yeast \\$@\" \
                 \ > .cleopatra/" ++ x ++ " \
             \ && chmod +x .cleopatra/" ++ x)
    -- TODO putStrLn
    rule ("add":xs)
rule ("add":[]) = return ()

rule ("remove":x:xs) = do
    _ <- system ("rm .cleopatra/" ++ x)
    -- TODO putStrLn
    rule ("remove":xs)
rule ("remove":[]) = return ()

rule ("glue":_) = do
    -- TODO putStrLn
    _ <- system "PATH=.cleopatra:$PATH $SHELL"
    return ()

rule ("unglue":_) = do
    -- TODO : Ctrl+D instruction
    _ <- system "export PATH=${PATH%:.cleopatra/}"
    return ()

rule [] = rule ("--help":[])

rule _ = putStrLn "\x1b[31merror:\x1b[0m \
    \Found argument 'TODO' which wasn't expected, or isn't valid in this \
    \context"
