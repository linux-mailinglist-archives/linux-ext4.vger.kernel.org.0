Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8443A44C259
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Nov 2021 14:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhKJNtc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Nov 2021 08:49:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKJNtb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Nov 2021 08:49:31 -0500
Date:   Wed, 10 Nov 2021 14:46:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636552002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mzJai93r+ZR/gProqThGByCGxin7/za36mQAiFwzR5Y=;
        b=QRitoM4ON9c/eiQciJNr2KdA4q0sGOAjNPCRhQeGjv5iCIrTtKURTDPvsP/8yXR5aSJm+q
        r6UyDQ0MwoirA3z4I/Lz603hSoeyVOMcHmefIr31LzWNTxpL3WxX/9sc+4hbgiLLW682E5
        ixbazbDp66FtsuLC1TD9H/3/FCm/qvY5wqMVmQqliPeMw4KNdSG5yJMxvcIeSWWIyXV/cS
        6FP60Pbk4Nv95nT2PbeoiDdf67fAPrUV0yqi/N5D/lxFv+lT/BomABiBN2YOrtrtqmGaYB
        7gVS6XI4V8GY6Xm8kLTGr+yjMFZYr7pkmB8RMJJ5/yYaMqc1WsN1O7F41m0Pig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636552002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mzJai93r+ZR/gProqThGByCGxin7/za36mQAiFwzR5Y=;
        b=LQf6WXS0PwnYNBxN4fDbF0N3Uz3PnqBNkbWZbFRKlxl2cadzWXTK5KzigKwLb4E/KEfbtV
        wiVp/7KXHw+5nvBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module
 removal.
Message-ID: <20211110134640.lyku5vklvdndw6uk@linutronix.de>
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
---
 fs/ext4/ext4.h        | 1 +
 fs/ext4/fast_commit.c | 5 +++++
 fs/ext4/super.c       | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3825195539d74..c97860ef322db 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2934,6 +2934,7 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
 int __init ext4_fc_init_dentry_cache(void);
+void ext4_fc_destroy_dentry_cache(void);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8ea5a81e65548..1a43af302ecba 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2185,3 +2185,8 @@ int __init ext4_fc_init_dentry_cache(void)
 
 	return 0;
 }
+
+void ext4_fc_destroy_dentry_cache(void)
+{
+	kmem_cache_destroy(ext4_fc_dentry_cachep);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88d5d274a8684..eb2dfc2a19d33 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6641,6 +6641,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
+	ext4_fc_destroy_dentry_cache();
 out05:
 	destroy_inodecache();
 out1:
@@ -6667,6 +6668,7 @@ static void __exit ext4_exit_fs(void)
 	unregister_as_ext2();
 	unregister_as_ext3();
 	unregister_filesystem(&ext4_fs_type);
+	ext4_fc_destroy_dentry_cache();
 	destroy_inodecache();
 	ext4_exit_mballoc();
 	ext4_exit_sysfs();
-- 
2.33.1

