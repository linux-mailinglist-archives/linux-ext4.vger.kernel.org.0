Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371B9171068
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2020 06:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgB0Fcp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 00:32:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:20119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgB0Fco (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 27 Feb 2020 00:32:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:43 -0800
X-IronPort-AV: E=Sophos;i="5.70,490,1574150400"; 
   d="scan'208";a="256595149"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 21:32:42 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V5 06/12] fs: Add locking for a dynamic address space operations state
Date:   Wed, 26 Feb 2020 21:24:36 -0800
Message-Id: <20200227052442.22524-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200227052442.22524-1-ira.weiny@intel.com>
References: <20200227052442.22524-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

DAX requires special address space operations (aops).  Changing DAX
state therefore requires changing those aops.

However, many functions require aops to remain consistent through a deep
call stack.

Define a vfs level inode rwsem to protect aops throughout call stacks
which require them.

Finally, define calls to be used in subsequent patches when aops usage
needs to be quiesced by the file system.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	Fix 0-day build issue.

Changes from V3:
	Convert from global to a per-inode rwsem
		Remove pre-optimization
	Remove static branch stuff
	Change function names from inode_dax_state_* to inode_aops_*
		I kept 'inode' as the synchronization is at the inode
		level now (probably where it belongs)...

		and I still prefer *_[down|up]_[read|write] as those
		names better reflect the use and interaction between
		users (readers) and writers better.  'XX_start_aop()'
		would have to be matched with something like
		'XX_wait_for_aop_user()' and 'XX_release_aop_users()' or
		something which does not make sense on the 'writer'
		side.

Changes from V2

	Rebase on linux-next-08-02-2020

	Fix locking order
	Change all references from mode to state where appropriate
	add CONFIG_FS_DAX requirement for state change
	Use a static branch to enable locking only when a dax capable
		device has been seen.

	Move the lock to a global vfs lock

		this does a few things
			1) preps us better for ext4 support
			2) removes funky callbacks from inode ops
			3) remove complexity from XFS and probably from
			   ext4 later

		We can do this because
			1) the locking order is required to be at the
			   highest level anyway, so why complicate xfs
			2) We had to move the sem to the super_block
			   because it is too heavy for the inode.
			3) After internal discussions with Dan we
			   decided that this would be easier, just as
			   performant, and with slightly less overhead
			   than in the VFS SB.

		We also change the functions names to up/down;
		read/write as appropriate.  Previous names were over
		simplified.

	Update comments and documentation

squash: add locking

squash:...
---
 Documentation/filesystems/vfs.rst | 16 ++++++++
 fs/attr.c                         |  1 +
 fs/inode.c                        | 15 ++++++--
 fs/iomap/buffered-io.c            |  1 +
 fs/open.c                         |  4 ++
 fs/stat.c                         |  2 +
 fs/xfs/xfs_icache.c               |  1 +
 include/linux/fs.h                | 64 ++++++++++++++++++++++++++++++-
 mm/fadvise.c                      |  7 +++-
 mm/filemap.c                      |  4 ++
 mm/huge_memory.c                  |  1 +
 mm/khugepaged.c                   |  2 +
 mm/util.c                         |  9 ++++-
 13 files changed, 119 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..4a10a232f8e2 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -934,6 +934,22 @@ cache in your filesystem.  The following members are defined:
 	Called during swapoff on files where swap_activate was
 	successful.
 
+Changing DAX 'state' dynamically
+----------------------------------
+
+Some file systems which support DAX want to be able to change the DAX state
+dyanically.  To switch the state safely we lock the inode state in all "normal"
+file system operations and restrict state changes to those operations.  The
+specific rules are.
+
+        1) the direct_IO address_space_operation must be supported in all
+           potential a_ops vectors for any state suported by the inode.
+
+        3) DAX state changes shall not be allowed while the file is mmap'ed
+        4) For non-mmaped operations the VFS layer must take the read lock for any
+           use of IS_DAX()
+        5) Filesystems take the write lock when changing DAX states.
+
 
 The File Object
 ===============
diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..9b15f73d1079 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -332,6 +332,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (error)
 		return error;
 
+	/* DAX read state should already be held here */
 	if (inode->i_op->setattr)
 		error = inode->i_op->setattr(dentry, attr);
 	else
diff --git a/fs/inode.c b/fs/inode.c
index 7d57068b6b7a..6e4f1cc872f2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -200,6 +200,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 #endif
 	inode->i_flctx = NULL;
 	this_cpu_inc(nr_inodes);
+	init_rwsem(&inode->i_aops_sem);
 
 	return 0;
 out:
@@ -1616,11 +1617,19 @@ EXPORT_SYMBOL(iput);
  */
 int bmap(struct inode *inode, sector_t *block)
 {
-	if (!inode->i_mapping->a_ops->bmap)
-		return -EINVAL;
+	int ret = 0;
+
+	inode_aops_down_read(inode);
+	if (!inode->i_mapping->a_ops->bmap) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
-	return 0;
+
+err:
+	inode_aops_up_read(inode);
+	return ret;
 }
 EXPORT_SYMBOL(bmap);
 #endif
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7c84c4c027c4..e313a34d5fa6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -999,6 +999,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		offset = offset_in_page(pos);
 		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
 
+		/* DAX state read should already be held here */
 		if (IS_DAX(inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
diff --git a/fs/open.c b/fs/open.c
index 0788b3715731..3abf0bfac462 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -59,10 +59,12 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	if (ret)
 		newattrs.ia_valid |= ret | ATTR_FORCE;
 
+	inode_aops_down_read(dentry->d_inode);
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+	inode_aops_up_read(dentry->d_inode);
 	return ret;
 }
 
@@ -306,7 +308,9 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	file_start_write(file);
+	inode_aops_down_read(inode);
 	ret = file->f_op->fallocate(file, mode, offset, len);
+	inode_aops_up_read(inode);
 
 	/*
 	 * Create inotify and fanotify events.
diff --git a/fs/stat.c b/fs/stat.c
index 894699c74dde..274b3ccc82b1 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -79,8 +79,10 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
+	inode_aops_down_read(inode);
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
+	inode_aops_up_read(inode);
 
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 836a1f09be03..3e83a97dc047 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -420,6 +420,7 @@ xfs_iget_cache_hit(
 		rcu_read_unlock();
 
 		ASSERT(!rwsem_is_locked(&inode->i_rwsem));
+		ASSERT(!rwsem_is_locked(&inode->i_aops_sem));
 		error = xfs_reinit_inode(mp, inode);
 		if (error) {
 			bool wake;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 63d1e533a07d..22cc1aa980f5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/percpu-rwsem.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -359,6 +360,11 @@ typedef struct {
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
+/**
+ * NOTE: DO NOT define new functions in address_space_operations without first
+ * considering how dynamic DAX states are to be supported.  See the
+ * inode_aops_*_read() functions
+ */
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
@@ -735,6 +741,7 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
+	struct rw_semaphore	i_aops_sem;
 } __randomize_layout;
 
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
@@ -1817,6 +1824,11 @@ struct block_device_operations;
 
 struct iov_iter;
 
+/**
+ * NOTE: DO NOT define new functions in file_operations without first
+ * considering how dynamic address_space operations are to be supported.  See
+ * the inode_aops_*_read() functions in this file.
+ */
 struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
@@ -1889,16 +1901,64 @@ struct inode_operations {
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
+#if defined(CONFIG_FS_DAX)
+/*
+ * Filesystems wishing to support dynamic DAX states must do the following.
+ *
+ * 1) the direct_IO address_space_operation must be supported in all potential
+ *    a_ops vectors for any state suported by the inode.  This is because the
+ *    direct_IO function is used as a flag long before the function is called.
+
+ * 3) DAX state changes shall not be allowed while the file is mmap'ed
+ * 4) For non-mmaped operations the VFS layer must take the read lock for any
+ *    use of IS_DAX()
+ * 5) Filesystems take the write lock when changing DAX states.
+ */
+static inline void inode_aops_down_read(struct inode *inode)
+{
+	down_read(&inode->i_aops_sem);
+}
+static inline void inode_aops_up_read(struct inode *inode)
+{
+	up_read(&inode->i_aops_sem);
+}
+static inline void inode_aops_down_write(struct inode *inode)
+{
+	down_write(&inode->i_aops_sem);
+}
+static inline void inode_aops_up_write(struct inode *inode)
+{
+	up_write(&inode->i_aops_sem);
+}
+#else /* !CONFIG_FS_DAX */
+#define inode_aops_down_read(inode) do { (void)(inode); } while (0)
+#define inode_aops_up_read(inode) do { (void)(inode); } while (0)
+#define inode_aops_down_write(inode) do { (void)(inode); } while (0)
+#define inode_aops_up_write(inode) do { (void)(inode); } while (0)
+#endif /* CONFIG_FS_DAX */
+
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
 				     struct iov_iter *iter)
 {
-	return file->f_op->read_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	inode_aops_down_read(inode);
+	ret = file->f_op->read_iter(kio, iter);
+	inode_aops_up_read(inode);
+	return ret;
 }
 
 static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
 				      struct iov_iter *iter)
 {
-	return file->f_op->write_iter(kio, iter);
+	struct inode		*inode = file_inode(kio->ki_filp);
+	ssize_t ret;
+
+	inode_aops_down_read(inode);
+	ret = file->f_op->write_iter(kio, iter);
+	inode_aops_up_read(inode);
+	return ret;
 }
 
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 4f17c83db575..6a30febb11e0 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -48,6 +48,8 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	bdi = inode_to_bdi(mapping->host);
 
 	if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
+		int ret = 0;
+
 		switch (advice) {
 		case POSIX_FADV_NORMAL:
 		case POSIX_FADV_RANDOM:
@@ -58,9 +60,10 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			/* no bad return value, but ignore advice */
 			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 		}
-		return 0;
+
+		return ret;
 	}
 
 	/*
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..3a7863ba51b9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2293,6 +2293,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		 * and return.  Otherwise fallthrough to buffered io for
 		 * the rest of the read.  Buffered reads will not work for
 		 * DAX files, so don't bother trying.
+		 *
+		 * IS_DAX is protected under ->read_iter lock
 		 */
 		if (retval < 0 || !count || iocb->ki_pos >= size ||
 		    IS_DAX(inode))
@@ -3377,6 +3379,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * holes, for example.  For DAX files, a buffered write will
 		 * not succeed (even if it did, DAX does not handle dirty
 		 * page-cache pages correctly).
+		 *
+		 * IS_DAX is protected under ->write_iter lock
 		 */
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..3d05bd10d83e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -572,6 +572,7 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
+	/* Should not need locking here because mmap is not allowed */
 	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
 		goto out;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..f048178e2b93 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1592,9 +1592,11 @@ static void collapse_file(struct mm_struct *mm,
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
 				xas_unlock_irq(&xas);
+				inode_aops_down_read(file->f_inode);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  PAGE_SIZE);
+				inode_aops_up_read(file->f_inode);
 				/* drain pagevecs to help isolate_lru_page() */
 				lru_add_drain();
 				page = find_lock_page(mapping, index);
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..a4fb0670137d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -501,11 +501,18 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 
 	ret = security_mmap_file(file, prot, flag);
 	if (!ret) {
-		if (down_write_killable(&mm->mmap_sem))
+		if (file)
+			inode_aops_down_read(file_inode(file));
+		if (down_write_killable(&mm->mmap_sem)) {
+			if (file)
+				inode_aops_up_read(file_inode(file));
 			return -EINTR;
+		}
 		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
 				    &populate, &uf);
 		up_write(&mm->mmap_sem);
+		if (file)
+			inode_aops_up_read(file_inode(file));
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
 			mm_populate(ret, populate);
-- 
2.21.0

