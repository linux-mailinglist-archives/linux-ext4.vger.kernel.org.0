Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227983BC367
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhGEUiU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 16:38:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52787 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229893AbhGEUiU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 16:38:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 165KZSEE004974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 16:35:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AB1CB15C3C96; Mon,  5 Jul 2021 16:35:28 -0400 (EDT)
Date:   Mon, 5 Jul 2021 16:35:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Fix use-after-free about sbi->s_mmp_tsk
Message-ID: <YONtEGojq7LcXnuC@mit.edu>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-2-yebin10@huawei.com>
 <20210705111548.GD15373@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705111548.GD15373@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 05, 2021 at 01:15:48PM +0200, Jan Kara wrote:
> 
> That being said for this scheme spinlock is enough, you don't need a mutex
> for s_mmp_lock.

I think we can solve this without using using either a spinlock or a
mutex, and it's a smaller and simpler patch as a result.  (This is the
-v2 version of this patch, which removes an unused label compared to
the earlier version.)

From 22ebc97aac75e27a5fd11acdb2bc3030d1da58d1 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Fri, 2 Jul 2021 12:45:02 -0400
Subject: [PATCH] ext4: fix possible UAF when remounting r/o a mmp-protected file system

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
 fs/ext4/mmp.c   | 33 +++++++++++++++++----------------
 fs/ext4/super.c |  6 +++++-
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 6cb598b549ca..1e95cee3d8b7 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -157,6 +157,17 @@ static int kmmpd(void *data)
 	       sizeof(mmp->mmp_nodename));
 
 	while (!kthread_should_stop()) {
+		if (!(le32_to_cpu(es->s_feature_incompat) &
+		    EXT4_FEATURE_INCOMPAT_MMP)) {
+			ext4_warning(sb, "kmmpd being stopped since MMP feature"
+				     " has been disabled.");
+			goto wait_to_exit;
+		}
+		if (sb_rdonly(sb)) {
+			if (!kthread_should_stop())
+				schedule_timeout_interruptible(HZ);
+			continue;
+		}
 		if (++seq > EXT4_MMP_SEQ_MAX)
 			seq = 1;
 
@@ -177,16 +188,6 @@ static int kmmpd(void *data)
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
@@ -207,7 +208,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
 					       retval);
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 
 			mmp_check = (struct mmp_struct *)(bh_check->b_data);
@@ -221,7 +222,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, EBUSY, "abort");
 				put_bh(bh_check);
 				retval = -EBUSY;
-				goto exit_thread;
+				goto wait_to_exit;
 			}
 			put_bh(bh_check);
 		}
@@ -242,9 +243,11 @@ static int kmmpd(void *data)
 	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 
-	retval = write_mmp_block(sb, bh);
+	return write_mmp_block(sb, bh);
 
-exit_thread:
+wait_to_exit:
+	while (!kthread_should_stop())
+		schedule();
 	return retval;
 }
 
@@ -391,5 +394,3 @@ int ext4_multi_mount_protect(struct super_block *sb,
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

