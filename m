Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685DF351AFC
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhDASEG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbhDASAg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 14:00:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B881C0319CC
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f3so2008627pgv.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQV21W7mlGTmabPDLzOmvSd0ICwvSZ5xxIEc9oZQtZE=;
        b=bhJNUk1dpt00aUylgorQV2oTlfuE7sqBDNY4YQRN6OMebCnsK4hPmepDso7SWh5HXh
         kptw1ePW36S+tEdcjCgBqBRJ1zSAEvMGJna2JZq5Na/rrtt0O5Kx7i0CyJF6HVD9Bydv
         pc3JK/o/leLgIfCVfKD1dElBhydkO7unvGmtqeyq1I9f0cefVXfn34MZVhH1fNB0B90h
         T3LtiIg2qrVhQXmJqxiNInoQCiXkictQmpavFlFxjUW50eUyQTkWHn0x2hiVxwAgoXY0
         kZY+ljtUuZCEfF8rYpDyuY4q0oietf5CIJafM2dlQAa9MeVGr81x25jbFuL0B1KrM4q6
         uB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQV21W7mlGTmabPDLzOmvSd0ICwvSZ5xxIEc9oZQtZE=;
        b=O3zVKjuJLwPWn503eEtE0+p4v0V+nqE1IibtGL5lS9ss32AVfPbFfT7FFNDPswcMKL
         /Lbuq7aw+2FtbiI7UgrQ9EhOkz2WCmFN+cmHpeZPkwujbza4/YFPUDNbNbR1yHMyWt6V
         vzg2RNc82O2l2EZalifIfRG2uKJ8k22co9zUwSqPBRaGSMst0DvavTFhysmY6ZOkcZPp
         bhurXFrK/FJU/K1oMQ4Idx8TQquKHf/XC5YtMSQHQtO5NxgPksFGk57BPQE2MgZac1lR
         c5/r+qCY/MWLGfJ7Axy28nIiRCL5RqT7gnR+2L7lIIonTzGX1GCYVuqi8PwQHKjenTNM
         tdBg==
X-Gm-Message-State: AOAM533bqYRRcbGcs2QiN5q3axep4TsKLe0lZ1FukVDIbUfLCN6Ug/xx
        DEd0janjn/hQV+tFLp91rqQ68FUVt74=
X-Google-Smtp-Source: ABdhPJze3FM6JhCB/tlBaubyK/d2V6ol3ikwJZwnC+z7bfmFUlip41/HGnDj5pCk0j1HY3gnSIU5ig==
X-Received: by 2002:a63:4441:: with SMTP id t1mr8442357pgk.124.1617297701558;
        Thu, 01 Apr 2021 10:21:41 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:40 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 3/7] ext4: add mballoc stats proc file
Date:   Thu,  1 Apr 2021 10:21:25 -0700
Message-Id: <20210401172129.189766-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add new stats for measuring the performance of mballoc. This patch is
forked from Artem Blagodarenko's work that can be found here:

https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patches/patches/rhel8/ext4-simple-blockalloc.patch

This patch reorganizes the stats by cr level. This is how the output
looks like:

mballoc:
	reqs: 0
	success: 0
	groups_scanned: 0
	cr0_stats:
		hits: 0
		groups_considered: 0
		useless_loops: 0
		bad_suggestions: 0
	cr1_stats:
		hits: 0
		groups_considered: 0
		useless_loops: 0
		bad_suggestions: 0
	cr2_stats:
		hits: 0
		groups_considered: 0
		useless_loops: 0
	cr3_stats:
		hits: 0
		groups_considered: 0
		useless_loops: 0
	extents_scanned: 0
		goal_hits: 0
		2^n_hits: 0
		breaks: 0
		lost: 0
	buddies_generated: 0/40
	buddies_time_used: 0
	preallocated: 0
	discarded: 0

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |  5 ++++
 fs/ext4/mballoc.c | 75 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cb0724b87d54..85eeeba3bca3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1549,9 +1549,13 @@ struct ext4_sb_info {
 	atomic_t s_bal_success;	/* we found long enough chunks */
 	atomic_t s_bal_allocated;	/* in blocks */
 	atomic_t s_bal_ex_scanned;	/* total extents scanned */
+	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
+	atomic64_t s_bal_cX_groups_considered[4];
+	atomic64_t s_bal_cX_hits[4];
+	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find blocks */
 	atomic_t s_mb_buddies_generated;	/* number of buddies generated */
 	atomic64_t s_mb_generation_time;
 	atomic_t s_mb_lost_chunks;
@@ -2808,6 +2812,7 @@ int __init ext4_fc_init_dentry_cache(void);
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
+extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
 extern int ext4_mb_init(struct super_block *);
 extern int ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 07b78a3cc421..a4b71c9c1e66 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2146,6 +2146,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	if (sbi->s_mb_stats)
+		atomic64_inc(&sbi->s_bal_cX_groups_considered[ac->ac_criteria]);
 	if (should_lock)
 		ext4_lock_group(sb, group);
 	free = grp->bb_free;
@@ -2420,6 +2422,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (ac->ac_status != AC_STATUS_CONTINUE)
 				break;
 		}
+		/* Processed all groups and haven't found blocks */
+		if (sbi->s_mb_stats && i == ngroups)
+			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
 	}
 
 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
@@ -2449,6 +2454,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			goto repeat;
 		}
 	}
+
+	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND)
+		atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
 out:
 	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
 		err = first_err;
@@ -2548,6 +2556,67 @@ const struct seq_operations ext4_mb_seq_groups_ops = {
 	.show   = ext4_mb_seq_groups_show,
 };
 
+int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
+{
+	struct super_block *sb = (struct super_block *)seq->private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	seq_puts(seq, "mballoc:\n");
+	if (!sbi->s_mb_stats) {
+		seq_puts(seq, "\tmb stats collection turned off.\n");
+		seq_puts(seq, "\tTo enable, please write \"1\" to sysfs file mb_stats.\n");
+		return 0;
+	}
+	seq_printf(seq, "\treqs: %u\n", atomic_read(&sbi->s_bal_reqs));
+	seq_printf(seq, "\tsuccess: %u\n", atomic_read(&sbi->s_bal_success));
+
+	seq_printf(seq, "\tgroups_scanned: %u\n",  atomic_read(&sbi->s_bal_groups_scanned));
+
+	seq_puts(seq, "\tcr0_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[0]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[0]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[0]));
+
+	seq_puts(seq, "\tcr1_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[1]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[1]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[1]));
+
+	seq_puts(seq, "\tcr2_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[2]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[2]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[2]));
+
+	seq_puts(seq, "\tcr3_stats:\n");
+	seq_printf(seq, "\t\thits: %llu\n", atomic64_read(&sbi->s_bal_cX_hits[3]));
+	seq_printf(seq, "\t\tgroups_considered: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_groups_considered[3]));
+	seq_printf(seq, "\t\tuseless_loops: %llu\n",
+		   atomic64_read(&sbi->s_bal_cX_failed[3]));
+	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
+	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
+	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
+	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
+	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
+
+	seq_printf(seq, "\tbuddies_generated: %u/%u\n",
+		   atomic_read(&sbi->s_mb_buddies_generated),
+		   ext4_get_groups_count(sb));
+	seq_printf(seq, "\tbuddies_time_used: %llu\n",
+		   atomic64_read(&sbi->s_mb_generation_time));
+	seq_printf(seq, "\tpreallocated: %u\n",
+		   atomic_read(&sbi->s_mb_preallocated));
+	seq_printf(seq, "\tdiscarded: %u\n",
+		   atomic_read(&sbi->s_mb_discarded));
+	return 0;
+}
+
 static struct kmem_cache *get_groupinfo_cache(int blocksize_bits)
 {
 	int cache_index = blocksize_bits - EXT4_MIN_BLOCK_LOG_SIZE;
@@ -2968,9 +3037,10 @@ int ext4_mb_release(struct super_block *sb)
 				atomic_read(&sbi->s_bal_reqs),
 				atomic_read(&sbi->s_bal_success));
 		ext4_msg(sb, KERN_INFO,
-		      "mballoc: %u extents scanned, %u goal hits, "
+		      "mballoc: %u extents scanned, %u groups scanned, %u goal hits, "
 				"%u 2^N hits, %u breaks, %u lost",
 				atomic_read(&sbi->s_bal_ex_scanned),
+				atomic_read(&sbi->s_bal_groups_scanned),
 				atomic_read(&sbi->s_bal_goals),
 				atomic_read(&sbi->s_bal_2orders),
 				atomic_read(&sbi->s_bal_breaks),
@@ -3573,12 +3643,13 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 
-	if (sbi->s_mb_stats && ac->ac_g_ex.fe_len > 1) {
+	if (sbi->s_mb_stats && ac->ac_g_ex.fe_len >= 1) {
 		atomic_inc(&sbi->s_bal_reqs);
 		atomic_add(ac->ac_b_ex.fe_len, &sbi->s_bal_allocated);
 		if (ac->ac_b_ex.fe_len >= ac->ac_o_ex.fe_len)
 			atomic_inc(&sbi->s_bal_success);
 		atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
+		atomic_add(ac->ac_groups_scanned, &sbi->s_bal_groups_scanned);
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 075aa3a19ff5..59ca9d73b42f 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -521,6 +521,8 @@ int ext4_register_sysfs(struct super_block *sb)
 					ext4_fc_info_show, sb);
 		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
 				&ext4_mb_seq_groups_ops, sb);
+		proc_create_single_data("mb_stats", 0444, sbi->s_proc,
+				ext4_seq_mb_stats_show, sb);
 	}
 	return 0;
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

