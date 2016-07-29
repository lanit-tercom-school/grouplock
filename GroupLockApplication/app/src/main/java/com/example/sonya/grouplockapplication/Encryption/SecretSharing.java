package com.example.sonya.grouplockapplication.Encryption;

/**
 * Created by NIKKAS on 24.07.2016.
 */
public class SecretSharing {
    public String key;
    int minK, maxK;

    SecretSharing(String K, int min, int max){
        key=K;
        minK=min;
        maxK=max;
    }

    public String[] Sharing(){
        String[] Secret = new String[maxK];
        int sizePart=Math.round(key.length() / maxK);
        for(int i=0;i<maxK;i++)
            if (i!=(maxK-1))
                Secret[i]=String.copyValueOf(key.toCharArray(),(i*sizePart),sizePart);
            else
                Secret[i]=String.copyValueOf(key.toCharArray(),(i*sizePart),key.length()-i*sizePart);
        return Secret;
    }
}
