Return-Path: <linux-ext4+bounces-10427-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23255BA05AD
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1A45E3114
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Sep 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D61D61A3;
	Thu, 25 Sep 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pYtsB68v";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="U/ksjWMD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E243F18E1F;
	Thu, 25 Sep 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813973; cv=none; b=QJgcwC7BXwf/DZX1d1MFmVlUwKFMS31RV4nXbxGDWa3JUpKy4Zj3QiwNnQ5GwsL0ea/uRAIIXZrRAl4oYmaCrxi9ezM6sTqUcnlyHmEeJojXqfRdmbH4QE2dEM3TodcoRIEFrNZdgW7VB/q7HnLsW90B5aMjv5s+g3w3+f95hkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813973; c=relaxed/simple;
	bh=osnFRIXvF89GUWj61/dA03hYp0fHJiMLqJX3DDdEnxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UDyatBUPL0bN22xfvztkjjuWcqGiEBVHNwA6MdrcJLLRrLfoj1yPhtmvZ9dCCy9X4NOpokwuZ2PhJbDnTtCNeost7/E82zxeT7EuJIb5OtEUuzfpdXfXhGtyMcz0eDwmpHRyS6AQMdXflksT3+IO/PAtems+kXzv/y4zAesRWlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pYtsB68v; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=U/ksjWMD; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cXcxR0Pbsz9stL;
	Thu, 25 Sep 2025 17:26:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758813963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5HDRD0D2WF7opL/goqHejviNxHZ7dxolCjCoT43ySq0=;
	b=pYtsB68vJ7rV7CE0ltZtYnRc19Gr1sSVAGm06MY2RhO8UMbV54R0JuIkVqVBpeVULKfXc8
	Gvf27tpoxa2m8g4wX6tOjOeQAoLwtp0hdsemBeOgfLVbBaz0stVWw73zq9UFFv0n0x7UjG
	ov08Sy1De4soQaF7/UN4yMts3za2JtN1H6E+7z8j93VHrRbrPZldLzXvKZEj90zWpUJtwN
	HzmSg8qYAAHYzlFX0OEWVcjRHQ2z1QyKqKiJzN7w5CUw3O8h1H6gh16fBFBh705mk+xgZ3
	BzmAW+PIVPeqQYD5NqpW/PYtyzxBEBpUeRTjeWTBNcGFf7PNH3GXumFWjOvXaQ==
From: Zeno Endemann <zeno.endemann@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758813961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5HDRD0D2WF7opL/goqHejviNxHZ7dxolCjCoT43ySq0=;
	b=U/ksjWMDtfW8Obs8LS1AmeYGBSGW86pv80ZtwmCL3UEMfCuuJkdaVY7Db64x8LOMaPWu4E
	Bx5IBXBwTad+fz9nMToQhZ2YY6NmQ01SSFBLNT3hkZdPUtzkNiSiAJzLMTv87v7joeSieA
	KU9C/NS8DYNitL5n7Y8N4bZh5ln7hvT4mHPKjI5MuxjFy3oguSp8e24zNHUnvmaPhz4x3J
	9JM3JLYUCz7EVu5jSEKQzgCb88RKqvIUboJoMhPrwZ/KF7azmvCQlxR0sIz4ZAOlt99+5w
	5vx2czpYgs8w0KQmKmNwAxDjEgCUaFeQBxDD7oaynr7/0foeYu2UhCwsBCvflA==
To: linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Zeno Endemann <zeno.endemann@mailbox.org>
Subject: [PATCH] ext4, doc: fix and improve directory hash tree description
Date: Thu, 25 Sep 2025 17:24:33 +0200
Message-ID: <20250925152435.22749-1-zeno.endemann@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gbuwe331ot97nbe7fasj6qnox583meni
X-MBO-RS-ID: 98017fd3ebe308a3597

Some of the details about how directory hash trees work were confusing or
outright wrong, this patch should fix those.

A note on dx_tail's dt_reserved member, as far as I can tell the kernel
never sets this explicitly, so its content is apparently left-overs from
what was there before (for the dx_root I've seen remnants of a
ext4_dir_entry_tail struct from when the dir was not yet a hash dir).

Signed-off-by: Zeno Endemann <zeno.endemann@mailbox.org>
---
 Documentation/filesystems/ext4/directory.rst | 63 ++++++++++----------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/Documentation/filesystems/ext4/directory.rst b/Documentation/filesystems/ext4/directory.rst
index 6eece8e31df8..9b003a4d453f 100644
--- a/Documentation/filesystems/ext4/directory.rst
+++ b/Documentation/filesystems/ext4/directory.rst
@@ -183,10 +183,10 @@ in the place where the name normally goes. The structure is
      - det_checksum
      - Directory leaf block checksum.
 
-The leaf directory block checksum is calculated against the FS UUID, the
-directory's inode number, the directory's inode generation number, and
-the entire directory entry block up to (but not including) the fake
-directory entry.
+The leaf directory block checksum is calculated against the FS UUID (or
+the checksum seed, if that feature is enabled for the fs), the directory's
+inode number, the directory's inode generation number, and the entire
+directory entry block up to (but not including) the fake directory entry.
 
 Hash Tree Directories
 ~~~~~~~~~~~~~~~~~~~~~
@@ -196,12 +196,12 @@ new feature was added to ext3 to provide a faster (but peculiar)
 balanced tree keyed off a hash of the directory entry name. If the
 EXT4_INDEX_FL (0x1000) flag is set in the inode, this directory uses a
 hashed btree (htree) to organize and find directory entries. For
-backwards read-only compatibility with ext2, this tree is actually
-hidden inside the directory file, masquerading as “empty” directory data
-blocks! It was stated previously that the end of the linear directory
-entry table was signified with an entry pointing to inode 0; this is
-(ab)used to fool the old linear-scan algorithm into thinking that the
-rest of the directory block is empty so that it moves on.
+backwards read-only compatibility with ext2, interior tree nodes are actually
+hidden inside the directory file, masquerading as “empty” directory entries
+spanning the whole block. It was stated previously that directory entries
+with the inode set to 0 are treated as unused entries; this is (ab)used to
+fool the old linear-scan algorithm into skipping over those blocks containing
+the interior tree node data.
 
 The root of the tree always lives in the first data block of the
 directory. By ext2 custom, the '.' and '..' entries must appear at the
@@ -209,24 +209,24 @@ beginning of this first block, so they are put here as two
 ``struct ext4_dir_entry_2`` s and not stored in the tree. The rest of
 the root node contains metadata about the tree and finally a hash->block
 map to find nodes that are lower in the htree. If
-``dx_root.info.indirect_levels`` is non-zero then the htree has two
-levels; the data block pointed to by the root node's map is an interior
-node, which is indexed by a minor hash. Interior nodes in this tree
-contains a zeroed out ``struct ext4_dir_entry_2`` followed by a
-minor_hash->block map to find leafe nodes. Leaf nodes contain a linear
-array of all ``struct ext4_dir_entry_2``; all of these entries
-(presumably) hash to the same value. If there is an overflow, the
-entries simply overflow into the next leaf node, and the
-least-significant bit of the hash (in the interior node map) that gets
-us to this next leaf node is set.
-
-To traverse the directory as a htree, the code calculates the hash of
-the desired file name and uses it to find the corresponding block
-number. If the tree is flat, the block is a linear array of directory
-entries that can be searched; otherwise, the minor hash of the file name
-is computed and used against this second block to find the corresponding
-third block number. That third block number will be a linear array of
-directory entries.
+``dx_root.info.indirect_levels`` is non-zero then the htree has that many
+levels and the blocks pointed to by the root node's map are interior nodes.
+These interior nodes have a zeroed out ``struct ext4_dir_entry_2`` followed by
+a hash->block map to find nodes of the next level. Leaf nodes look like
+classic linear directory blocks, but all of its entries have a hash value
+equal or greater than the indicated hash of the parent node.
+
+The actual hash value for an entry name is only 31 bits, the least-significant
+bit is set to 0. However, if there is a hash collision between directory
+entries, the least-significant bit may get set to 1 on interior nodes in the
+case where these two (or more) hash-colliding entries do not fit into one leaf
+node and must be split across multiple nodes.
+
+To look up a name in such a htree, the code calculates the hash of the desired
+file name and uses it to find the leaf node with the range of hash values the
+calculated hash falls into (in other words, a lookup works basically the same
+as it would in a B-Tree keyed by the hash value), and possibly also scanning
+the leaf nodes that follow (in tree order) in case of hash collisions.
 
 To traverse the directory as a linear array (such as the old code does),
 the code simply reads every data block in the directory. The blocks used
@@ -319,7 +319,8 @@ of a data block:
    * - 0x24
      - __le32
      - block
-     - The block number (within the directory file) that goes with hash=0.
+     - The block number (within the directory file) that lead to the left-most
+       leaf node, i.e. the leaf containing entries with the lowest hash values.
    * - 0x28
      - struct dx_entry
      - entries[0]
@@ -442,7 +443,7 @@ The dx_tail structure is 8 bytes long and looks like this:
    * - 0x0
      - u32
      - dt_reserved
-     - Zero.
+     - Unused (but still part of the checksum curiously).
    * - 0x4
      - __le32
      - dt_checksum
@@ -450,4 +451,4 @@ The dx_tail structure is 8 bytes long and looks like this:
 
 The checksum is calculated against the FS UUID, the htree index header
 (dx_root or dx_node), all of the htree indices (dx_entry) that are in
-use, and the tail block (dx_tail).
+use, and the tail block (dx_tail) with the dt_checksum initially set to 0.
-- 
2.51.0


