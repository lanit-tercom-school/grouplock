package com.example.sonya.grouplockapplication.Encryption;

import android.graphics.Bitmap;

import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by NIKKAS on 14.07.2016.
 */
public class EncrJPG implements IEncryption {
    public Bitmap image;
    public String key;
    public String keyForDecr;
    EncrJPG(Bitmap img){
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
    public void SaveResult(String FilePath) {
        FileOutputStream out = null;
        try {
            out = new FileOutputStream(FilePath);
            image.compress(Bitmap.CompressFormat.PNG, 90, out);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
