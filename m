Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC253BDC01
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhGFRPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 13:15:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52906 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230178AbhGFRPF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 13:15:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166HCAfJ027697
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 13:12:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6100115C3CC6; Tue,  6 Jul 2021 13:12:10 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3] ext4: fix possible UAF when remounting r/o a mmp-protected file system
Date:   Tue,  6 Jul 2021 13:12:08 -0400
Message-Id: <20210706171208.3540887-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <YOR+5AY2owcnhrgy@mit.edu>
References: <YOR+5AY2owcnhrgy@mit.edu>
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

Link: https://lore.kernel.org/r/YONtEGojq7LcXnuC@mit.edu
Reported-by: Ye Bin <yebin10@huawei.com>
Bug-Report-Link: <20210629143603.2166962-1-yebin10@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mmp.c   | 31 ++++++++++++++-----------------
 fs/ext4/super.c |  6 +++++-
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 6cb598b549ca..16d69c0ff46a 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -156,7 +156,12 @@ static int kmmpd(void *data)
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
 
-	while (!kthread_should_stop()) {
+	while (!kthread_should_stop() && !sb_rdonly(sb)) {
+		if (!ext4_has_feature_mmp(sb)) {
+			ext4_warning(sb, "kmmpd being stopped since MMP feature"
+				     " has been disabled.");
+			goto wait_to_exit;
+		}
 		if (++seq > EXT4_MMP_SEQ_MAX)
 			seq = 1;
 
@@ -177,16 +182,6 @@ static int kmmpd(void *data)
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
@@ -207,7 +202,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
 					       retval);
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 
 			mmp_check = (struct mmp_struct *)(bh_check->b_data);
@@ -221,7 +216,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, EBUSY, "abort");
 				put_bh(bh_check);
 				retval = -EBUSY;
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 			put_bh(bh_check);
 		}
@@ -242,9 +237,13 @@ static int kmmpd(void *data)
 	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 
-	retval = write_mmp_block(sb, bh);
+	return write_mmp_block(sb, bh);
 
-exit_thread:
+wait_to_exit:
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop())
+		schedule();
+	set_current_state(TASK_RUNNING);
 	return retval;
 }
 
@@ -391,5 +390,3 @@ int ext4_multi_mount_protect(struct super_block *sb,
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

