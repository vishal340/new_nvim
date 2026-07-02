local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local events = require("luasnip.util.events")

local function detach_snippet()
	if ls.in_snippet() then
		ls.unlink_current()
	end
end

return {
	s("codeforce", {
		t({
			"#include <bits/stdc++.h>",
			"using namespace std;",
			"",
			"using vi = vector<int>;",
			"",
			"void solve() {",
			"  int n;",
			"  cin >> n;",
			"  vi a(n);",
			"  for (int i = 0; i < n; i++) {",
			"    cin >> a[i];",
			"  }",
			"  ",
		}),
		i(1, ""),
		t({
			"}",
			"",
			"int main() {",
			"  ios::sync_with_stdio(false);",
			"  cin.tie(0);",
			"",
			"  int t;",
			"  cin >> t;",
			"  while (t--) solve();",
			"",
			"  return 0;",
			"}",
		}),
	}, {
		callbacks = {
			-- Node index 2 is i(1): land here on expand, then leave snippet mode.
			[2] = {
				[events.enter] = detach_snippet,
			},
		},
	}),
}
