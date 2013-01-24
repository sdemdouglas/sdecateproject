<%@ Control language="c#" AutoEventWireup="false" Inherits="DictionaryConfiguration._Default" %>
<div class="sideNav">
	<a href="<%=Page.ResolveUrl(ConfigRoot)%>?Page=Import">Import a new dictionary.</a>
</div>
<div class="sideNav">
	<a href="<%= Page.ResolveUrl(ConfigRoot)%>?Page=EditDictionary">Edit dictionary.</a>
</div>