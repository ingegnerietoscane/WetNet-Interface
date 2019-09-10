<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="footer">
      <div class="container-fluid">
        <div class="text-muted" style="font-weight: 400; font-size: 13px;">
	       	<spring:message code="footer.it.text" />
       	</div>
      </div>
</div>

<div id="modalLoading" data-backdrop="static" data-keyboard="false" class="modal fade" role="dialog">
      <div class="modal-dialog" style="width: 300px;height: 300px; padding: 10px">
          <div class="modal-content" style="margin: 0px;">
              <div class="modal-body" style="margin: 0px;">
                  <img src="/images/hourglass.gif" style="width:100%;height: 100%;" alt="Caricamento..." />
              </div>
          </div>
      </div>
  </div>