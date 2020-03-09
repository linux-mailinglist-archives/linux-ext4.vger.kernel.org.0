Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815F217D996
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCIHGO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:14 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39603 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgCIHGN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id d8so4013376pje.4
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=woiAN27YTllGAJmapNpmkur12nJYC1QjNlOpvSQd5iM=;
        b=hU8caSJKTarxI3OTCZ5RRnvPy7klQQCz/lndfYfqI3cH6uTl0e73OLl8IerEnTwWP9
         N1xJkXNKj0JpwDp/tzrk7yV/zbhWiAqW/982zyD05jwPjocTzNwBxZJ+6l2BrgVpYSLZ
         Y3R1AWejGfnWutQK6Nclz2QCJhhBk7tHE/uRrSwwAnj+YYYslCES3nGLt5eqHITkqBMX
         0/chUEW3Uz1uftkzEtaGszkWfaXZXIqo/cc9pPCEsAQZMKoiom/SRQkwsaBvfkE1tDuo
         vB4CfgDdm6WwneKASzJtLOzQTT83a0qWpTUEaaDOHU+LUduuBl3XBvzqDnC/HkKJQ8kW
         qhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=woiAN27YTllGAJmapNpmkur12nJYC1QjNlOpvSQd5iM=;
        b=Wp8VZE9RaXlggeTgRqJvRNyy1DD/vY2pgSOM7rowSBI7kv36Noss9YYGcUZu4j8PJv
         5YOd7fcbY7uRx7xWrLMwlWImfPJs2X6L2jq7VdSpkm/H1QIL2KzwOi7BKgoGAIPTeI8D
         W/b5DhsUxjBGDlnWJbt9z1e6EYGKYYM1CRSCZ+oKGV88bHOkzP5T2GjuAbOch5J5hIjq
         7hZ3sLdwxrS8e/JqoGT8Clbx3X0WKCItc7UUjMHvEyMW0yKs+4vbg4f6/CxsN+6Lt3hZ
         atERjxWtnEdIcNvQ28rSRXKZ+zOHG1yzzUnPQ4t4Gb2d6GjcvH2C1r/W4/7eFA6t8spd
         4qew==
X-Gm-Message-State: ANhLgQ1QZ9ghyhROj0rc3x2SUKV9+83Ex5SdAjpZcIBzTuGGg6QgFqcV
        Y4OffoJMMCga1AHu9psdhECsbXkv
X-Google-Smtp-Source: ADFU+vurdzY/r038NGCimJ5HHpJ9CGg7y2rzX/NP3cON3a6EhhI6UTzLCgn+B9/Qn1Ra9N6jNOub2A==
X-Received: by 2002:a17:90a:5289:: with SMTP id w9mr16507574pjh.95.1583737570295;
        Mon, 09 Mar 2020 00:06:10 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:09 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 20/20] ext4: add debug mount option to test fast commit replay
Date:   Mon,  9 Mar 2020 00:05:26 -0700
Message-Id: <20200309070526.218202-20-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a debug mount option to simulate errors while replaying. If
fc_debug_max_replay is set, ext4 will replay only as many fast
commit blocks as passed as an argument.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h      |  3 +++
 fs/ext4/ext4_jbd2.c |  6 ++++++
 fs/ext4/super.c     | 12 +++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cc92a333bc68..5fea64ca8b5b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1661,6 +1661,9 @@ struct ext4_sb_info {
 	struct list_head s_fc_dentry_q;
 	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
+#ifdef EXT4_FC_DEBUG
+	int s_fc_debug_max_replay;
+#endif
 	struct ext4_fc_stats s_fc_stats;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 9e4b6bcbd76c..602eb3392a5d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -1561,6 +1561,12 @@ static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
 		return sbi->s_fc_replay_state.fc_replay_error;
 	}
 
+#ifdef EXT4_FC_DEBUG
+	if (sbi->s_fc_debug_max_replay && off >= sbi->s_fc_debug_max_replay) {
+		pr_warn("Dropping fc block %d because max_replay set\n", off);
+		return -EINVAL;
+	}
+#endif
 	sbi->s_mount_state |= EXT4_FC_REPLAY;
 	fc_hdr = (struct ext4_fc_commit_hdr *)
 		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ffa91815dacf..a7bc3a4e75d0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1542,7 +1542,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_no_fc, Opt_fc_soft_consistency
+	Opt_no_fc, Opt_fc_soft_consistency, Opt_fc_debug_max_replay
 };
 
 static const match_table_t tokens = {
@@ -1628,6 +1628,9 @@ static const match_table_t tokens = {
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_no_fc, "no_fc"},
 	{Opt_fc_soft_consistency, "fc_soft_consistency"},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
+#endif
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1847,6 +1850,9 @@ static const struct mount_opts {
 	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
+#endif
 	{Opt_err, 0, 0}
 };
 
@@ -2006,6 +2012,10 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		sbi->s_li_wait_mult = arg;
 	} else if (token == Opt_max_dir_size_kb) {
 		sbi->s_max_dir_size_kb = arg;
+#ifdef EXT4_FC_DEBUG
+	} else if (token == Opt_fc_debug_max_replay) {
+		sbi->s_fc_debug_max_replay = arg;
+#endif
 	} else if (token == Opt_stripe) {
 		sbi->s_stripe = arg;
 	} else if (token == Opt_resuid) {
-- 
2.25.1.481.gfbce0eb801-goog

