Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27E02A8DD4
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFD71 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKFD71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:27 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BBC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:25 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id x13so2928463pgp.7
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0t1NbJLbS56LHyKvofC03BLMZMF2MU5eZrdOs0SCio=;
        b=OZ3pkGncfocM342A8IfDAva6uO6TQ/uP7pcWB/WBJYMYmzPG7xeC/9JBHWRhfbo1xf
         LVAjRdu3Voljy/f3LoIJJfa/qFnQ5t+yPG0p+C5+WxXUzBu+64dJ3E+n4NSC8p71bNuw
         cJRjsMZeaB6+hCpjc+3xTFj3GbHVaueHVPbdbp/QixAkc3PjvS0ZeGhdf+doOVZPgzU9
         aNimTXKXBRB49DUyqOUk3jwyxPHJzDejEKsFj3422LPF88f++Dc3WM9do7k1Z/y+sOZb
         uUjbbVSteYAYSQABg952xRsMI1wMzxHxOwSEu3N/LvNxZkEzQvFW1rZamB9Sv6RYlRRh
         K0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0t1NbJLbS56LHyKvofC03BLMZMF2MU5eZrdOs0SCio=;
        b=FsTKao/pT2je5/xj5FE9pD6y6GSCl3GvusvLl6jiStWkg3a5g/mBxXKXSrXcanJLhr
         j1LGTlU7nhHTsCKu8gsxXOkmKCwwZo5snXjx3vhpDbZu/TqfAHv8FWVBP2mzvj1R7cFd
         Flx5FXzJ+O4RmR+vICM8GiwEZWjuz25+nlRT0jfbPdos40Q5PnkGck79maigb26KMt8J
         LfnkGgvqOOJPpyqDsceDQSG61NRKMQuUUc8jnaizETA5AcW8ao5L7c8z/SIuYk94J6Nc
         Px/m6JFsxvR1rZfnBMIVnLx48cLf885zUC/Te1rpKYvg+1Xhb+RkgSZ3xsgP4yivDUB9
         Kmwg==
X-Gm-Message-State: AOAM531xc6if2eljNaRF0jYm4uJcqYE9o0vu3KjCjV2iXN8QUogdLW1q
        6/BdeLxTSfxubGHcrh+AZgWolC8dcPg=
X-Google-Smtp-Source: ABdhPJwVABJIBba6eX2A4/pP+qZMaaq5YMqE3664swNns3T8Amz9ZyfToue56lrGb+J0rRljSCMxEQ==
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr257570pja.75.1604635164930;
        Thu, 05 Nov 2020 19:59:24 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:23 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 02/22] ext4: mark fc ineligible if inode gets evictied due to mem pressure
Date:   Thu,  5 Nov 2020 19:58:51 -0800
Message-Id: <20201106035911.1942128-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If inode gets evicted due to memory pressure, we have to remove it
from the fast commit list. However, that inode may have uncommitted
changes that fast commits will lose. So, just fall back to full
commits in this case. Also, rename the fast commit ineligiblity reason
from "EXT4_FC_REASON_MEM" to "EXT4_FC_REASON_MEM_NOMEM" for better
expression.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c       | 4 ++--
 fs/ext4/fast_commit.h       | 2 +-
 fs/ext4/inode.c             | 2 ++
 include/trace/events/ext4.h | 6 +++---
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8d43058386c3..48b7bc129392 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -384,7 +384,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	mutex_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -397,7 +397,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
-				EXT4_FC_REASON_MEM);
+				EXT4_FC_REASON_NOMEM);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 06907d485989..140fbb6af19e 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -100,7 +100,7 @@ enum {
 	EXT4_FC_REASON_XATTR = 0,
 	EXT4_FC_REASON_CROSS_RENAME,
 	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
-	EXT4_FC_REASON_MEM,
+	EXT4_FC_REASON_NOMEM,
 	EXT4_FC_REASON_SWAP_BOOT,
 	EXT4_FC_REASON_RESIZE,
 	EXT4_FC_REASON_RENAME_DIR,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b96a18679a27..081b6a86b5db 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -327,6 +327,8 @@ void ext4_evict_inode(struct inode *inode)
 	ext4_xattr_inode_array_free(ea_inode_array);
 	return;
 no_delete:
+	if (!list_empty(&EXT4_I(inode)->i_fc_list))
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM);
 	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index b14314fcf732..0f899d3b09d3 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -100,7 +100,7 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 		{ EXT4_FC_REASON_XATTR,		"XATTR"},		\
 		{ EXT4_FC_REASON_CROSS_RENAME,	"CROSS_RENAME"},	\
 		{ EXT4_FC_REASON_JOURNAL_FLAG_CHANGE, "JOURNAL_FLAG_CHANGE"}, \
-		{ EXT4_FC_REASON_MEM,	"NO_MEM"},			\
+		{ EXT4_FC_REASON_NOMEM,	"NO_MEM"},			\
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
+		      FC_REASON_NAME_STAT(EXT4_FC_REASON_NOMEM),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_SWAP_BOOT),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RESIZE),
 		      FC_REASON_NAME_STAT(EXT4_FC_REASON_RENAME_DIR),
-- 
2.29.1.341.ge80a0c044ae-goog

