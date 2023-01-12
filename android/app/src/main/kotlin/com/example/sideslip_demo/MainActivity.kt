package com.example.sideslip_demo

import android.graphics.Rect
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import android.view.Window
import android.view.WindowMetrics
import androidx.core.view.ViewCompat
import io.flutter.embedding.android.FlutterActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainActivity : FlutterActivity() {

    private val gestureExclusionRect = mutableListOf<Rect>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        CoroutineScope(Dispatchers.IO).launch {
            delay(1000)
            Log.e("延迟结束", "kaishi")
            updateGestureExclusion()
        }
        Log.e("延迟", "我先打印")
    }

    private fun updateGestureExclusion() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            gestureExclusionRect.clear()
            val height: Int
            val width: Int
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                height = windowManager.currentWindowMetrics.bounds.height()
                width = windowManager.currentWindowMetrics.bounds.width()
            } else {
                height = windowManager.defaultDisplay.height
                width = windowManager.defaultDisplay.width
            }
            gestureExclusionRect.add(Rect(0, 0, 80, height))
            gestureExclusionRect.add(Rect(width - 80, 0, width, height))
            window.systemGestureExclusionRects = gestureExclusionRect;
        }
    }
}
