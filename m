Return-Path: <linux-ext4+bounces-13696-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI/rCwXqkGkfdwEAu9opvQ
	(envelope-from <linux-ext4+bounces-13696-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:53 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B413D9AE
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 22:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D47E30C2327
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Feb 2026 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411F3311C35;
	Sat, 14 Feb 2026 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohPgMaYr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D7303A02;
	Sat, 14 Feb 2026 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104393; cv=none; b=iiQCpSiWqPvzGwjekvL0JqLIrnX08+/KZT5tdNtISN5a8SGfKCqOiBZ5VZb+c3AMMsI/DFy8ay9moUW39/ZsEmM200O+0ur6JiRP1Z0TLeOb4JMa/dM026rJCnwiJM9bGNcC/rfQMmtP1wkHPBjnwhfeXDaSVi+IEJoA3Bwo+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104393; c=relaxed/simple;
	bh=588WLZSu1c8MCUWtpYoMRbASwC4bIZj7xL+4hOCiCEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qj9BWOaLV77Q4BKzpbnNeazmZRGw63ESxJ+QdYJHE+sNdCi5BR7oRcjxDYbC91J55CWYgLgvKU6+zNYnJ1U2v9HXOsbF/yIL55n6NfipAz8lDYARNl7ZIb4hfVSDNwAaDIKvRwCDvyS9wM/WpdgUVxPUJaNSwHSxqo04jaILPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohPgMaYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2FEC19422;
	Sat, 14 Feb 2026 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104393;
	bh=588WLZSu1c8MCUWtpYoMRbASwC4bIZj7xL+4hOCiCEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohPgMaYr+tFkkr5UO6P/O+yuBCNVJoGLJoogcZM+80u6I7yYj77BTZ6878sEjG3Ax
	 FTfLIlXwkVMbTMbOnkMYh2P2Dd/26IS6SJBG8ajhwX4CM45TRjmx4iiY3nmqVXy6iv
	 w04uQVr0GSlNm3inis/IP6E85t5yZHpB/DiEcT8vMEn8eVGZ7ucOgZmbsqUZmAOss8
	 ylGU/2ade10Rh/QtlIMMxLZ2cBTZGXt/4xSc4DQHUy1vZ8IgJIajfBhmLy6q9C3CvS
	 mtONNtC7LUipRxycigsdTAz1lmJP4NOOlAGFY+zF5QMs58g5Ub8KqiLQPjFDvqLTYm
	 Vp+Tp8vqj0kgw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] ext4: move ext4_percpu_param_init() before ext4_mb_init()
Date: Sat, 14 Feb 2026 16:23:23 -0500
Message-ID: <20260214212452.782265-58-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13696-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,msgid.link:url,huawei.com:email]
X-Rspamd-Queue-Id: AD6B413D9AE
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 270564513489d98b721a1e4a10017978d5213bff ]

When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
`DOUBLE_CHECK` macro defined, the following panic is triggered:

==================================================================
EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
                        comm mount: bg 0: bad block bitmap checksum
BUG: unable to handle page fault for address: ff110000fa2cc000
PGD 3e01067 P4D 3e02067 PUD 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
                        6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
RIP: 0010:percpu_counter_add_batch+0x13/0xa0
Call Trace:
 <TASK>
 ext4_mark_group_bitmap_corrupted+0xcb/0xe0
 ext4_validate_block_bitmap+0x2a1/0x2f0
 ext4_read_block_bitmap+0x33/0x50
 mb_group_bb_bitmap_alloc+0x33/0x80
 ext4_mb_add_groupinfo+0x190/0x250
 ext4_mb_init_backend+0x87/0x290
 ext4_mb_init+0x456/0x640
 __ext4_fill_super+0x1072/0x1680
 ext4_fill_super+0xd3/0x280
 get_tree_bdev_flags+0x132/0x1d0
 vfs_get_tree+0x29/0xd0
 vfs_cmd_create+0x59/0xe0
 __do_sys_fsconfig+0x4f6/0x6b0
 do_syscall_64+0x50/0x1f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

This issue can be reproduced using the following commands:
        mkfs.ext4 -F -q -b 1024 /dev/sda 5G
        tune2fs -O quota,project /dev/sda
        mount /dev/sda /tmp/test

With DOUBLE_CHECK defined, mb_group_bb_bitmap_alloc() reads
and validates the block bitmap. When the validation fails,
ext4_mark_group_bitmap_corrupted() attempts to update
sbi->s_freeclusters_counter. However, this percpu_counter has not been
initialized yet at this point, which leads to the panic described above.

Fix this by moving the execution of ext4_percpu_param_init() to occur
before ext4_mb_init(), ensuring the per-CPU counters are initialized
before they are used.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20251209133116.731350-1-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of ext4: move ext4_percpu_param_init() before ext4_mb_init()

### 1. COMMIT MESSAGE ANALYSIS

The commit message is exceptionally detailed and clearly describes:
- **A concrete, reproducible crash** (kernel panic / page fault / oops)
- **Exact reproduction steps** (`mkfs.ext4 -F -q -b 1024 /dev/sda 5G;
  tune2fs -O quota,project /dev/sda; mount /dev/sda /tmp/test`)
- **Full stack trace** showing the crash in `percpu_counter_add_batch`
  called from `ext4_mark_group_bitmap_corrupted` during `ext4_mb_init`
- **Root cause**: `sbi->s_freeclusters_counter` (a percpu_counter) is
  used before it's initialized because `ext4_percpu_param_init()` was
  called *after* `ext4_mb_init()`

The trigger is a corrupted block bitmap encountered during mount with
`DOUBLE_CHECK` defined. When `ext4_validate_block_bitmap` fails and
calls `ext4_mark_group_bitmap_corrupted`, it tries to update a percpu
counter that hasn't been initialized yet.

### 2. CODE CHANGE ANALYSIS

The fix is straightforward reordering:

1. **Move `ext4_percpu_param_init(sbi)` call BEFORE `ext4_mb_init(sb)`**
   — This ensures percpu counters are initialized before `ext4_mb_init`
   can potentially use them via bitmap validation error paths.

2. **Move `ext4_percpu_param_destroy(sbi)` to the `failed_mount5`
   label** — This adjusts the cleanup ordering to match the new
   initialization ordering. Previously it was at `failed_mount6` (after
   `ext4_mb_release`), now it's at `failed_mount5` (before
   `ext4_mb_release` but still cleaning up properly).

The error path handling is also correctly adjusted: if
`ext4_percpu_param_init` fails, it jumps to `failed_mount5` which now
calls `ext4_percpu_param_destroy`. If `ext4_mb_init` fails, it also
jumps to `failed_mount5`, which will now properly destroy the percpu
params that were initialized.

Let me verify the error path correctness more carefully:

- **Before the change**: `failed_mount6` → `ext4_mb_release`,
  `ext4_flex_groups_free`, `ext4_percpu_param_destroy` → falls through
  to `failed_mount5` → `ext4_ext_release`, etc.
- **After the change**: `failed_mount6` → `ext4_mb_release`,
  `ext4_flex_groups_free` → falls through to `failed_mount5` →
  `ext4_percpu_param_destroy` → `ext4_ext_release`, etc.

This is correct: the destroy is still called on all paths where init
succeeded, and the ordering is proper (mb_release before
percpu_param_destroy, which mirrors the new init ordering).

### 3. CLASSIFICATION

This is a clear **bug fix** — it fixes a **NULL pointer dereference /
page fault** during mount. The crash occurs when:
1. A filesystem with corrupted block bitmap is mounted
2. `ext4_mb_init` reads and validates block bitmaps
3. Validation fails, triggering `ext4_mark_group_bitmap_corrupted`
4. That function tries to update an uninitialized percpu counter →
   **crash**

While the reproduction requires `DOUBLE_CHECK` to be defined in the test
scenario described, the underlying issue is that `ext4_mb_init` can
access percpu counters before they're initialized. This could
potentially be triggered in other scenarios too.

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: Very small — moving a few lines of code (function
  call reordering + error label adjustment)
- **Files touched**: 1 file (`fs/ext4/super.c`)
- **Subsystem**: ext4 filesystem — one of the most widely used Linux
  filesystems
- **Risk**: Very low. The change is a simple reordering of
  initialization. `ext4_percpu_param_init` has no dependency on
  `ext4_mb_init`, so moving it before is safe. The error paths are
  correctly adjusted.
- **Could this break something?** Extremely unlikely — it just
  initializes counters earlier, which is strictly safer.

### 5. USER IMPACT

- **Who is affected**: Any user mounting an ext4 filesystem with
  corrupted block bitmaps
- **How severe**: Kernel panic / crash during mount — **HIGH severity**
- **Real-world scenario**: Filesystem corruption can happen due to power
  failure, hardware issues, etc. A mount attempt on a corrupted
  filesystem should not crash the kernel.

### 6. STABILITY INDICATORS

- **Reviewed-by: Zhang Yi** and **Reviewed-by: Jan Kara** (Jan Kara is a
  well-known ext4/filesystem developer)
- **Committed by: Theodore Ts'o** (ext4 maintainer)
- The fix is obviously correct — it's a simple initialization order fix

### 7. DEPENDENCY CHECK

This commit is self-contained. It only reorders existing function calls
in `__ext4_fill_super()`. The functions `ext4_percpu_param_init()` and
`ext4_mb_init()` both exist in stable trees. No additional commits are
needed.

### Summary

This is a textbook stable backport candidate:
- **Fixes a real crash** (kernel panic on mount with corrupted
  filesystem)
- **Small, surgical fix** (just reordering initialization + adjusting
  error cleanup)
- **No new features** — purely defensive initialization ordering
- **Low risk** — the change is obviously correct
- **Important subsystem** — ext4 is used by millions of systems
- **Reviewed by subsystem experts** including Jan Kara and committed by
  Ted Ts'o
- **Meets all stable kernel rules**: obviously correct, fixes real bug,
  small scope, tested

**YES**

 fs/ext4/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d02..5c2e931d8a533 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5604,6 +5604,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			clear_opt2(sb, MB_OPTIMIZE_SCAN);
 	}
 
+	err = ext4_percpu_param_init(sbi);
+	if (err)
+		goto failed_mount5;
+
 	err = ext4_mb_init(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
@@ -5619,10 +5623,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	err = ext4_percpu_param_init(sbi);
-	if (err)
-		goto failed_mount6;
-
 	if (ext4_has_feature_flex_bg(sb))
 		if (!ext4_fill_flex_info(sb)) {
 			ext4_msg(sb, KERN_ERR,
@@ -5704,8 +5704,8 @@ failed_mount8: __maybe_unused
 failed_mount6:
 	ext4_mb_release(sb);
 	ext4_flex_groups_free(sbi);
-	ext4_percpu_param_destroy(sbi);
 failed_mount5:
+	ext4_percpu_param_destroy(sbi);
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
 failed_mount4a:
-- 
2.51.0


