<#import "parts/common.ftlh" as c>

<@c.page "Профиль">
    <div class="card p-3">
        <h1 class="mb-3">Профиль пользователя ${user.username}</h1>
        <form action="profile/edit" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <#if !user.isAdmin()>
                <div class="mb-3">
                    <label for="name" class="form-label">Имя</label>
                    <input name="name" type="text" class="form-control" id="name" placeholder="${user.name}">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Адрес электронной почты</label>
                    <input name="email" type="email" class="form-control" id="email" placeholder="${user.email}">
                </div>
                <#else>
                    <div class="mb-3">
                        <label for="name" class="form-label">Имя</label>
                        <input name="name" type="text" class="form-control" id="name" placeholder="admin">
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Адрес электронной почты</label>
                        <input name="email" type="email" class="form-control" id="email" placeholder="admin">
                    </div>
            </#if>
            <div class="mb-3">
                <p>Чтобы сменить пароль, сначала введите старый. При несовпадении пароль не поменяется.</p>
            </div>
            <div class="mb-3">
                <label for="oldPassword" class="form-label">Старый пароль</label>
                <input name="oldPassword" type="password" class="form-control" id="oldPassword" placeholder="Ваш старый пароль" value="nochange">
            </div>

            <div class="mb-3">
                <label for="newPassword" class="form-label">Новый пароль</label>
                <input name="newPassword" type="password" class="form-control" id="newPassword" placeholder="Ваш новый пароль" value="nochange">
            </div>
            <button type="submit" class="btn btn-primary">Обновить</button>
        </form>
    </div>

    <div class="card p-3">
        <h1 class="mb-3">Заказы пользователя ${user.username}</h1>
        <div class="row p-3 mb-3">
            <div class="col">
                <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseAllOrders" aria-expanded="false" aria-controls="collapseAllOrders">
                    Показать все
                </button>
            </div>

            <div class="col">
                <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDeliveredTrue" aria-expanded="false" aria-controls="collapseDeliveredTrue">
                    Доставленные
                </button>
            </div>

            <div class="col">
                <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDeliveredFalse" aria-expanded="false" aria-controls="collapseDeliveredFalse">
                    В доставке
                </button>
            </div>
        </div>

        <div class="collapse" id="collapseAllOrders">
            <#list orders as order>
                <div class="card p-3 mb-3">
                    <#list order.books as book>
                        <div class="row mb-2">
                            <div class="col">
                                <h4>${book.title}</h4>
                            </div>
                            <div class="col">
                                <p>Количество: null</p>
                            </div>
                        </div>
                        <#else>
                            <h3 class="mb-3">Что-то пошло не так.</h3>
                    </#list>
                </div>
                <#else>
                <h3 class="mb-3">Тут пока что пусто.</h3>
            </#list>
        </div>

    </div>
</@c.page>