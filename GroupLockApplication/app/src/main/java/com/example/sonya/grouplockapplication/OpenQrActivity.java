package com.example.sonya.grouplockapplication;

import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.TransitionDrawable;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;

import android.widget.ImageButton;
import android.widget.ImageView;

public class OpenQrActivity extends AppCompatActivity {

    private ViewPager mViewPager;
  //  private TransitionDrawable mTransition;
   // int n = 5;//зависит от того, сколько ключей выбрано
  //  private ImageButton image;
    Bundle b;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_open_qr);
    //    Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
    //    setSupportActionBar(toolbar);

        b=getIntent().getExtras();
        ImageView iv = (ImageView)findViewById(R.id.imageQR);
        iv.setImageBitmap((Bitmap)b.get("QrCode"));
    }
}
