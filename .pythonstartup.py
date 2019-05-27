try:
    import readline
except ImportError:
    try:
        import gnureadline as readline
    except ImportError:
        print("could not import readline")
try:
    import rlcompleter
except ImportError:
    print("could not import rlcompleter")
autocompletion = globals()
autocompletion.update(locals())
completer = rlcompleter.Completer(autocompletion)
readline.parse_and_bind("tab: complete")
readline.set_completer(completer.complete)
