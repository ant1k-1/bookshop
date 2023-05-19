<#import "parts/common.ftlh" as c>
<@c.page "Главная">
    <div class="row justify-content-between">
        <h3>Добро пожаловать${name}</h3>
        <div class="d-flex justify-content-center">
            <#if logged>
                <#if user.isModerator()>
                    <a href="/moder" class="btn btn-primary mb-3 me-2" style="width: 15rem">Панель модератора</a>
                </#if>
                <#if user.isAdmin()>
                    <a href="/admin" class="btn btn-primary mb-3 me-2" style="width: 15rem">Панель админа</a>
                </#if>
            </#if>
        </div>
    </div>
    <h3>Хиты</h3>
    <h4 class="mb-3">Топ 3 по рейтингу</h4>
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <#list topRate as book>
            <div class="col d-flex align-items-stretch">
                <div class="card">
                    <img src="/img/${book.image()}" class="card-img-top" alt="Image of a book">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <h5 class="card-title mb-4">${book.title()}</h5>
                        <div class="container d-flex justify-content-between">
                            <a href="/book/${book.id()}" class="btn btn-primary">Подробнее</a>
                            <#if userId==-1>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Купить ${book.finalPrice()} ₽
                                </button>
                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="exampleModalLabel">Похоже, вы не авторизованы</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Пожалуйста, авторизуйтесь, чтобы добавить товар в корзину.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                <a href="/sign-in" class="btn btn-primary">Войти</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <#else>
                                    <form action="/buy" method="post">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <input type="hidden" name="bookId" value="${book.id()}">
                                        <#if book.amount() != 0>
                                            <button id="buy-button" type="submit" class="btn btn-primary">В корзину ${book.finalPrice()} ₽</button>
                                        <#else >
                                            <button type="button" class="btn btn-danger">Нет в наличии</button>
                                        </#if>
                                    </form>

                            </#if>

                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="card w-100">
                <div class="card-body">
                    Извините, что-то пошло не так. Книги появятся в скором времени!
                </div>
            </div>
        </#list>
    </div>
    <h4 class="mb-3">Топ 3 по продажам</h4>
    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
        <#list topSold as book>
            <div class="col d-flex align-items-stretch">
                <div class="card">
                    <img src="/img/${book.image()}" class="card-img-top" alt="Image of a book">
                    <div class="card-body d-flex flex-column justify-content-between">
                        <h5 class="card-title mb-4">${book.title()}</h5>
                        <div class="container d-flex justify-content-between">
                            <a href="/book/${book.id()}" class="btn btn-primary">Подробнее</a>
                            <#if userId==-1>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    Купить ${book.finalPrice()} ₽
                                </button>
                                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h1 class="modal-title fs-5" id="exampleModalLabel">Похоже, вы не авторизованы</h1>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p>Пожалуйста, авторизуйтесь, чтобы добавить товар в корзину.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                <a href="/sign-in" class="btn btn-primary">Войти</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            <#else>
                                <form action="/buy" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <input type="hidden" name="bookId" value="${book.id()}">
                                    <#if book.amount() != 0>
                                        <button id="buy-button" type="submit" class="btn btn-primary">В корзину ${book.finalPrice()} ₽</button>
                                    <#else >
                                        <button type="button" class="btn btn-danger">Нет в наличии</button>
                                    </#if>
                                </form>

                            </#if>

                        </div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="card w-100">
                <div class="card-body">
                    Извините, что-то пошло не так. Книги появятся в скором времени!
                </div>
            </div>
        </#list>
    </div>
</@c.page>