package com.acklenavenue.damechamba;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;

import com.acklenavenue.tabpanel.MyTabHostProvider;
import com.acklenavenue.tabpanel.TabHostProvider;
import com.acklenavenue.tabpanel.TabView;
import com.actionbarsherlock.app.SherlockActivity;
import com.actionbarsherlock.view.Menu;
import com.actionbarsherlock.view.MenuInflater;
import com.fima.cardsui.views.CardUI;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

public class Jobs extends SherlockActivity{

	private CardUI cardsUI;
	boolean isEmployer;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		TabHostProvider tabProvider = new MyTabHostProvider(Jobs.this);
		TabView tabView = tabProvider.getTabHost("Jobs");
		tabView.setCurrentView(R.layout.jobs);
		setContentView(tabView.render(2));

		cardsUI = (CardUI) tabView.getCurrentView().findViewById(R.id.cardsview);
		// get jobs
		ParseUser user = ParseUser.getCurrentUser();
		if( user.getBoolean("isEmployer")){
			// Get all employer jobs
			ParseQuery<ParseObject> query = ParseQuery.getQuery("Jobs");
			query.whereEqualTo("createdBy", user.getUsername());
			query.findInBackground(new FindCallback<ParseObject>() {
			    public void done(List<ParseObject> jobs, ParseException e) {
			        if (e == null) {
			        	JobCard card;
			        	for(ParseObject job : jobs){
			        		ArrayList<Object> obj= (ArrayList<Object>) job.getList("skills");
			        		if(obj == null) obj = new ArrayList<Object>();
			        		card = new JobCard(job.getString("title"), job.getCreatedAt().toString(), obj, job.getObjectId());
			        		cardsUI.addCard(card, true);
			        	}
			        	cardsUI.refresh();
			        	Toast.makeText(getApplicationContext(), "Done!", Toast.LENGTH_SHORT).show();
			        } else {
			        	Toast.makeText(getApplicationContext(), "Error when getting the data", Toast.LENGTH_LONG).show();
			        }
			    }
			});
		}
		else{
			List<Object> skills = user.getList("skills");
		}
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		ParseUser user = ParseUser.getCurrentUser();
		boolean isEmployer = user.getBoolean("isEmployer");
		if( isEmployer){
			MenuInflater inflater = getSupportMenuInflater();
	        inflater.inflate(R.menu.menu, (Menu) menu);        
	        return super.onCreateOptionsMenu(menu);			
		}
		return super.onCreateOptionsMenu(menu);
	}
	
	@Override
	public boolean onOptionsItemSelected(com.actionbarsherlock.view.MenuItem item) {
		switch (item.getItemId()) {
		case R.id.btnAddJob:
			Toast.makeText(Jobs.this, "Test", Toast.LENGTH_SHORT).show();
			startActivity(new Intent(Jobs.this, CreateJob.class));
			break;
		}

		return super.onOptionsItemSelected(item);
	}
	
	private ArrayList<String> getSkills(String skills){
		ArrayList<String> skls = new ArrayList<String>();
		
		if(skills.equals("")) return skls;
		
		String[] skl = skills.split(",");
		for(String skill: skl)
			skls.add(skill);
		return skls;
	}

}
