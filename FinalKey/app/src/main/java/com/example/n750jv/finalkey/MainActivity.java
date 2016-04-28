package com.example.n750jv.finalkey;

import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.TransitionDrawable;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.DisplayMetrics;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TableLayout;
import android.widget.TableRow;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    private TransitionDrawable mTransition;
    ArrayList<ImageButton> buttonList = new ArrayList<ImageButton>();
    int n = 5;//зависит от того, сколько ключей выбрано
    int nextbutton = n;
    Resources res;
    Bitmap bmNewSize;
    Bitmap bmOriginal;
    Button next;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        TableLayout tableLayout = (TableLayout) findViewById(R.id.tableLayout);
        res = this.getResources();
        mTransition = (TransitionDrawable) res.getDrawable(R.drawable.transition);
        DisplayMetrics metrics = res.getDisplayMetrics();
        float px = 85 * (metrics.densityDpi / 160f);

        for (int i = 0; i < (n / 3) + 1; i++) {
            TableRow tableRow = new TableRow(this);
            tableRow.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));
            for (int j = 0; j < 3; j++) {//столбцы
                final int numberimage = i * 3 + (j + 1);
                final int id = getResources().getIdentifier("qr" + numberimage, "drawable", getPackageName());
                bmOriginal = BitmapFactory.decodeResource(getResources(),
                        id);
                bmNewSize = Bitmap.createScaledBitmap(bmOriginal, (int) px,
                        (int) px, false);
                buttonList.add(new ImageButton(this));
                buttonList.get(numberimage - 1).setImageBitmap(bmNewSize);

                buttonList.get(numberimage - 1).setOnClickListener(new View.OnClickListener() {
                    public void onClick(View v) {
                        Intent intent = new Intent(MainActivity.this,
                                OpenImage.class);
                        intent.putExtra("numberimage", numberimage);

                        startActivity(intent);

                        buttonList.get(numberimage - 1).setAlpha(100);
                        nextbutton--;
                        if (nextbutton ==0){}
                    }
                });
                tableRow.addView(buttonList.get(numberimage - 1), j);

                if (numberimage >= n) break;
            }
            tableLayout.addView(tableRow, i);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.menu_open_image, menu);
        return true;
    }

}
