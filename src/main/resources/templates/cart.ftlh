<#import "parts/common.ftlh" as c>
<@c.page "Корзина">
    <div class="card p-3">
        <h3 class="m-3">Корзина</h3>
        <#if cartMap?has_content>
        <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            Оформить заказ
        </button>
        </#if>
        <div class="col p-3 mt-3">
            <div class="collapse" id="collapseExample">
                <div><h4>Оформление заказа</h4></div>
                <form action="/cart/create" name="order" method="post">
                    <div class="card p-3">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <div class="mb-3">
                            <label for="address1" class="form-label">Адрес</label>
                            <input name="address" type="text" class="form-control" id="address1">
                        </div>
                        <button type="submit" class="btn btn-primary">Подтвердить</button>
                    </div>
                </form>
            </div>
            <form action="/cart/delete" method="post" enctype="multipart/form-data">
            <#list cartMap as book, amount>
                <div class="card p-3 mb-3">
                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                    <div class="row mb-3">
                        <div class="col m-2">
                            <img src="/img/${book.image}" alt="Image of a book" class="card-img-top rounded" style="width: 50%">
                        </div>
                        <div class="col m-2">
                            <h4>${book.title}</h4>
                            <a class="mt-3 btn btn-secondary" href="/book/${book.id}">Страница в магазине</a>
                        </div>
                        <div class="col m-2">
                            <div class="row p-2">
                                <div class="col">
                                    <p>Цена:</p>
                                </div>
                                <div class="col">${book.price}</div>
                            </div>
                            <div class="row p-2">
                                <div class="col">
                                    <p>Скидка:</p>
                                </div>
                                <div class="col">${book.sale}</div>
                            </div>
                            <div class="row p-2">
                                <div class="col">
                                    <p>Цена со скидкой:</p>
                                </div>
                                <div class="col">${book.finalPrice}</div>
                            </div>
                            <div class="row p-2">
                                <label for="${book.id}amount">Количество</label>
                                <input required min="1" max="${book.amount}" class="mt-3 w-50" type="number" name="${book.id}amount" id="${book.id}amount" style="margin-left: 2rem" value="${amount}">
                            </div>
                            <div class="p-2 form-check d-flex flex-row align-items-center">
                                <label for="${book.id}" class="form-check-label">Удалить</label>
                                <input class="form-check-input ml-3" type="checkbox" name="${book.id}delete" style="margin-left: 2rem">
                            </div>
                        </div>
                    </div>
                </div>
            <#else>
            <h4 class="mb-3">Ваша корзина пуста.</h4>
            </#list>
                <#if cartMap?has_content>
                    <div class="row justify-content-between">
                        <div class="col">
                            <button type="submit" class="btn btn-primary">Обновить корзину</button>
                        </div>
                        <div class="col">
                            <div class="d-flex justify-content-end">
                                <h3 class="font-monospace">
                                    Итого: ${cost} ₽
                                </h3>
                            </div>
                        </div>
                    </div>
                </#if>
            </form>
        </div>
    </div>
</@c.page>