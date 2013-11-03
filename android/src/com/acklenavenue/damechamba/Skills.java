package com.acklenavenue.damechamba;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

public class Skills extends SherlockActivity{

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.skills);
		
		final ListView listview = (ListView) findViewById(R.id.ListView1);
		listview.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE);
		//listview.setItemsCanFocus(false);
		
		final ArrayList<String> listItems=new ArrayList<String>();
		
		ParseQuery<ParseObject> query = ParseQuery.getQuery("Skills");
		query.findInBackground(new FindCallback<ParseObject>() {
			
			@Override
			public void done(List<ParseObject> skills, ParseException e) {
				if (e == null) {
					for(ParseObject skill : skills){
						listItems.add(skill.getString("title"));
					}
					ArrayAdapter<String> adapter=new ArrayAdapter<String>(Skills.this,
				            android.R.layout.simple_list_item_1,
				            listItems);
					listview.setAdapter(adapter);
				}
			}
		});
		
	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getSupportMenuInflater();
        inflater.inflate(R.menu.save_skills, (Menu) menu);        
        return super.onCreateOptionsMenu(menu);			
	}
	
	public boolean onOptionsItemSelected(com.actionbarsherlock.view.MenuItem item) {
		switch (item.getItemId()) {
		case R.id.btnSaveSkillsOption:
			Toast.makeText(Skills.this, "Test", Toast.LENGTH_SHORT).show();
//			startActivity(new Intent(Skills.this, CreateJob.class));
			break;
		}

		return super.onOptionsItemSelected(item);
	}
	
	@Override
	public void onBackPressed() {
	}
}
