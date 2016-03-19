###############################################
#
#   Odds and ends for debugging
#
###############################################

def print_call_chain(*args):
    import sys
    print(" ".join(map(str, args)))
    f = sys._getframe(1)
    while f:
        name = f.f_code.co_name
        s = f.f_locals.get('self', None)
        if s:
            c = getattr(s, "__class__", None)
            if c:
                name = "{0!s}.{1!s}".format(c.__name__, name)
        print("Called from: {0!s} {1!s}".format(name, f.f_lineno))
        f = f.f_back
    print("-" * 70)
