Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D185B3BA36A
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 18:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGBRAq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 13:00:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37703 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229455AbhGBRAp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 13:00:45 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 162GvvjO014381
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jul 2021 12:57:58 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5868215C3CE4; Fri,  2 Jul 2021 12:57:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: possible use-after-free when remounting r/o a mmp-protected file system
Date:   Fri,  2 Jul 2021 12:57:53 -0400
Message-Id: <e525c0bf7b18da426bb3d3dd63830a3f85218a9e.1625244710.git.tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210629143603.2166962-1-yebin10@huawei.com>
References: <20210629143603.2166962-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After commit 618f003199c6 ("ext4: fix memory leak in
ext4_fill_super"), after the file system is remounted read-only, there
is a race where the kmmpd thread can exit, causing sbi->s_mmp_tsk to
point at freed memory, which the call to ext4_stop_mmpd() can trip
over.

Fix this by only allowing kmmpd() to exit when it is stopped via
ext4_stop_mmpd().

Link: https://lore.kernel.org/r/e525c0bf7b18da426bb3d3dd63830a3f85218a9e.1625244710.git.tytso@mit.edu
Reported-by: Ye Bin <yebin10@huawei.com>
Bug-Report-Link: <20210629143603.2166962-1-yebin10@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Ye, thanks for reporting the bug!  I think this might be a better way
to address the problem, since it avoids adding a mutex just to protect
s_mmp_tsk.  What do you think?

 fs/ext4/mmp.c   | 31 +++++++++++++++++--------------
 fs/ext4/super.c |  6 +++++-
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 6cb598b549ca..af461df1c1ec 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -157,6 +157,16 @@ static int kmmpd(void *data)
 	       sizeof(mmp->mmp_nodename));
 
 	while (!kthread_should_stop()) {
+		if (!(le32_to_cpu(es->s_feature_incompat) &
+		    EXT4_FEATURE_INCOMPAT_MMP)) {
+			ext4_warning(sb, "kmmpd being stopped since MMP feature"
+				     " has been disabled.");
+			goto wait_to_exit;
+		}
+		if (sb_rdonly(sb)) {
+			schedule_timeout_interruptible(HZ);
+			continue;
+		}
 		if (++seq > EXT4_MMP_SEQ_MAX)
 			seq = 1;
 
@@ -177,16 +187,6 @@ static int kmmpd(void *data)
 			failed_writes++;
 		}
 
-		if (!(le32_to_cpu(es->s_feature_incompat) &
-		    EXT4_FEATURE_INCOMPAT_MMP)) {
-			ext4_warning(sb, "kmmpd being stopped since MMP feature"
-				     " has been disabled.");
-			goto exit_thread;
-		}
-
-		if (sb_rdonly(sb))
-			break;
-
 		diff = jiffies - last_update_time;
 		if (diff < mmp_update_interval * HZ)
 			schedule_timeout_interruptible(mmp_update_interval *
@@ -207,7 +207,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
 					       retval);
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 
 			mmp_check = (struct mmp_struct *)(bh_check->b_data);
@@ -221,7 +221,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, EBUSY, "abort");
 				put_bh(bh_check);
 				retval = -EBUSY;
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 			put_bh(bh_check);
 		}
@@ -246,6 +246,11 @@ static int kmmpd(void *data)
 
 exit_thread:
 	return retval;
+wait_to_exit:
+	while (!kthread_should_stop())
+		schedule();
+	return retval;
+
 }
 
 void ext4_stop_mmpd(struct ext4_sb_info *sbi)
@@ -391,5 +396,3 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	brelse(bh);
 	return 1;
 }
-
-
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cdbe71d935e8..b8ff0399e171 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5993,7 +5993,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				 */
 				ext4_mark_recovery_complete(sb, es);
 			}
-			ext4_stop_mmpd(sbi);
 		} else {
 			/* Make sure we can mount this feature set readwrite */
 			if (ext4_has_feature_readonly(sb) ||
@@ -6107,6 +6106,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
 		ext4_release_system_zone(sb);
 
+	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
+		ext4_stop_mmpd(sbi);
+
 	/*
 	 * Some options can be enabled by ext4 and/or by VFS mount flag
 	 * either way we need to make sure it matches in both *flags and
@@ -6140,6 +6142,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
 		kfree(to_free[i]);
 #endif
+	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
+		ext4_stop_mmpd(sbi);
 	kfree(orig_data);
 	return err;
 }
-- 
2.31.0

