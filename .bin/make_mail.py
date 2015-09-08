#!/usr/bin/python

import os

def isDir(name):
    return (os.path.exists(name) and
            os.path.isdir(name))

def isFile(name):
    return (os.path.exists(name) and
            not os.path.isdir(name))

if __name__ == "__main__":
    import argparse

    full_text = ""
    
    parser = argparse.ArgumentParser(description = "Makes a mail")
    
    parser.add_argument("-s", "--subject", help = "Subject of the mail", type=str)
    parser.add_argument("-r", "--recipient", help = "Recipient of the mail", type=str)
    parser.add_argument("-f", "--sender", help = "Sender of the mail", type=str)
    parser.add_argument("-o", "--output", help = "output file", type=str)
    parser.add_argument("--force", help = "force output of file", action = "store_true")

    args = parser.parse_args()

    full_text += "To:"
    if args.recipient == None:
        full_text += "{}\n".format(input("To:"))
    else:
        full_text += args.recipient + '\n'

    full_text += "From:"
    if args.sender == None:
        full_text += "{}\n".format(input("From:"))
    else:
        full_text += args.sender + '\n'

    full_text += "Subject:"
    if args.subject == None:
        full_text += "{}\n".format(input("Subject:"))
    else:
        full_text += args.subject + '\n'

    print()
    while 1:
        try:
            full_text += input() + '\n'
        except EOFError:
            break

    if args.output != None:
        if ((isFile(args.output) and args.force) or
            (not isFile(args.output and not isDir(args.output)))):
            f = open(args.output, "w")
            f.write(full_text)
            f.close() 
        else:
            print("Use --force option if you wan't to overwrite a file")
    else:
        print(full_text)

