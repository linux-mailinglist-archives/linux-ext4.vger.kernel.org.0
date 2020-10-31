Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDC32A1A6B
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgJaUFm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgJaUFm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEBC0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so4708595plr.4
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLHLGs1W6OTsvX8yBw7h8v+LuSkE22MNYO6vCCy3YPw=;
        b=V/Iw1czXVgF0SfK5CUYZ7bDrSRlR8l082KtkFQTCn3WadvVi1xtRyafARtSm3oinLc
         9RjV3RycGWPvLjg9NCvQeaBjPKYfW0E52V/LAPx1I/foGLoqt6edXaCl1eMVMbUt1al2
         96lKS+NPNa36kgpSHiHAnwHH1K2pEi6Y3Kmua4DF6z0xkDY44JMVtnPVdgaEcf801Do+
         a6PXKsAk/B/MjUqT/HiKzRytp0K7vl4RoV2hipyApH/ms4rGyeqiRE6Fr6pkjXCpTrH9
         dcdSZcNwZ5/iQiYYvTfJ/2VSyou8hYglvRazgMXU00SMq7tumk7il4Ve4gseYc82DI7F
         jKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLHLGs1W6OTsvX8yBw7h8v+LuSkE22MNYO6vCCy3YPw=;
        b=plN+EIu1qqiD74lY2WeKi7C4OrVBmGBPOjDuDdQhyqaxd5fEXn7sh0H9mP3ny7IC3k
         jYI/4203ddkRuN1ufvUR7CPz91MV8Gs9n2ba2JtaFwSYPqoRaXBYbfeijzS4OeG6JceA
         oGwpgevR7YGPI1cD4o33WnWWd0Ikoff1U9XMrudgQXC609lZPwim6E3iIIpJa/NAKKgB
         x8jAjWxme8f2oXbWsiOPBgkcLkV5sT9WM5DO96XnKb0TxFo6bYCAaL1NuWfw06+KTgd9
         rmXtICGlK84atfDC4s1N1vGjtiJErNTNrOUOlxu5ZEu7QS4ygGX5gHuHK7X2iH/4b3MV
         uQDQ==
X-Gm-Message-State: AOAM531MmZbcfiSgWv6cQuuerohbvb7jd5+TDwgDv7QjE221yIqfP6aI
        Hb2DqOulC9xrhSi1jyvKCv4uN1sjJL8=
X-Google-Smtp-Source: ABdhPJy3yXeoaBZuzLlfLL4QJZOncrhNFWt5PUOrWez1XrTB6C5ysWCh0YtBnXcmgl6RcMr1D+Iw7w==
X-Received: by 2002:a17:90b:1413:: with SMTP id jo19mr8683941pjb.221.1604174741736;
        Sat, 31 Oct 2020 13:05:41 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:40 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 02/10] ext4: mark fc ineligible if inode gets evictied due to mem pressure
Date:   Sat, 31 Oct 2020 13:05:10 -0700
Message-Id: <20201031200518.4178786-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If inode gets evicted due to memory pressure, we have to remove it
from the fast commit list. However, that inode may have uncommitted
changes that fast commits will lose. So, just fall back to full
commits in this case. Also, rename the fast commit ineligiblity reason
from "EXT4_FC_REASON_MEM" to "EXT4_FC_REASON_MEM_CRUNCH" for better
expression.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c       | 4 ++--
 fs/ext4/fast_commit.h       | 2 +-
 fs/ext4/inode.c             | 1 +
 include/trace/events/ext4.h | 6 +++---
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8d43058386c3..354f81ff819d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -384,7 +384,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	mutex_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM_CRUNCH);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -397,7 +397,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
-				EXT4_FC_REASON_MEM);
+				EXT4_FC_REASON_MEM_CRUNCH);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 06907d485989..cde86747faf8 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -100,7 +100,7 @@ enum {
 	EXT4_FC_REASON_XATTR = 0,
 	EXT4_FC_REASON_CROSS_RENAME,
 	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
-	EXT4_FC_REASON_MEM,
+	EXT4_FC_REASON_MEM_CRUNCH,
 	EXT4_FC_REASON_SWAP_BOOT,
 	EXT4_FC_REASON_RESIZE,
 	EXT4_FC_REASON_RENAME_DIR,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b96a18679a27..52ff71236290 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -327,6 +327,7 @@ void ext4_evict_inode(struct inode *inode)
 	ext4_xattr_inode_array_free(ea_inode_array);
 	return;
 no_delete:
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM_CRUNCH);
 	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index b14314fcf732..239e98014f9b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -100,7 +100,7 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
 		{ EXT4_FC_REASON_CROSS_RENAME,	"CROSS_RENAME"},	\
 		{ EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, "JOURNAL_FLAG_CHANGE"}, \
-		{ EXT4_FC_REASON_MEM,	"NO_MEM"},			\
+		{ EXT4_FC_REASON_MEM_CRUNCH,	"MEM_CRUNCH"},			\
 		{ EXT4_FC_REASON_SWAP_BOOT,	"SWAP_BOOT"},		\
 		{ EXT4_FC_REASON_RESIZE,	"RESIZE"},		\
 		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
@@ -2917,13 +2917,13 @@ TRACE_EVENT(ext4_fc_stats,
 		    ),
 
 	    TP_printk("dev %d:%d fc ineligible reasons:\n"
-		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s,%d; "
+		      "%s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d, %s:%d; "
 		      "num_commits:%ld, ineligible: %ld, numblks: %ld",
 		      MAJOR(__entry->dev), MINOR(__entry->dev),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_CROSS_RENAME),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE),
-		      FC_REASON_NAME_STAT(EXT4_FC_REASON_MEM),
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_MEM_CRUNCH),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
-- 
2.29.1.341.ge80a0c044ae-goog

