package com.acklenavenue.damechamba;

import com.acklenavenue.tabpanel.MyTabHostProvider;
import com.acklenavenue.tabpanel.TabHostProvider;
import com.acklenavenue.tabpanel.TabView;
import com.fima.cardsui.views.CardUI;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.view.WindowManager;

public class Search extends Activity{
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);	
		TabHostProvider tabProvider = new MyTabHostProvider(Search.this);
		TabView tabView = tabProvider.getTabHost("Jobs");
		tabView.setCurrentView(R.layout.jobs);
		setContentView(tabView.render(1));
		
		CardUI cardsUi = (CardUI) findViewById(R.id.cardsViewSearch);

		ParseUser user = ParseUser.getCurrentUser();
		ParseQuery<ParseObject> query = ParseQuery.getQuery("Jobs");
		query.whereEqualTo("createdBy", user.getUsername());
//		query.where
	}
}
