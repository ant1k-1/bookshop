<#import "parts/common.ftlh" as c>

<@c.page "Главная">
    <h1 class="m-3">Панель модерации отзывов</h1>
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
                                <button type="submit" class="btn btn-danger">Удалить</button>
                            </form>

                            <form class="d-flex justify-content-end" action="/moder/allow-comment/${comment.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-success">Опубликовать</button>
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
</@c.page>