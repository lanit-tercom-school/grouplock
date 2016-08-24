package com.example.sonya.grouplockapplication.Encryption;


import android.graphics.Bitmap;

public interface IEncryption {
    void EncrImg();           //шифрует изображение
    Bitmap ResultEncr();

    Bitmap ResultDecr(String DecrKey);

    String[] PartsOfSecret(int minK, int maxK);

    void SaveResult(String FilePath);
}
