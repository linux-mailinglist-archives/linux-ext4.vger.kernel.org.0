Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27F31EC61
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Feb 2021 17:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhBRQiR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Feb 2021 11:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhBRPMZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Feb 2021 10:12:25 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30BC061788
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 07:11:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o21so1589279qtr.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmGcUUb0lOOZjJkF+Co3oT/JY7S3np8hVD15Hgd8EQk=;
        b=reLYdq/UivrIqy2PPULtfQni/+raTNQo0A6vk712+oUy4BvuOCLu4zCIEy84VM9kj+
         qSB7aBVj0qS7qtwHDgCxnwCP0cr4u4kLW9tMoJ5LMVEBw/PjLY7AfxLagdFcZ3IavKKu
         5ayqnEf4Oes2kHtHO1Mnkt1TF3q6asQ6xjOqfxpGi+iyBRXC6FKXpvzqdQK3xfYZoppO
         3ffvgtzPSs3749aJjsdkdJQ1hhWwcMZsMEo1EGirF4WAGf86OD60Q17PUIuV3Mh7ky/8
         Q3pNWmCW/zsrhd5LKPTWEFdB2qsdpN0yyS6HoKJtTR3F9cSWkIkjoRrK1FJ6Jh1gxuo+
         SLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmGcUUb0lOOZjJkF+Co3oT/JY7S3np8hVD15Hgd8EQk=;
        b=b1JAMn6x1eraNHj8EU0gn8BZ1/yrjLVhPL60+nYj39v6wKMBA8rjjXxtjKyT2szzUY
         rMrC40m7q3JGGXSD4QjdiK/3xLAyLrIDjVeN9t7dQF3uz/Fl14BZI+wUJJIkzRwjGPvQ
         hx09HL4clvQxWqqgKfCCsCEr6vDu9XFSdof1Pgpm/L3Aihr4QeISQhXlQL2pm9bfcIWd
         mclazVptVvI8FTo5+nazHk0VbOVXKfHfZX/jRmSTwdFwOtvGXehscCKwCKfX+xEjU1Cw
         Btso1UMTw77Wy7RsjFkwOLJvxKyQKR0kr7xFVw+MdsfbpGs6zvEaC1D+shf0EXydERTh
         RXTw==
X-Gm-Message-State: AOAM532mwAvk1Cauad/sF+/SK+NIs8A1OOD4FN5lED/pAyUpMKHGKYfl
        gHubg8ePuKjuLLr7e3xuz5SoOcoc4pE=
X-Google-Smtp-Source: ABdhPJzmnjJHWrtAxq8lLvk47f7VKDs/qztqBwj/U1LwINNKZsE6AmMIGkxm77E2L1KOonnXxgG4DA==
X-Received: by 2002:ac8:6f4e:: with SMTP id n14mr4385438qtv.299.1613661099783;
        Thu, 18 Feb 2021 07:11:39 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id y27sm2331470qtv.43.2021.02.18.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 07:11:39 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: shrink race window in ext4_should_retry_alloc()
Date:   Thu, 18 Feb 2021 10:11:32 -0500
Message-Id: <20210218151132.19678-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When generic/371 is run on kvm-xfstests using 5.10 and 5.11 kernels, it
fails at significant rates on the two test scenarios that disable
delayed allocation (ext3conv and data_journal) and force actual block
allocation for the fallocate and pwrite functions in the test.  The
failure rate on 5.10 for both ext3conv and data_journal on one test
system typically runs about 85%.  On 5.11, the failure rate on ext3conv
sometimes drops to as low as 1% while the rate on data_journal
increases to nearly 100%.

The observed failures are largely due to ext4_should_retry_alloc()
cutting off block allocation retries when s_mb_free_pending (used to
indicate that a transaction in progress will free blocks) is 0.
However, free space is usually available when this occurs during runs
of generic/371.  It appears that a thread attempting to allocate
blocks is just missing transaction commits in other threads that
increase the free cluster count and reset s_mb_free_pending while
the allocating thread isn't running.  Explicitly testing for free space
availability avoids this race.

The current code uses a post-increment operator in the conditional
expression that determines whether the retry limit has been exceeded.
This means that the conditional expression uses the value of the
retry counter before it's increased, resulting in an extra retry cycle.
The current code actually retries twice before hitting its retry limit
rather than once.

Increasing the retry limit to 3 from the current actual maximum retry
count of 2 in combination with the change described above reduces the
observed failure rate to less that 0.1% on both ext3conv and
data_journal with what should be limited impact on users sensitive to
the overhead caused by retries.

A per filesystem percpu counter exported via sysfs is added to allow
users or developers to track the number of times the retry limit is
exceeded without resorting to debugging methods.  This should provide
some insight into worst case retry behavior.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/balloc.c | 38 ++++++++++++++++++++++++++------------
 fs/ext4/ext4.h   |  1 +
 fs/ext4/super.c  |  5 +++++
 fs/ext4/sysfs.c  |  7 +++++++
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f45f9feebe59..74a5172c2d83 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -626,27 +626,41 @@ int ext4_claim_free_clusters(struct ext4_sb_info *sbi,
 
 /**
  * ext4_should_retry_alloc() - check if a block allocation should be retried
- * @sb:			super block
- * @retries:		number of attemps has been made
+ * @sb:			superblock
+ * @retries:		number of retry attempts made so far
  *
- * ext4_should_retry_alloc() is called when ENOSPC is returned, and if
- * it is profitable to retry the operation, this function will wait
- * for the current or committing transaction to complete, and then
- * return TRUE.  We will only retry once.
+ * ext4_should_retry_alloc() is called when ENOSPC is returned while
+ * attempting to allocate blocks.  If there's an indication that a pending
+ * journal transaction might free some space and allow another attempt to
+ * succeed, this function will wait for the current or committing transaction
+ * to complete and then return TRUE.
  */
 int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 {
-	if (!ext4_has_free_clusters(EXT4_SB(sb), 1, 0) ||
-	    (*retries)++ > 1 ||
-	    !EXT4_SB(sb)->s_journal)
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (!sbi->s_journal)
 		return 0;
 
-	smp_mb();
-	if (EXT4_SB(sb)->s_mb_free_pending == 0)
+	if (++(*retries) > 3) {
+		percpu_counter_inc(&sbi->s_sra_exceeded_retry_limit);
 		return 0;
+	}
 
+	/*
+	 * if there's no indication that blocks are about to be freed it's
+	 * possible we just missed a transaction commit that did so
+	 */
+	smp_mb();
+	if (sbi->s_mb_free_pending == 0)
+		return ext4_has_free_clusters(sbi, 1, 0);
+
+	/*
+	 * it's possible we've just missed a transaction commit here,
+	 * so ignore the returned status
+	 */
 	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
-	jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal);
+	(void) jbd2_journal_force_commit_nested(sbi->s_journal);
 	return 1;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2866d249f3d2..8055ade70532 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1484,6 +1484,7 @@ struct ext4_sb_info {
 	struct percpu_counter s_freeinodes_counter;
 	struct percpu_counter s_dirs_counter;
 	struct percpu_counter s_dirtyclusters_counter;
+	struct percpu_counter s_sra_exceeded_retry_limit;
 	struct blockgroup_lock *s_blockgroup_lock;
 	struct proc_dir_entry *s_proc;
 	struct kobject s_kobj;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a6f9875aa34..a871db52d1d2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1210,6 +1210,7 @@ static void ext4_put_super(struct super_block *sb)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
 	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < EXT4_MAXQUOTAS; i++)
@@ -5004,6 +5005,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (!err)
 		err = percpu_counter_init(&sbi->s_dirtyclusters_counter, 0,
 					  GFP_KERNEL);
+	if (!err)
+		err = percpu_counter_init(&sbi->s_sra_exceeded_retry_limit, 0,
+					  GFP_KERNEL);
 	if (!err)
 		err = percpu_init_rwsem(&sbi->s_writepages_rwsem);
 
@@ -5117,6 +5121,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
 	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
+	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
 	percpu_free_rwsem(&sbi->s_writepages_rwsem);
 failed_mount5:
 	ext4_ext_release(sb);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 075aa3a19ff5..a3d08276d441 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -24,6 +24,7 @@ typedef enum {
 	attr_session_write_kbytes,
 	attr_lifetime_write_kbytes,
 	attr_reserved_clusters,
+	attr_sra_exceeded_retry_limit,
 	attr_inode_readahead,
 	attr_trigger_test_error,
 	attr_first_error_time,
@@ -202,6 +203,7 @@ EXT4_ATTR_FUNC(delayed_allocation_blocks, 0444);
 EXT4_ATTR_FUNC(session_write_kbytes, 0444);
 EXT4_ATTR_FUNC(lifetime_write_kbytes, 0444);
 EXT4_ATTR_FUNC(reserved_clusters, 0644);
+EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
 
 EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
 		 ext4_sb_info, s_inode_readahead_blks);
@@ -251,6 +253,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(session_write_kbytes),
 	ATTR_LIST(lifetime_write_kbytes),
 	ATTR_LIST(reserved_clusters),
+	ATTR_LIST(sra_exceeded_retry_limit),
 	ATTR_LIST(inode_readahead_blks),
 	ATTR_LIST(inode_goal),
 	ATTR_LIST(mb_stats),
@@ -374,6 +377,10 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return snprintf(buf, PAGE_SIZE, "%llu\n",
 				(unsigned long long)
 				atomic64_read(&sbi->s_resv_clusters));
+	case attr_sra_exceeded_retry_limit:
+		return snprintf(buf, PAGE_SIZE, "%llu\n",
+				(unsigned long long)
+			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
 	case attr_inode_readahead:
 	case attr_pointer_ui:
 		if (!ptr)
-- 
2.20.1

