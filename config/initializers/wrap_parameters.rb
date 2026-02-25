# frozen_string_literal: true

# プロジェクト全体で ParamsWrapper を無効化する。
# クライアントが既に適切なキー（例: user）で JSON を送信するため、
# コントローラー名による自動ラップは不要。
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: []
end
