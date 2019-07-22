Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94346F832
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 06:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGVECY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 00:02:24 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38193 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfGVECW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 00:02:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so18525449plb.5
        for <linux-ext4@vger.kernel.org>; Sun, 21 Jul 2019 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OggAYreUABkJf7e2CePjTIDWI/LivdAMCnsaxS4sdSw=;
        b=QCtnXm2LuNF3pR76ZrefCS2wbMyQFF0bpSq5MPSr2KDGClK3F3xl3jq17Rkk1In5zE
         d6XPY+NLCbJE43fp0jzf3YfDQFRyA1YnuGQ2W9G/yhrwadC+BjUDBgMngQ1KDhfmqDR9
         hWn8/EdBve5noEYxI/qTPvg9GORkfVzfl71zyrD/tyNGJBfnRAVxOXxfGxCF+dsGvmNG
         TwOyY4j5PiKS1lpRRMNnwffksNSPapQ1We4lM340YaQ4WO9QeaT0+vN7vhZjMiRDHqq4
         vtetqnginnwKLG37j9A7pFTCjt9c+93tPHZvnRxaMWj7l2TjWAz/Sb50lkdW49h4NxqA
         2Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OggAYreUABkJf7e2CePjTIDWI/LivdAMCnsaxS4sdSw=;
        b=hwXDIcjCavRrAfEuQDNuL+9Rgei3HqTiZtrfZ28NaDlJgfj6yYMpX3V/UqgUsLde/c
         rwHWTkKVyYKvmlDfrknQz0o6yyTyilChAF8KAnqjPTQ8Gxb0Kdj53Eo9q3be4Vn4xcyZ
         nye3YDXjrAskHLRiA0H1Ix4cAgo9Z/yYy8gtJML/5HID/GRGIe3YLhIJp8h/nmD2QGvf
         0Kis54CV8ymCSviq82SVFO35f6Gdler3sEkuTCkgtlnCDyaPN1w2F9e/o4CKeiijuhLj
         cdRIOzAK1BYbiL9BAM3QJ6Vr1Qkdrpr2KQhcVkAXlyH08stQjgKderaxWg8Rc0LFzKAL
         xcOQ==
X-Gm-Message-State: APjAAAXFQ6f+uSPzU8y6uAT2aGZtkX38BjYRJZAbJdKqgxiT/zhy+06f
        1LlOb5sa50lCjBOktYFNaDHDR49a
X-Google-Smtp-Source: APXvYqyXWXyYJLLuYG8v96N0AjSrQpaCq02ieddW9kTFVlos76bIBINY5UkukVnJx1hhNooRtgR0yQ==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr72501520plt.152.1563768141541;
        Sun, 21 Jul 2019 21:02:21 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f14sm37420625pfn.53.2019.07.21.21.02.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 21:02:21 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 09/11] ext4: fast-commit commit range tracking
Date:   Sun, 21 Jul 2019 21:00:09 -0700
Message-Id: <20190722040011.18892-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With this patch, we track logical range of file offsets that need to
be committed using fast commit. This allows us to find file extents
that need to be committed during the commit time.

Signed-Off-By: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/inline.c    |  5 ++++-
 fs/ext4/inode.c     | 18 +++++++++++++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b32b42076318..75754e98cc78 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -389,3 +389,36 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&EXT4_I(inode)->i_fc_list);
 	mutex_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
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
index 130297255624..d5958d4a0846 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -485,5 +485,7 @@ ext4_fc_mark_ineligible(struct super_block *sb)
 	mutex_unlock(&sbi->s_fc_lock);
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
2.22.0.657.g960e92d24f-goog

