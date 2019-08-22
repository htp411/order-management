<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value='/resources/js/jquery-3.3.1.js'/>"></script>
<script src="<c:url value='/resources/bootstrap/bootstrap.js'/>"></script>
<script src="<c:url value='/resources/common/header/header.js'/>"></script>
<script>
    $(document).ready(function () {
        var herf = window.location.href;
        var dest = '#'+herf.slice(herf.indexOf('order/')+6,herf.lastIndexOf('/'));
        $('.nav-ul-item a').removeClass('active');
        $(dest).addClass('active');
    });
    $('.hide-details').on('mouseover',function () {
        $($($(this).parent()).find('a')[0]).addClass('hover');
    })
    $('.hide-details').on('mouseout',function () {
        $($($(this).parent()).find('a')[0]).removeClass('hover');
    })
</script>
</body>
</html>
