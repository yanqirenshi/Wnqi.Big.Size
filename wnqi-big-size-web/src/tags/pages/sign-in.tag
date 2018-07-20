<sign-in>
    <div class="card" style="border-radius: 8px;">
        <header class="card-header">
            <p class="card-header-title">
                💩 Big Size
            </p>
        </header>

        <div class="card-content">
            <div class="field">
                <div class="control has-icons-left has-icons-right">
                    <input class="input is-success"
                           type="text"
                           placeholder="User"
                           value=""
                           ref="user-code">
                    <span class="icon is-small is-left">
                        <i class="fa fa-user"></i>
                    </span>
                </div>
            </div>
        </div>

    </div>

    <div class="operator">
        <p class="card-footer-item">
            <button class="button is-link"
                    style="width:266px"
                    onclick={this.clickSignIn}>
                Sign in
            </button>
        </p>
    </div>

    <style>
     sign-in > div.card {
         width: 333px;
         margin: 222px auto auto auto;
     }
     sign-in > div.operator {
         width: 333px;
         margin: 22px auto auto auto;
     }
    </style>

    <script>
     this.clickSignIn = function () {
         let user_code = this.refs['user-code'].value.trim();
         ACTIONS.signIn(user_code);
     }.bind(this);
    </script>
</sign-in>
