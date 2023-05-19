<#import "parts/common.ftlh" as c>

<@c.page "Профиль">
    <div class="card p-3 mb-3">
        <h1 class="mb-3">Профиль пользователя ${user.username}</h1>
        <form action="profile/edit" method="post" autocomplete="off">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <#if !user.isAdmin()>
                <div class="mb-3">
                    <label for="name" class="form-label">Имя</label>
                    <input autocomplete="off" name="name" type="text" class="form-control" id="name" placeholder="${user.name}">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Адрес электронной почты</label>
                    <input autocomplete="off" name="email" type="email" class="form-control" id="email" placeholder="${user.email}">
                </div>
                <#else>
                    <div class="mb-3">
                        <label for="name" class="form-label">Имя</label>
                        <input autocomplete="off" name="name" type="text" class="form-control" id="name" placeholder="admin">
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Адрес электронной почты</label>
                        <input autocomplete="off" name="email" type="email" class="form-control" id="email" placeholder="admin">
                    </div>
            </#if>
            <div class="mb-3">
                <p>Чтобы сменить пароль, сначала введите старый. При несовпадении пароль не поменяется.</p>
            </div>
            <div class="mb-3">
                <label for="oldPassword" class="form-label">Старый пароль</label>
                <input autocomplete="off" name="oldPassword" type="password" class="form-control" id="oldPassword" placeholder="Ваш старый пароль">
            </div>

            <div class="mb-3">
                <label for="newPassword" class="form-label">Новый пароль</label>
                <input autocomplete="off" name="newPassword" type="password" class="form-control" id="newPassword" placeholder="Ваш новый пароль">
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
                    <div class="container d-flex flex-row align-items-between">
                        <div class="flex-grow-1">
                            <#list order.books as book, amount>
                                <div class="row mb-2">
                                    <div class="col">
                                        <h4>${book.title}</h4>
                                    </div>
                                    <div class="col">
                                        <p>Количество: ${amount}</p>
                                    </div>
                                </div>
                            <#else>
                                <h3 class="mb-3">Что-то пошло не так.</h3>
                            </#list>
                        </div>
                        <div>
                            <div class="row">
                                <h4>Статус заказа:</h4>
                            </div>
                            <div class="row">
                                <#if order.isDelivered>
                                    <h3 class="font-monospace text-success">
                                        доставлен
                                    </h3>
                                <#else>
                                    <h3 class="font-monospace text-success">
                                        в доставке
                                    </h3>
                                </#if>
                            </div>
                            <div class="row">
                                <#if !order.isDelivered>
                                    <form action="/profile/close-order/${order.id}" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <button type="submit" class="btn btn-success">Закрыть заказ</button>
                                    </form>
                                </#if>
                            </div>
                        </div>
                    </div>

                </div>
                <#else>
                <h3 class="mb-3">Тут пока что пусто.</h3>
            </#list>
        </div>


        <div class="collapse" id="collapseDeliveredTrue">
            <#list deliveredOrders as order>
                <div class="card p-3 mb-3">
                    <div class="container d-flex flex-row align-items-between">
                        <div class="flex-grow-1">
                            <#list order.books as book, amount>
                                <div class="row mb-2">
                                    <div class="col">
                                        <h4>${book.title}</h4>
                                    </div>
                                    <div class="col">
                                        <p>Количество: ${amount}</p>
                                    </div>
                                </div>
                            <#else>
                                <h3 class="mb-3">Что-то пошло не так.</h3>
                            </#list>
                        </div>
                        <div>
                            <div class="row">
                                <h4>Статус заказа:</h4>
                            </div>
                            <div class="row">
                                <h3 class="font-monospace text-success">
                                    доставлен
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            <#else>
                <h3 class="mb-3">Тут пока что пусто.</h3>
            </#list>
        </div>


        <div class="collapse" id="collapseDeliveredFalse">
            <#list unDeliveredOrders as order>
                <div class="card p-3 mb-3">
                    <div class="container d-flex flex-row align-items-between">
                        <div class="flex-grow-1">
                            <#list order.books as book, amount>
                                <div class="row mb-2">
                                    <div class="col">
                                        <h4>${book.title}</h4>
                                    </div>
                                    <div class="col">
                                        <p>Количество: ${amount}</p>
                                    </div>
                                </div>
                            <#else>
                                <h3 class="mb-3">Что-то пошло не так.</h3>
                            </#list>
                        </div>
                        <div>
                            <div class="row">
                                <h4>Статус заказа:</h4>
                            </div>
                            <div class="row">
                                <h3 class="font-monospace text-success">
                                    в доставке
                                </h3>
                            </div>
                            <div class="row">
                                <form action="/profile/close-order/${order.id}" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-success">Закрыть заказ</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            <#else>
                <h3 class="mb-3">Тут пока что пусто.</h3>
            </#list>
        </div>

    </div>
</@c.page>