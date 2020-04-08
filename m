Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAD1A2B8E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDHV4B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:56:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46001 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgDHV4A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:56:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id 128so1337439pge.12
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/tbb09dhmKoGd36xgDiwMId5I/xfne1fhL5wT8HkB5g=;
        b=F5fjFCXqUfTwvvylK/JzzRSkMbKUrj2NsFyciheiGvvL0yRo0CY4vfh1BjQ05Gv8+Z
         bGSBNLNkQYAGFbux0YaQ8HxcITML5BaxO/nfgENanGhMNuTgaCidiyOiTczrHumRYk8j
         /4uRxm80UuQJqAqRwMuTeJSSxPEvJ2ndU/HCDLVj40ysVOdii+iLzIXSbmFBGE/jdH0B
         XKWel0si8ev0Iw41Z4lAn6q/rk357rg1Ucr7rrYVnE/zfaTWGIF6t2jfKubGE1at2QJI
         karjBhhjC4kJiNSNV7qgqSMEldugn/2TB/nYiNfrtynaKzlJOXTBV+IL+vFnvhvBy/E9
         SVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tbb09dhmKoGd36xgDiwMId5I/xfne1fhL5wT8HkB5g=;
        b=SPgJrPRBjJnCWvhDIpHHG1tGQrlZ8WjpjkbMvoc24OCE/EE3XN4CgmpEyW7If1Grq+
         pe39GALdIE4h1E1r/Y3SUmI8TW3I7lZklFQFMwugsaUYWFVDAlKT8RzZDJemHxKOIlYI
         Y17ixGeqoSNFmulwC3O+5nxF2cp9Zx5KFxTgExBbxqYqLnYWm36dCajsyZCito0awzA7
         R0dgS5B+1W23rOMRly77S82wYTwLnO5t5wDVCEgBec4peXYBdbYLUoe6JIGUAzRG7dgh
         k53ZxuXvx/jSthTyDbaeG8jAMGZiK76Cmn27nYWj3oaa2imSME9N2QXpS3GMPvyJv51J
         zWLw==
X-Gm-Message-State: AGi0PuaKBMvYSQQ4/geaMhb31MRdDMppmmNuVYG+Vm3CNNS60gUc1zM7
        lK8dx03JSNR3O1TXUvbetBRqiVNS
X-Google-Smtp-Source: APiQypJRlb8AHOM86qKV3lgY6X16IQNEv3qJuFm4peL0N7LxJ/yphvqCCUrF2ublNA4X9bWD60GHSg==
X-Received: by 2002:aa7:9e4d:: with SMTP id z13mr10056552pfq.6.1586382958444;
        Wed, 08 Apr 2020 14:55:58 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:58 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 20/20] ext4: add debug mount option to test fast commit replay
Date:   Wed,  8 Apr 2020 14:55:30 -0700
Message-Id: <20200408215530.25649-20-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
index df88e408d0bf..72e8b7078e77 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1660,6 +1660,9 @@ struct ext4_sb_info {
 	struct list_head s_fc_dentry_q;
 	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
+#ifdef EXT4_FC_DEBUG
+	int s_fc_debug_max_replay;
+#endif
 	struct ext4_fc_stats s_fc_stats;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 5effa1389705..f1865a97f6f8 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -1557,6 +1557,12 @@ static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
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
index 16548b0cbe71..995c61d19327 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1539,7 +1539,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_no_fc, Opt_fc_soft_consistency
+	Opt_no_fc, Opt_fc_soft_consistency, Opt_fc_debug_max_replay
 };
 
 static const match_table_t tokens = {
@@ -1625,6 +1625,9 @@ static const match_table_t tokens = {
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_no_fc, "no_fc"},
 	{Opt_fc_soft_consistency, "fc_soft_consistency"},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
+#endif
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1844,6 +1847,9 @@ static const struct mount_opts {
 	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
+#ifdef EXT4_FC_DEBUG
+	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
+#endif
 	{Opt_err, 0, 0}
 };
 
@@ -2003,6 +2009,10 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
2.26.0.110.g2183baf09c-goog

