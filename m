Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87428FA37
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgJOUi0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388515AbgJOUiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E9AC0613D3
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f5so32851pgb.1
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnjE6G0gVI5grrmDv9BsLM2967PWw89YuBEfx58s760=;
        b=caVdeQuO4drBnBJ3xDTX3jwC2FyZk/SwSSbPAux/19fe1Dg9bMS1RLFqLquAbZ7Q0D
         e+AAYBU5+pD1LK7dzpTOk/cgJEbrpwuEQ5pjHJC4gUNECGafmYWCP50AjcJpwzlPbm/q
         NdCITeBtO/MTWazt1W66NKhQoVprumXwEpcRuIvRyeF+QTSTLBesLUnyyLAlv+k73UQL
         PLW2ax+q4zo++0oEca5e0rC80Jtyqe0zxfcCn1HoLtrORiLVXf4K+oDNNczTtM81j2ts
         MwQgT92P1zfa82Df5SQcBSNzClbnoT7kYDxFGSZyEkL/ul33M0h+YLCY9OZsMpbXV2MW
         LWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnjE6G0gVI5grrmDv9BsLM2967PWw89YuBEfx58s760=;
        b=XWo57B8itwD6XGXoLWhu39ps31Qykx6yR8iQvIFvwev9moJsf6eqaEnNo2OXLjEiEk
         EZCe6bxMrLOVS/Dpj4O1I6T0eNh1xvO6aB4ENuHx/Yhn9zpjEB+TSM0inKy9YHHCKr44
         yTwJEt+kr7UfkBnX8+nKBs93LvmICOEjkJPstC+4OSTkkk00Hje29aog1PDAgnt/TpVr
         q1hkX8Uh1rYm3E/RC0eNPPDoF4k9OsumcCocfaSZ6sv5S3bpoHYSgeb0VcsfddlFR+88
         KNzMQL8z1mjjbaHiVH71O/Mny4E/kaBL0ev+pwMs8TSaJESuhF0xtd60jq2X1oPGkaoS
         AD2w==
X-Gm-Message-State: AOAM531CWkGQtn7LOONmU9+NM6PibbrsJ1+VVKEsXBMZlrPGsxE4cngX
        dm4ylh9IrZ0afXazH3O6FmcoM7pfbME=
X-Google-Smtp-Source: ABdhPJyl6LSZ4JkeiAI62uWcl2NMPoabuSjs+wd2V6EaC4SZxQYfOe1/MxkLiIGh1e+d46EonMoQ/Q==
X-Received: by 2002:a65:63c5:: with SMTP id n5mr267651pgv.437.1602794300294;
        Thu, 15 Oct 2020 13:38:20 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:19 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 9/9] ext4: add fast commit stats in procfs
Date:   Thu, 15 Oct 2020 13:38:01 -0700
Message-Id: <20201015203802.3597742-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
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
index ff5094eb0e39..18a6df442671 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2737,7 +2737,7 @@ extern int ext4_init_inode_table(struct super_block *sb,
 extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
 
 /* fast_commit.c */
-
+int ext4_fc_info_show(struct seq_file *seq, void *v);
 void ext4_fc_init(struct super_block *sb, journal_t *journal);
 void ext4_fc_init_inode(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1dda5329be61..3e3ec989a2df 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2082,6 +2082,40 @@ void ext4_fc_init(struct super_block *sb, journal_t *journal)
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
+		"fc stats:\n%ld commits\n%ld ineligible\n%ld numblks\n%lluus avg_commit_time\n",
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
2.29.0.rc1.297.gfa9743e501-goog

