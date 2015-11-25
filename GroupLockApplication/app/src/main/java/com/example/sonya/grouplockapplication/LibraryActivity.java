package com.example.sonya.grouplockapplication;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.*;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import java.io.File;
import java.util.ArrayList;
import java.util.List;


public class LibraryActivity extends AppCompatActivity {

    private List<String> directoryEntries = new ArrayList<String>();
    private File currentDirectory = new File("/");
    ListView list1;


    @Override
    protected void onCreate(Bundle savedInstanceState) {


        super.onCreate(savedInstanceState);
        setContentView(R.layout.library_layout);
        Toolbar mToolbar = (Toolbar) findViewById(R.id.toolbar_actionbar);
        setSupportActionBar(mToolbar);
        File folder = new File("/storage/emulated/0"+"/GroupLockLibrary");
        boolean success = true;
        if (!folder.exists()) {
            success = folder.mkdir();
        }
        File folder1 = new File("/storage/emulated/0"+"/GroupLockLibrary/Encrypted");
        File folder2 = new File("/storage/emulated/0"+"/GroupLockLibrary/Decrypted");
        success = true;
        if (!folder1.exists()) {
            success = folder1.mkdir();
        }
        success = true;
        if (!folder2.exists()) {
            success = folder2.mkdir();
        }
        browseTo(new File("/storage/emulated/0/GroupLockLibrary"));

    }

    //browse to file or directory
    private void browseTo(final File aDirectory){
        //if we want to browse directory
        if (aDirectory.isDirectory()){
            //fill list with files from this directory
            this.currentDirectory = aDirectory;
            fill(aDirectory.listFiles());

            //set titleManager text
            TextView titleManager = (TextView) findViewById(R.id.titleManager);
            titleManager.setText(aDirectory.getAbsolutePath());
        } else {
            //if we want to open file, show this dialog:
            //listener when YES button clicked
            DialogInterface.OnClickListener okButtonListener = new DialogInterface.OnClickListener(){
                public void onClick(DialogInterface arg0, int arg1) {
                    //intent to navigate file
                    Intent i = new Intent(android.content.Intent.ACTION_VIEW, Uri.parse("file://" + aDirectory.getAbsolutePath()));
                    //start this activity
                    startActivity(i);
                }
            };
            //listener when NO button clicked
            DialogInterface.OnClickListener cancelButtonListener = new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface arg0, int arg1) {
                    //do nothing
                    //or add something you want
                }
            };

            //create dialog
            new AlertDialog.Builder(this)
                    .setTitle("Подтверждение") //title
                    .setMessage("Хотите открыть файл "+ aDirectory.getName() + "?") //message
                    .setPositiveButton("Да", okButtonListener) //positive button
                    .setNegativeButton("Нет", cancelButtonListener) //negative button
                    .show(); //show dialog
        }
    }

    //fill list
    private void fill(File[] files) {
        //clear list
        this.directoryEntries.clear();

        if (this.currentDirectory.getParent() != null)
            this.directoryEntries.add("..");

        //add every file into list
        for (File file : files) {
            if(file.isDirectory()){
                this.directoryEntries.add(file.getName() + "/");
            }else{
                this.directoryEntries.add(file.getName());
            }
        }

        // получаем элемент ListView
        ListView seeDirectories = (ListView) findViewById(R.id.list_view);

        // создаем адаптер
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.row, this.directoryEntries);

        // устанавливаем для списка адаптер
        seeDirectories.setAdapter(adapter);
    }
/*
   @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        //get selected file name
        String selectedFileString = this.directoryEntries.get(position);
        //if we select ".." then go upper
        if(selectedFileString.equals("..")){
            this.upOneLevel();
        }
        else {
            //browse to clicked file or directory using browseTo()
            File clickedFile = null;
            clickedFile = new File(selectedFileString);
            if (clickedFile.isDirectory()) {
                if(clickedFile.canRead()){
                    getDir(selectedFileString,position);
                }else{
                    new AlertDialog.Builder(this)
                            .setTitle("[" + clickedFile.getName() + "] folder can't be read!")
                            .setPositiveButton("OK", null).show();
                }
            }else {
                new AlertDialog.Builder(this)
                        .setTitle("[" + clickedFile.getName() + "]")
                        .setPositiveButton("OK", null).show();

            }
        }
    }
*/
    //browse to parent directory
    private void upOneLevel(){
        if(this.currentDirectory.getParent() != null) {
            this.browseTo(this.currentDirectory.getParentFile());
        }
    }



    public void GoToPrevStep(View v)
    {
        Intent intent  = new Intent(this, ChooseToDoActivity.class);
        startActivity(intent);
    }



    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.library_menu, menu);
        return true;
    }



    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // получим идентификатор выбранного пункта меню
        int id = item.getItemId();


        // Операции для выбранного пункта меню
        switch (id) {
            case R.id.action_settings:
                return true;

            case R.id.action_change:
                return true;

            case R.id.action_search:
                return true;

            case R.id.action_create:

                //create dialog
                AlertDialog.Builder alert =new AlertDialog.Builder(this)
                        .setTitle("Создание папки") //title
                        .setMessage("Введите название новой папки");

                // Set an EditText view to get user input
                final EditText input = new EditText(this);
                alert.setView(input);

                alert.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        String value = input.getText().toString();

                        String name = "/" + value;

                        File folder = new File("/storage/emulated/0/GroupLockLibrary" +name);
                        boolean success = true;
                        if (!folder.exists()) {
                            success = folder.mkdir();
                        }
                        Intent intent = getIntent();
                        startActivity(intent);
                    }
                });
                alert.show();
                return true;
            case R.id.help_button:
                //create dialog
                AlertDialog.Builder helpMe =new AlertDialog.Builder(this)
                        .setTitle("Information") //title
                        .setMessage("Choose directory!");

                // Set an EditText view to get user input
                helpMe.show();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }


    //@Override
    //protected int getListViewId() {
    //    return R.id.list_view;
    //}
}