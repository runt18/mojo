// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>

#include "examples/bank_app/bank.mojom.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/vanadium/security/interfaces/principal.mojom.h"

namespace examples {

class LoginHandler {
 public:
  void Run(const vanadium::UserPtr& user) const {
    if (user) {
      MOJO_LOG(INFO) << "User logged-in as " << user->email;
    }
  }
};

class BankCustomer : public mojo::ApplicationDelegate {
 public:
  void Initialize(mojo::ApplicationImpl* app) override {
    app->ConnectToService("mojo:principal_service", &login_service_);

    // Login to the principal service to get a user identity.
    login_service_->Login(LoginHandler());
    // Check and see whether we got a valid user id.
    if (!login_service_.WaitForIncomingResponse()) {
      MOJO_LOG(INFO) << "Login() to the principal service failed";
    }

    BankPtr bank;
    app->ConnectToService("mojo:bank", &bank);
    bank->Deposit(500/*usd*/);
    bank->Withdraw(100/*usd*/);
    auto gb_callback = [](const int32_t& balance) {
      MOJO_LOG(INFO) << "Bank balance: " << balance;
    };
    bank->GetBalance(mojo::Callback<void(const int32_t&)>(gb_callback));
    bank.WaitForIncomingResponse();
  }
  void Quit() override {
    login_service_->Logout();
  }
 private:
  vanadium::PrincipalServicePtr login_service_;
};

}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(new examples::BankCustomer);
  return runner.Run(application_request);
}
