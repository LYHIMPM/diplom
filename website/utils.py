import traceback
import uuid
import imghdr
from django.core.files.uploadedfile import UploadedFile
from typing import Optional, Union
from django.conf import settings
import os

def process_uploaded_image(img: UploadedFile) -> Union[str, int]:
    """ 
        Возвращает:
        - editor_hash файла, если файл загружен успешно
        - `-1` - Файл пустой
        - `-2` - Формат файла не поддерживается
        - `-3` - Неизвестная ошибка
    """
    if img is None:
        return -1

    fname = uuid.uuid4().hex
    path = settings.CONSTRUCTOR_IMAGES_FOLDER.joinpath(fname)

    _path = str(settings.CONSTRUCTOR_IMAGES_FOLDER)
    if not os.path.exists(_path):
        os.makedirs(_path)

    with open(path, 'wb') as f:
        for chunk in img.chunks():
            f.write(chunk)
    try:
        ext = imghdr.what(path)
        if ext is None:
            os.remove(path)
            return -2
        newpath = str(path)+"."+ext
        if not ext in settings.CONSTRUCTOR_FORMATS:
            os.remove(path)
            return -2
        else:
            os.rename(path, newpath)
    except Exception:
        traceback.print_exc()
        try:
            os.remove(path)
        except:
            pass
        return -3


    return fname

def get_constructor_img_file_path_by_hash(editor_hash: str) -> Optional[str]:
    dirpath = settings.CONSTRUCTOR_IMAGES_FOLDER
    for fmt in settings.CONSTRUCTOR_FORMATS:
        fp = dirpath.joinpath(editor_hash + "." + fmt)
        if os.path.exists(fp):
            return fp