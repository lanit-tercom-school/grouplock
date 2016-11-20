package grouplockapplication;

import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import grouplockapplication.R;

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
