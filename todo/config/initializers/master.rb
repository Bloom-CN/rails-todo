module SessionConfig
  NAMES = {
    user_id: "user_id",
    success: "success",
    failed: "failed"
  }
end

module UserConfig
  FLASH = {
    login_ok:       "ログインしました。",
    login_failed:   "ログイン失敗しました。もう一度試してください。",
    logout_ok:      "ログアウトしました。",
    account_ok:     "アカウント作成しました。",
    account_failed: "アカウント作成に失敗しました。",
    account_edit_success: "アカウント更新に成功しました。",
    account_edit_failed: "アカウント更新に失敗しました。",
    account_delete_success: "アカウントを削除しました。",
    account_delete_failed: "アカウント削除に失敗しました。"
  }
end

module PostConfig
  FLASH = {
    post_ok: "投稿が完了しました。",
    post_failed: "投稿に失敗しました。",
    edit_ok: "投稿編集に成功しました。",
    edit_failed: "投稿編集に失敗しました。",
    delete_ok: "投稿削除に成功しました。",
    delete_failed: "投稿削除に失敗しました。",
  }
end
