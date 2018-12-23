#!/usr/bin/env stack
-- stack --install-ghc runghc

import Data.Maybe
import System.Environment
import System.Process

main :: IO ()
main = do
    args <- getArgs
    run args

run :: [String] -> IO ()
run (cmd:args) = fromMaybe (\x -> err (cmd:x)) (lookup cmd dispatch) args
run _ = help []

dispatch :: [(String, [String] -> IO ())]
dispatch = [ ("add", add)
           , ("remove", remove)
           , ("glue", glue)
           , ("unglue", unglue)
           , ("-h", help)
           , ("--help", help)
           , ("-V", version)
           , ("--version", version)
           ]

--help, -h
help :: [String] -> IO ()
help _ = putStrLn "\
    \Cleopatra 0.5.0\n\
    \Yvan SRAKA <yvan@sraka.pw>\n\
    \Micro virtual environment for YeAST\n\
    \\n\
    \USAGE:\n\
    \    cleopatra <COMMAND>\n\
    \\n\
    \FLAGS:\n\
    \    -h, --help       Prints help information\n\
    \    -V, --version    Prints version information\n\
    \\n\
    \COMMANDS:\n\
    \    add <program>    Alias YeAST to be call instead of <program> inside\
                        \ virtual environment\n\
    \    remove <program> Remove alias set for <program>\n\
    \    glue             Enter the virtual environment by opening a new shell\
                        \ where ./cleopatra folder is in PATH\n\
    \    unglue           Exit the virtual environment without leaving current\
                        \ opened shell"

--version, -V
version :: [String] -> IO ()
version _ = putStrLn "Cleopatra 0.1.0"

err :: [String] -> IO ()
err (cmd:args) = putStrLn ("\x1b[31merror:\x1b[0m\
    \Found command '" ++ cmd ++ "' which wasn't expected, or isn't valid in \
    \this context")
err [] = return ()

add :: [String] -> IO ()
add (x:xs) = do
    _ <- system ("mkdir -p .cleopatra \
             \ && echo \"YEAST_CONTEXT=$(which " ++ x ++ ") yeast \\$@\" \
                 \ > .cleopatra/" ++ x ++ " \
             \ && chmod +x .cleopatra/" ++ x)
    -- TODO putStrLn
    add xs
add [] = return ()

remove :: [String] -> IO ()
remove (x:xs) = do
    _ <- system ("rm .cleopatra/" ++ x)
    -- TODO putStrLn
    remove xs
remove [] = return ()

glue :: [String] -> IO ()
glue _ = do
    -- TODO putStrLn
    _ <- system "PATH=.cleopatra:$PATH $SHELL"
    return ()

unglue :: [String] -> IO ()
unglue _ = do
    -- TODO Ctrl+D instruction
    _ <- system "export PATH=${PATH%:.cleopatra/}"
    return ()
