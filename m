Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C933C499
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhCORht (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhCORhc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A4C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o10so3459932plg.11
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9rpIAf4HbFDRvwaIUBWsTvIm7wMLQX9zLaIDstWx1J8=;
        b=HnYRbR72kjzXxczYZr7BlkBUoixbh+daVua2d810uaUNSohCYoQ3CaWtlIozXIwAjV
         hURpbqGfgKQo2CwpIRkOPT0nPpC1yf7A2X5xEUSk/fPMejPmRAOMvCmnHmYIv0cwahFu
         gzNXSok96vKv4g4gU54HoQ+GExSh9xdrXtizCHghu73eco5Nvak6nU9tMLrU7QKrSHKy
         pDbE1RRlRlGMzXzl62ptu4FWHap779UV9CQxMOcez6bLmKKHjgdSQvw7bmd/FSIA+Vhv
         tV0TmWv5CnuZwkUouE/cwjIyuXWmxnzrzeKLoZYw9SMAUmfH1ipiwhpRpfg2SS59zeQY
         Zidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9rpIAf4HbFDRvwaIUBWsTvIm7wMLQX9zLaIDstWx1J8=;
        b=EyAsKhj77Q6jePVNRsXZLQVkMV5gtJAXbPCIh1VR9O7oljKmzzdF1u7uxW8Rc2KQYe
         0odjg1RsHAQZm4L3hv/Ld/c9SkMHXRf4wut8wYLUqd52OxpezNg5leSOJ1Y/JcWK+jJf
         XD6V1ynyeXHkKHGyUbiS0bn1psnghSAO1p5bEzZziChdLnNcwZziJpKNpnMy9ejwmBZx
         IA0rOhGUmxYlCcCOb42s4Fmwr5cL2uekXKKJp+PuQIdm/Xp4Qbjy1TYP+PFnRZuTXR0G
         iDbv1TH70sAQG8SXsX/0YN3hgU6gkJ5SnRyH//nX7gQJffw8/+MR8xy4mvMsuzCM8o87
         T0hQ==
X-Gm-Message-State: AOAM532Bt4rVigavzUgXe3cb0J2IZVyk1k6KY2gOt2N9dR2KWlo2fjB8
        9Gm35Rih6+rzbizaJgkto92ylASRhQg=
X-Google-Smtp-Source: ABdhPJxWkUsZ7708rmnhhNponcZoobbfFtxrZzgMKmj6kvq56v7Oj7ogTyiSVAvxH/CvSN+7Xg+7Rw==
X-Received: by 2002:a17:90a:e614:: with SMTP id j20mr198237pjy.184.1615829851367;
        Mon, 15 Mar 2021 10:37:31 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:30 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4 3/6] ext4: add mballoc stats proc file
Date:   Mon, 15 Mar 2021 10:37:13 -0700
Message-Id: <20210315173716.360726-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
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
2.31.0.rc2.261.g7f71774620-goog

