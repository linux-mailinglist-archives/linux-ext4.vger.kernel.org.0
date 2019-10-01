Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019C9C2E5A
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbfJAHmI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44485 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHmI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so7287445pfn.11
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3uAdSaeo3SK4NEMv1bA39yXg1xoIX91DGqpS4F5v5A=;
        b=rce9Wv7GrLZkgaLuV3U+iCNJp3FWNl2LqRhBZZQ+9PrbHABzwvzE8SR6MBlHujsaz7
         og4Gzj15dP4N19e8sDftD+7sJyKlfjH5TeZ+sks+vtL0Of8i6DjsD5EE0cgkyIJvMsbn
         ipOx94pRPjxYdsIVp+uN7nHaVtnnqsaLM7NqCpwXbSkCBljay/+TfPUxRFXlqlWRxUqs
         fBsMVvrHzXZsSFVFgol9f0c62KI6ADosxQoljtzbvyuTXaMCevH+O6aMMHeZL9yADfiw
         tVy8f8Gm6GGviNL09RlgI2GFgIhg1cEoEBRygkdxz1azKBFCc70xJLlmJRGScRDuNMvC
         DeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3uAdSaeo3SK4NEMv1bA39yXg1xoIX91DGqpS4F5v5A=;
        b=ohB/mwljGq+mBMV4KFrCO543cg+yoYbAbSU0pkfIZqeskz2TsDABeruAd/rN/dMzZH
         jIBnEI2uNQ3/0VNUui4i+xUJzxtmGqkj0v2IH+HGSQLnCNa78z5V+k6hPDXhrbtPfCdz
         fGZj4yui5j1igPTlAUyzcddkmKP+Su+04Bj8D1kzdEL4kTlonbTtOc4vS4Vn9wEc/HCy
         NhzTFZZWul1CQnAzeaF4OiKXDKRELtMGOSyCRHr2G6amtuVPkHqthvqs7rVZzk8YRNxb
         GybRXrGQMI3/dMiTKXdNKJOJ/sxz5HIkJWzioqpUXJNV8BJkxwUkuZU7tkPu2hTiodqG
         5Zgg==
X-Gm-Message-State: APjAAAXiyk4zzsK4+Bn8M0JxdIP2kRa+Forkf7VjbBVbrE+AkuHjzdNj
        HHF6de2fnRsn9EtKpRqwzKM5aD6d85g=
X-Google-Smtp-Source: APXvYqwsQQNxTZSgFmEhArypNBP/jxe1i/tNY9CO6pt9VAzDzJsbvoZvM1WpoI3iyJ+c5jjVvHy6mA==
X-Received: by 2002:aa7:998f:: with SMTP id k15mr27228769pfh.203.1569915726947;
        Tue, 01 Oct 2019 00:42:06 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:06 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 08/13] ext4: fast-commit commit range tracking
Date:   Tue,  1 Oct 2019 00:40:57 -0700
Message-Id: <20191001074101.256523-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/ext4_jbd2.c | 34 ++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h |  2 ++
 fs/ext4/inline.c    |  4 +++-
 fs/ext4/inode.c     | 17 ++++++++++++++++-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index e70ad7a8e46e..0bb8de2139a5 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -405,6 +405,40 @@ void ext4_fc_del(struct inode *inode)
 	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 }
 
+void ext4_fc_update_commit_range(struct inode *inode, ext4_lblk_t start,
+				 ext4_lblk_t end)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);
+
+	if (!ext4_should_fast_commit(inode->i_sb))
+		return;
+
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
+		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+
+	if (!EXT4_SB(inode->i_sb)->s_fc_eligible)
+		return;
+
+	write_lock(&ei->i_fc.fc_lock);
+	if (ei->i_fc.fc_tid == running_txn_tid) {
+		ei->i_fc.fc_lblk_start = ei->i_fc.fc_lblk_start < start ?
+					 ei->i_fc.fc_lblk_start : start;
+		ei->i_fc.fc_lblk_end = ei->i_fc.fc_lblk_end > end ?
+				     ei->i_fc.fc_lblk_end : end;
+		write_unlock(&ei->i_fc.fc_lock);
+		return;
+	}
+
+	ext4_reset_inode_fc_info(&ei->i_fc);
+	ei->i_fc.fc_eligible = true;
+	ei->i_fc.fc_lblk_start = start;
+	ei->i_fc.fc_lblk_end = end;
+	ei->i_fc.fc_tid = running_txn_tid;
+	write_unlock(&ei->i_fc.fc_lock);
+
+}
+
 void ext4_fc_mark_new(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 65f20fbfb002..2cb7e7e1f025 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -501,6 +501,8 @@ ext4_fc_mark_ineligible(struct inode *inode)
 	spin_unlock(&sbi->s_fc_lock);
 }
 
+void ext4_fc_update_commit_range(struct inode *inode, ext4_lblk_t start,
+				 ext4_lblk_t end);
 
 void ext4_fc_mark_new(struct inode *inode);
 bool ext4_is_inode_fc_ineligible(struct inode *inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index fbd561cba098..66b2c0e3f7e4 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -966,8 +966,10 @@ int ext4_da_write_inline_data_end(struct inode *inode, loff_t pos,
 	 * But it's important to update i_size while still holding page lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos+copied > inode->i_size)
+	if (pos+copied > inode->i_size) {
+		ext4_fc_update_commit_range(inode, inode->i_size, pos + copied);
 		i_size_write(inode, pos+copied);
+	}
 	unlock_page(page);
 	put_page(page);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6d2efbd9aba9..ea039e3e1a4d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1549,6 +1549,8 @@ static int ext4_journalled_write_end(struct file *file,
 			SetPageUptodate(page);
 	}
 	size_changed = ext4_update_inode_size(inode, pos + copied);
+	ext4_fc_update_commit_range(inode, pos, pos + copied);
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
+			ext4_fc_update_commit_range(inode,
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
 
+	ext4_fc_update_commit_range(inode, pos, pos + copied);
+
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
 	    ext4_has_inline_data(inode))
@@ -3627,6 +3635,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 		goto orphan_del;
 	}
 
+	ext4_fc_update_commit_range(inode, offset, offset + written);
 	if (ext4_update_inode_size(inode, offset + written)) {
 		ext4_mark_inode_dirty(handle, inode);
 		ext4_fc_enqueue_inode(handle, inode);
@@ -3751,6 +3760,7 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 		ext4_update_i_disksize(inode, inode->i_size);
 		ext4_journal_stop(handle);
 	}
+	ext4_fc_update_commit_range(inode, offset, offset + count);
 
 	BUG_ON(iocb->private == NULL);
 
@@ -3869,6 +3879,8 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 				ext4_mark_inode_dirty(handle, inode);
 				ext4_fc_enqueue_inode(handle, inode);
 			}
+			ext4_fc_update_commit_range(inode, offset,
+						    offset + end);
 		}
 		err = ext4_journal_stop(handle);
 		if (ret == 0)
@@ -5327,6 +5339,9 @@ static int ext4_do_update_inode(handle_t *handle,
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
 	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
+		ext4_fc_update_commit_range(inode,
+					    ext4_isize(inode->i_sb, raw_inode),
+					    ei->i_disksize);
 		ext4_isize_set(raw_inode, ei->i_disksize);
 		need_datasync = 1;
 	}
-- 
2.23.0.444.g18eeb5a265-goog

