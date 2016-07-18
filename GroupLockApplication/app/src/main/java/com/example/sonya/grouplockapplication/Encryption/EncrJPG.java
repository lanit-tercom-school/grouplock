package com.example.sonya.grouplockapplication.Encryption;

import android.graphics.Bitmap;

/**
 * Created by NIKKAS on 14.07.2016.
 */
public class EncrJPG implements IEncryption {
    public String EncrImg(){

        /*
           Алгоритм шифрования JPG
         */

        return "Key_JPG";
    }
    public Bitmap ResultEncr(){
        return null;
    }

    public Bitmap ResultDecr(){
        return null;
    }
}
