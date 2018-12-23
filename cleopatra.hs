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
rule (cmd:args)
    | cmd == "--help" = putStrLn "\
        \Cleopatra 0.1.0\n\
        \Yvan SRAKA <yvan@sraka.pw>\n\
        \Micro virtual environment for YeAST\n\
        \\n\
        \USAGE:\n\
        \    cleopatra <COMMAND>...\n\
        \\n\
        \FLAGS:\n\
        \    -h, --help       Prints help information\n\
        \    -V, --version    Prints version information"
    | cmd == "-h" = rule ("--help":[])
    | cmd == "--version" = putStrLn "Cleopatra 0.1.0"
    | cmd == "-V" = rule ("--version":[])
    {- | cmd:args == "add":(x:xs) = do
        _ <- system ("mkdir -p .cleopatra \
                 \ && echo \"YEAST_CONTEXT=$(which " ++ x ++ ") yeast \\$@\" \
                     \ > .cleopatra/" ++ x ++ " \
                 \ && chmod +x .cleopatra/" ++ x)
        rule ("add":xs) -}
    | cmd:args == "add":[] = return ()
    {- | cmd:args == "remove":(x:xs) = do
        _ <- system ("rm .cleopatra/" ++ x)
        rule ("remove":xs) -}
    | cmd:args == "remove":[] = return ()
    | cmd == "glue" = do
        _ <- system "PATH=.cleopatra:$PATH $SHELL"
        return ()
    | otherwise = putStrLn "\x1b[31merror:\x1b[0m \
        \Found command 'TODO' which wasn't expected, or isn't valid in this \
        \context"
rule _ = rule ("--help":[])
