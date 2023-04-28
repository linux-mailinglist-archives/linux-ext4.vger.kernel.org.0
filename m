Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A66F1AE3
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjD1OwC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjD1OwB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 10:52:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401581731;
        Fri, 28 Apr 2023 07:52:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE83321F91;
        Fri, 28 Apr 2023 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682693518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVBDS+kkAwbd3tTbXGHSZcY0afzQY4uU7/js2p10hmo=;
        b=kidRj+2quVMc9tmN5gl2//ix3e0L9yGCSsVzytF6Sz8O3MfR9iMnwu6VpvXU3CROnZnmZR
        tjXztqeeev1DxK8/4HiVY7ohCptd4IGAJo0c1cq6g6//zlBOLlci6Ef4mCqUfoR5rwiQs/
        3HJzsFroQzczGfXLGtleQNI9Yw9LdfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682693518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CVBDS+kkAwbd3tTbXGHSZcY0afzQY4uU7/js2p10hmo=;
        b=by3WUWwnj9YYE+8jnVDiVjtb9qDkCwLoIkyZeAieDHnNWgclC/C3ZXZ6tFdctYHw1K2Y1j
        evdxDjIALEeKAvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA2941390E;
        Fri, 28 Apr 2023 14:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aJ44NY7dS2R9SwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 14:51:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3E4E2A0729; Fri, 28 Apr 2023 16:51:58 +0200 (CEST)
Date:   Fri, 28 Apr 2023 16:51:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Pick commit 2729cfdcfa ("ext4: use ext4_journal_start/stop for
 fast commit transactions")
Message-ID: <20230428145158.47qrmwrujo6giyif@quack3>
References: <20230427162459.qb3tnh3be6ofibzz@quack3>
 <2023042804-feed-radiantly-2a07@gregkh>
 <20230428120246.hzx6lhkvmfdspy75@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikn6c23aybzyrrpv"
Content-Disposition: inline
In-Reply-To: <20230428120246.hzx6lhkvmfdspy75@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--ikn6c23aybzyrrpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 28-04-23 14:02:46, Jan Kara wrote:
> > Can you send us backported, and tested, versions of this commit so that
> > we can apply them?
> 
> Yeah, I'll look into applying the patch directly to stable branches.

Attached is backport of the fix to 5.10-stable kernel (passed xfstests run
for ext4 with fast_commit enabled).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--ikn6c23aybzyrrpv
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-use-ext4_journal_start-stop-for-fast-commit-tra.patch"

From f6e82961c44f5c6b3bd01ee858363beb3091b90f Mon Sep 17 00:00:00 2001
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Date: Thu, 23 Dec 2021 12:21:37 -0800
Subject: [PATCH] ext4: use ext4_journal_start/stop for fast commit
 transactions

commit 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69 upstream.

This patch drops all calls to ext4_fc_start_update() and
ext4_fc_stop_update(). To ensure that there are no ongoing journal
updates during fast commit, we also make jbd2_fc_begin_commit() lock
journal for updates. This way we don't have to maintain two different
transaction start stop APIs for fast commit and full commit. This
patch doesn't remove the functions altogether since in future we want
to have inode level locking for fast commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20211223202140.2061101-2-harshads@google.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/acl.c     | 2 --
 fs/ext4/extents.c | 2 --
 fs/ext4/file.c    | 4 ----
 fs/ext4/inode.c   | 7 +------
 fs/ext4/ioctl.c   | 8 +-------
 fs/jbd2/journal.c | 2 ++
 6 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 68aaed48315f..76f634d185f1 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -242,7 +242,6 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
 		error = posix_acl_update_mode(inode, &mode, &acl);
@@ -260,7 +259,6 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	ext4_fc_stop_update(inode);
 	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
 	return error;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index bf0872bb34f6..6c06ce9dd6bd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4694,7 +4694,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
@@ -4764,7 +4763,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0f61e0aa85d6..f42cc1fe0ba1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -260,7 +260,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	inode_lock(inode);
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
@@ -272,7 +271,6 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 
 out:
 	inode_unlock(inode);
-	ext4_fc_stop_update(inode);
 	if (likely(ret > 0)) {
 		iocb->ki_pos += ret;
 		ret = generic_write_sync(iocb, ret);
@@ -559,9 +557,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9bd5f8b0511b..a93b93de5a60 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5437,7 +5437,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5461,7 +5461,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5473,7 +5472,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5488,12 +5486,10 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
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
 
@@ -5619,7 +5615,6 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 53bdc67a815f..1171618f6549 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1322,13 +1322,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
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
index 6689d235de8a..fee325d62bfd 100644
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
2.35.3


--ikn6c23aybzyrrpv--
