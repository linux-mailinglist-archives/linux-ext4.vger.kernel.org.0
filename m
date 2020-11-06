Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9A2A8DE4
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKFD7s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:48 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E52C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:48 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i26so2931685pgl.5
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+nEvLfDzPet76f15vlvCMrgMMebL2c9QMOO9knBIDQ=;
        b=DyBx1VK86bz2QaoOydT572XWXNA3mIeiVSyTvDmYibonWopFdJobd1pxMdk+hXDo4j
         y+NacwoDuqaSQ/7h6WlR4Sao+P2EO/dPABPGPLXlPkF79RrUWO3iKCQMv47TJFTuEiad
         s9xiBN0QE4pq55o5m5E73sQEtq4ASyTpNjEjhx7vbrtBN3c0tqwMTadRgzwkia5sCiWS
         qbBbLRVYRUKMQE7wA/QcnIQloLnpsjjpONH7yhT2hrs2rbJvwVvBNXDDLLbwfSV/PYdb
         c6T8SESJQ1qzvxtZqUP6vXKSd3dWQWAxLeZJLJcqcHDozAhy9sols5QBRVjoWzFOyYc1
         4eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+nEvLfDzPet76f15vlvCMrgMMebL2c9QMOO9knBIDQ=;
        b=HlbDgNK1NfcRWPJk3bT12t1C7XNfwmq85gwhBAPKcDLYu8NGnknSNelVW3pkTIe4tQ
         Psx1XtTpJ0IB5HKYc9Y/zjtyFZNKlMjrDjHzxdDYjud52dF3GFnqIXbSAwnnFO/BkNHv
         +zRcSNMqaJVjhM6oAI9AIn2fzUE8W5FLY0QsTYQUe67q4VbNHIBNbBD7v5hDxjwrahHU
         Qta8KqRPdX0VgfA6dsIlPdN/HZNgJiQGkLtMuX6Y+OT93mulhwy70NXeQkodaq+k0WEw
         snUgJviYNzYmbR/d19af3mpzDg4U5fIbHqqwY4Mu9eiRq1edPaozoivrbDTphCTmVeJT
         CZGw==
X-Gm-Message-State: AOAM532Rb4zlyJZK5I3Q3m9kj84hszDdjM80cYZrA6ZonZt72r5uyYdR
        nd8sGzjU++q7ff/u3iyvegi4pcwzf5E=
X-Google-Smtp-Source: ABdhPJyeFWgS/qbLcd3V+FYh3gQZb8SraYCOWJHwMtU2rNm5alOgBCF+kpg75TMehf2vyoT6Wuj7IA==
X-Received: by 2002:a17:90a:6288:: with SMTP id d8mr292125pjj.210.1604635187090;
        Thu, 05 Nov 2020 19:59:47 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:46 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 18/22] ext4: disable fast commit with data journalling
Date:   Thu,  5 Nov 2020 19:59:07 -0800
Message-Id: <20201106035911.1942128-19-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commits don't work with data journalling. This patch disables the
fast commit support when data journalling is turned on.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c       | 7 +++++++
 fs/ext4/fast_commit.h       | 1 +
 fs/ext4/super.c             | 3 ++-
 include/trace/events/ext4.h | 6 ++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 6b963e09af2c..fb9b4e9d82b2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -483,6 +483,12 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
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
@@ -2102,6 +2108,7 @@ const char *fc_ineligible_reasons[] = {
 	"Resize",
 	"Dir renamed",
 	"Falloc range op",
+	"Data journalling",
 	"FC Commit Failed"
 };
 
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 1d96e0ac8138..3a6e5a1fa1b8 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -102,6 +102,7 @@ enum {
 	EXT4_FC_REASON_RESIZE,
 	EXT4_FC_REASON_RENAME_DIR,
 	EXT4_FC_REASON_FALLOC_RANGE,
+	EXT4_FC_REASON_INODE_JOURNAL_DATA,
 	EXT4_FC_COMMIT_FAILED,
 	EXT4_FC_REASON_MAX
 };
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9d2fbeb0c9ea..5386736913d2 100644
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
index 0f899d3b09d3..70ae5497b73a 100644
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

