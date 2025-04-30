Return-Path: <linux-ext4+bounces-7565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8368AA424D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 07:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80AC7B9422
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 05:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C901E2602;
	Wed, 30 Apr 2025 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnuaHNOh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC01DE891
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 05:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990463; cv=none; b=U/Wnqs9/AqCfs29KiIWZe4OGHpHq7+qbbHW3LMVaH4KRDViCH+oLRe6v6KUynX4cSNlQRcb9yjuFXfApubQuAZmWCjVqfI8tInukqmzLrLJ3z4xvJIc/1tzZw64I5cAfWtK4WCxsqLZnZIi3Z8xnJDdn7rSd3XWvVtJ+t/uEVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990463; c=relaxed/simple;
	bh=PNjaM+eHDk1Wva0FZTIxAQ3YuvAy1g+AKPUPpV/TH5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROXVNbnziXNQmmGnfkhlLapN7NGvHb4enZzztw9JyVpyF6E/I7TguiIOv+oQTmy+TiHrWoKoY6wdVUxvTq2oATQSs6G4dqXfjnYBwlsM+6jnduLiiDJHzTU7H/IEfTO5Or6Qf8hddxNscSSH47dtUuFfV+Ga7MzNG/JMAUWJt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnuaHNOh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7396f13b750so7587037b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 22:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745990460; x=1746595260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5gulvlWKMDMzsy27UuKySsIAXWehKxj9HHC6zD9NT4=;
        b=fnuaHNOhEH/luiQEx5bUbd4GMos0lzbYSDLn0dk8/tChpYAUbEebhDG6CKJbHGY9JU
         HSqMftgDNbNvvbPn3G+J33CPGeDnUQ6Z+ZsnCONsj3WDSZ5qmNVV7kitidYgnt+3otvz
         v/Wv3t9t8fTRrIlweJmQOuL94cgQevI4q41B7uMiBUhvMC6OoCxbnGRNoLhDxmehHOEq
         puvmseUGkcllBSAweLP1DOQN9ZgMgkaTMDE9CeIlfdL8XNHvrazSk3ghnCOVkMVdHZv/
         jO8om5kj7/UvcB4IL7EL8PJRl/0gYjEt8UV8+FBXiHr4flksE3bd8X9RIH2OI1awyRIj
         TwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745990460; x=1746595260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5gulvlWKMDMzsy27UuKySsIAXWehKxj9HHC6zD9NT4=;
        b=s5oMlmHqsJy/uU0cNzUHr1w+006nRlKVOS/6H9YhhPlDy7lJJbbBrDy8i01oqf65hq
         EXR+x0BtUGJr/KK7CAor6HAP5x6xRzvUw3fy1yTRzvB6yTA2pJcEV+wHiIDVuvp3Mu2E
         XiwO5riBisr0I/XjhaGdwkWGzLfTpbCrQPR+0OsWrSBNaRXvL9hP5Y82IArlvyEC+EXg
         n6cJaWIk7ILmcsmn7dStGmgDLhwWuBtDT3pb3nLIs4nOnue2YNyPg31PApBJ3KUh/LRU
         KW4UhFLBji+mCJ5TuioXx8LLE0dm8jGmO3bYRuxqzVnDl7jG1RkSEdbcaogLNHRXHKTV
         x8hg==
X-Forwarded-Encrypted: i=1; AJvYcCUi3s9GHsiyDL9K5vqB6RdKpFEu26lQOUckRdevI3JPrq80aOh+mOMDh3oDv4UCyMIiGjzJVpoo5rVq@vger.kernel.org
X-Gm-Message-State: AOJu0YzF45Ghq9vg0ndTo0MsUZqrR3Zwgq4EMhHE7Vsf9LcLDI9XfeJY
	2jCz5bXO/pRsLIH0kT0WgkORlyTumnettJtmlM3tgdJ1cMQR93aA
X-Gm-Gg: ASbGncveHxpURZTTvioCSrGh/xYp32JeLWuN5uMN2FmypWA4TmLjL/D0Qfri0fyGpAN
	MUvNK8UTiV60UEnUZbrEeZBfcX6USVzBPPg/enmSz1UbGRM3Tz32BCtmd62eLcTrxzpXEsTLV8X
	whYVqbPaUhohXv3oJbh7jscLjMSZdg3OqNwVxDTxrG5heOKkvvLPcdWTu0u36QBR1kJyf4yBVEi
	NFjI39X0LIYJF5luIpvsS964NmkY+IWYj0rDT9x1Nl48Qdn41WX8pV7We8zIDsz6gIaUDtmSKS1
	U4ZkZ6APjwQf7Vy5s7ScRcM6XTpFuGcaKlo6J/M8Fei5c4JIygX0feY/gg==
X-Google-Smtp-Source: AGHT+IGFmxnlulXzFWNkMPUKQTqY+TNHTf2o1oEa8uzxyEtCwrFqzSyiQ+L1IZrQX8OO5uB1fzLbVA==
X-Received: by 2002:a05:6a21:78c:b0:1f5:8748:76b0 with SMTP id adf61e73a8af0-20a89124a9bmr2340730637.29.1745990460352;
        Tue, 29 Apr 2025 22:21:00 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a3100dsm735388b3a.90.2025.04.29.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:20:59 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-ext4@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 1/2] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Wed, 30 Apr 2025 10:50:41 +0530
Message-ID: <4409e24e0885a0aed17f6a34a0e719e8c0955b14.1745987268.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745987268.git.ritesh.list@gmail.com>
References: <cover.1745987268.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EXT4 supports bigalloc feature which allows the FS to work in size of
clusters (group of blocks) rather than individual blocks. This patch
adds atomic write support for bigalloc so that systems with bs = ps can
also create FS using -
    mkfs.ext4 -F -O bigalloc -b 4096 -C 16384 <dev>

With bigalloc ext4 can support multi-fsblock atomic writes. We will have to
adjust ext4's atomic write unit max value to cluster size. This can then support
atomic write of size anywhere between [blocksize, clustersize].

We first query the underlying region of the requested range by calling
ext4_map_blocks() call. Here are the various cases which we then handle
for block allocation depending upon the underlying mapping type:
1. If the underlying region for the entire requested range is a mapped extent,
   then we don't call ext4_map_blocks() to allocate anything. We don't need to
   even start the jbd2 txn in this case.
2. For an append write case, we create a mapped extent.
3. If the underlying region is entirely a hole, then we create an unwritten
   extent for the requested range.
4. If the underlying region is a large unwritten extent, then we split the
   extent into 2 unwritten extent of required size.
5. If the underlying region has any type of mixed mapping, then we call
   ext4_map_blocks() in a loop to zero out the unwritten and the hole regions
   within the requested range. This then provide a single mapped extent type
   mapping for the requested range.

Note: We invoke ext4_map_blocks() in a loop with the EXT4_GET_BLOCKS_ZERO
flag only when the underlying extent mapping of the requested range is
not entirely a hole, an unwritten extent, or a fully mapped extent. That
is, if the underlying region contains a mix of hole(s), unwritten
extent(s), and mapped extent(s), we use this loop to ensure that all the
short mappings are zeroed out. This guarantees that the entire requested
range becomes a single, uniformly mapped extent. It is ok to do so
because we know this is being done on a bigalloc enabled filesystem
where the block bitmap represents the entire cluster unit.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |   3 +
 fs/ext4/extents.c |  64 +++++++++++++++++++++
 fs/ext4/file.c    |   7 ++-
 fs/ext4/inode.c   | 142 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ext4/super.c   |   8 ++-
 5 files changed, 213 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..589d51389327 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3039,6 +3039,7 @@ extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_meta_trans_blocks(struct inode *, int nrblocks, int extents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
@@ -3710,6 +3711,8 @@ extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
 			  loff_t len);
 extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 					  loff_t offset, ssize_t len);
+extern int ext4_convert_unwritten_extents_atomic(handle_t *handle,
+			struct inode *inode, loff_t offset, ssize_t len);
 extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
 					     ext4_io_end_t *io_end);
 extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..0e00b78b521c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4780,6 +4780,70 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	return ret;
 }

+int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
+					  loff_t offset, ssize_t len)
+{
+	unsigned int max_blocks;
+	int ret = 0, ret2 = 0, ret3 = 0;
+	struct ext4_map_blocks map;
+	unsigned int blkbits = inode->i_blkbits;
+	unsigned int credits = 0;
+	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT;
+
+	map.m_lblk = offset >> blkbits;
+	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
+
+	if (!handle) {
+		/*
+		 * TODO: Should we query whether the extent is split across two
+		 * leaf blocks. Or shall we just consider the worst case credits
+		 * of inserting 2 extents into extent tree
+		 */
+		credits = ext4_meta_trans_blocks(inode, max_blocks, 2);
+	}
+
+	if (credits) {
+		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
+					    credits);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			return ret;
+		}
+	}
+
+	while (ret >= 0 && ret < max_blocks) {
+		map.m_lblk += ret;
+		map.m_len = (max_blocks -= ret);
+		ret = ext4_map_blocks(handle, inode, &map, flags);
+		if (ret != max_blocks)
+			ext4_warning(inode->i_sb,
+				     "inode #%lu: block %u: len %u: "
+				     "split block mapping found for atomic write,"
+				     "ret = %d",
+				     inode->i_ino, map.m_lblk,
+				     map.m_len, ret);
+		if (ret <= 0)
+			break;
+	}
+
+	ret2 = ext4_mark_inode_dirty(handle, inode);
+
+	if (credits) {
+		ret3 = ext4_journal_stop(handle);
+		if (unlikely(ret3))
+			ret2 = ret3;
+	}
+
+	if (ret <= 0 || ret2)
+		ext4_warning(inode->i_sb,
+			     "inode #%lu: block %u: len %u: "
+			     "returned %d or %d",
+			     inode->i_ino, map.m_lblk,
+			     map.m_len, ret, ret2);
+
+	return ret > 0 ? ret2 : ret;
+}
+
 /*
  * This function convert a range of blocks to written extents
  * The caller of this function will pass the start offset and the size.
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index beb078ee4811..959328072c15 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -377,7 +377,12 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(iocb->ki_filp);

-	if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
+
+	if (!error && size && (flags & IOMAP_DIO_UNWRITTEN) &&
+			(iocb->ki_flags & IOCB_ATOMIC))
+		error = ext4_convert_unwritten_extents_atomic(NULL, inode, pos,
+							      size);
+	else if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
 		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
 	if (error)
 		return error;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..27235a76c2d1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -142,9 +142,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }

-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
-				  int pextents);
-
 /*
  * Test whether an inode is a fast symlink.
  * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
@@ -3340,6 +3337,91 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	}
 }

+static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
+			struct inode *inode, struct ext4_map_blocks *map)
+{
+	ext4_lblk_t m_lblk = map->m_lblk;
+	unsigned int m_len = map->m_len;
+	unsigned int mapped_len = 0, m_flags = 0;
+	int ret = 0;
+
+	/*
+	 * This is a slow path in case of mixed mapping. We use
+	 * EXTT4_GET_BLOCKS_CREATE_ZERO flag here to make sure we get a single
+	 * contiguous mapping. This will ensure any unwritten or hole regions
+	 * within the requested range is zeroed out and we return a single
+	 * contiguous mapped extent.
+	 */
+	m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
+
+	do {
+		ret = ext4_map_blocks(handle, inode, map, m_flags);
+		if (ret < 0)
+			goto out;
+		mapped_len += map->m_len;
+		map->m_lblk += map->m_len;
+		map->m_len = m_len - mapped_len;
+	} while (mapped_len < m_len);
+
+	/*
+	 * We might have done some work in above loop, so we need to query the
+	 * start of the physical extent, based on the origin m_lblk and m_len.
+	 * Let's also ensure we were able to allocate the required range for
+	 * mixed mapping case.
+	 */
+	map->m_lblk = m_lblk;
+	map->m_len = m_len;
+
+	ret = ext4_map_blocks(handle, inode, map, 0);
+	if (ret != m_len) {
+		ext4_warning_inode(inode, "allocation failed for atomic write request pos:%u, len:%u\n",
+			m_lblk, m_len);
+		ret = -EINVAL;
+	}
+out:
+	return ret;
+
+}
+
+/*
+ * ext4_map_blocks_atomic: Helper routine to ensure the entire requested mapping
+ * [map.m_lblk, map.m_len] is one single contiguous extent with no mixed
+ * mappings. For the normal case we re-use the mappings passed to us by m_flags.
+ *
+ * We call EXT4_GET_BLOCKS_ZERO (in the slow path) only when the underlying
+ * physical extent for the requested range does not have a single mapping type
+ * (Hole, Mapped, or Unwritten) throughout. In that case we will loop over the
+ * requested range to allocate and zero out the unwritten / holes in between, to
+ * get a single mapped extent from [m_lblk, m_len]. This case is mostly
+ * non-performance critical path, so it should be ok to loop using
+ * ext4_map_blocks() with appropriate flags to allocate & zero the underlying
+ * short holes/unwritten extents within the requested range.
+ */
+static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
+				struct ext4_map_blocks *map, int m_flags)
+{
+	ext4_lblk_t m_lblk = map->m_lblk;
+	unsigned int m_len = map->m_len;
+	int ret = 0;
+
+	WARN_ON_ONCE(m_len > 1 && !ext4_has_feature_bigalloc(inode->i_sb));
+
+	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (ret < 0 || ret == m_len)
+		goto out;
+	/*
+	 * This is a mixed mapping case where we were not able to allocate
+	 * a single contiguous extent. In that case let's reset requested
+	 * mapping and call the slow path.
+	 */
+	map->m_lblk = m_lblk;
+	map->m_len = m_len;
+
+	return ext4_map_blocks_atomic_write_slow(handle, inode, map);
+out:
+	return ret;
+}
+
 static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 			    unsigned int flags)
 {
@@ -3353,7 +3435,24 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	 */
 	if (map->m_len > DIO_MAX_BLOCKS)
 		map->m_len = DIO_MAX_BLOCKS;
-	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+
+	if (flags & IOMAP_ATOMIC) {
+		unsigned int orig_mlen = map->m_len;
+
+		ret = ext4_map_blocks(NULL, inode, map, 0);
+		if (ret < 0)
+			return ret;
+		if (map->m_len < orig_mlen) {
+			map->m_len = orig_mlen;
+			dio_credits = ext4_meta_trans_blocks(inode, orig_mlen,
+							     map->m_len / 2);
+		} else {
+			dio_credits = ext4_chunk_trans_blocks(inode,
+							      map->m_len);
+		}
+	} else {
+		dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
+	}

 retry:
 	/*
@@ -3384,7 +3483,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
 	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;

-	ret = ext4_map_blocks(handle, inode, map, m_flags);
+	if (flags & IOMAP_ATOMIC)
+		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags);
+	else
+		ret = ext4_map_blocks(handle, inode, map, m_flags);

 	/*
 	 * We cannot fill holes in indirect tree based inodes as that could
@@ -3408,6 +3510,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	int ret;
 	struct ext4_map_blocks map;
 	u8 blkbits = inode->i_blkbits;
+	unsigned int m_len_orig;

 	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
 		return -EINVAL;
@@ -3421,6 +3524,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_lblk = offset >> blkbits;
 	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
 			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
+	m_len_orig = map.m_len;

 	if (flags & IOMAP_WRITE) {
 		/*
@@ -3431,11 +3535,23 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		 */
 		if (offset + length <= i_size_read(inode)) {
 			ret = ext4_map_blocks(NULL, inode, &map, 0);
-			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
-				goto out;
+			/*
+			 * For atomic writes the entire requested length should
+			 * be mapped.
+			 */
+			if (map.m_flags & EXT4_MAP_MAPPED) {
+				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
+				   (flags & IOMAP_ATOMIC && ret >= m_len_orig))
+					goto out;
+			}
+			map.m_len = m_len_orig;
 		}
 		ret = ext4_iomap_alloc(inode, &map, flags);
 	} else {
+		/*
+		 * This can be called for overwrites path from
+		 * ext4_iomap_overwrite_begin().
+		 */
 		ret = ext4_map_blocks(NULL, inode, &map, 0);
 	}

@@ -3449,6 +3565,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	 */
 	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);

+	/*
+	 * Before returning to iomap, let's ensure the allocated mapping
+	 * covers the entire requested length for atomic writes.
+	 */
+	if (flags & IOMAP_ATOMIC) {
+		if (map.m_len < (length >> blkbits)) {
+			WARN_ON(1);
+			return -EINVAL;
+		}
+	}
 	ext4_set_iomap(inode, iomap, &map, offset, length, flags);

 	return 0;
@@ -5773,7 +5899,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
  *
  * Also account for superblock, inode, quota and xattr blocks
  */
-static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
+int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents)
 {
 	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..5c319d08446f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4442,12 +4442,13 @@ static int ext4_handle_clustersize(struct super_block *sb)
 /*
  * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
  * @sb: super block
- * TODO: Later add support for bigalloc
  */
 static void ext4_atomic_write_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *bdev = sb->s_bdev;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	unsigned int clustersize = sb->s_blocksize;

 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4455,9 +4456,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
 	if (!ext4_has_feature_extents(sb))
 		return;

+	if (ext4_has_feature_bigalloc(sb))
+		clustersize = 1U << (sbi->s_cluster_bits + blkbits);
+
 	sbi->s_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->s_awu_max = min(sb->s_blocksize,
+	sbi->s_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->s_awu_min && sbi->s_awu_max &&
 	    sbi->s_awu_min <= sbi->s_awu_max) {
--
2.49.0


