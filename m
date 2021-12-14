Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3129F47422B
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 13:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhLNMP2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 07:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLNMP2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 07:15:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2C6C061574
        for <linux-ext4@vger.kernel.org>; Tue, 14 Dec 2021 04:15:28 -0800 (PST)
Date:   Tue, 14 Dec 2021 13:15:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639484125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VSSGqKWrulK7FvEkBZ985y3w5SZtkSNgNk4wk8Vv85M=;
        b=uBbwqn82Cbd2asZGDPp03cJ01a8t2z5it4mKAWDUJfLQs7eS2iAC3BWOF77dBAfQwZ5sWW
        S8HuVu47wcc71ov3RDiobx609ktDSKqvfgn5b6PIxQiWVupiApl/j1cs6F1YJxnKQ44S7N
        +MH5cYrDvUpRjOlGXmv3BP+AVtCmTSVTnJmFHpmuNYJ832lC7xgBPmusBCM4602jP89lIa
        roAgjasAefm0XHCn7yjQQlOrKMx+SNuWXj7X8N4o78nBR+Lm9/N64EOFfovIaPOol/fKy5
        wwg/59zhrhDgIzfsyIkZF+oed/2jXdRIYtMxY92ZpaHFnoVcbImKENMmv/kVew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639484125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VSSGqKWrulK7FvEkBZ985y3w5SZtkSNgNk4wk8Vv85M=;
        b=ocRsryxEcRfKwK1M6zovA64duJUqI6sA3gb8NBkU6zH8v7NUgwwu5tsxKMVN5xANPkRlox
        0IVbBrpNrguLHEDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH REPOST] ext4: Destroy ext4_fc_dentry_cachep kmemcache on
 module removal.
Message-ID: <YbiK3JetFFl08bd7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The kmemcache for ext4_fc_dentry_cachep remains registered after module
removal.

Destroy ext4_fc_dentry_cachep kmemcache on module removal.

Fixes: aa75f4d3daaeb ("ext4: main fast-commit commit path")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Link: https://lore.kernel.org/r/20211110134640.lyku5vklvdndw6uk@linutronix.de
---
 fs/ext4/ext4.h        | 1 +
 fs/ext4/fast_commit.c | 5 +++++
 fs/ext4/super.c       | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5d..af7088085d4e4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2935,6 +2935,7 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
 int __init ext4_fc_init_dentry_cache(void);
+void ext4_fc_destroy_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f32b445582ab..4665508efd778 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2192,3 +2192,8 @@ int __init ext4_fc_init_dentry_cache(void)
 
 	return 0;
 }
+
+void ext4_fc_destroy_dentry_cache(void)
+{
+	kmem_cache_destroy(ext4_fc_dentry_cachep);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4e33b5eca694d..71185a217d05b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6649,6 +6649,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
+	ext4_fc_destroy_dentry_cache();
 out05:
 	destroy_inodecache();
 out1:
@@ -6675,6 +6676,7 @@ static void __exit ext4_exit_fs(void)
 	unregister_as_ext2();
 	unregister_as_ext3();
 	unregister_filesystem(&ext4_fs_type);
+	ext4_fc_destroy_dentry_cache();
 	destroy_inodecache();
 	ext4_exit_mballoc();
 	ext4_exit_sysfs();
-- 
2.34.1

