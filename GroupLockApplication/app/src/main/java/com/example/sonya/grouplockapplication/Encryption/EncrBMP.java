package com.example.sonya.grouplockapplication.Encryption;

import android.graphics.Bitmap;

import java.io.IOException;

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

  /*  EncrBMP(Bitmap img, String keyDecr){
        image=img;
        keyForDecr=keyDecr;
    }*/

    public void EncrImg(){

        /*
           Алгоритм шифрования BMP
         */

        check Shifr = new check(image);
        Shifr.encr();
        image=Shifr.result;
        keyForDecr = Shifr.key;
    }

    public Bitmap ResultEncr(){
        return image;
    }

    public Bitmap ResultDecr(String DecrKey){
        check Deshifr = new check(image);
        Deshifr.decr(DecrKey);
        image=Deshifr.result;
        return image;
    }

    public String[] PartsOfSecret(int minK, int maxK){
        SecretSharing Sec=new SecretSharing(keyForDecr,minK,maxK);
        return Sec.Sharing();
    }

    public void SaveResult(String FilePath){
        SaveBMP bmpUtil = new SaveBMP();
        try {
            boolean isSaveResult = bmpUtil.save(image, FilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
