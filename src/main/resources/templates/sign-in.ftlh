<#import "parts/common.ftlh" as c>
<@c.page "Авторизация">
    <div class="container mx-auto p-2">
        <!-- Section: Design Block -->
        <section class="text-center">
            <!-- Background image -->
            <div class="p-5 bg-image" style="
        background-image: url('/static/img/a-pleasure-doing-business-my-perfect-dad-43-jayhypnowriter.png');
        height: 300px;
        "></div>
            <!-- Background image -->

            <div class="card shadow-5-strong mx-auto p-2" style="
        margin-top: -10rem;
        background: hsla(0, 0%, 100%, 0.8);
        backdrop-filter: blur(30px);
        width: 50%;
        ">
                <div class="card-body py-5 px-md-5">

                    <div class="row d-flex justify-content-center">
                        <div class="col-lg-8">
                            <h2 class="fw-bold mb-3">Авторизация</h2>
                            <form action="/sign-in" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <!-- Username input -->
                                <div class="form-outline mb-1">
                                    <label class="form-label float-start" for="form3Example1">Логин</label>
                                    <input name="username" type="text" id="form3Example1" class="form-control" aria-describedby="loginHelp"/>
                                    <div id="loginHelp" class="form-text">Введите ваш логин</div>
                                </div>

                                <!-- Password input -->
                                <div class="form-outline mb-3">
                                    <label class="form-label float-start" for="form3Example2">Пароль</label>
                                    <input name="password" type="password" id="form3Example2" class="form-control" aria-describedby="passwordHelp"/>
                                    <div id="passwordHelp" class="form-text">Введите ваш пароль</div>
                                </div>
                                <!-- Submit button -->
                                <button type="submit" class="btn btn-primary btn-block mb-5">
                                    Войти
                                </button>

                                <div>
                                    <p class="mb-0">Ещё нет аккаунта? <a href="/sign-up" class="text-blue-50 fw-bold">Зарегистрироваться</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Section: Design Block -->
    </div>
</@c.page>