/*
 * Copyright (c) 2012 ekkes-corner UG (haftungsbeschränkt), Rosenheim, Germany
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import bb.cascades 1.0

//-- create one page with a label and text
Page {
    id: page
    
    titleBar: TitleBar {
        id: titleBarId
        title: qsTr ("Kreta: ekke in Loutro")
        visibility: ChromeVisibility.Default
        
    }
    
    attachedObjects: [
            OrientationHandler {
             onUiOrientationChanging: {
                 //
            }
            onUiOrientationChanged: {
                if (uiOrientation == UiOrientation.Landscape) {
                    console.log("LANDSCAPE onUiOrientationChanged")
                    userInteractionDelay.play()
    	            page.actionBarVisibility = ChromeVisibility.Overlay
    	            titleBarId.visibility = ChromeVisibility.Overlay
    	            textAreaId.visible = false
                } else {
                    console.log("PORTRAIT onUiOrientationChanged")
                    if (userInteractionDelay.isPlaying()) {
    	                userInteractionDelay.stop();
    	            }
    	            page.actionBarVisibility = ChromeVisibility.Default
    	            titleBarId.visibility = ChromeVisibility.Default
    	            textAreaId.visible = true
                }
            }
            }
        ]
    
    actions: [
        ActionItem {
            title: qsTr ("Action")
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
    content: Container {
        id: content
        
        ImageView {
		    id: imageViewID
		    imageSource: "asset:///images/kreta.png"
		    preferredWidth: width
		    preferredHeight: height
		    scalingMethod: ScalingMethod.AspectFit
		}
		
		TextArea {
            id: textAreaId
            editable: false
            text: qsTr ("You can switch the Device to see the image larger. Controls in Landscape will be hidden after 3 seconds of inactivity and come back if touching the screen. HAVE FUN")
            backgroundVisible: true
            visible: false
        }
        
        animations: [
            TranslateTransition {
                id: userInteractionDelay
                delay: 3000
                onEnded: {
                    page.actionBarVisibility = ChromeVisibility.Hidden
                    titleBarId.visibility = ChromeVisibility.Hidden
                }
            }
        ]
        onCreationCompleted: {
            // support all orientations
            OrientationSupport.supportedDisplayOrientation =
                            SupportedDisplayOrientation.All;
            // if started in Landscape: play animation
           if (OrientationSupport.uiOrientation == UiOrientation.Landscape) {
               console.log("LANDSCAPE onCreationCompleted")
               userInteractionDelay.play()
               page.actionBarVisibility = ChromeVisibility.Overlay
               titleBarId.visibility = ChromeVisibility.Overlay
               textAreaId.visible = false
           } else {
               console.log("PORTRAIT onCreationCompleted")
               page.actionBarVisibility = ChromeVisibility.Default
               titleBarId.visibility = ChromeVisibility.Default
               textAreaId.visible = true
           }
       }
        onTouch: {
            // if Landscape: display ActionBar and start animation
            if (OrientationSupport.uiOrientation == UiOrientation.Landscape) {
                console.log("LANDSCAPE onTouch")
	            if (userInteractionDelay.isPlaying()) {
	                userInteractionDelay.stop();
	            }
	            userInteractionDelay.play()
	            page.actionBarVisibility = ChromeVisibility.Overlay
	            titleBarId.visibility = ChromeVisibility.Overlay
	        }
        }
    }
} 
