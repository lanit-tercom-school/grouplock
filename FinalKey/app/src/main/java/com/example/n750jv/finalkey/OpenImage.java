package com.example.n750jv.finalkey;

import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.TransitionDrawable;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
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
import android.widget.TextView;

public class OpenImage extends AppCompatActivity {

    //private SectionsPagerAdapter mSectionsPagerAdapter;
    private ViewPager mViewPager;
    private TransitionDrawable mTransition;
    int n = 5;//зависит от того, сколько ключей выбрано
    private ImageButton image;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_open_image);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
      //  mSectionsPagerAdapter = new SectionsPagerAdapter(getSupportFragmentManager());

       // mViewPager = (ViewPager) findViewById(R.id.container);
     //   mViewPager.setAdapter(mSectionsPagerAdapter);

        ImageView iv = (ImageView)findViewById(R.id.image);
        int numberimage = getIntent().getIntExtra("numberimage", 0);
        final int id = getResources().getIdentifier("qr" + numberimage, "drawable", getPackageName());
        Bitmap bm = BitmapFactory.decodeResource(getResources(),
                id);
        iv.setImageBitmap(bm);
    }

/*
    public static class PlaceholderFragment extends Fragment {

        private static final String ARG_SECTION_NUMBER = "section_number";

        public PlaceholderFragment() {
        }

        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_open_image, container, false);
            ImageView iv = (ImageView) rootView.findViewById(R.id.image);
            int numberimage = getActivity().getIntent().getIntExtra("numberimage", 0);
            final int id = getResources().getIdentifier("qr" + numberimage, "drawable", getActivity().getPackageName());
            Bitmap bm = BitmapFactory.decodeResource(getResources(),
                    id);
            iv.setImageBitmap(bm);
            return rootView;
        }
    }

    public class SectionsPagerAdapter extends FragmentPagerAdapter {

        public SectionsPagerAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            return PlaceholderFragment.newInstance(position + 1);
        }

        @Override
        public int getCount() {
            return n;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            int numberimage = getIntent().getIntExtra("numberimage", 0);
            int id;
            Bitmap bm;
            position = numberimage;
            switch (position) {
                case 1:
                    id = getResources().getIdentifier("qr" + position, "drawable", getPackageName());
                    bm = BitmapFactory.decodeResource(getResources(),
                            id);

                case 2:
                    id = getResources().getIdentifier("qr" + position, "drawable", getPackageName());
                    bm = BitmapFactory.decodeResource(getResources(),
                            id);
                case 3:
                    id = getResources().getIdentifier("qr" + position, "drawable", getPackageName());
                    bm = BitmapFactory.decodeResource(getResources(),
                             id);
            }
            return null;
        }
}*/
}
