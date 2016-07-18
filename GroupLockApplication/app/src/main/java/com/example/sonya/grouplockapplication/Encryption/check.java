package com.example.sonya.grouplockapplication.Encryption;


import android.graphics.Bitmap;
import android.graphics.Color;
import android.util.Log;
import java.util.Random;

/**
 * Created by NIKKAS on 15.07.2016.
 */
public class check {
    public Bitmap source;
    public Bitmap result;
    public String key="";

    public check(Bitmap bm){
        source=bm;
        Log.i("Inf","bmp загрузилась");

    }

    public void encr(){
        Random rand = new Random();
        int size=40;
        int[] k=new int[size];
        for (int i = 0; i < size; i++) {
            k[i] = rand.nextInt(255 - 1) + 1;
            /*int k2 = rand.nextInt(8 - 1) + 1;
            int k3 = rand.nextInt(8 - 1) + 1;*/
        }

        int Height = source.getHeight();
        int Width = source.getWidth();
        result = Bitmap.createBitmap(Width , Height , Bitmap.Config.ARGB_8888);
        int[] srcPixels = new int[Width * Height ];
        source.getPixels(srcPixels, 0, Width, 0, 0, Width, Height );
        int[] destPixels = new int[Width * Height ];
        int r,g,b;
        for (int i = 0; i < srcPixels.length; i++) {
            r=(((srcPixels[i] & 0xff0000) >> 16)+k[i%(size-3)])%256;
            g=(((srcPixels[i] & 0xff00) >> 8)+k[i%(size-3)+1])%256;
            b=((srcPixels[i] & 0xff)+k[i%(size-3)+2])%256;
            destPixels[i]=Color.rgb(r,g,b);
        }
        result.setPixels(destPixels, 0, Width , 0, 0, Width , Height );

        for (int i = 0; i < size; i++)
            key=key+k[i]+"|";
      //  Log.i("fm",key);
       // return answer;
    }




}
