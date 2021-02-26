Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A24326783
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBZThN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBZThH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0FC061756
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ba1so5851909plb.1
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v99MoK5XowtjdD0DtRdQ+7VFESrzX5fu3SIr5OwKGvc=;
        b=FwsyEZDUGW14w89w42DbWBVUyKIbocUQ3Z1MbOiFkhSOkYlo0Exc4JB5LVOo97HfaG
         nDW27PGqiQIQzGvBYqci0eUTMPFg887QfojOG4mqEYPPgTz4hCCLIZv0W7WPY7frEVbK
         l4ua3uk2KnUPrkbXn2YqdUVnXQHc/VPT7emnfGnjNF6cnlooLMWpX2BfPH0KkHMkYK1I
         /0nNJUkhx6QVGhgIT7CnJVeTtM1Bmgt+GsZXLkNu/CxiId9CVPxrTTAKDKfujJ7cAmuh
         Kwqb5kbk6HBjJmX8cNcFx5JQzlcAEuEqB6N4VlTJT+Kamh2wwGHq7WCHa27xkyLm1KZ5
         H0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v99MoK5XowtjdD0DtRdQ+7VFESrzX5fu3SIr5OwKGvc=;
        b=QerrxzOk/sMYBsR6wncpzwTWU1NkQxhYcm9Nz5DIiJ+VIP/uhv0oH+vrOEiAcoWiOi
         YerINgSLZX+kwPq06HeBQr/bSmoUSLosv2XFB7OWuW+ERssjc2Jye2UnLfCmv9FQk18w
         6TP8FmL7FFnqi7CBwvX3cWsVGi/BXFYxrAQuTRZ8jmTINXsXTj1yKuV2Zxvjna6muvc1
         0Ty6oPmO8XJTDzaox6vp/Xv1/Q9biqnL65AtORnZUMpeczF1Bm3L5O5HGbXPFuBAp61H
         UMcAChInI4kZZgTKH5wvDeg9nTku29WEW9KPID1p8XaSzm2N1S7QzKk6bOn4Fzn2CsN2
         DT4Q==
X-Gm-Message-State: AOAM533AmC0V3FfKbQzd44KUSfY4TjqFh3TRUZvNDHe5EXWiSi+HodFl
        HTLohN/0f4krH2blUJsZHOnt7NpyVCU=
X-Google-Smtp-Source: ABdhPJxyCbpZzIxINmbcON8c5d7P7cwCluFLVn8uZY/cfMkOX23XQOP3k8A2Us/B88/m8RjEZ4PhJw==
X-Received: by 2002:a17:90b:244:: with SMTP id fz4mr1903622pjb.137.1614368186444;
        Fri, 26 Feb 2021 11:36:26 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:25 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 2/5] ext4: add mballoc stats proc file
Date:   Fri, 26 Feb 2021 11:36:09 -0800
Message-Id: <20210226193612.1199321-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add new stats for measuring the performance of mballoc. This patch is
forked from Artem Blagodarenko's work that can be found here:

https://github.com/lustre/lustre-release/blob/master/ldiskfs/kernel_patches/patches/rhel8/ext4-simple-blockalloc.patch

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/ext4.h    |  4 ++++
 fs/ext4/mballoc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/mballoc.h |  1 +
 fs/ext4/sysfs.c   |  2 ++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cb0724b87d54..3e906a3d553a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1549,6 +1549,8 @@ struct ext4_sb_info {
 	atomic_t s_bal_success;	/* we found long enough chunks */
 	atomic_t s_bal_allocated;	/* in blocks */
 	atomic_t s_bal_ex_scanned;	/* total extents scanned */
+	atomic_t s_bal_groups_considered;	/* number of groups considered */
+	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
@@ -1558,6 +1560,7 @@ struct ext4_sb_info {
 	atomic_t s_mb_preallocated;
 	atomic_t s_mb_discarded;
 	atomic_t s_lock_busy;
+	atomic64_t s_bal_cX_failed[4];		/* cX loop didn't find blocks */
 
 	/* locality groups */
 	struct ext4_locality_group __percpu *s_locality_groups;
@@ -2808,6 +2811,7 @@ int __init ext4_fc_init_dentry_cache(void);
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern long ext4_mb_stats;
 extern long ext4_mb_max_to_scan;
+extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
 extern int ext4_mb_init(struct super_block *);
 extern int ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 07b78a3cc421..92c4edaa1afc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2146,6 +2146,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	ac->ac_groups_considered++;
 	if (should_lock)
 		ext4_lock_group(sb, group);
 	free = grp->bb_free;
@@ -2420,6 +2421,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (ac->ac_status != AC_STATUS_CONTINUE)
 				break;
 		}
+		/* Processed all groups and haven't found blocks */
+		if (sbi->s_mb_stats && i == ngroups)
+			atomic64_inc(&sbi->s_bal_cX_failed[cr]);
 	}
 
 	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
@@ -2548,6 +2552,48 @@ const struct seq_operations ext4_mb_seq_groups_ops = {
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
+	seq_printf(seq, "\tgroups_considered: %u\n",  atomic_read(&sbi->s_bal_groups_considered));
+	seq_printf(seq, "\textents_scanned: %u\n", atomic_read(&sbi->s_bal_ex_scanned));
+	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
+	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
+	seq_printf(seq, "\t\tbreaks: %u\n", atomic_read(&sbi->s_bal_breaks));
+	seq_printf(seq, "\t\tlost: %u\n", atomic_read(&sbi->s_mb_lost_chunks));
+
+	seq_printf(seq, "\tuseless_c0_loops: %llu\n",
+		   (unsigned long long)atomic64_read(&sbi->s_bal_cX_failed[0]));
+	seq_printf(seq, "\tuseless_c1_loops: %llu\n",
+		   (unsigned long long)atomic64_read(&sbi->s_bal_cX_failed[1]));
+	seq_printf(seq, "\tuseless_c2_loops: %llu\n",
+		   (unsigned long long)atomic64_read(&sbi->s_bal_cX_failed[2]));
+	seq_printf(seq, "\tuseless_c3_loops: %llu\n",
+		   (unsigned long long)atomic64_read(&sbi->s_bal_cX_failed[3]));
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
@@ -2968,9 +3014,10 @@ int ext4_mb_release(struct super_block *sb)
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
@@ -3579,6 +3626,8 @@ static void ext4_mb_collect_stats(struct ext4_allocation_context *ac)
 		if (ac->ac_b_ex.fe_len >= ac->ac_o_ex.fe_len)
 			atomic_inc(&sbi->s_bal_success);
 		atomic_add(ac->ac_found, &sbi->s_bal_ex_scanned);
+		atomic_add(ac->ac_groups_scanned, &sbi->s_bal_groups_scanned);
+		atomic_add(ac->ac_groups_considered, &sbi->s_bal_groups_considered);
 		if (ac->ac_g_ex.fe_start == ac->ac_b_ex.fe_start &&
 				ac->ac_g_ex.fe_group == ac->ac_b_ex.fe_group)
 			atomic_inc(&sbi->s_bal_goals);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index e75b4749aa1c..7597330dbdf8 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -161,6 +161,7 @@ struct ext4_allocation_context {
 	/* copy of the best found extent taken before preallocation efforts */
 	struct ext4_free_extent ac_f_ex;
 
+	__u32 ac_groups_considered;
 	__u16 ac_groups_scanned;
 	__u16 ac_found;
 	__u16 ac_tail;
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
2.30.1.766.gb4fecdf3b7-goog

