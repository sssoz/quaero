{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-12 col-md-6 page">
      <header class="page-header justify-content-md-center">
  			<h1>{translate key="user.login"}</h1>

        {* A login message may be displayed if the user was redireceted to the
           login page from another request. Examples include if login is required
           before dowloading a file. *}
        {if $loginMessage}
          <p>
            {translate key=$loginMessage}
          </p>
        {/if}
    	</header>

      <div class="page-content justify-content-md-center">
      {if $error}
        <div class="alert alert-danger" role="alert">
          {translate key=$error reason=$reason}
        </div>
      {/if}

      {include file="frontend/components/loginForm.tpl" formType = "loginPage"}
      </div>
    </div>
  </div>
</main>
{include file="frontend/components/footer.tpl"}
