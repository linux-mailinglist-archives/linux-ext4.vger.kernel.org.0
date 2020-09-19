Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF350270993
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgISAzV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgISAzT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37ABC0613D0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id e4so3856896pln.10
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBeYy790CmY32lXpZ+BNUIrNOelp1RppnEsgqwl6p1M=;
        b=gcnWnuoGZ2UNx7cxINuFd0V0FMIzSDoUvXW4ZnJPy2swQ+hOzEuaAYeXlqccgPQyjT
         uNgFZJMewhrMnRv9xDf2LlXVcngXe0zM3FSNJP9U5TgHZUFFKoTjt+asyNHW+rsZ6QmX
         ALvY+uGxealjY3iN5+0RhgVfZgLAXKwUywsXc2SHw0hcrQNVhIfjztR1PeIdcBNKYVRm
         P+NL+yhENnfpHBcRNmdaJXpTtJPApVGZmjCXD132bUeWk7sTo2Jt42WlOZphKC6D2jFm
         BfKsLk8eOu71+BB3iNsoKFosn078Wcl5LXRHdZHs7Lc81JPrULEJcUKYOLf/eyqRgZ0Y
         qsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBeYy790CmY32lXpZ+BNUIrNOelp1RppnEsgqwl6p1M=;
        b=LSWPfCVtdl4WASGdLQwmaMThLL9/qN18LGTLIkBFdG0J7obtWXdaMGPNH5aljcxQ0n
         KCmDMuFgqHpFu2ucpnJQr9KMlIO1r5K/KIKLhpDC6dMrn2p6BYpnxTxiJI+zcAZMxEbs
         0nomvTjQajYiwfQDGbcSui3PdNzOMMa0YfPXJlRDrM/zEKAbINjHc7k56XDcVKPp32Xx
         Q5JTo6Jcvgw/geVEhFHaMsxI/Gtdywc22huoTQ1WSigfaZbps2ZhVp49rZ4RtelGMcWR
         0yCpIS5D6DoUWMoHJaLcCzE3tRBfTPZ1vUD6iH5KkfmFS1ddb4OLId3iNWSXyWmd7I9q
         M5JQ==
X-Gm-Message-State: AOAM5337dhthnr+rodtD10SmM4bRvi8grKzK2PBgnHlz1lVo+WL84awn
        foJwP2q97+PjqMLjAjLhGQklJLOqrF8=
X-Google-Smtp-Source: ABdhPJy4IS8F1Gt0vyzsFslDjHujBRl2wc+KDaqodPhMn6DM2syUHdLfUleTbko+bXh6k2X40ywUDw==
X-Received: by 2002:a17:90a:530c:: with SMTP id x12mr13739373pjh.223.1600476918941;
        Fri, 18 Sep 2020 17:55:18 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:18 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 9/9] ext4: add fast commit stats in procfs
Date:   Fri, 18 Sep 2020 17:54:51 -0700
Message-Id: <20200919005451.3899779-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This commit adds a file in procfs that tracks fast commit related
statistics.

root@kvm-xfstests:/mnt# cat /proc/fs/ext4/vdc/fc_info
fc stats:
7772 commits
15 ineligible
4083 numblks
2242us avg_commit_time
Ineligible reasons:
"Extended attributes changed":  0
"Cross rename": 0
"Journal flag changed": 0
"Insufficient memory":  0
"Swap boot":    0
"Resize":       0
"Dir renamed":  0
"Falloc range op":      0
"FC Commit Failed":     15

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/fast_commit.c | 34 ++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c       |  2 ++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 372a38292ed1..1a8b10ed412f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2732,7 +2732,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
 extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 
 /* fast_commit.c */
-
+int ext4_fc_info_show(struct seq_file *seq, void *v);
 void ext4_fc_init(struct super_block *sb, journal_t *journal);
 void ext4_fc_init_inode(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 63429076ad59..1380bfe7bd0d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2103,6 +2103,40 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
 	}
 }
 
+const char *fc_ineligible_reasons[] = {
+	"Extended attributes changed",
+	"Cross rename",
+	"Journal flag changed",
+	"Insufficient memory",
+	"Swap boot",
+	"Resize",
+	"Dir renamed",
+	"Falloc range op",
+	"FC Commit Failed"
+};
+
+int ext4_fc_info_show(struct seq_file *seq, void *v)
+{
+	struct ext4_sb_info *sbi = EXT4_SB((struct super_block *)seq->private);
+	struct ext4_fc_stats *stats = &sbi->s_fc_stats;
+	int i;
+
+	if (v != SEQ_START_TOKEN)
+		return 0;
+
+	seq_printf(seq,
+		"fc stats:\n%d commits\n%d ineligible\n%d numblks\n%lluus avg_commit_time\n",
+		   stats->fc_num_commits, stats->fc_ineligible_commits,
+		   stats->fc_numblks,
+		   div_u64(sbi->s_fc_avg_commit_time, 1000));
+	seq_puts(seq, "Ineligible reasons:\n");
+	for (i = 0; i < EXT4_FC_REASON_MAX; i++)
+		seq_printf(seq, "\"%s\":\t%d\n", fc_ineligible_reasons[i],
+			stats->fc_ineligible_reason_count[i]);
+
+	return 0;
+}
+
 int __init ext4_fc_init_dentry_cache(void)
 {
 	ext4_fc_dentry_cachep = KMEM_CACHE(ext4_fc_dentry_update,
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index bfabb799fa45..5ff33d18996a 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -521,6 +521,8 @@ int ext4_register_sysfs(struct super_block *sb)
 		proc_create_single_data("es_shrinker_info", S_IRUGO,
 				sbi->s_proc, ext4_seq_es_shrinker_info_show,
 				sb);
+		proc_create_single_data("fc_info", 0444, sbi->s_proc,
+					ext4_fc_info_show, sb);
 		proc_create_seq_data("mb_groups", S_IRUGO, sbi->s_proc,
 				&ext4_mb_seq_groups_ops, sb);
 	}
-- 
2.28.0.681.g6f77f65b4e-goog

