package com.example.sonya.grouplockapplication.Encryption;


import android.graphics.Bitmap;

public interface IEncryption {
    String EncrImg();           //шифрует изображение и возвращает ключ
    Bitmap ResultEncr();

    Bitmap ResultDecr(String DecrKey);
}
