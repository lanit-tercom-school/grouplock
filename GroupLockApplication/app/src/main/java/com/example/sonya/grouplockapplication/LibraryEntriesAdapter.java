package com.example.sonya.grouplockapplication;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CheckBox;
import android.widget.TextView;

import java.util.ArrayList;


public class LibraryEntriesAdapter extends BaseAdapter {

    Context context;
    LayoutInflater layoutInflater;
    ArrayList<LibraryEntry> libraryEntries;

    public LibraryEntriesAdapter(Context context, ArrayList<LibraryEntry> libraryEntries) {
        this.context = context;
        this.layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.libraryEntries = libraryEntries;
    }

    @Override
    public int getCount() {
        return libraryEntries.size();
    }

    @Override
    public Object getItem(int position) {
        return libraryEntries.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        /* Trying to get View that already exists in order to save resources */
        View view = convertView;
        if (view == null) {
            view = layoutInflater.inflate(R.layout.library_entry, parent, false);
        }

        LibraryEntry entry = (LibraryEntry) getItem(position);
        ((TextView) view.findViewById(R.id.textEntryName)).setText(
                entry.isParent() ? ".." : entry.getName());

        CheckBox isSelected = (CheckBox) view.findViewById(R.id.checkboxIsSelected);
        isSelected.setTag(position);
        /* Hide checkboxes on directories */
        isSelected.setVisibility(entry.isDirectory() ? View.INVISIBLE : View.VISIBLE);
        isSelected.setChecked(entry.isSelected());
        return view;

    }
}
