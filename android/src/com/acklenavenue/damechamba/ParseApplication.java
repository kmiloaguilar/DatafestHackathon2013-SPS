package com.acklenavenue.damechamba;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseInstallation;
import com.parse.ParseUser;
import com.parse.PushService;

import android.app.Application;

public class ParseApplication extends Application{

	private static final String AppId = "vACnwFsPhrcKYpFEvO72kdzJScGzGHS62dxrC2ID";
	private static final String ClientKey = "oGEwXFIs81f956FirttrYcjv3EyrDqEBpU7J3XKR";	

	@Override
	public void onCreate() {
		super.onCreate();
		
		Parse.initialize(this, AppId, ClientKey);
		ParseUser.enableAutomaticUser();
		
		PushService.setDefaultPushCallback(this, ViewJob.class);
		ParseInstallation.getCurrentInstallation().saveInBackground();
		
		ParseACL defaultACL = new ParseACL();
		defaultACL.setPublicReadAccess(true);
		ParseACL.setDefaultACL(defaultACL, true);
	}
}
