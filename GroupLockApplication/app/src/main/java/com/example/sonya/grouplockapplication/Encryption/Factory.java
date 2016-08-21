package com.example.sonya.grouplockapplication.Encryption;

import android.graphics.Bitmap;

/**
 * Created by NIKKAS on 14.07.2016.
 */
public class Factory {
    public Bitmap image;
    public Factory(Bitmap img){
        image=img;
    }
    public IEncryption getClass(String typeImg){
        if(typeImg.equals("bmp"))
            return new EncrBMP(image);
        else if(typeImg.equals("jpg")||typeImg.equals("jpeg"))
            return new EncrJPG(image);
        else if(typeImg.equals("png"))
            return new EncrPNG(image);
        return null;
    }
}
