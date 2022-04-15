Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE465020C4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Apr 2022 04:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbiDOC51 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Apr 2022 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348839AbiDOC50 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Apr 2022 22:57:26 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4C3669D
        for <linux-ext4@vger.kernel.org>; Thu, 14 Apr 2022 19:54:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23F2sjIP023992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 22:54:45 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1217715C3EB4; Thu, 14 Apr 2022 22:54:45 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Fariya F <fariya.fatima03@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 3/3] ext4: update the cached overhead value in the superblock
Date:   Thu, 14 Apr 2022 22:54:40 -0400
Message-Id: <20220415025440.2342107-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220415025440.2342107-1-tytso@mit.edu>
References: <CACA3K+iNFkLLuXJ7W5N70sVC+RVVszx-xVQojNUE8NqfWFuSVg@mail.gmail.com>
 <20220415025440.2342107-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If we (re-)calculate the file system overhead amount and it's
different from the on-disk s_overhead_clusters value, update the
on-disk version since this can take potentially quite a while on
bigalloc file systems.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/ioctl.c | 16 ++++++++++++++++
 fs/ext4/super.c |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 48dc2c3247ad..a743b1e3b89e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3068,6 +3068,7 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		      struct dentry *dentry, struct fileattr *fa);
 int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
+int ext4_update_overhead(struct super_block *sb);
 
 /* migrate.c */
 extern int ext4_ext_migrate(struct inode *);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 992229ca2d83..ba44fa1be70a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1652,3 +1652,19 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ext4_ioctl(file, cmd, (unsigned long) compat_ptr(arg));
 }
 #endif
+
+static void set_overhead(struct ext4_super_block *es, const void *arg)
+{
+	es->s_overhead_clusters = cpu_to_le32(*((unsigned long *) arg));
+}
+
+int ext4_update_overhead(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (sb_rdonly(sb) || sbi->s_overhead == 0 ||
+	    sbi->s_overhead == le32_to_cpu(sbi->s_es->s_overhead_clusters))
+		return 0;
+
+	return ext4_update_superblocks_fn(sb, set_overhead, &sbi->s_overhead);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d08820fdfdee..1847b46af808 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5618,6 +5618,8 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
 			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
 
+	/* Update the s_overhead_clusters if necessary */
+	ext4_update_overhead(sb);
 	return 0;
 
 free_sbi:
-- 
2.31.0

