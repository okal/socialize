<!doctype html>
<html>
	<%@page import="de.deltatree.social.web.filter.api.SASFHelper"%>
	<%@page import="de.deltatree.social.web.filter.api.SASFStaticHelper"%>
	<%@page import="org.brickred.socialauth.SocialAuthManager"%>
	<%@page import="org.codehaus.groovy.grails.web.pages.ext.jsp.GroovyPagesPageContext"%>
	<head>
		<meta name="layout" content="main"/>
		<title>Socialize</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}
            
			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
		<script>
			function validate(obj) {
				var value = obj.id.value
				if( trimString(value).length <= 0 ) {
					alert("Please enter OpenID URL");
					return false;
				} else {
					return true;
				}
			}
			function trimString(tempString) {
				return tempString.replace(/^\s*|\s*$/g,"");
			}
		</script>
	</head>
	<body>
		<%
			SASFHelper helper = SASFStaticHelper.getHelper(request)
			SocialAuthManager socialAuthManager
			if ( helper != null ) {
				socialAuthManager = helper.getAuthManager()
				if( socialAuthManager != null ) {
					GroovyPagesPageContext pageContext = new GroovyPagesPageContext(pageScope)
					pageContext.setAttribute("socialAuthManager", socialAuthManager)
				}
			}
		%>

		<g:set var="linkedin" value="false"/>

		<g:if test="${socialAuthManager != null}">
			<g:each var="item" in="${socialAuthManager.connectedProvidersIds}">
				<g:if test="${'linkedin'.equals(item)}">
					<g:set var="linkedin" value="true"/>
				</g:if>
			</g:each>
		</g:if>

		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="page-body" role="main">
			<p>
				<a href="socialAuth?id=linkedin">LinkedIn</a><br/>
				<g:if test="${linkedin.equals('true')}">
					<a href="socialAuth/signout?id=linkedin&mode=signout">Signout</a><br/>
				</g:if>
				<g:if test="${linkedin.equals('false')}">
					<a href="socialAuth?id=linkedin">Signin</a><br/>
				</g:if>
			</p>
		</div>
	</body>
</html>
