Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B37177BD
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 09:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjEaHU1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjEaHUZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 03:20:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0D122;
        Wed, 31 May 2023 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rJDdDhTRqJ0hb0KJKHGdzKkpTnId05huPY6N7LjcMHE=; b=caV75RH9GjbjbIvfo/jDfAInhX
        zYGyafMyiy8fIUXngpb4b7orGLjJ/3uUzi842pRK0mb3Ij62dCApYSRvbMvy7XBq6shE0uByzA0Q9
        g63D0B1dmceEeU5OqSgve1SvjemzExqcYyaL0HLEbIWLRSdVrii6oDODdkckMbeiQGai2P+iNUlxD
        SS4dr1cJy4Srcj92O4sdjP1JeF+wxOXxBcusFwd5KqU4OIclGHUTYYTHWhxqRixAA9SBKxzBRMuzq
        lBELI9gho7DL1fRBStQKyGkMBWG4s68/52SIcwhPTQrWl9kwhUb9PbEngS5hZjg/AA+/fbnqNsTK7
        gogLC8TQ==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4G7w-00GPhO-0L;
        Wed, 31 May 2023 07:20:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/8] backing_dev: remove current->backing_dev_info
Date:   Wed, 31 May 2023 09:19:59 +0200
Message-Id: <20230531072006.476386-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531072006.476386-1-hch@lst.de>
References: <20230531072006.476386-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The last user of current->backing_dev_info disappeared in commit
b9b1335e6403 ("remove bdi_congested() and wb_congested() and related
functions").  Remove the field and all assignments to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/file.c       | 6 +-----
 fs/ceph/file.c        | 4 ----
 fs/ext4/file.c        | 2 --
 fs/f2fs/file.c        | 2 --
 fs/fuse/file.c        | 4 ----
 fs/gfs2/file.c        | 2 --
 fs/nfs/file.c         | 5 +----
 fs/ntfs/file.c        | 2 --
 fs/ntfs3/file.c       | 3 ---
 fs/xfs/xfs_file.c     | 4 ----
 include/linux/sched.h | 3 ---
 mm/filemap.c          | 3 ---
 12 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f649647392e0e4..ecd43ab66fa6c7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1145,7 +1145,6 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	    !(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)))
 		return -EAGAIN;
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	ret = file_remove_privs(file);
 	if (ret)
 		return ret;
@@ -1165,10 +1164,8 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
 
 		ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
-		if (ret) {
-			current->backing_dev_info = NULL;
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
@@ -1689,7 +1686,6 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	if (sync)
 		atomic_dec(&inode->sync_writers);
 
-	current->backing_dev_info = NULL;
 	return num_written;
 }
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f4d8bf7dec88a8..c8ef72f723badd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1791,9 +1791,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	else
 		ceph_start_io_write(inode);
 
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
-
 	if (iocb->ki_flags & IOCB_APPEND) {
 		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
 		if (err < 0)
@@ -1940,7 +1937,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ceph_end_io_write(inode);
 out_unlocked:
 	ceph_free_cap_flush(prealloc_cf);
-	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d101b3b0c7dad8..bc430270c23c19 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -285,9 +285,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 	if (ret <= 0)
 		goto out;
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	ret = generic_perform_write(iocb, from);
-	current->backing_dev_info = NULL;
 
 out:
 	inode_unlock(inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ac53d2627d20d..4f423d367a44b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4517,9 +4517,7 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	ret = generic_perform_write(iocb, from);
-	current->backing_dev_info = NULL;
 
 	if (ret > 0) {
 		iocb->ki_pos += ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e05e..97d435874b14aa 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1362,9 +1362,6 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 writethrough:
 	inode_lock(inode);
 
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
-
 	err = generic_write_checks(iocb, from);
 	if (err <= 0)
 		goto out;
@@ -1409,7 +1406,6 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			iocb->ki_pos += written;
 	}
 out:
-	current->backing_dev_info = NULL;
 	inode_unlock(inode);
 	if (written > 0)
 		written = generic_write_sync(iocb, written);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 300844f50dcd28..904a0d6ac1a1a9 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1041,11 +1041,9 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb,
 			goto out_unlock;
 	}
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	pagefault_disable();
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 	pagefault_enable();
-	current->backing_dev_info = NULL;
 	if (ret > 0) {
 		iocb->ki_pos += ret;
 		written += ret;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f0edf5a36237d1..665ce3fc62eaf4 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -648,11 +648,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
-	if (result > 0) {
-		current->backing_dev_info = inode_to_bdi(inode);
+	if (result > 0)
 		result = generic_perform_write(iocb, from);
-		current->backing_dev_info = NULL;
-	}
 	nfs_end_io_write(inode);
 	if (result <= 0)
 		goto out;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index c481b14e4fd989..e296f804a9c442 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1911,11 +1911,9 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	inode_lock(vi);
 	/* We can write back this queue in page reclaim. */
-	current->backing_dev_info = inode_to_bdi(vi);
 	err = ntfs_prepare_file_for_write(iocb, from);
 	if (iov_iter_count(from) && !err)
 		written = ntfs_perform_write(file, from, iocb->ki_pos);
-	current->backing_dev_info = NULL;
 	inode_unlock(vi);
 	iocb->ki_pos += written;
 	if (likely(written > 0))
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 9a3d55c367d920..86d16a2c8339ca 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -820,7 +820,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!pages)
 		return -ENOMEM;
 
-	current->backing_dev_info = inode_to_bdi(inode);
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -993,8 +992,6 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 	kfree(pages);
 
-	current->backing_dev_info = NULL;
-
 	if (err < 0)
 		return err;
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index aede746541f8ae..431c3fd0e2b598 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -717,9 +717,6 @@ xfs_file_buffered_write(
 	if (ret)
 		goto out;
 
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
-
 	trace_xfs_file_buffered_write(iocb, from);
 	ret = iomap_file_buffered_write(iocb, from,
 			&xfs_buffered_write_iomap_ops);
@@ -753,7 +750,6 @@ xfs_file_buffered_write(
 		goto write_retry;
 	}
 
-	current->backing_dev_info = NULL;
 out:
 	if (iolock)
 		xfs_iunlock(ip, iolock);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f4d..54780571fe9a07 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -41,7 +41,6 @@
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
-struct backing_dev_info;
 struct bio_list;
 struct blk_plug;
 struct bpf_local_storage;
@@ -1186,8 +1185,6 @@ struct task_struct {
 	/* VM state: */
 	struct reclaim_state		*reclaim_state;
 
-	struct backing_dev_info		*backing_dev_info;
-
 	struct io_context		*io_context;
 
 #ifdef CONFIG_COMPACTION
diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e58..33b54660ad2b39 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3991,8 +3991,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t		err;
 	ssize_t		status;
 
-	/* We can write back this queue in page reclaim */
-	current->backing_dev_info = inode_to_bdi(inode);
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -4053,7 +4051,6 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			iocb->ki_pos += written;
 	}
 out:
-	current->backing_dev_info = NULL;
 	return written ? written : err;
 }
 EXPORT_SYMBOL(__generic_file_write_iter);
-- 
2.39.2

