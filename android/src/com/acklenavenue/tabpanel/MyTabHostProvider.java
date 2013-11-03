package com.acklenavenue.tabpanel;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;

import com.acklenavenue.damechamba.Jobs;
import com.acklenavenue.damechamba.MyProfile;
import com.acklenavenue.damechamba.R;
import com.acklenavenue.damechamba.Search;
import com.acklenavenue.tabpanel.*;

public class MyTabHostProvider extends TabHostProvider 
{
	private Tab profileTab;
	private Tab searchTab;
	private Tab jobsTab;
	
	private TabView tabView;
	private GradientDrawable gradientDrawable, transGradientDrawable;

	public MyTabHostProvider(Activity context) {
		super(context);
	}

	@Override
	public TabView getTabHost(String category) 
	{
		tabView = new TabView(context);
		tabView.setOrientation(TabView.Orientation.BOTTOM);
		tabView.setBackgroundID(R.drawable.tab_background_gradient);
		
		gradientDrawable = new GradientDrawable(
	            GradientDrawable.Orientation.TOP_BOTTOM,
	            new int[] {Color.parseColor("#34495e"), Color.parseColor("#34495e")});
	    gradientDrawable.setCornerRadius(0f);
	    gradientDrawable.setDither(true);
	    
	    transGradientDrawable = new GradientDrawable(
	            GradientDrawable.Orientation.TOP_BOTTOM,
	            new int[] {0x00000000, 0x00000000});
	    transGradientDrawable.setCornerRadius(0f);
	    transGradientDrawable.setDither(true);
	    
	    profileTab = new Tab(context, category);
	    profileTab.setIcon(R.drawable.user_icon);
	    profileTab.setIconSelected(R.drawable.user_icon);
	    profileTab.setIntent(new Intent(context, MyProfile.class));
		profileTab.setSelectedBtnGradient(gradientDrawable);
		profileTab.setBtnText("Profile");
		
	    jobsTab = new Tab(context, category);
	    jobsTab.setIcon(R.drawable.jobs_icon);
	    jobsTab.setIconSelected(R.drawable.jobs_icon);
	    jobsTab.setIntent(new Intent(context, Jobs.class));
		jobsTab.setSelectedBtnGradient(gradientDrawable);
	    
	    searchTab = new Tab(context, category);
	    searchTab.setIcon(R.drawable.search_icon);
	    searchTab.setIconSelected(R.drawable.search_icon);
	    searchTab.setIntent(new Intent(context, Search.class));
		searchTab.setSelectedBtnGradient(gradientDrawable);
	       
/*
		homeTab = new Tab(context, category);
		homeTab.setIcon(R.drawable.home_sel);
		homeTab.setIconSelected(R.drawable.home_sel);
		homeTab.setBtnText("Home");
		homeTab.setBtnTextColor(Color.WHITE);
		homeTab.setSelectedBtnTextColor(Color.BLACK);
		homeTab.setBtnGradient(transGradientDrawable);
		homeTab.setSelectedBtnGradient(gradientDrawable);
		homeTab.setIntent(new Intent(context, HomeActivity.class));	
*/
	    tabView.addTab(profileTab);
	    tabView.addTab(searchTab);
	    tabView.addTab(jobsTab);
		return tabView;
	}
}