Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC40555F4BC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 06:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiF2EAy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 00:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiF2EAl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 00:00:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A420F65
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 21:00:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25T40TpQ011618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 00:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656475231; bh=gfUX62MTmWwpvqozuOVbgMR15bCrH3xc5Q9mdt+HrNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cqWeBSKO6kKvxkrwIg5lApLf+Y5j5QS7IY0LZ8xqa5Ic1i+7Wip+obopplRTQlCc1
         3B8t/MD97ypWoPPrQ4dzwdBu9QHNi9d907k7EeiPWtHHHi71/IhvWcHe3gjA+HjBXm
         d+X7zNdl7kBoMcR8yVELsunu7puromqxmu+zfopIfvOLPuetGFz84i6pzQRYwfzVgL
         nWPFlYKlgD3Q9ST7vt60riuGNTaCGwIKL8UwWmUUTC00/KuV5ozKZxEPTSpmx5lJcJ
         Ilo7RMi/powIEhYiY4JxrOIG/+lEIFw65FigY8DB31+WNyHGg6aH7N3QG6DCxQPaAp
         5nc1tXNx0N1xA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C7FD215C432B; Wed, 29 Jun 2022 00:00:29 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: update the s_overhead_clusters in the backup sb's when resizing
Date:   Wed, 29 Jun 2022 00:00:26 -0400
Message-Id: <20220629040026.112371-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629040026.112371-1-tytso@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When the EXT4_IOC_RESIZE_FS ioctl is complete, update the backup
superblocks.  We don't do this for the old-style resize ioctls since
they are quite ancient, and only used by very old versions of
resize2fs --- and we don't want to update the backup superblocks every
time EXT4_IOC_GROUP_ADD is called, since it might get called a lot.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h   |  4 ++--
 fs/ext4/ioctl.c  | 22 +++++++++++++++-------
 fs/ext4/resize.c |  6 +++++-
 fs/ext4/super.c  |  2 +-
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b8d81b2469..826fcd12e393 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3016,7 +3016,7 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		      struct dentry *dentry, struct fileattr *fa);
 int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
-int ext4_update_overhead(struct super_block *sb);
+int ext4_update_overhead(struct super_block *sb, bool force);
 
 /* migrate.c */
 extern int ext4_ext_migrate(struct inode *);
@@ -3799,7 +3799,7 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
 extern wait_queue_head_t ext4__ioend_wq[EXT4_WQ_HASH_SZ];
 
 extern int ext4_resize_begin(struct super_block *sb);
-extern void ext4_resize_end(struct super_block *sb);
+extern int ext4_resize_end(struct super_block *sb, bool update_backups);
 
 static inline void ext4_set_io_unwritten_flag(struct inode *inode,
 					      struct ext4_io_end *io_end)
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index cb01c1da0f9d..1702c574407a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -944,7 +944,9 @@ static long ext4_ioctl_group_add(struct file *file,
 	    test_opt(sb, INIT_INODE_TABLE))
 		err = ext4_register_li_request(sb, input->group);
 group_add_out:
-	ext4_resize_end(sb);
+	err2 = ext4_resize_end(sb, false);
+	if (err == 0)
+		err = err2;
 	return err;
 }
 
@@ -1223,7 +1225,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = err2;
 		mnt_drop_write_file(filp);
 group_extend_out:
-		ext4_resize_end(sb);
+		err2 = ext4_resize_end(sb, false);
+		if (err == 0)
+			err = err2;
 		return err;
 	}
 
@@ -1371,7 +1375,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = ext4_register_li_request(sb, o_group);
 
 resizefs_out:
-		ext4_resize_end(sb);
+		err2 = ext4_resize_end(sb, true);
+		if (err == 0)
+			err = err2;
 		return err;
 	}
 
@@ -1599,13 +1605,15 @@ static void set_overhead(struct ext4_super_block *es, const void *arg)
 	es->s_overhead_clusters = cpu_to_le32(*((unsigned long *) arg));
 }
 
-int ext4_update_overhead(struct super_block *sb)
+int ext4_update_overhead(struct super_block *sb, bool force)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (sb_rdonly(sb) || sbi->s_overhead == 0 ||
-	    sbi->s_overhead == le32_to_cpu(sbi->s_es->s_overhead_clusters))
+	if (sb_rdonly(sb))
+		return 0;
+	if (!force &&
+	    (sbi->s_overhead == 0 ||
+	     sbi->s_overhead == le32_to_cpu(sbi->s_es->s_overhead_clusters)))
 		return 0;
-
 	return ext4_update_superblocks_fn(sb, set_overhead, &sbi->s_overhead);
 }
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e5c2713aa11a..8abff9400f69 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -97,10 +97,14 @@ int ext4_resize_begin(struct super_block *sb)
 	return ret;
 }
 
-void ext4_resize_end(struct super_block *sb)
+int ext4_resize_end(struct super_block *sb, bool update_backups)
 {
 	clear_bit_unlock(EXT4_FLAGS_RESIZING, &EXT4_SB(sb)->s_ext4_flags);
 	smp_mb__after_atomic();
+	if (update_backups)
+		return ext4_update_overhead(sb, true);
+	else
+		return 0;
 }
 
 static ext4_group_t ext4_meta_bg_first_group(struct super_block *sb,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..6a8a752d812b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5523,7 +5523,7 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
 
 	/* Update the s_overhead_clusters if necessary */
-	ext4_update_overhead(sb);
+	ext4_update_overhead(sb, false);
 	return 0;
 
 free_sbi:
-- 
2.31.0

