<#import "parts/common.ftlh" as c>
<@c.page "Закладки">
    <div class="card p-3">
        <h3 class="m-3">Закладки</h3>
        <div class="col p-3 mt-3">
            <form action="/cart/delete" method="post" enctype="multipart/form-data">
                <#list bookmarks as book>
                    <div class="card p-3 mb-3">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <div class="row mb-3">
                            <div class="col m-2">
                                <img src="/img/${book.image}" alt="Image of a book" class="card-img-top rounded" style="width: 50%">
                            </div>
                            <div class="col m-2">
                                <h4>${book.title}</h4>
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
                                <div class="p-2 form-check d-flex flex-row align-items-center">
                                    <label for="${book.id}" class="form-check-label">Удалить</label>
                                    <input class="form-check-input ml-3" type="checkbox" name="${book.id}" style="margin-left: 2rem">
                                </div>
                            </div>
                        </div>
                    </div>
                <#else>
                    <h4 class="mb-3">Здесь пока что пусто.</h4>
                </#list>
                <#if bookmarks?has_content>
                    <button type="submit" class="btn btn-primary">Обновить список</button>
                </#if>
            </form>
        </div>
    </div>
</@c.page>