Return-Path: <linux-ext4+bounces-2660-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7718D11BF
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 04:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321FA1F24D13
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CC38DE4;
	Tue, 28 May 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avauGSQQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25F37719;
	Tue, 28 May 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862727; cv=none; b=d4pTCeNQu7t3vcEoxaPMWunMf+247u3R7YDPp3hEUOG/I3DG8ysdwZsrRsM/RL70QTzVwXPZTbIcHOrKK/gaUqmYvdjyzjVOut9Slx3opEIyt6vwUuCUjWNUOZezT6Fgl+p2ZXeoT3B5/Z6bJ30tCUjho1r+wp2DINWpmBMVPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862727; c=relaxed/simple;
	bh=rhmOw/+SwBu79j3YvIR5ee96mjkov8qRkwVET61TZvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glnnTb8XtplzZ7oflLwsQ/qkOG9DMRk3/1Yh87d/1vr7QzFx7/EPZMKg3EmbM2XlZzYeIQpIpvTf1O+VY63uMcOy49vhbDHPYH9bzSDHnW2C5lIXsJ0mF8cJZkFI9P9dhtJ8KT0qApNV0rBTuiwoUFlev7v22zVapUM6tJOErWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avauGSQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF7DC32782;
	Tue, 28 May 2024 02:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862727;
	bh=rhmOw/+SwBu79j3YvIR5ee96mjkov8qRkwVET61TZvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avauGSQQFUCtbTDSIktiX8V2GGHCgZkhP10Js4dMW8WTDDimMHIoxLhYiZD95mV/4
	 i/KhH/X1FIJU3vfIlprXs6qKmj9UeUW2XHxBk4holDCj+IyP/HEBDYBT1k5zcQLYg7
	 zXfIRX6Jqf2biMqVP3bNgOFOeK0/2o5GC9ZolgTbSwePSOrZIVV4mmj5WuEyp4/uPv
	 ggLZWwRCIC2lOSR1oavBau9D8bf3lSU4og429JvrqnYs69H4GgxTRqgZDGQa8q3CQr
	 qUYVddKCZCgw8kpDoS0TIUE41vdY8UzeQpzpdkqYv2hF5kh+LNsO9bPfQ4NIAYJ+ij
	 9/0gEaxiXIelw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 3/4] ext4: fix uninitialized ratelimit_state->lock access in __ext4_fill_super()
Date: Mon, 27 May 2024 22:18:38 -0400
Message-ID: <20240528021840.3905128-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021840.3905128-1-sashal@kernel.org>
References: <20240528021840.3905128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]

In the following concurrency we will access the uninitialized rs->lock:

ext4_fill_super
  ext4_register_sysfs
   // sysfs registered msg_ratelimit_interval_ms
                             // Other processes modify rs->interval to
                             // non-zero via msg_ratelimit_interval_ms
  ext4_orphan_cleanup
    ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
      __ext4_msg
        ___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state)
          if (!rs->interval)  // do nothing if interval is 0
            return 1;
          raw_spin_trylock_irqsave(&rs->lock, flags)
            raw_spin_trylock(lock)
              _raw_spin_trylock
                __raw_spin_trylock
                  spin_acquire(&lock->dep_map, 0, 1, _RET_IP_)
                    lock_acquire
                      __lock_acquire
                        register_lock_class
                          assign_lock_key
                            dump_stack();
  ratelimit_state_init(&sbi->s_msg_ratelimit_state, 5 * HZ, 10);
    raw_spin_lock_init(&rs->lock);
    // init rs->lock here

and get the following dump_stack:

=========================================================
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 12 PID: 753 Comm: mount Tainted: G E 6.7.0-rc6-next-20231222 #504
[...]
Call Trace:
 dump_stack_lvl+0xc5/0x170
 dump_stack+0x18/0x30
 register_lock_class+0x740/0x7c0
 __lock_acquire+0x69/0x13a0
 lock_acquire+0x120/0x450
 _raw_spin_trylock+0x98/0xd0
 ___ratelimit+0xf6/0x220
 __ext4_msg+0x7f/0x160 [ext4]
 ext4_orphan_cleanup+0x665/0x740 [ext4]
 __ext4_fill_super+0x21ea/0x2b10 [ext4]
 ext4_fill_super+0x14d/0x360 [ext4]
[...]
=========================================================

Normally interval is 0 until s_msg_ratelimit_state is initialized, so
___ratelimit() does nothing. But registering sysfs precedes initializing
rs->lock, so it is possible to change rs->interval to a non-zero value
via the msg_ratelimit_interval_ms interface of sysfs while rs->lock is
uninitialized, and then a call to ext4_msg triggers the problem by
accessing an uninitialized rs->lock. Therefore register sysfs after all
initializations are complete to avoid such problems.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240102133730.1098120-1-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4866657c6d41f..b5fc5fa4e586c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5555,19 +5555,15 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount6;
 
-	err = ext4_register_sysfs(sb);
-	if (err)
-		goto failed_mount7;
-
 	err = ext4_init_orphan_info(sb);
 	if (err)
-		goto failed_mount8;
+		goto failed_mount7;
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount. */
 	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
 		err = ext4_enable_quotas(sb);
 		if (err)
-			goto failed_mount9;
+			goto failed_mount8;
 	}
 #endif  /* CONFIG_QUOTA */
 
@@ -5593,7 +5589,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount10;
+			goto failed_mount9;
 	}
 
 	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
@@ -5610,15 +5606,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	atomic_set(&sbi->s_warning_count, 0);
 	atomic_set(&sbi->s_msg_count, 0);
 
+	/* Register sysfs after all initializations are complete. */
+	err = ext4_register_sysfs(sb);
+	if (err)
+		goto failed_mount9;
+
 	return 0;
 
-failed_mount10:
+failed_mount9:
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
-failed_mount9: __maybe_unused
+failed_mount8: __maybe_unused
 	ext4_release_orphan_info(sb);
-failed_mount8:
-	ext4_unregister_sysfs(sb);
-	kobject_put(&sbi->s_kobj);
 failed_mount7:
 	ext4_unregister_li_request(sb);
 failed_mount6:
-- 
2.43.0


