package org.brickred

import org.brickred.socialauth.AuthProvider
import org.brickred.socialauth.SocialAuthManager
import org.brickred.socialauth.exception.SocialAuthException

import de.deltatree.social.web.filter.api.SASFHelper
import de.deltatree.social.web.filter.api.SASFStaticHelper

class SocialAuthUpdateStatusController {

    def index = { 
		def statusMessage = params.statusMessage
		def callbackStatus
		def callbackMessage
		if (statusMessage == null || statusMessage.trim().length() == 0) {
			callbackMessage = "Status can't be left blank."
		} else {
			SASFHelper helper = SASFStaticHelper.getHelper(request)
			SocialAuthManager manager = helper.getAuthManager()

			AuthProvider provider = null
			if (manager != null) {
				provider = manager.getCurrentAuthProvider()
			}
			if (provider != null) {
				try {
					provider.updateStatus(statusMessage)
					callbackMessage = "Status updated successfully"
				} catch (SocialAuthException e) {
					callbackMessage = e.getMessage()
					e.printStackTrace()
				}
			} else {
				callbackMessage = "Unable to update status"
			}
		}
		[callbackMessage: callbackMessage]
	}
}
