Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546A487049
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405226AbfHIDqg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44413 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405192AbfHIDqf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so45244639pfe.11
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYxGtB2AAo13bc1nbrh+Vvilu06ItaaLOGpOmCFjms4=;
        b=ACZhGKiRJxFRF3gqe6E1LgNgf5jm2CUpnDFrJ9lmnNh5hQ55msk5sKdtb/YfFChchb
         WjmClOtNpbMtf6lpEdcyfNRPwhjHziTIqEtcafmsdBLyTLOlf+Ic+TOJYeDfNyCRPZOi
         tUYpXn2T6orltnIZpbgRUgOFlbxKGzs9FDev5qc9oKob1Pg4+0+6Ki1BqKz3cPah709P
         SDvQ6chh4zZQsssvEVhsbGF5vqbQbep3Q+hx0v4P3fXMfvEcu/TI5N4dy/4Cln3ORNn3
         A1nBQdKhaxuX3SBruGT5rBIyAEirSFKD6dCKdX6uaYMhlBY3UEfu+w9JgfKiuF8de/Qn
         zxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYxGtB2AAo13bc1nbrh+Vvilu06ItaaLOGpOmCFjms4=;
        b=bPTwVzD5EGF3X3pRYp15CibGDEdrWHbFv/dGHlVRrA9V6OyjtAk+wEuLI0lUPvwPHV
         bX3ZRsGkxEOBV3LpGPyZ5JVTtqfNbmyLiNTCNJaiJJszYr34itzGFxAs87D4p/Q8XLng
         EIcL+X8tf1XQCJQ8TUd3Kl4MJKU2/7KbnlnphdqhTHYY6ADbqhCECYK+igyCr4OTC6YG
         yTqt9Yk814uVH348V5CCp/Q4b8rQgrHr4RHHP8uziyhRgcGdUO0jeMkT17Ucpd4Zkk5s
         J5sYPbfj13jFBivsedoeUnEri9WxY8BJUtXTtKwS1x83QdryPBSBMyYLd24XNHUAsx4a
         Pn5Q==
X-Gm-Message-State: APjAAAXCNVHXrWw/5K7HdJV3zXozuxF62WHVUon7vVhdEhKZhUGJ04Pm
        wV/XE9pQfN7+JC9YGNhU7P6Or/FL
X-Google-Smtp-Source: APXvYqwl313YZgqdDGsY8LBMZb/W+anUKsuM34tXlpHBVJyyYittqApiMwbArlJXqNwS3Sv+8moBBg==
X-Received: by 2002:a65:6495:: with SMTP id e21mr15735302pgv.359.1565322394367;
        Thu, 08 Aug 2019 20:46:34 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:33 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 09/12] ext4: fast-commit commit range tracking
Date:   Thu,  8 Aug 2019 20:45:49 -0700
Message-Id: <20190809034552.148629-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With this patch, we track logical range of file offsets that need to
be committed using fast commit. This allows us to find file extents
that need to be committed during the commit time.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

---

Changelog:

V2: Since s_fc_lock is now a spinlock, updated calls appropriately.
---
 fs/ext4/ext4_jbd2.c | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/inline.c    |  5 ++++-
 fs/ext4/inode.c     | 18 +++++++++++++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d77b9f1e9dab..2897cbf4cc03 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -389,3 +389,36 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&EXT4_I(inode)->i_fc_list);
 	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 }
+
+void ext4_fc_update_commit_range(handle_t *handle, struct inode *inode,
+				 loff_t start, loff_t end)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	if (!ext4_should_fast_commit(inode->i_sb))
+		return;
+
+	if (!ext4_handle_valid(handle))
+		return;
+
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
+		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+
+	if (!EXT4_SB(inode->i_sb)->s_fc_eligible)
+		return;
+
+	if (ei->i_fc.fc_tid == handle->h_transaction->t_tid &&
+	    ei->i_fc.fc_subtid ==
+	    handle->h_transaction->t_journal->j_subtid) {
+		ei->i_fc.fc_lblk_start = ei->i_fc.fc_lblk_start < start ?
+					 ei->i_fc.fc_lblk_start : start;
+		ei->i_fc.fc_lblk_end = ei->i_fc.fc_lblk_end > end ?
+				     ei->i_fc.fc_lblk_end : end;
+		return;
+	}
+
+	ei->i_fc.fc_lblk_start = start;
+	ei->i_fc.fc_lblk_end = end;
+	ei->i_fc.fc_subtid = handle->h_transaction->t_journal->j_subtid;
+	ei->i_fc.fc_tid = handle->h_transaction->t_tid;
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index a27cc3a5c676..1badb142dc2a 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -485,5 +485,7 @@ ext4_fc_mark_ineligible(struct super_block *sb)
 	spin_unlock(&sbi->s_fc_lock);
 }
 
+void ext4_fc_update_commit_range(handle_t *handle, struct inode *inode,
+				 loff_t start, loff_t end);
 
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 190968996bc6..de61c15e1b17 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -967,8 +967,11 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
 	 * But it's important to update i_size while still holding page lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos+copied > inode->i_size)
+	if (pos+copied > inode->i_size) {
+		ext4_fc_update_commit_range(ext4_journal_current_handle(),
+					    inode, inode->i_size, pos + copied);
 		i_size_write(inode, pos+copied);
+	}
 	unlock_page(page);
 	put_page(page);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 379e911b48c4..f79b185c013e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1549,6 +1549,8 @@ static int ext4_journalled_write_end(struct file *file,
 			SetPageUptodate(page);
 	}
 	size_changed = ext4_update_inode_size(inode, pos + copied);
+	ext4_fc_update_commit_range(handle, inode, pos, pos + copied);
+
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
 	unlock_page(page);
@@ -2610,8 +2612,12 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		i_size = i_size_read(inode);
 		if (disksize > i_size)
 			disksize = i_size;
-		if (disksize > EXT4_I(inode)->i_disksize)
+		if (disksize > EXT4_I(inode)->i_disksize) {
+			ext4_fc_update_commit_range(handle, inode,
+						    EXT4_I(inode)->i_disksize,
+						    disksize);
 			EXT4_I(inode)->i_disksize = disksize;
+		}
 		up_write(&EXT4_I(inode)->i_data_sem);
 		err2 = ext4_mark_inode_dirty(handle, inode);
 		ext4_fc_enqueue_inode(handle, inode);
@@ -3220,6 +3226,8 @@ static int ext4_da_write_end(struct file *file,
 		}
 	}
 
+	ext4_fc_update_commit_range(handle, inode, pos, pos + copied);
+
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
@@ -3627,6 +3635,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 		goto orphan_del;
 	}
 
+	ext4_fc_update_commit_range(handle, inode, offset, offset + written);
 	if (ext4_update_inode_size(inode, offset + written)) {
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_fc_enqueue_inode(handle, inode);
@@ -3751,6 +3760,8 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 		ext4_update_i_disksize(inode, inode->i_size);
 		ext4_journal_stop(handle);
 	}
+	ext4_fc_update_commit_range(journal_current_handle(), inode, offset,
+				    offset + count);
 
 	BUG_ON(iocb->private == NULL);
 
@@ -3869,6 +3880,8 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 				ext4_mark_inode_dirty(handle, inode);
 				ext4_fc_enqueue_inode(handle, inode);
 			}
+			ext4_fc_update_commit_range(handle, inode, offset,
+						    offset + end);
 		}
 		err = ext4_journal_stop(handle);
 		if (ret == 0)
@@ -5327,6 +5340,9 @@ static int ext4_do_update_inode(handle_t *handle,
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
 	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
+		ext4_fc_update_commit_range(handle, inode,
+					    ext4_isize(inode->i_sb, raw_inode),
+					    ei->i_disksize);
 		ext4_isize_set(raw_inode, ei->i_disksize);
 		need_datasync = 1;
 	}
-- 
2.23.0.rc1.153.gdeed80330f-goog

