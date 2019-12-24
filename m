Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E1129EE4
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLXIPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45911 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLXIPE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so10052368pgk.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VaHC5Bd0+l/QJOpetguQmp1Vf7JDCNDcEJVp6iS4ehk=;
        b=U7b+Vbtep8jy65FP2A0IegghpPLEwJbmJ8eAZ8K7UOFX+rCbqRrXOuYyvezUSZdzAP
         56fIxfWNPrSbYN55Z2tCtwgqoRdneR0EUD6HkM6y13XuGGFYbXmIFUz8iuLBaJaAnUNk
         xSCujZJJBnrDdThPl/KuAbw+HnT6GNBPajuiH/PyhcEzokNUMfpZOJ4hcDNPJEJEOSEs
         Xh1WxvwG+nG9stXI2RGOZJ5g5WUtk84m/IV7SG/ChSNm30FXMGvHKVBRAjLoiNn8uqlR
         ferd9k5nsADgi0Aybp6ZHwBSfLvOfb9UqYY2CCRjaOJ6mNCTnnX2A/R78tuauUh8N9cU
         J4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaHC5Bd0+l/QJOpetguQmp1Vf7JDCNDcEJVp6iS4ehk=;
        b=hjiFKJhgd7vpczJEvJhZtEDX0jepdOjw/QFqNRiRMpk2x3iRyGxGSslsEWxEHfosgE
         0151VF0ecKeJ/mioJlG9FzeBJzrbZtMBXGVFMb8aRhYD8EJmjB24vS+KsdEaTNS1vitY
         YAYzD8JRBQB2FtgSMlz4NNxbGcI2hd9/tuUwU+EmaBU6tjJo2tifOmzYGbgpWfSK0Im9
         x9rRlEvXjqYDaQNmELuyIfum5d4adZ5CvkekIByiyZopmyqMJ8KOOs0N8fwx4gUCCbB0
         3eBGPOhN8RJjRK9XdkR4a5mRFFIq0ObSZy3YYPER/6GG6VRqu+q6T2gR+5a7eMe2byut
         zcbQ==
X-Gm-Message-State: APjAAAXJxwrG0VVBVRz3RY0N5Afriw6+zrqCvZ1ZgX0KBzrPbKalW+99
        OniuPCx05RGkI47GLXWnZoPcs+w5
X-Google-Smtp-Source: APXvYqyZa0HS82z3lZXqIbrvjkWAi/x4RszZsWp5TRc8zyLPC+ToC6O3NjEUb1xIsNPvIm88bke5uA==
X-Received: by 2002:a63:2355:: with SMTP id u21mr35118964pgm.179.1577175303559;
        Tue, 24 Dec 2019 00:15:03 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:15:03 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 20/20] ext4: add debug mount option to test fast commit replay
Date:   Tue, 24 Dec 2019 00:13:24 -0800
Message-Id: <20191224081324.95807-20-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index e12900d77673..62d72e7005ad 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1652,6 +1652,9 @@ struct ext4_sb_info {
 	struct list_head s_fc_dentry_q;
 	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
+#ifdef EXT4_FC_DEBUG
+	int s_fc_debug_max_replay;
+#endif
 	struct ext4_fc_stats s_fc_stats;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index ef36a973ed8b..1f8ba23912ba 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -1520,6 +1520,12 @@ static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
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
index bfd19a127188..117ccde1a7c1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1475,7 +1475,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_no_fc, Opt_fc_soft_consistency
+	Opt_no_fc, Opt_fc_soft_consistency, Opt_fc_debug_max_replay
 };
 
 static const match_table_t tokens = {
@@ -1560,6 +1560,9 @@ static const match_table_t tokens = {
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_no_fc, "no_fc"},
 	{Opt_fc_soft_consistency, "fc_soft_consistency"},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
+#endif
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1779,6 +1782,9 @@ static const struct mount_opts {
 	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
+#endif
 	{Opt_err, 0, 0}
 };
 
@@ -1931,6 +1937,10 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
2.24.1.735.g03f4e72817-goog

