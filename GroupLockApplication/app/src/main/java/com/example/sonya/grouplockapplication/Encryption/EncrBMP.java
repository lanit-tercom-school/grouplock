package com.example.sonya.grouplockapplication.Encryption;

import android.graphics.Bitmap;

/**
 * Created by NIKKAS on 14.07.2016.
 */
public class EncrBMP implements IEncryption {
    public Bitmap image;
    public String key;
    public String keyForDecr;
    EncrBMP(Bitmap img){
        image=img;
    }

    EncrBMP(Bitmap img, String keyDecr){
        image=img;
        keyForDecr=keyDecr;
    }

    public String EncrImg(){

        /*
           Алгоритм шифрования BMP
         */

        check Shifr = new check(image);
        Shifr.encr();
        image=Shifr.result;
        return Shifr.key;
    }

    public Bitmap ResultEncr(){
        return image;
    }

    public Bitmap ResultDecr(){
        return null;
    }
}
