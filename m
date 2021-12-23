Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9690847E684
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 17:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349240AbhLWQo4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 11:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhLWQoz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 11:44:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B61C061401
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 08:44:54 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640277891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DqjzpyejmKl3fb8aZGQqkotqBv+cbYCwbKa9BS3bBcE=;
        b=XM9OgyOlnTsARrpHECG5nN+1B6wAVtiYlz7EnnkBk0O/p1ytVb0svf7SwVa1JVA0pi/KNL
        CkmdLho0y91/G2hCAbf+zo79HdS7pv7prCHMsDxYKlbMy+K27IV50ytSVJ4t6dWhC2ngQP
        YWGD/UNbLqqR5KtaGOqx9G4JJ1HUdh4f2OjTqfuza5Uxh3JJRuM/bfGkI3ZHe7Z+Eg77b/
        89jxpy3dJBvwku5kl3TtME8lJ0OmjsCov69cQRQdtLdyy5LSKwxXOCsopjEJrvRJEHYb9i
        ecgbTGXGnbffLSStMdFMzLUUdkeFr2vgil+QlL64TVJ9wXddFRqY2cdXMnrBQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640277891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DqjzpyejmKl3fb8aZGQqkotqBv+cbYCwbKa9BS3bBcE=;
        b=yh9/7gsnPG4hexn2YPepQuO4FfWlm1Dw5TVdSO9zmlKnJCTmv46PkkmxyoMyQ7wlof4TeT
        kikV0nx78KqGTlAQ==
To:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lukas Czerner <lczerner@redhat.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH REPOST REPOST] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module removal.
Date:   Thu, 23 Dec 2021 17:44:36 +0100
Message-Id: <20211223164436.2628390-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The kmemcache for ext4_fc_dentry_cachep remains registered after module
removal.

Destroy ext4_fc_dentry_cachep kmemcache on module removal.

Fixes: aa75f4d3daaeb ("ext4: main fast-commit commit path")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20211110134640.lyku5vklvdndw6uk@linutronix.=
de
Link: https://lore.kernel.org/r/YbiK3JetFFl08bd7@linutronix.de
---
 fs/ext4/ext4.h        | 1 +
 fs/ext4/fast_commit.c | 5 +++++
 fs/ext4/super.c       | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9cc55bcda6ba4..2d414dfd60cb6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2936,6 +2936,7 @@ bool ext4_fc_replay_check_excluded(struct super_block=
 *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
 int __init ext4_fc_init_dentry_cache(void);
+void ext4_fc_destroy_dentry_cache(void);
=20
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0f32b445582ab..4665508efd778 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2192,3 +2192,8 @@ int __init ext4_fc_init_dentry_cache(void)
=20
 	return 0;
 }
+
+void ext4_fc_destroy_dentry_cache(void)
+{
+	kmem_cache_destroy(ext4_fc_dentry_cachep);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb6..55f2fba6a5292 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7133,6 +7133,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
+	ext4_fc_destroy_dentry_cache();
 out05:
 	destroy_inodecache();
 out1:
@@ -7159,6 +7160,7 @@ static void __exit ext4_exit_fs(void)
 	unregister_as_ext2();
 	unregister_as_ext3();
 	unregister_filesystem(&ext4_fs_type);
+	ext4_fc_destroy_dentry_cache();
 	destroy_inodecache();
 	ext4_exit_mballoc();
 	ext4_exit_sysfs();
--=20
2.34.1

