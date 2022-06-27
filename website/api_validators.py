def _validate(val: str, min_len: int, max_len: int) -> bool:
    return val is not None and len(val) >= min_len and len(val) <= max_len


def first_name(value: str) -> bool:
    return _validate(value, 2, 64)

def second_name(value: str) -> bool:
    return first_name(value)

def last_name(value: str) -> bool:
    return first_name(value)

def email(value: str) -> bool:
    return _validate(value, 5, 255) and "@" in value and "." in value and not " " in value

def password(value: str) -> bool:
    return _validate(value, 6, 32) and not " " in value

def username(value: str) -> bool:
    return _validate(value, 2, 16) and not " " in value