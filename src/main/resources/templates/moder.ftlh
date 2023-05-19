<#import "parts/common.ftlh" as c>

<@c.page "Главная">

    <h1 class="m-3">Панель модерации отзывов</h1>
    <div class="d-flex justify-content-center mb-3">
        <a href="/moder" class="btn btn-primary mb-3 me-2" style="width: 10rem">Комментарии на модерации</a>
        <a href="/moder/users" class="btn btn-primary mb-3 me-2" style="width: 10rem">Заблокированные пользователи</a>
    </div>
    <#if commentsDisplay>
        <div class="card p-3">
            <h2 class="m-3">Отзывы, еще не прошедшие модерацию</h2>
            <#list comments as comment>
                <#if !comment.isModerated>
                    <div class="card p-3 mb-3">
                        <div class="row justify-content-between">
                            <div class="col-4">
                                <div class="mb-3">
                                    <p><b>${comment.user.username}</b>, дата: ${comment.formatDate()}</p>
                                </div>
                            </div>

                            <div class="col-4">
                                <form class="d-flex justify-content-end" action="/moder/delete-comment/${comment.id}" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-danger mb-2" style="width: 10rem">Удалить</button>
                                </form>

                                <form class="d-flex justify-content-end" action="/moder/allow-comment/${comment.id}" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-success" style="width: 10rem">Опубликовать</button>
                                </form>
                            </div>
                        </div>

                        <div class="mb-3">
                            <h4>${comment.title}</h4>
                        </div>
                        <div class="mb-3">
                            <p>${comment.text}</p>
                        </div>
                        <div class="mb-3">
                            <strong>Оценка: ${comment.rate}</strong>
                        </div>
                    </div>
                </#if>
            <#else>
                <h4 class="p-5">Пусто</h4>
            </#list>
        </div>
    </#if>
    
    <#if userDisplay>
        <div class="card p-3 mb-3">
            <#list users as user>
                <div class="card p-3 mb-3">
                    <div class="d-flex justify-content-between">
                        <h5 class="mb-3">id:${user.id}. Пользователь ${user.username}</h5>
                        <form action="/moder/unlock" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <input type="hidden" name="userId" value="${user.id}">
                            <button type="submit" class="btn btn-danger">Разблокировать</button>
                        </form>
                    </div>
                </div>
            <#else>
                <h4 class="p-5">Пусто</h4>
            </#list>
        </div>
    </#if>
    
</@c.page>