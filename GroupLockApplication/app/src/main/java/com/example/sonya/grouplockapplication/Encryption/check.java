package com.example.sonya.grouplockapplication.Encryption;

import android.os.Environment;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.util.Log;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Random;
import java.lang.String;

/**
 * Created by NIKKAS on 15.07.2016.
 */
public class check {
    public Bitmap source;
    public Bitmap result;
    public String key="";
    public int[] k, expKey;
    public int Height;
    public int Width;
    int redOffset = 234, greenOffset = -132, blueOffset = 17;

    public check(Bitmap bm){
        source=bm;
        Height = source.getHeight();
        Width = source.getWidth();
    }

    public void encr(){
        Random rand = new Random();
        int size=40;
        k=new int[size];
        for (int i = 0; i < size; i++) {
            k[i] = rand.nextInt(255 - 1) + 1;
         //   Log.i("key", Integer.toString(i)+" "+Integer.toString(k[i]));
        }

        expand();

        result = Bitmap.createBitmap(Width , Height , Bitmap.Config.ARGB_8888);
        int[] srcPixels = new int[Width * Height ];
        source.getPixels(srcPixels, 0, Width, 0, 0, Width, Height );
        int[] destPixels = new int[Width * Height ];
        int r,g,b;
        for (int i = 0; i < srcPixels.length; i++) {
            r=(((srcPixels[i] & 0xff0000) >> 16)+expKey[i%(expKey.length-3)]+512 + redOffset)%256;
            g=(((srcPixels[i] & 0xff00) >> 8)+expKey[i%(expKey.length-3)+1]+512 + greenOffset)%256;
            b=((srcPixels[i] & 0xff)+expKey[i%(expKey.length-3)+2]+512 + blueOffset)%256;
            destPixels[i]=Color.rgb(r,g,b);
        }
        result.setPixels(destPixels, 0, Width, 0, 0, Width, Height);

        for (int i = 0; i < size; i++)
            key=key+String.format("%03d",k[i]);
    }

    public void decr(String keyDecr){

        int nKey=keyDecr.length()/3;
        k=new int[nKey];
        for(int i=0;i<nKey;i++){
            k[i]=Integer.parseInt(String.copyValueOf(keyDecr.toCharArray(),(i*3),3));
        }

        expand();
      /*  int Height = source.getHeight();
        int Width = source.getWidth();*/
        result = Bitmap.createBitmap(Width , Height , Bitmap.Config.ARGB_8888);
        int[] srcPixels = new int[Width * Height];
        source.getPixels(srcPixels, 0, Width, 0, 0, Width, Height );
        int[] destPixels = new int[Width * Height ];
        int r,g,b;
        for (int i = 0; i < srcPixels.length; i++) {
            r=(((srcPixels[i] & 0xff0000) >> 16)-expKey[i%(expKey.length-3)] + 512 - redOffset)%256;
            g=(((srcPixels[i] & 0xff00) >> 8)-expKey[i%(expKey.length-3)+1] + 512 - greenOffset)%256;
            b=((srcPixels[i] & 0xff)-expKey[i%(expKey.length-3)+2]+ 512 - blueOffset)%256;
            destPixels[i]=Color.rgb(r,g,b);
        }
        result.setPixels(destPixels, 0, Width , 0, 0, Width , Height );
    }

    protected void expand(){
        int numberOfBytes=Height*Width;
        int expandingFactor=numberOfBytes / k.length + 1;
        int[][] expandedKey=new int[k.length][expandingFactor];
        for(int i=0;i<k.length;i++){
            expandedKey[i]=generateExpansion(k[i],expandingFactor);
      /*      String s="";
            for (int j=0;j<expandedKey[i].length;j++)
                s=s+expandedKey[i][j]+" ";
            Log.i("exp",s);*/
        }
        expKey=new int[k.length*expandingFactor];
        for(int i=0;i<expandedKey.length;i++)
            System.arraycopy(expandedKey[i], 0, expKey, i*expandingFactor, expandingFactor);

    }

    protected int[] generateExpansion(int element, int expandingFactor){
        LinearCongruentialGenerator lcg = new LinearCongruentialGenerator(element);
        int[] expansion=new int[expandingFactor];
        for(int i=0;i<expandingFactor;i++)
            expansion[i]=(int)(lcg.random()*255);
        return expansion;
    }
}

class LinearCongruentialGenerator {

    private double _seed;
    private double m = 139968.0;
    private double a = 3877.0;
    private double c = 29573.0;

    LinearCongruentialGenerator(double seed) {
        _seed = seed;
    }
    public double random() {
        _seed = (_seed * a + c) % m;
        return _seed / m;
    }
}