Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A466F1ACB
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjD1Oth (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346078AbjD1Otg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 10:49:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8E4C2D;
        Fri, 28 Apr 2023 07:49:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 756AE21A0E;
        Fri, 28 Apr 2023 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682693372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5Z1BaNKTAuyFV1Ko8sxD+ulDr7JBEpLMccUg+SPw84=;
        b=lPYl4buAcbM6bP9sShyeQ1VQhl17erypVdEdIPldHHHqpjpPLjaN6z/ZM1g1agB0Uj7tQ3
        QxePrZ6X5z04yCVNPnSRKr/UqaWC2H1dDt9aVVRESmcxcQzyEkWh/r1uiXmXFtGCJJzvwi
        bN49l/noWvamzCW3Ab7dMvwehgnE1Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682693372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5Z1BaNKTAuyFV1Ko8sxD+ulDr7JBEpLMccUg+SPw84=;
        b=jaX8mKt+DCR77TljXHAVQNG8q5zPDCizJSOBct7tQHB4cj0EY/KxJFoRp0i1p3dI/vi/Xe
        1aNkINeyFCcszrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65BA41390E;
        Fri, 28 Apr 2023 14:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nznNGPzcS2QcSgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 28 Apr 2023 14:49:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DDE0BA0729; Fri, 28 Apr 2023 16:49:31 +0200 (CEST)
Date:   Fri, 28 Apr 2023 16:49:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Pick commit 2729cfdcfa ("ext4: use ext4_journal_start/stop for
 fast commit transactions")
Message-ID: <20230428144931.5wqpd5azweziee7u@quack3>
References: <20230427162459.qb3tnh3be6ofibzz@quack3>
 <2023042804-feed-radiantly-2a07@gregkh>
 <20230428120246.hzx6lhkvmfdspy75@quack3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4vbcoud4cxddwdli"
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


--4vbcoud4cxddwdli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 28-04-23 14:02:46, Jan Kara wrote:
> On Fri 28-04-23 09:32:34, Greg KH wrote:
> > On Thu, Apr 27, 2023 at 06:24:59PM +0200, Jan Kara wrote:
> > > Hello,
> > > 
> > > recently I've debugged a deadlock issue in ext4 fast commit feature in our
> > > openSUSE Leap kernel. Checking with upstream I've found out the issue was
> > > accidentally fixed by commit 2729cfdcfa1c ("ext4: use
> > > ext4_journal_start/stop for fast commit transactions"). Can you please pick
> > > up this commit into the stable tree? The problem has been there since fast
> > > commit began to exist (in 5.10-rc1) so 5.10 and 5.15 stable trees need the
> > > fix. Thanks!
> > 
> > This commit does not apply to those branches, so how was it tested?
> 
> Hum, I've picked up the patch to our 5.14-based distro kernel and it
> applied (and passed testing) without issues so I was hoping 5.15 and 5.10
> would work as well. Apparently I was wrong. Sorry for the trouble.
> 
> > Can you send us backported, and tested, versions of this commit so that
> > we can apply them?
> 
> Yeah, I'll look into applying the patch directly to stable branches.

Tested version of the patch for 5.15-stable is attached.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--4vbcoud4cxddwdli
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-ext4-use-ext4_journal_start-stop-for-fast-commit-tra.patch"

From 28237a586fdcf183e534fa8920fb62bf4f5a3512 Mon Sep 17 00:00:00 2001
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
index d3fae909fcbf..82bcf718b1e6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4701,8 +4701,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
-
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
 	inode_unlock(inode);
@@ -4772,7 +4770,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
-	ext4_fc_stop_update(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 45f6d75de660..4704fe627c4e 100644
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
@@ -558,9 +556,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out;
 		}
 
-		ext4_fc_start_update(inode);
 		ret = ext4_orphan_add(handle, inode);
-		ext4_fc_stop_update(inode);
 		if (ret) {
 			ext4_journal_stop(handle);
 			goto out;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a39d5cca4121..0426f88ba907 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5366,7 +5366,7 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		if (error)
 			return error;
 	}
-	ext4_fc_start_update(inode);
+
 	if ((ia_valid & ATTR_UID && !uid_eq(attr->ia_uid, inode->i_uid)) ||
 	    (ia_valid & ATTR_GID && !gid_eq(attr->ia_gid, inode->i_gid))) {
 		handle_t *handle;
@@ -5390,7 +5390,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 
 		if (error) {
 			ext4_journal_stop(handle);
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 		/* Update corresponding info in inode so that everything is in
@@ -5402,7 +5401,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		error = ext4_mark_inode_dirty(handle, inode);
 		ext4_journal_stop(handle);
 		if (unlikely(error)) {
-			ext4_fc_stop_update(inode);
 			return error;
 		}
 	}
@@ -5417,12 +5415,10 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
 
@@ -5548,7 +5544,6 @@ int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		ext4_std_error(inode->i_sb, error);
 	if (!error)
 		error = rc;
-	ext4_fc_stop_update(inode);
 	return error;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 656c6ba66ca7..47ec00cfb445 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -744,7 +744,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 	u32 flags = fa->flags;
 	int err = -EOPNOTSUPP;
 
-	ext4_fc_start_update(inode);
 	if (flags & ~EXT4_FL_USER_VISIBLE)
 		goto out;
 
@@ -765,7 +764,6 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
 		goto out;
 	err = ext4_ioctl_setproject(inode, fa->fsx_projid);
 out:
-	ext4_fc_stop_update(inode);
 	return err;
 }
 
@@ -1272,13 +1270,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
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
index 097ba728d516..580d2fdfe21f 100644
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
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
-- 
2.35.3


--4vbcoud4cxddwdli--
