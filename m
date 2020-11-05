Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D12A8604
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgKESVj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 13:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKESVj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 13:21:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B07C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 10:21:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id f12so490181pjp.4
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 10:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:date:references:cc:to:message-id;
        bh=JbblGZvCILuwKe5mlKxIz6OgnDiv+b1Y74PGe1PVBKw=;
        b=frg/XiaWgyUK1EYlAGIZLF5LOq2VIZAthAr/WBGIYLoE1TwLCf0/qrxDFDIdjt16YM
         bMTrSeCd436bt1v2upTg6JSMrsY2QBF46Mtumuyl3vCxBew/Lga8mhO3ZsXkcj2zdsLh
         qydcqWEp/W6WIomckYj9y8lMqae9RcpTMqnczZ1XzafeilvoAHdlwhl6RlBtBfEyV7DV
         3Hrj+qUJZArs9AAP6+AjQ0MaXfFiYSzU8l2/gxnlmJcSCqy59Au9Cw+GusQK7hRU5o9U
         RNyJC8nxjKSkLaxMCT94PF8uVCvMZdt0foF1Y0CRJgrbh+RlOpn1UTkLhRrJ3VkIRWG9
         8dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:date:references:cc:to
         :message-id;
        bh=JbblGZvCILuwKe5mlKxIz6OgnDiv+b1Y74PGe1PVBKw=;
        b=eLMMp7Q2C2/y2N+THJGw0VeGxDVD6qjohGFwY7+u5J8tZNHYhCQYO5oa7Ofr2BeKPQ
         3CY9xaAEgwzegL7Xi16tObx8Zuzdzsvn8pVlOym9bWkcTMWCqB6HXFpqgziGZUJuexNH
         A/9V5ZdWvxGoEqrgN9i7twg5FJVik4NoRBShPjrCprle7qcwny+KPCg9kAaiXF2lbcxo
         wq51zAqxhNp0ruQftZONsJyN1jpWRm456GfSzBTXgD07zePfgqhStnsLLJP1rAFvZHMt
         WV698NM1Ts5omUAONzTN2cqdWJynsvB6jb5sMJmBwAnIsZzR9BNRbQnWo5NAGMHsrnGK
         XWLg==
X-Gm-Message-State: AOAM530ic6QRUpAXfUu1Ez7bqSAD7OfbMLG3ZS4SSyA+DLq9BLLLROI3
        /CgpCe5SsXWzYbqdcAZKF5VVMvJOzOZOUbA4
X-Google-Smtp-Source: ABdhPJz3949FfQM/5OAwyBzYaJl+r6X1k6yNqZV0DefxfvzLd3DmvLAoFBLQ64hfoyR3U/kb4AF2Ow==
X-Received: by 2002:a17:90a:8c:: with SMTP id a12mr3642520pja.155.1604600497921;
        Thu, 05 Nov 2020 10:21:37 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id nv7sm2659118pjb.27.2020.11.05.10.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:21:37 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DD4ECBDD-6ECA-4ABD-A5A9-6EACD2E3F827";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: [PATCH] [RFC] Asynchronous unlink/truncate patch for ext3
Date:   Thu, 5 Nov 2020 11:21:33 -0700
References: <20051207002316.GA14509@schatzie.adilger.int>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Message-Id: <64D58E46-3B59-4DB6-BF4C-2CA585C07FFE@dilger.ca>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DD4ECBDD-6ECA-4ABD-A5A9-6EACD2E3F827
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Per discussion earlier today, included here is a copy of the old
asynchronous delete thread patch that we previously used in Lustre
to speed up unlink() and truncate(0) before we had extents.  This
patch is also available from the Lustre git repositories:

=
https://git.whamcloud.com/?p=3Dfs/lustre-release.git;f=3Dlustre/kernel_pat=
ches/patches/ext3-delete_thread-2.4.29.patch;hb=3D9b6f9d17a35188f5f4dbfae8=
40164b999a7a78a2

=
https://github.com/lustre/lustre-release/blob/1.4.10/lustre/kernel_patches=
/patches/ext3-delete_thread-2.4.29.patch

This patch is based on ext3 and the 2.4.29 kernel, so it will need
updating, but I think the general idea is reasonably solid, and the
code worked for years without issues before it was deprecated.  The
"asyncdel" mount option enables this behavior on a filesystem.

There is no support for extent-mapped files (which would only need
to copy the extent flag over), nor is there support for metadata_csum,
which would cause checksums for the extent blocks to be invalid when
blocks are swapped to a new inode, similar to the EXT4_BOOT_LOADER_INO
issue that was recently hit.


When files are being unlinked or truncated to zero, a temporary inode
is allocated and the blocks are moved to that temp inode, and then a
per-superblock background thread is woken to handle this work.  The
temporary inode is added to the orphan list in case of crash, and is
processed normally at mount time like other orphan inodes.

This not only defers the inode indirect block iteration, it also
avoids increasing the foreground transaction size for the truncate.

The blocks of files temporarily in the delete queue are tracked in
an in-memory counter, and there is a wait queue for callers needing
space to wait on, but the blocks are not actually subtracted from the
statfs counters in this patch, nor does block or inode allocation
actually wait on the thread if they run out of space.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Alex Zhuravlev <alex@clusterfs.com>
---
 fs/ext3/file.c             |    4 +
 fs/ext3/inode.c            |  112 +++++++++++++++++++++++++++++++++++
 fs/ext3/namei.c            |   38 +++++++++++-
 fs/ext3/super.c            |  142 =
++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ext3_fs.h    |    5 +
 include/linux/ext3_fs_sb.h |   10 +++
 6 files changed, 309 insertions(+), 2 deletions(-)


Index: linux-2.4.29/fs/ext3/super.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/fs/ext3/super.c	2005-05-03 15:53:33.047533872 =
+0300
+++ linux-2.4.29/fs/ext3/super.c	2005-05-03 15:54:47.192262160 =
+0300
@@ -400,6 +400,127 @@
 	}
 }

+#ifdef EXT3_DELETE_THREAD
+/*
+ * Delete inodes in a loop until there are no more to be deleted.
+ * Normally, we run in the background doing the deletes and sleeping =
again,
+ * and clients just add new inodes to be deleted onto the end of the =
list.
+ * If someone is concerned about free space (e.g. block allocation or =
similar)
+ * then they can sleep on s_delete_waiter_queue and be woken up when =
space
+ * has been freed.
+ */
+int ext3_delete_thread(void *data)
+{
+	struct super_block *sb =3D data;
+	struct ext3_sb_info *sbi =3D EXT3_SB(sb);
+	struct task_struct *tsk =3D current;
+
+	/* Almost like daemonize, but not quite */
+	exit_mm(current);
+	tsk->session =3D 1;
+	tsk->pgrp =3D 1;
+	tsk->tty =3D NULL;
+	exit_files(current);
+	reparent_to_init();
+
+	sprintf(tsk->comm, "kdelext3-%s", kdevname(sb->s_dev));
+	sigfillset(&tsk->blocked);
+
+	/*tsk->flags |=3D PF_KERNTHREAD;*/
+
+	INIT_LIST_HEAD(&sbi->s_delete_list);
+	wake_up(&sbi->s_delete_waiter_queue);
+	ext3_debug("delete thread on %s started\n", =
kdevname(sb->s_dev));
+
+	/* main loop */
+	for (;;) {
+		wait_event_interruptible(sbi->s_delete_thread_queue,
+					 =
!list_empty(&sbi->s_delete_list) ||
+					 !test_opt(sb, ASYNCDEL));
+		ext3_debug("%s woken up: %lu inodes, %lu blocks\n",
+			   =
tsk->comm,sbi->s_delete_inodes,sbi->s_delete_blocks);
+
+		spin_lock(&sbi->s_delete_lock);
+		if (list_empty(&sbi->s_delete_list)) {
+			clear_opt(sbi->s_mount_opt, ASYNCDEL);
+			memset(&sbi->s_delete_list, 0,
+			       sizeof(sbi->s_delete_list));
+			spin_unlock(&sbi->s_delete_lock);
+			ext3_debug("delete thread on %s exiting\n",
+				   kdevname(sb->s_dev));
+			wake_up(&sbi->s_delete_waiter_queue);
+			break;
+		}
+
+		while (!list_empty(&sbi->s_delete_list)) {
+			struct inode =
*inode=3Dlist_entry(sbi->s_delete_list.next,
+						       struct inode, =
i_devices);
+			unsigned long blocks =3D inode->i_blocks >>
+							=
(inode->i_blkbits - 9);
+
+			list_del_init(&inode->i_devices);
+			spin_unlock(&sbi->s_delete_lock);
+			ext3_debug("%s delete ino %lu blk %lu\n",
+				   tsk->comm, inode->i_ino, blocks);
+
+			J_ASSERT(EXT3_I(inode)->i_state & =
EXT3_STATE_DELETE);
+			J_ASSERT(inode->i_nlink =3D=3D 1);
+			inode->i_nlink =3D 0;
+			iput(inode);
+
+			spin_lock(&sbi->s_delete_lock);
+			sbi->s_delete_blocks -=3D blocks;
+			sbi->s_delete_inodes--;
+		}
+		if (sbi->s_delete_blocks !=3D 0 || sbi->s_delete_inodes =
!=3D 0) {
+			ext3_warning(sb, __FUNCTION__,
+				     "%lu blocks, %lu inodes on =
list?\n",
+				     =
sbi->s_delete_blocks,sbi->s_delete_inodes);
+			sbi->s_delete_blocks =3D 0;
+			sbi->s_delete_inodes =3D 0;
+		}
+		spin_unlock(&sbi->s_delete_lock);
+		wake_up(&sbi->s_delete_waiter_queue);
+	}
+
+	return 0;
+}
+
+static void ext3_start_delete_thread(struct super_block *sb)
+{
+	struct ext3_sb_info *sbi =3D EXT3_SB(sb);
+	int rc;
+
+	spin_lock_init(&sbi->s_delete_lock);
+	init_waitqueue_head(&sbi->s_delete_thread_queue);
+	init_waitqueue_head(&sbi->s_delete_waiter_queue);
+
+	if (!test_opt(sb, ASYNCDEL))
+		return;
+
+	rc =3D kernel_thread(ext3_delete_thread, sb, CLONE_VM | =
CLONE_FILES);
+	if (rc < 0)
+		printk(KERN_ERR "EXT3-fs: cannot start delete thread: rc =
%d\n",
+		       rc);
+	else
+		wait_event(sbi->s_delete_waiter_queue, =
sbi->s_delete_list.next);
+}
+
+static void ext3_stop_delete_thread(struct ext3_sb_info *sbi)
+{
+	if (sbi->s_delete_list.next =3D=3D 0)	/* thread never started =
*/
+		return;
+
+	clear_opt(sbi->s_mount_opt, ASYNCDEL);
+	wake_up(&sbi->s_delete_thread_queue);
+	wait_event(sbi->s_delete_waiter_queue,
+			sbi->s_delete_list.next =3D=3D 0 && =
sbi->s_delete_inodes =3D=3D 0);
+}
+#else
+#define ext3_start_delete_thread(sbi) do {} while(0)
+#define ext3_stop_delete_thread(sbi) do {} while(0)
+#endif /* EXT3_DELETE_THREAD */
+
 void ext3_put_super (struct super_block * sb)
 {
 	struct ext3_sb_info *sbi =3D EXT3_SB(sb);
@@ -407,6 +528,9 @@
 	kdev_t j_dev =3D sbi->s_journal->j_dev;
 	int i;

+#ifdef EXT3_DELETE_THREAD
+	J_ASSERT(sbi->s_delete_inodes =3D=3D 0);
+#endif
 	ext3_xattr_put_super(sb);
 	journal_destroy(sbi->s_journal);
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -526,6 +650,13 @@
 			clear_opt (*mount_options, XATTR_USER);
 		else
 #endif
+#ifdef EXT3_DELETE_THREAD
+		if (!strcmp(this_char, "asyncdel"))
+			set_opt(*mount_options, ASYNCDEL);
+		else if (!strcmp(this_char, "noasyncdel"))
+			clear_opt(*mount_options, ASYNCDEL);
+		else
+#endif
 		if (!strcmp (this_char, "bsddf"))
 			clear_opt (*mount_options, MINIX_DF);
 		else if (!strcmp (this_char, "nouid32")) {
@@ -1244,6 +1375,7 @@
 	}

 	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY);
+	ext3_start_delete_thread(sb);
 	EXT3_SB(sb)->s_mount_state |=3D EXT3_ORPHAN_FS;
 	ext3_orphan_cleanup(sb, es);
 	EXT3_SB(sb)->s_mount_state &=3D ~EXT3_ORPHAN_FS;
@@ -1626,7 +1758,12 @@
 static int ext3_sync_fs(struct super_block *sb)
 {
 	tid_t target;
-
+
+	if (atomic_read(&sb->s_active) =3D=3D 0) {
+		/* fs is being umounted: time to stop delete thread */
+		ext3_stop_delete_thread(EXT3_SB(sb));
+	}
+
 	sb->s_dirt =3D 0;
 	target =3D log_start_commit(EXT3_SB(sb)->s_journal, NULL);
 	log_wait_commit(EXT3_SB(sb)->s_journal, target);
@@ -1690,6 +1827,9 @@
 	if (!parse_options(data, &tmp, sbi, &tmp, 1))
 		return -EINVAL;

+	if (!test_opt(sb, ASYNCDEL) || (*flags & MS_RDONLY))
+		ext3_stop_delete_thread(sbi);
+
 	if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 		ext3_abort(sb, __FUNCTION__, "Abort forced by user");

Index: linux-2.4.29/fs/ext3/inode.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/fs/ext3/inode.c	2005-05-03 15:53:36.555000656 =
+0300
+++ linux-2.4.29/fs/ext3/inode.c	2005-05-03 15:53:56.901907456 =
+0300
@@ -2562,6 +2562,118 @@
 	return err;
 }

+#ifdef EXT3_DELETE_THREAD
+/* Move blocks from to-be-truncated inode over to a new inode, and =
delete
+ * that one from the delete thread instead.  This avoids a lot of =
latency
+ * when truncating large files.
+ *
+ * If we have any problem deferring the truncate, just truncate it =
right away.
+ * If we defer it, we also mark how many blocks it would free, so that =
we
+ * can keep the statfs data correct, and we know if we should sleep on =
the
+ * delete thread when we run out of space.
+ */
+void ext3_truncate_thread(struct inode *old_inode)
+{
+	struct ext3_sb_info *sbi =3D EXT3_SB(old_inode->i_sb);
+	struct ext3_inode_info *nei, *oei =3D EXT3_I(old_inode);
+	struct inode *new_inode;
+	handle_t *handle;
+	unsigned long blocks =3D old_inode->i_blocks >> =
(old_inode->i_blkbits-9);
+
+	if (!test_opt(old_inode->i_sb, ASYNCDEL) || =
!sbi->s_delete_list.next)
+		goto out_truncate;
+
+	/* XXX This is a temporary limitation for code simplicity.
+	 *     We could truncate to arbitrary sizes at some later time.
+	 */
+	if (old_inode->i_size !=3D 0)
+		goto out_truncate;
+
+	/* We may want to truncate the inode immediately and not defer =
it */
+	if (IS_SYNC(old_inode) || blocks <=3D EXT3_NDIR_BLOCKS ||
+	    old_inode->i_size > oei->i_disksize)
+		goto out_truncate;
+
+	/* We can't use the delete thread as-is during real orphan =
recovery,
+	 * as we add to the orphan list here, causing =
ext3_orphan_cleanup()
+	 * to loop endlessly.  It would be nice to do so, but needs =
work.
+	 */
+	if (oei->i_state & EXT3_STATE_DELETE ||
+	    sbi->s_mount_state & EXT3_ORPHAN_FS) {
+		ext3_debug("doing deferred inode %lu delete (%lu =
blocks)\n",
+			   old_inode->i_ino, blocks);
+		goto out_truncate;
+	}
+
+	ext3_discard_prealloc(old_inode);
+
+	/* old_inode   =3D 1
+	 * new_inode   =3D sb + GDT + ibitmap
+	 * orphan list =3D 1 inode/superblock for add, 2 inodes for del
+	 * quota files =3D 2 * EXT3_SINGLEDATA_TRANS_BLOCKS
+	 */
+	handle =3D ext3_journal_start(old_inode, 7);
+	if (IS_ERR(handle))
+		goto out_truncate;
+
+	new_inode =3D ext3_new_inode(handle, old_inode, =
old_inode->i_mode);
+	if (IS_ERR(new_inode)) {
+		ext3_debug("truncate inode %lu directly (no new =
inodes)\n",
+			   old_inode->i_ino);
+		goto out_journal;
+	}
+
+	nei =3D EXT3_I(new_inode);
+
+	down_write(&oei->truncate_sem);
+	new_inode->i_size =3D old_inode->i_size;
+	new_inode->i_blocks =3D old_inode->i_blocks;
+	new_inode->i_uid =3D old_inode->i_uid;
+	new_inode->i_gid =3D old_inode->i_gid;
+	new_inode->i_nlink =3D 1;
+
+	/* FIXME when we do arbitrary truncates */
+	old_inode->i_blocks =3D oei->i_file_acl ? old_inode->i_blksize / =
512 : 0;
+	old_inode->i_mtime =3D old_inode->i_ctime =3D CURRENT_TIME;
+
+	memcpy(nei->i_data, oei->i_data, sizeof(nei->i_data));
+	memset(oei->i_data, 0, sizeof(oei->i_data));
+
+	nei->i_disksize =3D oei->i_disksize;
+	nei->i_state |=3D EXT3_STATE_DELETE;
+	up_write(&oei->truncate_sem);
+
+	if (ext3_orphan_add(handle, new_inode) < 0)
+		goto out_journal;
+
+	if (ext3_orphan_del(handle, old_inode) < 0) {
+		ext3_orphan_del(handle, new_inode);
+		iput(new_inode);
+		goto out_journal;
+	}
+
+	ext3_journal_stop(handle, old_inode);
+
+	spin_lock(&sbi->s_delete_lock);
+	J_ASSERT(list_empty(&new_inode->i_devices));
+	list_add_tail(&new_inode->i_devices, &sbi->s_delete_list);
+	sbi->s_delete_blocks +=3D blocks;
+	sbi->s_delete_inodes++;
+	spin_unlock(&sbi->s_delete_lock);
+
+	ext3_debug("delete inode %lu (%lu blocks) by thread\n",
+		   new_inode->i_ino, blocks);
+
+	wake_up(&sbi->s_delete_thread_queue);
+	return;
+
+out_journal:
+	ext3_journal_stop(handle, old_inode);
+out_truncate:
+	ext3_truncate(old_inode);
+}
+#endif /* EXT3_DELETE_THREAD */
+
 /*
  * On success, We end up with an outstanding reference count against
  * iloc->bh.  This _must_ be cleaned up later.
Index: linux-2.4.29/fs/ext3/file.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/fs/ext3/file.c	2005-04-07 19:31:00.000000000 =
+0300
+++ linux-2.4.29/fs/ext3/file.c	2005-05-03 15:53:56.902907304 +0300
@@ -123,7 +123,11 @@
 };

 struct inode_operations ext3_file_inode_operations =3D {
+#ifdef EXT3_DELETE_THREAD
+	truncate:	ext3_truncate_thread,	/* BKL held */
+#else
 	truncate:	ext3_truncate,		/* BKL held */
+#endif
 	setattr:	ext3_setattr,		/* BKL held */
 	setxattr:	ext3_setxattr,		/* BKL held */
 	getxattr:	ext3_getxattr,		/* BKL held */
Index: linux-2.4.29/fs/ext3/namei.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/fs/ext3/namei.c	2005-05-03 15:53:33.044534328 =
+0300
+++ linux-2.4.29/fs/ext3/namei.c	2005-05-03 15:53:56.905906848 =
+0300
@@ -838,6 +838,40 @@
 	return retval;
 }

+#ifdef EXT3_DELETE_THREAD
+static int ext3_try_to_delay_deletion(struct inode *inode)
+{
+	struct ext3_sb_info *sbi =3D EXT3_SB(inode->i_sb);
+	struct ext3_inode_info *ei =3D EXT3_I(inode);
+	unsigned long blocks;
+
+	if (!test_opt(inode->i_sb, ASYNCDEL))
+		return 0;
+
+	/* We may want to delete the inode immediately and not defer it =
*/
+	blocks =3D inode->i_blocks >> (inode->i_blkbits - 9);
+	if (IS_SYNC(inode) || blocks <=3D EXT3_NDIR_BLOCKS)
+		return 0;
+
+	inode->i_nlink =3D 1;
+	atomic_inc(&inode->i_count);
+	ei->i_state |=3D EXT3_STATE_DELETE;
+
+	spin_lock(&sbi->s_delete_lock);
+	J_ASSERT(list_empty(&inode->i_devices));
+	list_add_tail(&inode->i_devices, &sbi->s_delete_list);
+	sbi->s_delete_blocks +=3D blocks;
+	sbi->s_delete_inodes++;
+	spin_unlock(&sbi->s_delete_lock);
+
+	wake_up(&sbi->s_delete_thread_queue);
+
+	return 0;
+}
+#else
+#define ext3_try_to_delay_deletion(inode) do {} while (0)
+#endif
+
 static int ext3_unlink(struct inode * dir, struct dentry *dentry)
 {
 	int retval;
@@ -878,8 +912,10 @@
 	dir->u.ext3_i.i_flags &=3D ~EXT3_INDEX_FL;
 	ext3_mark_inode_dirty(handle, dir);
 	inode->i_nlink--;
-	if (!inode->i_nlink)
+	if (!inode->i_nlink) {
+		ext3_try_to_delay_deletion(inode);
 		ext3_orphan_add(handle, inode);
+	}
 	inode->i_ctime =3D dir->i_ctime;
 	ext3_mark_inode_dirty(handle, inode);
 	retval =3D 0;
Index: linux-2.4.29/include/linux/ext3_fs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/include/linux/ext3_fs.h	2005-05-03 =
15:53:37.124914016 +0300
+++ linux-2.4.29/include/linux/ext3_fs.h	2005-05-03 =
15:53:56.907906544 +0300
@@ -188,6 +188,7 @@
  */
 #define EXT3_STATE_JDATA		0x00000001 /* journaled data =
exists */
 #define EXT3_STATE_NEW			0x00000002 /* inode is newly =
created */
+#define EXT3_STATE_DELETE		0x00000010 /* deferred delete =
inode */

 /*
  * ioctl commands
@@ -315,6 +316,7 @@
 #define EXT3_MOUNT_UPDATE_JOURNAL	0x1000	/* Update the journal =
format */
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs =
*/
 #define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user =
attributes */
+#define EXT3_MOUNT_ASYNCDEL		0x20000 /* Delayed deletion */

 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at =
once */
 #ifndef _LINUX_EXT2_FS_H
@@ -639,6 +641,9 @@
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
+#ifdef EXT3_DELETE_THREAD
+extern void ext3_truncate_thread(struct inode *inode);
+#endif
 extern void ext3_set_inode_flags(struct inode *);

 /* ioctl.c */
Index: linux-2.4.29/include/linux/ext3_fs_sb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.4.29.orig/include/linux/ext3_fs_sb.h	2005-05-03 =
15:53:33.048533720 +0300
+++ linux-2.4.29/include/linux/ext3_fs_sb.h	2005-05-03 =
15:53:56.909906240 +0300
@@ -29,6 +29,8 @@

 #define EXT3_MAX_GROUP_LOADED	8

+#define EXT3_DELETE_THREAD
+
 /*
  * third extended-fs super-block data in memory
  */
@@ -74,6 +76,14 @@
 	struct timer_list turn_ro_timer;	/* For turning read-only =
(crash simulation) */
 	wait_queue_head_t ro_wait_queue;	/* For people waiting =
for the fs to go read-only */
 #endif
+#ifdef EXT3_DELETE_THREAD
+	spinlock_t s_delete_lock;
+	struct list_head s_delete_list;
+	unsigned long s_delete_blocks;
+	unsigned long s_delete_inodes;
+	wait_queue_head_t s_delete_thread_queue;
+	wait_queue_head_t s_delete_waiter_queue;
+#endif
 };

 #endif	/* _LINUX_EXT3_FS_SB */


Cheers, Andreas


--Apple-Mail=_DD4ECBDD-6ECA-4ABD-A5A9-6EACD2E3F827
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+kQq4ACgkQcqXauRfM
H+CiUA/9H3ONZhG78AQBQEEaUqkA4Q1leBMCpaBGcnbupeGPJCbhpXBP1BgVwCNE
F6vjmW0rWs2WMVc5VEniyUi/hTv248Ka9mmb5v8ysOxqtyrV5YwsIJqFBGy/q1zh
hdyEYeqDQ7nwt1dvE5FLBb/sJyG5SVtILj9nmdK1oXyPAr5xAklJ1vZLP5c+L6F3
k1p2MdMoNeJkFZK2+djva+8EdobulH0KW7LAzrja0MaSGIMYgz1bjmih/W+P3w7n
pf8+JCpmDmrbdl2gBU5xOlOzDMb+3a9fXOzAHOHzthbdadAzWKN46TolxeXBSDoW
MWUkAL10cOALw7QZTdIHnEyP3Qo1va9cMPWG+7nXDs5JW7q74syKqXfyHC6y+TfT
W3IYQ2RN5QSFDOl7s5sMHl6fQPXQFX98D7fhk+rgm6i08n74NCfRfmWhFTBi7FnN
tX0b/lSdXWihuonPCq1hF40XIsuzb1QXP+0dlstOSFHhyUUhPHNOXWDi9AL9PJgi
yDbP2o0Jg3XQTA1DnHUhWMEaSSCytejuxVS8RK8yX14HNfzEeLELzK+tu1x8lYFl
YW+yAr1bsT/DPaGUC7RAalyT0NpsoiXvCWxZzf25vNxWCvwFMEa0rwnyN2Z2dwJj
Efd0H2wpzvwtzjOqxcqXyZ2wm5dvXbIfJwGP+n6DGtI3VE39WBQ=
=qzlI
-----END PGP SIGNATURE-----

--Apple-Mail=_DD4ECBDD-6ECA-4ABD-A5A9-6EACD2E3F827--
