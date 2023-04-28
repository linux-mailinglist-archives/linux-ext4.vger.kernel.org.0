Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62A36F10C2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 05:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345071AbjD1DQq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 23:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345058AbjD1DQi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 23:16:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A43C23
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 20:16:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33S3GI0r012426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 23:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682651779; bh=1aQAG8ZlBllKhkDgEOxU+hrLEBkVFzSko4MWppltGtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=msl/qGjz8/s7VTpqtGhzCkayjsdEwYA7yS+ShtsuqGCQniOB2Zy4f3rkI/IHNBpQL
         4qJfUhUHcMt6P3lQhIkoXnYqNonEaR5Pnv0XbFpU+0oFjX/MSGX0mcZZiEtSd9rllJ
         kS96UJObIwqxyH0gKHGYCQU71Dm4oaT6wI9lmoYT3b9cnJLvYQunopnfS/nrIFUkpC
         WEUIErqpy/s6BcfxXPr44Ak6KgOxLby5WRzea2lVoI/ffSAZ3o3MRcTCTPMHhCf2j0
         /v5oSfG/HRWQ66apSrLuyqN5WrqVQErb7k168w+7O/jBjuiOSHd2/P26A4zWkA0xkb
         VCMgBira9jYwQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 45C1415C5336; Thu, 27 Apr 2023 23:16:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Jason Yan <yanaijie@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH 2/3] ext4: reflect error codes from ext4_multi_mount_protect() to its callers
Date:   Thu, 27 Apr 2023 23:16:01 -0400
Message-Id: <20230428031602.242297-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230428031602.242297-1-tytso@mit.edu>
References: <20230428031602.242297-1-tytso@mit.edu>
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

This will allow more fine-grained errno codes to be returned by the
mount system call.

Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mmp.c   |  9 ++++++++-
 fs/ext4/super.c | 14 +++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 4681fff6665f..4022bc713421 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -282,6 +282,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
 	    mmp_block >= ext4_blocks_count(es)) {
 		ext4_warning(sb, "Invalid MMP block in superblock");
+		retval = -EINVAL;
 		goto failed;
 	}
 
@@ -307,6 +308,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (seq == EXT4_MMP_SEQ_FSCK) {
 		dump_mmp_msg(sb, mmp, "fsck is running on the filesystem");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -320,6 +322,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount\n");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -330,6 +333,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -349,6 +353,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	 */
 	if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
 		ext4_warning(sb, "MMP startup interrupted, failing mount");
+		retval = -ETIMEDOUT;
 		goto failed;
 	}
 
@@ -359,6 +364,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (seq != le32_to_cpu(mmp->mmp_seq)) {
 		dump_mmp_msg(sb, mmp,
 			     "Device is already active on another node.");
+		retval = -EBUSY;
 		goto failed;
 	}
 
@@ -378,6 +384,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		EXT4_SB(sb)->s_mmp_tsk = NULL;
 		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
 			     sb->s_id);
+		retval = -ENOMEM;
 		goto failed;
 	}
 
@@ -385,5 +392,5 @@ int ext4_multi_mount_protect(struct super_block *sb,
 
 failed:
 	brelse(bh);
-	return 1;
+	return retval;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b11907e1fab2..9a8af70815b1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5329,9 +5329,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			  ext4_has_feature_orphan_present(sb) ||
 			  ext4_has_feature_journal_needs_recovery(sb));
 
-	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
-		if (ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block)))
+	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb)) {
+		err = ext4_multi_mount_protect(sb, le64_to_cpu(es->s_mmp_block));
+		if (err)
 			goto failed_mount3a;
+	}
 
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -6566,12 +6568,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				goto restore_opts;
 
 			sb->s_flags &= ~SB_RDONLY;
-			if (ext4_has_feature_mmp(sb))
-				if (ext4_multi_mount_protect(sb,
-						le64_to_cpu(es->s_mmp_block))) {
+			if (ext4_has_feature_mmp(sb)) {
+				err = ext4_multi_mount_protect(sb,
+						le64_to_cpu(es->s_mmp_block));
+				if (err) {
 					err = -EROFS;
 					goto restore_opts;
 				}
+			}
 #ifdef CONFIG_QUOTA
 			enable_quota = 1;
 #endif
-- 
2.31.0

