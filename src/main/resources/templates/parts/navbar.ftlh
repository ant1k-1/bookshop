<#assign
    known = SPRING_SECURITY_CONTEXT??
>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: #8accff;">
    <div class="container">
        <a class="navbar-brand" href="/">BookShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse d-flex justify-content-between" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link btn btn-sm btn-outline-light" aria-current="page" href="/home">Главная</a>
                <a class="nav-link btn btn-sm btn-outline-light" href="/catalog">Каталог</a>
                <a class="nav-link btn btn-sm btn-outline-light" href="/cart">Корзина</a>
            </div>
            <div class="navbar-nav">
<#--                <#if isAdmin!>-->
<#--                    <a class="nav-link btn btn-sm btn-outline-light" href="/admin">Админка</a>-->
<#--                </#if>-->
<#--                <#if isModer!>-->
<#--                    <a class="nav-link btn btn-sm btn-outline-light" href="/moder">Админка</a>-->
<#--                </#if>-->
                <a class="nav-link btn btn-sm btn-outline-light" href="/profile">Профиль</a>
                <a class="nav-link btn btn-sm btn-outline-light" href="/bookmark">Закладки</a>
                <#if known>
                    <form action="/logout" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input class="btn btn-sm btn-outline-danger nav-link" type="submit" value="Выйти"/>
                    </form>
                    <#else>
                        <a href="/sign-in" class="btn btn-sm btn-outline-light nav-link" role="button">Войти</a>
                </#if>
            </div>
        </div>
    </div>
</nav>