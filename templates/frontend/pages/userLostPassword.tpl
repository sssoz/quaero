{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2000-2017 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<main class="container">

  <div class="row justify-content-center">

    <div class="col-12 col-md-6 page">
      <header class="page-header justify-content-md-center">
    		<h1>{translate key="user.login.resetPassword"}</h1>
        <p>{translate key="user.login.resetPasswordInstructions"}</p>
    	</header>

      <div class="page-content justify-content-md-center">
        {if $error}
          <div class="alert alert-danger">
            {translate key=$error}
          </div>
        {/if}
        <form class="form-lost-password" action="{url page="login" op="requestResetPassword"}" method="post">
          {csrf}
          <div class="form-group">
            <label for="email">
              {translate key="user.login.registeredEmail"}
              <span class="required" aria-hidden="true">*</span>
              <span class="sr-only">{translate key="common.required"}</span>
            </label>
            <input type="text" class="form-control" name="email" id="email" value="{$email|escape}" required>
          </div>
          <div class="form-group form-group-buttons">
            <button class="btn btn-primary" type="submit">
              {translate key="user.login.resetPassword"}
            </button>

            {if !$disableUserReg}
              {capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
              <a href="{$registerUrl}" class="btn btn-link">
                {translate key="user.login.registerNewAccount"}
              </a>
            {/if}
          </div>
        </form>
      </div>
    </div>
  </div>
</main>

{include file="frontend/components/footer.tpl"}
