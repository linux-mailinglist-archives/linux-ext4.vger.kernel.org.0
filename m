Return-Path: <linux-ext4+bounces-7566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B78AA424B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 07:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB09C5464
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D381E47CA;
	Wed, 30 Apr 2025 05:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYQcG++B"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAB1E2853
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990466; cv=none; b=Onf4SSLs2wsYNKwkXTTorj3ic5436zX8B2z3Wl9r/QJpM76SfT05pBN1NWWVulJXwR0wR9IlFEog6O3K7Rd1Zv7vHV+qe9KNsUdiYos5XMhGDEK7TBS0Zx+kCcn7kuazyV8/2WgGSJPVzhL6cOIBe+jd8vt12OcOh/mJdwGxcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990466; c=relaxed/simple;
	bh=mHh8WbTwZ3NtGXeKzxuoERonpaKd+wiojdmb37SMX5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOYXdh+qijVnr07sImCbf53gd/I4iTjlZUFsdTRWF+nO3j+KTDcVcxo2Ggi2KoBRbJyOetW2xCzNsrGTy+qaMdbxR4QYn3KGiwa/YR+ZiFayn1FEYWRevBZLIRsJvcbJnm1Mtuh74tTW/aIdcZnB+ePuahKjYqSUdZG5np+fZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYQcG++B; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73712952e1cso7229312b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745990464; x=1746595264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ8FdPnP/lqSR+ssupFGPDQRSenDfFhk1Htqyk0xg9U=;
        b=UYQcG++BsSu6Y00it7/wUz74gwYoVCn4/KrRBLFDDJMV6ltchL9+xlWHK81Dm8L65X
         dYSXrVBsrLGRKovxb8FlBKxaYk1HDcn34XoqQ/m5Hix6Y1tRz7oZ4N7LVCUNqqE6HLDM
         tA5kK+PfooFK92h7VKW19/8V0R4G/XW6Oa30e8OylTRZDQ8Qx1bcKo7TUZhkLUyvkqr/
         94atRaozUCbKrkUm/KNwQLP5TpnquqIqTjdvVoptBbmH5R8gMODYmOcEX+rE8jd8Zo3t
         6QWGKSKuklnqf2VD0s6fcf0NpKs/CfflhSQJUej5eF0NkFwD3BEEDrMfGjMgdAlYJZui
         3syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745990464; x=1746595264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ8FdPnP/lqSR+ssupFGPDQRSenDfFhk1Htqyk0xg9U=;
        b=nkZ3rmWTkKZhIb2QQlBLQwFX2LAjoyzOONAGHHLfq8ZeRK+EqzPIABzizszoBkpHaE
         8sydExADUh7wyNS+mPWeFyFg9Pck5iyZQzVFhb419DOGdlmTj0VODyeZojO5ouTQxZut
         YTcaDnogwmcUeb8kNp52kekz9w+NXiBmIG2VXvXFQU50Jse6w88KGAI/4DOP2/E0CQdS
         2Hzg3GHczb/4Xy0Cd/rgNHVOhpK4rxnn9P5DThfKx6QgarWWHx0B6o8YFy8w7s9Vk8AN
         BXEbBSGJGZmJ6A1Q+prcPFPhMkzoMa8vsR33/QuTt9Xkt5IU+kVXDVJYy6fOX+GFNE92
         q3+w==
X-Forwarded-Encrypted: i=1; AJvYcCWxXW4Fk0bWfSNd3BAilDyp68bfRTCOvM9nk/N9GyG/Mc4cAO/By8TJB3qMe+RMmzm//ku+411JLsbc@vger.kernel.org
X-Gm-Message-State: AOJu0YybNYvllt2LHLt5BvjqZYUlxjQmA5g6WhymmyBCCvue6E/zMkvw
	6YtgzNhBGd7gCxyziN2hzuGh9hSlDNifLhJ4fWxEfRR3CITM4RgW
X-Gm-Gg: ASbGncs90aBwiQW+fhuJkfzRRVyGFXvju2mE5Jce7Ioav34pBrWF/VrGdZUUu1Pk7PT
	+hzFhed51GwsXaqGSxcbqR8iXV8qBfRve6VHn7xHSb5bd6Td/ghQAK+aChPF+5zLKbRKziAreq7
	VxKCCNA4POxEBbn6ZPpHFF7we1XkDIe10ksMqp7RWUBUM7QUMhacXXevzoVGMqLcBexqX+ajdZL
	awOyHYKWfcQbT88vtOmnC1XZ5v/on+BYnZuVpLfL5Dx+G8XOFkIx1vWmvzZgAMrUmDpswsjH5ds
	vUumopndcNQTcB7azj8qHlOm4/lLFD/mo0mzebGu+XEDx8c=
X-Google-Smtp-Source: AGHT+IETdK0eQ4TRKPo+m+8vT7cC31Lm+y1ku84Z1VlEhfEDE0xacuUwV9gjn2cEt6TrkP2ekhwa+Q==
X-Received: by 2002:a05:6a20:d526:b0:1f5:9098:e42e with SMTP id adf61e73a8af0-20aa26d421amr2138412637.7.1745990463547;
        Tue, 29 Apr 2025 22:21:03 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a3100dsm735388b3a.90.2025.04.29.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:21:02 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-ext4@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 2/2] ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
Date: Wed, 30 Apr 2025 10:50:42 +0530
Message-ID: <64e865aa8e53151e681eee0332c2a2e956c852eb.1745987268.git.ritesh.list@gmail.com>
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

There can be a case where there are contiguous extents on the adjacent
leaf nodes of on-disk extent trees. So when someone tries to write to
this contiguous range, ext4_map_blocks() call will split by returning
1 extent at a time if this is not already cached in extent_status tree
cache (where if these extents when cached can get merged since they are
contiguous).

This is fine for a normal write however in case of atomic writes, it
can't afford to break the write into two. Now this is also something
that will only happen in the slow write case where we call
ext4_map_blocks() for each of these extents spread across different leaf
nodes. However, there is no guarantee that these extent status cache
cannot be reclaimed before the last call to ext4_map_blocks() in
ext4_map_blocks_atomic_write_slow().

Hence this patch adds support of EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
This flag checks if the requested range can be fully found in extent
status cache and return. If not, it looks up in on-disk extent
tree via ext4_map_query_blocks(). If the found extent is the last entry
in the leaf node, then it goes and queries the next lblk to see if there
is an adjacent contiguous extent in the adjacent leaf node of the
on-disk extent tree.

Even though there can be a case where there are multiple adjacent extent
entries spread across multiple leaf nodes. But we only read an adjacent
leaf block i.e. in total of 2 extent entries spread across 2 leaf nodes.
The reason for this is that we are mostly only going to support atomic
writes with upto 64KB or maybe max upto 1MB of atomic write support.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h    |  6 ++++
 fs/ext4/extents.c |  9 +++--
 fs/ext4/inode.c   | 91 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 589d51389327..38f75d33d67f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -256,6 +256,7 @@ struct ext4_allocation_request {
 #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
 #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
 #define EXT4_MAP_DELAYED	BIT(BH_Delay)
+#define EXT4_MAP_LAST_IN_LEAF	BIT(BH_PrivateStart)
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
 				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
 				 EXT4_MAP_DELAYED)
@@ -725,6 +726,11 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+/*
+ * Atomic write caller needs this to query in the slow path of mixed mapping
+ * case, when a contiguous extent can be split across two adjacent leaf nodes.
+ */
+#define EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS	0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e00b78b521c..12fae8d70f46 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4433,6 +4433,10 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	allocated = map->m_len;
 	ext4_ext_show_leaf(inode, path);
 out:
+	if (flags & EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS)
+		if (ex && (ex == EXT_LAST_EXTENT(path[depth].p_hdr)))
+			map->m_flags |= EXT4_MAP_LAST_IN_LEAF;
+
 	ext4_free_ext_path(path);
 
 	trace_ext4_ext_map_blocks_exit(inode, flags, map,
@@ -4788,7 +4792,8 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
 	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned int credits = 0;
-	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT;
+	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT |
+			EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS;
 
 	map.m_lblk = offset >> blkbits;
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
@@ -4815,7 +4820,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
 		map.m_lblk += ret;
 		map.m_len = (max_blocks -= ret);
 		ret = ext4_map_blocks(handle, inode, &map, flags);
-		if (ret != max_blocks)
+		if (!(map.m_flags & EXT4_MAP_LAST_IN_LEAF) && ret != max_blocks)
 			ext4_warning(inode->i_sb,
 				     "inode #%lu: block %u: len %u: "
 				     "split block mapping found for atomic write,"
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 27235a76c2d1..f5c8c4b8cd16 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -459,14 +459,69 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+static int ext4_map_query_last_in_leaf_blocks(handle_t *handle,
+			struct inode *inode, struct ext4_map_blocks *map,
+			unsigned int orig_mlen)
+{
+	struct ext4_map_blocks map2;
+	unsigned int status, status2;
+	int retval;
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+
+	WARN_ON_ONCE(!(map->m_flags & EXT4_MAP_LAST_IN_LEAF));
+
+	map2.m_lblk = map->m_lblk + map->m_len;
+	map2.m_len = INT_MAX;
+	map2.m_flags = 0;
+	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
+
+	if (retval <= 0) {
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+		return map->m_len;
+
+	}
+
+	if (unlikely(retval != map2.m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode "
+			     "%lu: retval %d != map->m_len %d",
+			     inode->i_ino, retval, map2.m_len);
+		WARN_ON(1);
+	}
+
+	status2 = map2.m_flags & EXT4_MAP_UNWRITTEN ?
+		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+
+	if (map->m_pblk + map->m_len == map2.m_pblk &&
+			status == status2) {
+		ext4_es_insert_extent(inode, map->m_lblk,
+				      map->m_len + map2.m_len, map->m_pblk,
+				      status, false);
+		if (in_range(orig_mlen, map->m_len,
+					map->m_len + map2.m_len + 1))
+			map->m_len = orig_mlen;
+	} else {
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+	}
+
+	return map->m_len;
+}
+
 static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
-				 struct ext4_map_blocks *map)
+				 struct ext4_map_blocks *map, int flags)
 {
 	unsigned int status;
 	int retval;
+	unsigned int orig_mlen = map->m_len;
+
+	flags = flags & EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+		retval = ext4_ext_map_blocks(handle, inode, map, flags);
 	else
 		retval = ext4_ind_map_blocks(handle, inode, map, 0);
 
@@ -481,11 +536,16 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 		WARN_ON(1);
 	}
 
-	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-			      map->m_pblk, status, false);
-	return retval;
+	if (!(map->m_flags & EXT4_MAP_LAST_IN_LEAF)) {
+		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status, false);
+		return retval;
+	}
+
+	return ext4_map_query_last_in_leaf_blocks(handle, inode, map,
+						  orig_mlen);
 }
 
 static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
@@ -599,6 +659,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	struct extent_status es;
 	int retval;
 	int ret = 0;
+	unsigned int orig_mlen = map->m_len;
 #ifdef ES_AGGRESSIVE_TEST
 	struct ext4_map_blocks orig_map;
 
@@ -650,7 +711,12 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_map_blocks_es_recheck(handle, inode, map,
 					   &orig_map, flags);
 #endif
-		goto found;
+		if (!(flags & EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS) ||
+				orig_mlen == map->m_len)
+			goto found;
+
+		if (flags & EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS)
+			map->m_len = orig_mlen;
 	}
 	/*
 	 * In the query cache no-wait mode, nothing we can do more if we
@@ -664,7 +730,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * file system block.
 	 */
 	down_read(&EXT4_I(inode)->i_data_sem);
-	retval = ext4_map_query_blocks(handle, inode, map);
+	retval = ext4_map_query_blocks(handle, inode, map, flags);
 	up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
@@ -1802,7 +1868,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 	if (ext4_has_inline_data(inode))
 		retval = 0;
 	else
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 	up_read(&EXT4_I(inode)->i_data_sem);
 	if (retval)
 		return retval < 0 ? retval : 0;
@@ -1825,7 +1891,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
 			goto found;
 		}
 	} else if (!ext4_has_inline_data(inode)) {
-		retval = ext4_map_query_blocks(NULL, inode, map);
+		retval = ext4_map_query_blocks(NULL, inode, map, 0);
 		if (retval) {
 			up_write(&EXT4_I(inode)->i_data_sem);
 			return retval < 0 ? retval : 0;
@@ -3372,7 +3438,8 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
 	map->m_lblk = m_lblk;
 	map->m_len = m_len;
 
-	ret = ext4_map_blocks(handle, inode, map, 0);
+	ret = ext4_map_blocks(handle, inode, map,
+			      EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS);
 	if (ret != m_len) {
 		ext4_warning_inode(inode, "allocation failed for atomic write request pos:%u, len:%u\n",
 			m_lblk, m_len);
-- 
2.49.0


