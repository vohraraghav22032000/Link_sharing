<!Doctype html>
<html>
<body>

%{--<g:if  test ="${Age > 18}">--}%
%{--    <p>User can vote</p>--}%
%{--</g:if>--}%
%{--<g:else>--}%
%{--    <p>User can not vote</p>--}%
%{--</g:else>--}%


%{--<ol>--}%
%{--    <g:each in="${range}" var ="num">--}%
%{--         <g:if test = "${num%2==0}">--}%
%{--            <li>Even number is ${num}</li>--}%
%{--        </g:if>--}%
%{--    </g:each>--}%
%{--</ol>--}%



%{--<g:link action = "show" params = "[idd: 'even']">--}%
%{--        <p>Print Even</p>--}%
%{--</g:link>--}%

%{--<g:link action="show" params = "[idd : 'odd']">--}%
%{--        <p>Print Odd</p>--}%
%{--</g:link>--}%


%{--for method calling in console#new , we have ctx.Sevice_Name.Method_Name()--}%
%{--To get properties in console of the user , we have--}%
%{--User.list()*.firstname--}%
%{--User.findByUsername('ankit_mishra')--}%

%{--User.findByUsername('ankit_mishra')*.properties.each {--}%
%{--it.each{--}%
%{--println it--}%
%{--}--}%
%{--}--}%

</body>
</html>