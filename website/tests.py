# from django.test import TestCase

# Create your tests here.


def dick(func):
    def wrapper():
        print(123)
        f = func()
        print(456)
        return f
    return wrapper


@dick
def test(f="gdfg"):
    return f

print(test())