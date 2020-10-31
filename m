Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C1A2A1A76
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgJaUFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgJaUFw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5BC061A04
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so7812451pfp.13
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM1Nt8JiNX4RedAVowPM21CL/+A8obYkQKrEr2dY1EM=;
        b=ts0Fe2iwnmdQNx+R6hvDp6+ezuWQYAvjZw9YLRDZM0NSsL0oH7c7GKRxZsvhUItTz1
         Y6/2+vh2d4DyAukWaQqhuGbWk/RD5ZBAngPcS1G9Y5nRA5cxFQ0HzRmD4UoP8zVdKiwH
         ezhsSl75bpG8hIke4VNU0drvqAk3dlpj8diWTVZW6aVBMpIWYrnIreSbKxrPjKw7HxNy
         w9mNWj0KIRrvVzSayc80Z89c/A/bkbFUWNNwB/WeNTrBZe9BGtQ12u5PUl0LRWPXd0MD
         LykhyOgbtXKgiA5Blmrzh+M6e10DstHwQDKr4xSqz9q9nJFyEMbeLqE5jS6wPkgPup5b
         Qchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM1Nt8JiNX4RedAVowPM21CL/+A8obYkQKrEr2dY1EM=;
        b=hrp85wJrKD7AaaZMa1JtZI4a2X0js4H/SK8nVXdqOlfdMpHx+gAE4zK17Sd7MlEzOu
         N3W2qnDAzgF2eYdp/Eekko3V2kkG/q5AHlSsPRMzMuXzFoCQ17NwFLQ9zmAKpQNY058x
         SQXOixrFDOpXeFUimaTBzno94/ZNn1wEK7En52u8vJ8GhT7TqRCxNOK5gBAUaHBOcZts
         Vb498KY9gFXushTjFfr5Ubct4Cp989SF2vgXZivAAqapxwmGSdycOFy4wPzB81Kh+Ioa
         p1t0dDHz3tcympv/arxLVqgI6ooDrHfzH8U+CXUZYdclhuXqXNI1t1Hl8anD922qgVuM
         XCFA==
X-Gm-Message-State: AOAM531selWQQAvW4cmUa1XsjpQXRKpfpqk9HqcYjzipUGfjoJEErlnL
        VYLOGlgVntopqRke6oYlLD6IvZt4GSs=
X-Google-Smtp-Source: ABdhPJwvq6sAi4lJxPAuTpnBl7RWGwEKqXJbVm3K40FmE1d/SRijYPtApnSkP7xP0J2qOvGl6a5Jfg==
X-Received: by 2002:a63:eb08:: with SMTP id t8mr7247785pgh.8.1604174751324;
        Sat, 31 Oct 2020 13:05:51 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:50 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 09/10] ext4: disable fast commit with data journalling
Date:   Sat, 31 Oct 2020 13:05:17 -0700
Message-Id: <20201031200518.4178786-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commits don't work with data journalling. This patch disables the
fast commit support when data journalling is turned on.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c       | 7 +++++++
 fs/ext4/fast_commit.h       | 1 +
 fs/ext4/super.c             | 3 ++-
 include/trace/events/ext4.h | 6 ++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4c0a3e858ea3..9ae8ba213961 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -472,6 +472,12 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		return;
 
+	if (ext4_should_journal_data(inode)) {
+		ext4_fc_mark_ineligible(inode->i_sb,
+					EXT4_FC_REASON_INODE_JOURNAL_DATA);
+		return;
+	}
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(inode, ret);
 }
@@ -2095,6 +2101,7 @@ const char *fc_ineligible_reasons[] = {
 	"Resize",
 	"Dir renamed",
 	"Falloc range op",
+	"Data journalling",
 	"FC Commit Failed"
 };
 
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index cde86747faf8..cdb36a10dfd0 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -105,6 +105,7 @@ enum {
 	EXT4_FC_REASON_RESIZE,
 	EXT4_FC_REASON_RENAME_DIR,
 	EXT4_FC_REASON_FALLOC_RANGE,
+	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_COMMIT_FAILED,
 	EXT4_FC_REASON_MAX
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e67d2fa41a78..9333475737ac 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4340,9 +4340,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 
 	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
-		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, and O_DIRECT support!\n");
+		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
 		/* can't mount with both data=journal and dioread_nolock. */
 		clear_opt(sb, DIOREAD_NOLOCK);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "both data=journal and delalloc");
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 239e98014f9b..ee7362f31eb6 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -104,7 +104,8 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 		{ EXT4_FC_REASON_SWAP_BOOT,	"SWAP_BOOT"},		\
 		{ EXT4_FC_REASON_RESIZE,	"RESIZE"},		\
 		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
-		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"})
+		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
+		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"})
 
 TRACE_EVENT(ext4_other_inode_update_time,
 	TP_PROTO(struct inode *inode, ino_t orig_ino),
@@ -2917,7 +2918,7 @@ TRACE_EVENT(ext4_fc_stats,
 		    ),
 
 	    TP_printk("dev %d:%d fc ineligible reasons:\n"
-		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
+		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
 		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
 		      MAJOR(__entry->dev), MINOR(__entry->dev),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
@@ -2928,6 +2929,7 @@ TRACE_EVENT(ext4_fc_stats,
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
 		      __entry->sbi->s_fc_stats.fc_num_commits,
 		      __entry->sbi->s_fc_stats.fc_ineligible_commits,
 		      __entry->sbi->s_fc_stats.fc_numblks)
-- 
2.29.1.341.ge80a0c044ae-goog

