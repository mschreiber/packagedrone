<%@ page
  language="java"
  contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"
  trimDirectiveWhitespaces="true"
  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pm" uri="http://eclipse.org/packagedrone/repo/channel" %>
<%@ taglib prefix="web" uri="http://eclipse.org/packagedrone/web" %>

<%@ taglib prefix="h" tagdir="/WEB-INF/tags/main" %>
<%@ taglib prefix="s" tagdir="/WEB-INF/tags/storage" %>

<%
pageContext.setAttribute ( "manager", request.isUserInRole ( "MANAGER" ) );
%>

<c:set var="idUrl" value="${ fn:escapeXml(sitePrefix.concat ( '/api/v3/upload/{plain,archive}/channel/' ).concat ( channel.id )) }"/>
<c:set var="exampleUrl" value="${ fn:escapeXml(exampleSitePrefix.concat ( '/api/v3/upload/plain/channel/' ).concat ( channel.id )) }" />

<h:main title="API Upload" subtitle="${pm:channel(channel) }">

<jsp:attribute name="subtitleHtml"><s:channelSubtitle channel="${channel }" /></jsp:attribute>

<jsp:body>

<h:buttonbar menu="${menuManager.getActions(channel) }"/>
<h:nav menu="${menuManager.getViews(channel) }"/>

<div class="container-fluid form-padding">
    <c:if test="${not hasExampleKey }">
        <div class="alert alert-warning">
	        All further information in this page requires the channel to have at least one deploy
	        key assigned. However there are currently no deploy groups/keys assigned to this channel, so
	        it will not be possible to authenticate.
	        
	        <c:if test="${manager }">
	   	        <a class="alert-link" href="<c:url value="/channel/${channel.id }/deployKeys"/>">Assign deploy groups now</a>.
	        </c:if>
        </div>
    </c:if>
    
    <div class="alert alert-info">
      <strong>Upload API V3!</strong> This page documents the upload API version 3. The older version 2 API is still present and working.
      For more information also see
      <a class="alert-link" href="https://github.com/eclipse/packagedrone/blob/master/bundles/org.eclipse.packagedrone.repo.api/README.md" target="_blank">the readme</a>.
    </div>
    
    <p>
        It is possible to upload to this channel by making a <code>PUT</code> or <code>POST</code> request to the following URLs:
    </p>
    <ul>
        <li><code>${idUrl }</code></li>
        <c:if test="${not empty channel.names }">
				  <c:forEach var="name" items="${channel.names }">
	          <li><code>${ fn:escapeXml(sitePrefix.concat ( '/api/v3/upload/{plain,archive}/channel/' ).concat ( web:encode(name) )) }</code></li>
	        </c:forEach>    
        </c:if>
    </ul>
    
    <p>
        <strong>Note:</strong> it is required to perform <q>Basic Authentication</q> using one of the assigned deploy keys. The password must be the deploy key token. The user name is ignored.
    </p>
    
    <p>
    For more information about the Upload API V3 also see the .
    </p>
    
    <h3>Jenkins Plugin</h3>
    
    There is a <a href="https://wiki.jenkins-ci.org/display/JENKINS/Package+Drone+Plugin" target="_blank">Package Drone Jenkins plugin</a> available which can automate this process.
    The plugin has to be installed in the originating Jenkins instance. 
    
    <h3>Example</h3>
    
    <p>
        Using the command line tool <code>curl</code> you can deploy the file <code>my.jar</code> in the local directory to this channel:
    </p>
    
    <pre>curl -X PUT --data-binary @<strong>my.jar</strong> ${exampleUrl }/<strong>my.jar</strong></pre>
    
    <p>If you want to set the provided meta data field <code>test:foo</code> to <code>bar</code> add these as request parameters:
    
    <pre>curl -X PUT --data-binary @<strong>my.jar</strong> ${exampleUrl }/my.jar<strong>?test:foo=bar</strong></pre>
    
</div>

</jsp:body>

</h:main>