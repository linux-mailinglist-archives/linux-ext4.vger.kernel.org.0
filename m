Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B847E8B6
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbhLWUVz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhLWUVy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:21:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D8C061401
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r138so5819886pgr.13
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afm2+HhHAC7Sw0hw77PiZFcDBcFO/g97mTbrFBErryw=;
        b=ijF//6q4Rbe+zvIX+csVsocYzVyOM6VzdarZsSFEF7XkL5h6K1HcNgRG28GSjn6xd/
         0ZNuoSzK4PUx3kbAac8Q+z74NXnw3nZlOdg07K3VgR6OxlUeN6YXLIv0/VdLwjZjC1ll
         389VCNoqGiOtzwniFnk0NMCCLdQ/+2qbv3cXWEz8blVKyvk7ggsDLaRCVQWp3xdMibDx
         corpgIEk1jDacCU3c/A/bIc9e3iuBUi3lmR7UTa/0/JuTLNUNQV6xVy/Zp6eZBbgqGrG
         Ge+ZIizbWMIR4FUF5vORCTCrntDXAxWinSk/qYxAbAihMLiyhxrphHL6lAxybsSngCe5
         Pf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afm2+HhHAC7Sw0hw77PiZFcDBcFO/g97mTbrFBErryw=;
        b=tlkamziAu6lp5S7EhCf4mLEFDfw/6lSB2YZbBt9aCrL+DYkkw5KHlqdDpzeufEsXgu
         doGNXGJp7/X4T2Q6aLvDyCyaQuAIiMgRJHgGiM5gjVrWarht/VLeTVAzZm9jNfmlteIK
         L7EGQUJP0zgGE/w0X5OsoprnTDfDePYlLHGD31FdMXUCW3FJJBDNaKlN1BqwE4ROzf1c
         dbohCQvD4z+zr6lnj/sWdGDvD3iZSvmH7dhHsKh1WijDO+9n1Q7NwV/B+O+NxF2lkYp5
         njJVFvZznTOVMqTtyih2pwg2svSo9TAtWdTRL7KzsI8JTz57sy0oOTKBqxUcwt5KenPZ
         ebXg==
X-Gm-Message-State: AOAM530aCqpe1mnUGzj9NFAPdvbEp8FT/0ccdNttzphgPNUVZb7exTME
        J7urAglqjq/TRQpe6lXsYfg5Ih6diCw=
X-Google-Smtp-Source: ABdhPJwJU735A4svmVoG3nDdQbweymDWiK9SwvTtoRBrKTi1W3L6W2UgSuH8PtOdD8XFWMmtHO5Egw==
X-Received: by 2002:a05:6a00:b89:b0:4bb:15c:908c with SMTP id g9-20020a056a000b8900b004bb015c908cmr4107140pfj.34.1640290913764;
        Thu, 23 Dec 2021 12:21:53 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:404a:8e2b:a329:bed6])
        by smtp.googlemail.com with ESMTPSA id lx8sm10351074pjb.18.2021.12.23.12.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:21:52 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 1/4] ext4: use ext4_journal_start/stop for fast commit transactions
Date:   Thu, 23 Dec 2021 12:21:37 -0800
Message-Id: <20211223202140.2061101-2-harshads@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211223202140.2061101-1-harshads@google.com>
References: <20211223202140.2061101-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch drops all calls to ext4_fc_start_update() and
ext4_fc_stop_update(). To ensure that there are no ongoing journal
updates during fast commit, we also make jbd2_fc_begin_commit() lock
journal for updates. This way we don't have to maintain two different
transaction start stop APIs for fast commit and full commit. This
patch doesn't remove the functions altogether since in future we want
to have inode level locking for fast commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/acl.c     |  2 --
 fs/ext4/extents.c |  3 ---
 fs/ext4/file.c    |  4 ----
 fs/ext4/inode.c   |  7 +------
 fs/ext4/ioctl.c   | 10 +---------
 fs/jbd2/journal.c |  2 ++
 6 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 0613dfcbfd4a..5a35768d6149 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -246,7 +246,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(mnt_userns, inode, &mode, &acl);
@@ -264,7 +263,6 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0ecf819bf189..703feff8cb8c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4697,8 +4697,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
-
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		ret = ext4_punch_hole(inode, offset, len);
 		goto exit;
@@ -4762,7 +4760,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 4c5f41052351..8cc11715518a 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -259,7 +259,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -271,7 +270,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -552,9 +550,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bfd3545f1e5d..82f555d26980 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5320,7 +5320,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5344,7 +5344,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5356,7 +5355,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5370,12 +5368,10 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes) {
-				ext4_fc_stop_update(inode);
 				return -EFBIG;
 			}
 		}
 		if (!S_ISREG(inode->i_mode)) {
-			ext4_fc_stop_update(inode);
 			return -EINVAL;
 		}
 
@@ -5499,7 +5495,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..e64a12e1218a 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -743,7 +743,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
 
@@ -764,7 +763,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
 out:
-	ext4_fc_stop_update(inode);
 	return err;
 }
 
@@ -1273,13 +1271,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	long ret;
-
-	ext4_fc_start_update(file_inode(filp));
-	ret = __ext4_ioctl(filp, cmd, arg);
-	ext4_fc_stop_update(file_inode(filp));
-
-	return ret;
+	return __ext4_ioctl(filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 35302bc192eb..0b86a4365b66 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,6 +757,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
+	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -768,6 +769,7 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
+	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0);
 	write_lock(&journal->j_state_lock);
-- 
2.34.1.307.g9b7440fafd-goog

