Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098AE52E272
	for <lists+linux-ext4@lfdr.de>; Fri, 20 May 2022 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344722AbiETCXF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiETCXC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 22:23:02 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B980132744;
        Thu, 19 May 2022 19:22:58 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L49T920tNz1JCLy;
        Fri, 20 May 2022 10:21:33 +0800 (CST)
Received: from huawei.com (10.113.189.238) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 10:22:56 +0800
From:   Wang Jianjian <wangjianjian3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/2] ext4, doc: Remove unnecessary escaping
Date:   Fri, 20 May 2022 10:22:55 +0800
Message-ID: <20220520022255.2120576-2-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520022255.2120576-1-wangjianjian3@huawei.com>
References: <20220520022255.2120576-1-wangjianjian3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.113.189.238]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 Documentation/filesystems/ext4/attributes.rst |  68 +--
 Documentation/filesystems/ext4/bigalloc.rst   |   2 +-
 Documentation/filesystems/ext4/bitmaps.rst    |   6 +-
 Documentation/filesystems/ext4/blockgroup.rst |  30 +-
 Documentation/filesystems/ext4/blockmap.rst   |   2 +-
 Documentation/filesystems/ext4/checksums.rst  |  26 +-
 Documentation/filesystems/ext4/directory.rst  | 166 +++---
 Documentation/filesystems/ext4/eainode.rst    |  10 +-
 .../filesystems/ext4/group_descr.rst          | 126 ++--
 Documentation/filesystems/ext4/ifork.rst      |  60 +-
 Documentation/filesystems/ext4/inlinedata.rst |   8 +-
 Documentation/filesystems/ext4/inodes.rst     | 306 +++++-----
 Documentation/filesystems/ext4/journal.rst    | 214 +++----
 Documentation/filesystems/ext4/mmp.rst        |  36 +-
 Documentation/filesystems/ext4/overview.rst   |   2 +-
 .../filesystems/ext4/special_inodes.rst       |   8 +-
 Documentation/filesystems/ext4/super.rst      | 550 +++++++++---------
 17 files changed, 810 insertions(+), 810 deletions(-)

diff --git a/Documentation/filesystems/ext4/attributes.rst b/Documentation/filesystems/ext4/attributes.rst
index 871d2da7a0a9..87814696a65b 100644
--- a/Documentation/filesystems/ext4/attributes.rst
+++ b/Documentation/filesystems/ext4/attributes.rst
@@ -13,8 +13,8 @@ disappeared as of Linux 3.0.
 
 There are two places where extended attributes can be found. The first
 place is between the end of each inode entry and the beginning of the
-next inode entry. For example, if inode.i\_extra\_isize = 28 and
-sb.inode\_size = 256, then there are 256 - (128 + 28) = 100 bytes
+next inode entry. For example, if inode.i_extra_isize = 28 and
+sb.inode_size = 256, then there are 256 - (128 + 28) = 100 bytes
 available for in-inode extended attribute storage. The second place
 where extended attributes can be found is in the block pointed to by
 ``inode.i_file_acl``. As of Linux 3.11, it is not possible for this
@@ -38,8 +38,8 @@ Extended attributes, when stored after the inode, have a header
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - h\_magic
+     - __le32
+     - h_magic
      - Magic number for identification, 0xEA020000. This value is set by the
        Linux driver, though e2fsprogs doesn't seem to check it(?)
 
@@ -55,28 +55,28 @@ The beginning of an extended attribute block is in
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - h\_magic
+     - __le32
+     - h_magic
      - Magic number for identification, 0xEA020000.
    * - 0x4
-     - \_\_le32
-     - h\_refcount
+     - __le32
+     - h_refcount
      - Reference count.
    * - 0x8
-     - \_\_le32
-     - h\_blocks
+     - __le32
+     - h_blocks
      - Number of disk blocks used.
    * - 0xC
-     - \_\_le32
-     - h\_hash
+     - __le32
+     - h_hash
      - Hash value of all attributes.
    * - 0x10
-     - \_\_le32
-     - h\_checksum
+     - __le32
+     - h_checksum
      - Checksum of the extended attribute block.
    * - 0x14
-     - \_\_u32
-     - h\_reserved[3]
+     - __u32
+     - h_reserved[3]
      - Zero.
 
 The checksum is calculated against the FS UUID, the 64-bit block number
@@ -100,46 +100,46 @@ Attributes stored inside an inode do not need be stored in sorted order.
      - Name
      - Description
    * - 0x0
-     - \_\_u8
-     - e\_name\_len
+     - __u8
+     - e_name_len
      - Length of name.
    * - 0x1
-     - \_\_u8
-     - e\_name\_index
+     - __u8
+     - e_name_index
      - Attribute name index. There is a discussion of this below.
    * - 0x2
-     - \_\_le16
-     - e\_value\_offs
+     - __le16
+     - e_value_offs
      - Location of this attribute's value on the disk block where it is stored.
        Multiple attributes can share the same value. For an inode attribute
        this value is relative to the start of the first entry; for a block this
        value is relative to the start of the block (i.e. the header).
    * - 0x4
-     - \_\_le32
-     - e\_value\_inum
+     - __le32
+     - e_value_inum
      - The inode where the value is stored. Zero indicates the value is in the
        same block as this entry. This field is only used if the
-       INCOMPAT\_EA\_INODE feature is enabled.
+       INCOMPAT_EA_INODE feature is enabled.
    * - 0x8
-     - \_\_le32
-     - e\_value\_size
+     - __le32
+     - e_value_size
      - Length of attribute value.
    * - 0xC
-     - \_\_le32
-     - e\_hash
+     - __le32
+     - e_hash
      - Hash value of attribute name and attribute value. The kernel doesn't
        update the hash for in-inode attributes, so for that case this value
        must be zero, because e2fsck validates any non-zero hash regardless of
        where the xattr lives.
    * - 0x10
      - char
-     - e\_name[e\_name\_len]
+     - e_name[e_name_len]
      - Attribute name. Does not include trailing NULL.
 
 Attribute values can follow the end of the entry table. There appears to
 be a requirement that they be aligned to 4-byte boundaries. The values
 are stored starting at the end of the block and grow towards the
-xattr\_header/xattr\_entry table. When the two collide, the overflow is
+xattr_header/xattr_entry table. When the two collide, the overflow is
 put into a separate disk block. If the disk block fills up, the
 filesystem returns -ENOSPC.
 
@@ -167,15 +167,15 @@ the key name. Here is a map of name index values to key prefixes:
    * - 1
      - “user.”
    * - 2
-     - “system.posix\_acl\_access”
+     - “system.posix_acl_access”
    * - 3
-     - “system.posix\_acl\_default”
+     - “system.posix_acl_default”
    * - 4
      - “trusted.”
    * - 6
      - “security.”
    * - 7
-     - “system.” (inline\_data only?)
+     - “system.” (inline_data only?)
    * - 8
      - “system.richacl” (SuSE kernels only?)
 
diff --git a/Documentation/filesystems/ext4/bigalloc.rst b/Documentation/filesystems/ext4/bigalloc.rst
index 72075aa608e4..976a180b209c 100644
--- a/Documentation/filesystems/ext4/bigalloc.rst
+++ b/Documentation/filesystems/ext4/bigalloc.rst
@@ -23,7 +23,7 @@ means that a block group addresses 32 gigabytes instead of 128 megabytes,
 also shrinking the amount of file system overhead for metadata.
 
 The administrator can set a block cluster size at mkfs time (which is
-stored in the s\_log\_cluster\_size field in the superblock); from then
+stored in the s_log_cluster_size field in the superblock); from then
 on, the block bitmaps track clusters, not individual blocks. This means
 that block groups can be several gigabytes in size (instead of just
 128MiB); however, the minimum allocation unit becomes a cluster, not a
diff --git a/Documentation/filesystems/ext4/bitmaps.rst b/Documentation/filesystems/ext4/bitmaps.rst
index c7546dbc197a..91c45d86e9bb 100644
--- a/Documentation/filesystems/ext4/bitmaps.rst
+++ b/Documentation/filesystems/ext4/bitmaps.rst
@@ -9,15 +9,15 @@ group.
 The inode bitmap records which entries in the inode table are in use.
 
 As with most bitmaps, one bit represents the usage status of one data
-block or inode table entry. This implies a block group size of 8 \*
-number\_of\_bytes\_in\_a\_logical\_block.
+block or inode table entry. This implies a block group size of 8 *
+number_of_bytes_in_a_logical_block.
 
 NOTE: If ``BLOCK_UNINIT`` is set for a given block group, various parts
 of the kernel and e2fsprogs code pretends that the block bitmap contains
 zeros (i.e. all blocks in the group are free). However, it is not
 necessarily the case that no blocks are in use -- if ``meta_bg`` is set,
 the bitmaps and group descriptor live inside the group. Unfortunately,
-ext2fs\_test\_block\_bitmap2() will return '0' for those locations,
+ext2fs_test_block_bitmap2() will return '0' for those locations,
 which produces confusing debugfs output.
 
 Inode Table
diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index d5d652addce5..46d78f860623 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -56,39 +56,39 @@ established that the super block and the group descriptor table, if
 present, will be at the beginning of the block group. The bitmaps and
 the inode table can be anywhere, and it is quite possible for the
 bitmaps to come after the inode table, or for both to be in different
-groups (flex\_bg). Leftover space is used for file data blocks, indirect
+groups (flex_bg). Leftover space is used for file data blocks, indirect
 block maps, extent tree blocks, and extended attributes.
 
 Flexible Block Groups
 ---------------------
 
 Starting in ext4, there is a new feature called flexible block groups
-(flex\_bg). In a flex\_bg, several block groups are tied together as one
+(flex_bg). In a flex_bg, several block groups are tied together as one
 logical block group; the bitmap spaces and the inode table space in the
-first block group of the flex\_bg are expanded to include the bitmaps
-and inode tables of all other block groups in the flex\_bg. For example,
-if the flex\_bg size is 4, then group 0 will contain (in order) the
+first block group of the flex_bg are expanded to include the bitmaps
+and inode tables of all other block groups in the flex_bg. For example,
+if the flex_bg size is 4, then group 0 will contain (in order) the
 superblock, group descriptors, data block bitmaps for groups 0-3, inode
 bitmaps for groups 0-3, inode tables for groups 0-3, and the remaining
 space in group 0 is for file data. The effect of this is to group the
 block group metadata close together for faster loading, and to enable
 large files to be continuous on disk. Backup copies of the superblock
 and group descriptors are always at the beginning of block groups, even
-if flex\_bg is enabled. The number of block groups that make up a
-flex\_bg is given by 2 ^ ``sb.s_log_groups_per_flex``.
+if flex_bg is enabled. The number of block groups that make up a
+flex_bg is given by 2 ^ ``sb.s_log_groups_per_flex``.
 
 Meta Block Groups
 -----------------
 
-Without the option META\_BG, for safety concerns, all block group
+Without the option META_BG, for safety concerns, all block group
 descriptors copies are kept in the first block group. Given the default
 128MiB(2^27 bytes) block group size and 64-byte group descriptors, ext4
 can have at most 2^27/64 = 2^21 block groups. This limits the entire
 filesystem size to 2^21 * 2^27 = 2^48bytes or 256TiB.
 
 The solution to this problem is to use the metablock group feature
-(META\_BG), which is already in ext3 for all 2.6 releases. With the
-META\_BG feature, ext4 filesystems are partitioned into many metablock
+(META_BG), which is already in ext3 for all 2.6 releases. With the
+META_BG feature, ext4 filesystems are partitioned into many metablock
 groups. Each metablock group is a cluster of block groups whose group
 descriptor structures can be stored in a single disk block. For ext4
 filesystems with 4 KB block size, a single metablock group partition
@@ -110,7 +110,7 @@ bytes, a meta-block group contains 32 block groups for filesystems with
 a 1KB block size, and 128 block groups for filesystems with a 4KB
 blocksize. Filesystems can either be created using this new block group
 descriptor layout, or existing filesystems can be resized on-line, and
-the field s\_first\_meta\_bg in the superblock will indicate the first
+the field s_first_meta_bg in the superblock will indicate the first
 block group using this new layout.
 
 Please see an important note about ``BLOCK_UNINIT`` in the section about
@@ -121,15 +121,15 @@ Lazy Block Group Initialization
 
 A new feature for ext4 are three block group descriptor flags that
 enable mkfs to skip initializing other parts of the block group
-metadata. Specifically, the INODE\_UNINIT and BLOCK\_UNINIT flags mean
+metadata. Specifically, the INODE_UNINIT and BLOCK_UNINIT flags mean
 that the inode and block bitmaps for that group can be calculated and
 therefore the on-disk bitmap blocks are not initialized. This is
 generally the case for an empty block group or a block group containing
-only fixed-location block group metadata. The INODE\_ZEROED flag means
+only fixed-location block group metadata. The INODE_ZEROED flag means
 that the inode table has been initialized; mkfs will unset this flag and
 rely on the kernel to initialize the inode tables in the background.
 
 By not writing zeroes to the bitmaps and inode table, mkfs time is
-reduced considerably. Note the feature flag is RO\_COMPAT\_GDT\_CSUM,
-but the dumpe2fs output prints this as “uninit\_bg”. They are the same
+reduced considerably. Note the feature flag is RO_COMPAT_GDT_CSUM,
+but the dumpe2fs output prints this as “uninit_bg”. They are the same
 thing.
diff --git a/Documentation/filesystems/ext4/blockmap.rst b/Documentation/filesystems/ext4/blockmap.rst
index 30e25750d88a..2bd990402a5c 100644
--- a/Documentation/filesystems/ext4/blockmap.rst
+++ b/Documentation/filesystems/ext4/blockmap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-| i.i\_block Offset   | Where It Points                                                                                                                                                                                                              |
+| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
 +=====================+==============================================================================================================================================================================================================================+
 | 0 to 11             | Direct map to file blocks 0 to 11.                                                                                                                                                                                           |
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
diff --git a/Documentation/filesystems/ext4/checksums.rst b/Documentation/filesystems/ext4/checksums.rst
index 5519e253810d..e232749daf5f 100644
--- a/Documentation/filesystems/ext4/checksums.rst
+++ b/Documentation/filesystems/ext4/checksums.rst
@@ -4,7 +4,7 @@ Checksums
 ---------
 
 Starting in early 2012, metadata checksums were added to all major ext4
-and jbd2 data structures. The associated feature flag is metadata\_csum.
+and jbd2 data structures. The associated feature flag is metadata_csum.
 The desired checksum algorithm is indicated in the superblock, though as
 of October 2012 the only supported algorithm is crc32c. Some data
 structures did not have space to fit a full 32-bit checksum, so only the
@@ -20,7 +20,7 @@ encounters directory blocks that lack sufficient empty space to add a
 checksum, it will request that you run ``e2fsck -D`` to have the
 directories rebuilt with checksums. This has the added benefit of
 removing slack space from the directory files and rebalancing the htree
-indexes. If you \_ignore\_ this step, your directories will not be
+indexes. If you _ignore_ this step, your directories will not be
 protected by a checksum!
 
 The following table describes the data elements that go into each type
@@ -35,39 +35,39 @@ of checksum. The checksum function is whatever the superblock describes
      - Length
      - Ingredients
    * - Superblock
-     - \_\_le32
+     - __le32
      - The entire superblock up to the checksum field. The UUID lives inside
        the superblock.
    * - MMP
-     - \_\_le32
+     - __le32
      - UUID + the entire MMP block up to the checksum field.
    * - Extended Attributes
-     - \_\_le32
+     - __le32
      - UUID + the entire extended attribute block. The checksum field is set to
        zero.
    * - Directory Entries
-     - \_\_le32
+     - __le32
      - UUID + inode number + inode generation + the directory block up to the
        fake entry enclosing the checksum field.
    * - HTREE Nodes
-     - \_\_le32
+     - __le32
      - UUID + inode number + inode generation + all valid extents + HTREE tail.
        The checksum field is set to zero.
    * - Extents
-     - \_\_le32
+     - __le32
      - UUID + inode number + inode generation + the entire extent block up to
        the checksum field.
    * - Bitmaps
-     - \_\_le32 or \_\_le16
+     - __le32 or __le16
      - UUID + the entire bitmap. Checksums are stored in the group descriptor,
        and truncated if the group descriptor size is 32 bytes (i.e. ^64bit)
    * - Inodes
-     - \_\_le32
+     - __le32
      - UUID + inode number + inode generation + the entire inode. The checksum
        field is set to zero. Each inode has its own checksum.
    * - Group Descriptors
-     - \_\_le16
-     - If metadata\_csum, then UUID + group number + the entire descriptor;
-       else if gdt\_csum, then crc16(UUID + group number + the entire
+     - __le16
+     - If metadata_csum, then UUID + group number + the entire descriptor;
+       else if gdt_csum, then crc16(UUID + group number + the entire
        descriptor). In all cases, only the lower 16 bits are stored.
 
diff --git a/Documentation/filesystems/ext4/directory.rst b/Documentation/filesystems/ext4/directory.rst
index 55f618b37144..6eece8e31df8 100644
--- a/Documentation/filesystems/ext4/directory.rst
+++ b/Documentation/filesystems/ext4/directory.rst
@@ -42,24 +42,24 @@ is at most 263 bytes long, though on disk you'll need to reference
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - inode
      - Number of the inode that this directory entry points to.
    * - 0x4
-     - \_\_le16
-     - rec\_len
+     - __le16
+     - rec_len
      - Length of this directory entry. Must be a multiple of 4.
    * - 0x6
-     - \_\_le16
-     - name\_len
+     - __le16
+     - name_len
      - Length of the file name.
    * - 0x8
      - char
-     - name[EXT4\_NAME\_LEN]
+     - name[EXT4_NAME_LEN]
      - File name.
 
 Since file names cannot be longer than 255 bytes, the new directory
-entry format shortens the name\_len field and uses the space for a file
+entry format shortens the name_len field and uses the space for a file
 type flag, probably to avoid having to load every inode during directory
 tree traversal. This format is ``ext4_dir_entry_2``, which is at most
 263 bytes long, though on disk you'll need to reference
@@ -74,24 +74,24 @@ tree traversal. This format is ``ext4_dir_entry_2``, which is at most
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - inode
      - Number of the inode that this directory entry points to.
    * - 0x4
-     - \_\_le16
-     - rec\_len
+     - __le16
+     - rec_len
      - Length of this directory entry.
    * - 0x6
-     - \_\_u8
-     - name\_len
+     - __u8
+     - name_len
      - Length of the file name.
    * - 0x7
-     - \_\_u8
-     - file\_type
+     - __u8
+     - file_type
      - File type code, see ftype_ table below.
    * - 0x8
      - char
-     - name[EXT4\_NAME\_LEN]
+     - name[EXT4_NAME_LEN]
      - File name.
 
 .. _ftype:
@@ -137,19 +137,19 @@ entry uses this extension, it may be up to 271 bytes.
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - hash
      - The hash of the directory name
    * - 0x4
-     - \_\_le32
-     - minor\_hash
+     - __le32
+     - minor_hash
      - The minor hash of the directory name
 
 
 In order to add checksums to these classic directory blocks, a phony
 ``struct ext4_dir_entry`` is placed at the end of each leaf block to
 hold the checksum. The directory entry is 12 bytes long. The inode
-number and name\_len fields are set to zero to fool old software into
+number and name_len fields are set to zero to fool old software into
 ignoring an apparently empty directory entry, and the checksum is stored
 in the place where the name normally goes. The structure is
 ``struct ext4_dir_entry_tail``:
@@ -163,24 +163,24 @@ in the place where the name normally goes. The structure is
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - det\_reserved\_zero1
+     - __le32
+     - det_reserved_zero1
      - Inode number, which must be zero.
    * - 0x4
-     - \_\_le16
-     - det\_rec\_len
+     - __le16
+     - det_rec_len
      - Length of this directory entry, which must be 12.
    * - 0x6
-     - \_\_u8
-     - det\_reserved\_zero2
+     - __u8
+     - det_reserved_zero2
      - Length of the file name, which must be zero.
    * - 0x7
-     - \_\_u8
-     - det\_reserved\_ft
+     - __u8
+     - det_reserved_ft
      - File type, which must be 0xDE.
    * - 0x8
-     - \_\_le32
-     - det\_checksum
+     - __le32
+     - det_checksum
      - Directory leaf block checksum.
 
 The leaf directory block checksum is calculated against the FS UUID, the
@@ -194,7 +194,7 @@ Hash Tree Directories
 A linear array of directory entries isn't great for performance, so a
 new feature was added to ext3 to provide a faster (but peculiar)
 balanced tree keyed off a hash of the directory entry name. If the
-EXT4\_INDEX\_FL (0x1000) flag is set in the inode, this directory uses a
+EXT4_INDEX_FL (0x1000) flag is set in the inode, this directory uses a
 hashed btree (htree) to organize and find directory entries. For
 backwards read-only compatibility with ext2, this tree is actually
 hidden inside the directory file, masquerading as “empty” directory data
@@ -206,14 +206,14 @@ rest of the directory block is empty so that it moves on.
 The root of the tree always lives in the first data block of the
 directory. By ext2 custom, the '.' and '..' entries must appear at the
 beginning of this first block, so they are put here as two
-``struct ext4_dir_entry_2``\ s and not stored in the tree. The rest of
+``struct ext4_dir_entry_2`` s and not stored in the tree. The rest of
 the root node contains metadata about the tree and finally a hash->block
 map to find nodes that are lower in the htree. If
 ``dx_root.info.indirect_levels`` is non-zero then the htree has two
 levels; the data block pointed to by the root node's map is an interior
 node, which is indexed by a minor hash. Interior nodes in this tree
 contains a zeroed out ``struct ext4_dir_entry_2`` followed by a
-minor\_hash->block map to find leafe nodes. Leaf nodes contain a linear
+minor_hash->block map to find leafe nodes. Leaf nodes contain a linear
 array of all ``struct ext4_dir_entry_2``; all of these entries
 (presumably) hash to the same value. If there is an overflow, the
 entries simply overflow into the next leaf node, and the
@@ -245,83 +245,83 @@ of a data block:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - dot.inode
      - inode number of this directory.
    * - 0x4
-     - \_\_le16
-     - dot.rec\_len
+     - __le16
+     - dot.rec_len
      - Length of this record, 12.
    * - 0x6
      - u8
-     - dot.name\_len
+     - dot.name_len
      - Length of the name, 1.
    * - 0x7
      - u8
-     - dot.file\_type
+     - dot.file_type
      - File type of this entry, 0x2 (directory) (if the feature flag is set).
    * - 0x8
      - char
      - dot.name[4]
-     - “.\\0\\0\\0”
+     - “.\0\0\0”
    * - 0xC
-     - \_\_le32
+     - __le32
      - dotdot.inode
      - inode number of parent directory.
    * - 0x10
-     - \_\_le16
-     - dotdot.rec\_len
-     - block\_size - 12. The record length is long enough to cover all htree
+     - __le16
+     - dotdot.rec_len
+     - block_size - 12. The record length is long enough to cover all htree
        data.
    * - 0x12
      - u8
-     - dotdot.name\_len
+     - dotdot.name_len
      - Length of the name, 2.
    * - 0x13
      - u8
-     - dotdot.file\_type
+     - dotdot.file_type
      - File type of this entry, 0x2 (directory) (if the feature flag is set).
    * - 0x14
      - char
-     - dotdot\_name[4]
-     - “..\\0\\0”
+     - dotdot_name[4]
+     - “..\0\0”
    * - 0x18
-     - \_\_le32
-     - struct dx\_root\_info.reserved\_zero
+     - __le32
+     - struct dx_root_info.reserved_zero
      - Zero.
    * - 0x1C
      - u8
-     - struct dx\_root\_info.hash\_version
+     - struct dx_root_info.hash_version
      - Hash type, see dirhash_ table below.
    * - 0x1D
      - u8
-     - struct dx\_root\_info.info\_length
+     - struct dx_root_info.info_length
      - Length of the tree information, 0x8.
    * - 0x1E
      - u8
-     - struct dx\_root\_info.indirect\_levels
-     - Depth of the htree. Cannot be larger than 3 if the INCOMPAT\_LARGEDIR
+     - struct dx_root_info.indirect_levels
+     - Depth of the htree. Cannot be larger than 3 if the INCOMPAT_LARGEDIR
        feature is set; cannot be larger than 2 otherwise.
    * - 0x1F
      - u8
-     - struct dx\_root\_info.unused\_flags
+     - struct dx_root_info.unused_flags
      -
    * - 0x20
-     - \_\_le16
+     - __le16
      - limit
-     - Maximum number of dx\_entries that can follow this header, plus 1 for
+     - Maximum number of dx_entries that can follow this header, plus 1 for
        the header itself.
    * - 0x22
-     - \_\_le16
+     - __le16
      - count
-     - Actual number of dx\_entries that follow this header, plus 1 for the
+     - Actual number of dx_entries that follow this header, plus 1 for the
        header itself.
    * - 0x24
-     - \_\_le32
+     - __le32
      - block
      - The block number (within the directory file) that goes with hash=0.
    * - 0x28
-     - struct dx\_entry
+     - struct dx_entry
      - entries[0]
      - As many 8-byte ``struct dx_entry`` as fits in the rest of the data block.
 
@@ -362,38 +362,38 @@ also the full length of a data block:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - fake.inode
      - Zero, to make it look like this entry is not in use.
    * - 0x4
-     - \_\_le16
-     - fake.rec\_len
-     - The size of the block, in order to hide all of the dx\_node data.
+     - __le16
+     - fake.rec_len
+     - The size of the block, in order to hide all of the dx_node data.
    * - 0x6
      - u8
-     - name\_len
+     - name_len
      - Zero. There is no name for this “unused” directory entry.
    * - 0x7
      - u8
-     - file\_type
+     - file_type
      - Zero. There is no file type for this “unused” directory entry.
    * - 0x8
-     - \_\_le16
+     - __le16
      - limit
-     - Maximum number of dx\_entries that can follow this header, plus 1 for
+     - Maximum number of dx_entries that can follow this header, plus 1 for
        the header itself.
    * - 0xA
-     - \_\_le16
+     - __le16
      - count
-     - Actual number of dx\_entries that follow this header, plus 1 for the
+     - Actual number of dx_entries that follow this header, plus 1 for the
        header itself.
    * - 0xE
-     - \_\_le32
+     - __le32
      - block
      - The block number (within the directory file) that goes with the lowest
        hash value of this block. This value is stored in the parent block.
    * - 0x12
-     - struct dx\_entry
+     - struct dx_entry
      - entries[0]
      - As many 8-byte ``struct dx_entry`` as fits in the rest of the data block.
 
@@ -410,11 +410,11 @@ long:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
+     - __le32
      - hash
      - Hash code.
    * - 0x4
-     - \_\_le32
+     - __le32
      - block
      - Block number (within the directory file, not filesystem blocks) of the
        next node in the htree.
@@ -423,13 +423,13 @@ long:
 author.)
 
 If metadata checksums are enabled, the last 8 bytes of the directory
-block (precisely the length of one dx\_entry) are used to store a
+block (precisely the length of one dx_entry) are used to store a
 ``struct dx_tail``, which contains the checksum. The ``limit`` and
-``count`` entries in the dx\_root/dx\_node structures are adjusted as
-necessary to fit the dx\_tail into the block. If there is no space for
-the dx\_tail, the user is notified to run e2fsck -D to rebuild the
+``count`` entries in the dx_root/dx_node structures are adjusted as
+necessary to fit the dx_tail into the block. If there is no space for
+the dx_tail, the user is notified to run e2fsck -D to rebuild the
 directory index (which will ensure that there's space for the checksum.
-The dx\_tail structure is 8 bytes long and looks like this:
+The dx_tail structure is 8 bytes long and looks like this:
 
 .. list-table::
    :widths: 8 8 24 40
@@ -441,13 +441,13 @@ The dx\_tail structure is 8 bytes long and looks like this:
      - Description
    * - 0x0
      - u32
-     - dt\_reserved
+     - dt_reserved
      - Zero.
    * - 0x4
-     - \_\_le32
-     - dt\_checksum
+     - __le32
+     - dt_checksum
      - Checksum of the htree directory block.
 
 The checksum is calculated against the FS UUID, the htree index header
-(dx\_root or dx\_node), all of the htree indices (dx\_entry) that are in
-use, and the tail block (dx\_tail).
+(dx_root or dx_node), all of the htree indices (dx_entry) that are in
+use, and the tail block (dx_tail).
diff --git a/Documentation/filesystems/ext4/eainode.rst b/Documentation/filesystems/ext4/eainode.rst
index ecc0d01a0a72..7a2ef26b064a 100644
--- a/Documentation/filesystems/ext4/eainode.rst
+++ b/Documentation/filesystems/ext4/eainode.rst
@@ -5,14 +5,14 @@ Large Extended Attribute Values
 
 To enable ext4 to store extended attribute values that do not fit in the
 inode or in the single extended attribute block attached to an inode,
-the EA\_INODE feature allows us to store the value in the data blocks of
+the EA_INODE feature allows us to store the value in the data blocks of
 a regular file inode. This “EA inode” is linked only from the extended
 attribute name index and must not appear in a directory entry. The
-inode's i\_atime field is used to store a checksum of the xattr value;
-and i\_ctime/i\_version store a 64-bit reference count, which enables
+inode's i_atime field is used to store a checksum of the xattr value;
+and i_ctime/i_version store a 64-bit reference count, which enables
 sharing of large xattr values between multiple owning inodes. For
 backward compatibility with older versions of this feature, the
-i\_mtime/i\_generation *may* store a back-reference to the inode number
-and i\_generation of the **one** owning inode (in cases where the EA
+i_mtime/i_generation *may* store a back-reference to the inode number
+and i_generation of the **one** owning inode (in cases where the EA
 inode is not referenced by multiple inodes) to verify that the EA inode
 is the correct one being accessed.
diff --git a/Documentation/filesystems/ext4/group_descr.rst b/Documentation/filesystems/ext4/group_descr.rst
index 7ba6114e7f5c..392ec44f8fb0 100644
--- a/Documentation/filesystems/ext4/group_descr.rst
+++ b/Documentation/filesystems/ext4/group_descr.rst
@@ -7,34 +7,34 @@ Each block group on the filesystem has one of these descriptors
 associated with it. As noted in the Layout section above, the group
 descriptors (if present) are the second item in the block group. The
 standard configuration is for each block group to contain a full copy of
-the block group descriptor table unless the sparse\_super feature flag
+the block group descriptor table unless the sparse_super feature flag
 is set.
 
 Notice how the group descriptor records the location of both bitmaps and
 the inode table (i.e. they can float). This means that within a block
 group, the only data structures with fixed locations are the superblock
-and the group descriptor table. The flex\_bg mechanism uses this
+and the group descriptor table. The flex_bg mechanism uses this
 property to group several block groups into a flex group and lay out all
 of the groups' bitmaps and inode tables into one long run in the first
 group of the flex group.
 
-If the meta\_bg feature flag is set, then several block groups are
-grouped together into a meta group. Note that in the meta\_bg case,
+If the meta_bg feature flag is set, then several block groups are
+grouped together into a meta group. Note that in the meta_bg case,
 however, the first and last two block groups within the larger meta
 group contain only group descriptors for the groups inside the meta
 group.
 
-flex\_bg and meta\_bg do not appear to be mutually exclusive features.
+flex_bg and meta_bg do not appear to be mutually exclusive features.
 
 In ext2, ext3, and ext4 (when the 64bit feature is not enabled), the
 block group descriptor was only 32 bytes long and therefore ends at
-bg\_checksum. On an ext4 filesystem with the 64bit feature enabled, the
+bg_checksum. On an ext4 filesystem with the 64bit feature enabled, the
 block group descriptor expands to at least the 64 bytes described below;
 the size is stored in the superblock.
 
-If gdt\_csum is set and metadata\_csum is not set, the block group
+If gdt_csum is set and metadata_csum is not set, the block group
 checksum is the crc16 of the FS UUID, the group number, and the group
-descriptor structure. If metadata\_csum is set, then the block group
+descriptor structure. If metadata_csum is set, then the block group
 checksum is the lower 16 bits of the checksum of the FS UUID, the group
 number, and the group descriptor structure. Both block and inode bitmap
 checksums are calculated against the FS UUID, the group number, and the
@@ -51,59 +51,59 @@ The block group descriptor is laid out in ``struct ext4_group_desc``.
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - bg\_block\_bitmap\_lo
+     - __le32
+     - bg_block_bitmap_lo
      - Lower 32-bits of location of block bitmap.
    * - 0x4
-     - \_\_le32
-     - bg\_inode\_bitmap\_lo
+     - __le32
+     - bg_inode_bitmap_lo
      - Lower 32-bits of location of inode bitmap.
    * - 0x8
-     - \_\_le32
-     - bg\_inode\_table\_lo
+     - __le32
+     - bg_inode_table_lo
      - Lower 32-bits of location of inode table.
    * - 0xC
-     - \_\_le16
-     - bg\_free\_blocks\_count\_lo
+     - __le16
+     - bg_free_blocks_count_lo
      - Lower 16-bits of free block count.
    * - 0xE
-     - \_\_le16
-     - bg\_free\_inodes\_count\_lo
+     - __le16
+     - bg_free_inodes_count_lo
      - Lower 16-bits of free inode count.
    * - 0x10
-     - \_\_le16
-     - bg\_used\_dirs\_count\_lo
+     - __le16
+     - bg_used_dirs_count_lo
      - Lower 16-bits of directory count.
    * - 0x12
-     - \_\_le16
-     - bg\_flags
+     - __le16
+     - bg_flags
      - Block group flags. See the bgflags_ table below.
    * - 0x14
-     - \_\_le32
-     - bg\_exclude\_bitmap\_lo
+     - __le32
+     - bg_exclude_bitmap_lo
      - Lower 32-bits of location of snapshot exclusion bitmap.
    * - 0x18
-     - \_\_le16
-     - bg\_block\_bitmap\_csum\_lo
+     - __le16
+     - bg_block_bitmap_csum_lo
      - Lower 16-bits of the block bitmap checksum.
    * - 0x1A
-     - \_\_le16
-     - bg\_inode\_bitmap\_csum\_lo
+     - __le16
+     - bg_inode_bitmap_csum_lo
      - Lower 16-bits of the inode bitmap checksum.
    * - 0x1C
-     - \_\_le16
-     - bg\_itable\_unused\_lo
+     - __le16
+     - bg_itable_unused_lo
      - Lower 16-bits of unused inode count. If set, we needn't scan past the
-       ``(sb.s_inodes_per_group - gdt.bg_itable_unused)``\ th entry in the
+       ``(sb.s_inodes_per_group - gdt.bg_itable_unused)`` th entry in the
        inode table for this group.
    * - 0x1E
-     - \_\_le16
-     - bg\_checksum
-     - Group descriptor checksum; crc16(sb\_uuid+group\_num+bg\_desc) if the
-       RO\_COMPAT\_GDT\_CSUM feature is set, or
-       crc32c(sb\_uuid+group\_num+bg\_desc) & 0xFFFF if the
-       RO\_COMPAT\_METADATA\_CSUM feature is set.  The bg\_checksum
-       field in bg\_desc is skipped when calculating crc16 checksum,
+     - __le16
+     - bg_checksum
+     - Group descriptor checksum; crc16(sb_uuid+group_num+bg_desc) if the
+       RO_COMPAT_GDT_CSUM feature is set, or
+       crc32c(sb_uuid+group_num+bg_desc) & 0xFFFF if the
+       RO_COMPAT_METADATA_CSUM feature is set.  The bg_checksum
+       field in bg_desc is skipped when calculating crc16 checksum,
        and set to zero if crc32c checksum is used.
    * -
      -
@@ -111,48 +111,48 @@ The block group descriptor is laid out in ``struct ext4_group_desc``.
      - These fields only exist if the 64bit feature is enabled and s_desc_size
        > 32.
    * - 0x20
-     - \_\_le32
-     - bg\_block\_bitmap\_hi
+     - __le32
+     - bg_block_bitmap_hi
      - Upper 32-bits of location of block bitmap.
    * - 0x24
-     - \_\_le32
-     - bg\_inode\_bitmap\_hi
+     - __le32
+     - bg_inode_bitmap_hi
      - Upper 32-bits of location of inodes bitmap.
    * - 0x28
-     - \_\_le32
-     - bg\_inode\_table\_hi
+     - __le32
+     - bg_inode_table_hi
      - Upper 32-bits of location of inodes table.
    * - 0x2C
-     - \_\_le16
-     - bg\_free\_blocks\_count\_hi
+     - __le16
+     - bg_free_blocks_count_hi
      - Upper 16-bits of free block count.
    * - 0x2E
-     - \_\_le16
-     - bg\_free\_inodes\_count\_hi
+     - __le16
+     - bg_free_inodes_count_hi
      - Upper 16-bits of free inode count.
    * - 0x30
-     - \_\_le16
-     - bg\_used\_dirs\_count\_hi
+     - __le16
+     - bg_used_dirs_count_hi
      - Upper 16-bits of directory count.
    * - 0x32
-     - \_\_le16
-     - bg\_itable\_unused\_hi
+     - __le16
+     - bg_itable_unused_hi
      - Upper 16-bits of unused inode count.
    * - 0x34
-     - \_\_le32
-     - bg\_exclude\_bitmap\_hi
+     - __le32
+     - bg_exclude_bitmap_hi
      - Upper 32-bits of location of snapshot exclusion bitmap.
    * - 0x38
-     - \_\_le16
-     - bg\_block\_bitmap\_csum\_hi
+     - __le16
+     - bg_block_bitmap_csum_hi
      - Upper 16-bits of the block bitmap checksum.
    * - 0x3A
-     - \_\_le16
-     - bg\_inode\_bitmap\_csum\_hi
+     - __le16
+     - bg_inode_bitmap_csum_hi
      - Upper 16-bits of the inode bitmap checksum.
    * - 0x3C
-     - \_\_u32
-     - bg\_reserved
+     - __u32
+     - bg_reserved
      - Padding to 64 bytes.
 
 .. _bgflags:
@@ -166,8 +166,8 @@ Block group flags can be any combination of the following:
    * - Value
      - Description
    * - 0x1
-     - inode table and bitmap are not initialized (EXT4\_BG\_INODE\_UNINIT).
+     - inode table and bitmap are not initialized (EXT4_BG_INODE_UNINIT).
    * - 0x2
-     - block bitmap is not initialized (EXT4\_BG\_BLOCK\_UNINIT).
+     - block bitmap is not initialized (EXT4_BG_BLOCK_UNINIT).
    * - 0x4
-     - inode table is zeroed (EXT4\_BG\_INODE\_ZEROED).
+     - inode table is zeroed (EXT4_BG_INODE_ZEROED).
diff --git a/Documentation/filesystems/ext4/ifork.rst b/Documentation/filesystems/ext4/ifork.rst
index b9816d5a896b..dc31f505e6c8 100644
--- a/Documentation/filesystems/ext4/ifork.rst
+++ b/Documentation/filesystems/ext4/ifork.rst
@@ -1,6 +1,6 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-The Contents of inode.i\_block
+The Contents of inode.i_block
 ------------------------------
 
 Depending on the type of file an inode describes, the 60 bytes of
@@ -47,7 +47,7 @@ In ext4, the file to logical block map has been replaced with an extent
 tree. Under the old scheme, allocating a contiguous run of 1,000 blocks
 requires an indirect block to map all 1,000 entries; with extents, the
 mapping is reduced to a single ``struct ext4_extent`` with
-``ee_len = 1000``. If flex\_bg is enabled, it is possible to allocate
+``ee_len = 1000``. If flex_bg is enabled, it is possible to allocate
 very large files with a single extent, at a considerable reduction in
 metadata block use, and some improvement in disk efficiency. The inode
 must have the extents flag (0x80000) flag set for this feature to be in
@@ -76,28 +76,28 @@ which is 12 bytes long:
      - Name
      - Description
    * - 0x0
-     - \_\_le16
-     - eh\_magic
+     - __le16
+     - eh_magic
      - Magic number, 0xF30A.
    * - 0x2
-     - \_\_le16
-     - eh\_entries
+     - __le16
+     - eh_entries
      - Number of valid entries following the header.
    * - 0x4
-     - \_\_le16
-     - eh\_max
+     - __le16
+     - eh_max
      - Maximum number of entries that could follow the header.
    * - 0x6
-     - \_\_le16
-     - eh\_depth
+     - __le16
+     - eh_depth
      - Depth of this extent node in the extent tree. 0 = this extent node
        points to data blocks; otherwise, this extent node points to other
        extent nodes. The extent tree can be at most 5 levels deep: a logical
        block number can be at most ``2^32``, and the smallest ``n`` that
        satisfies ``4*(((blocksize - 12)/12)^n) >= 2^32`` is 5.
    * - 0x8
-     - \_\_le32
-     - eh\_generation
+     - __le32
+     - eh_generation
      - Generation of the tree. (Used by Lustre, but not standard ext4).
 
 Internal nodes of the extent tree, also known as index nodes, are
@@ -112,22 +112,22 @@ recorded as ``struct ext4_extent_idx``, and are 12 bytes long:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - ei\_block
+     - __le32
+     - ei_block
      - This index node covers file blocks from 'block' onward.
    * - 0x4
-     - \_\_le32
-     - ei\_leaf\_lo
+     - __le32
+     - ei_leaf_lo
      - Lower 32-bits of the block number of the extent node that is the next
        level lower in the tree. The tree node pointed to can be either another
        internal node or a leaf node, described below.
    * - 0x8
-     - \_\_le16
-     - ei\_leaf\_hi
+     - __le16
+     - ei_leaf_hi
      - Upper 16-bits of the previous field.
    * - 0xA
-     - \_\_u16
-     - ei\_unused
+     - __u16
+     - ei_unused
      -
 
 Leaf nodes of the extent tree are recorded as ``struct ext4_extent``,
@@ -142,24 +142,24 @@ and are also 12 bytes long:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - ee\_block
+     - __le32
+     - ee_block
      - First file block number that this extent covers.
    * - 0x4
-     - \_\_le16
-     - ee\_len
+     - __le16
+     - ee_len
      - Number of blocks covered by extent. If the value of this field is <=
        32768, the extent is initialized. If the value of the field is > 32768,
        the extent is uninitialized and the actual extent length is ``ee_len`` -
        32768. Therefore, the maximum length of a initialized extent is 32768
        blocks, and the maximum length of an uninitialized extent is 32767.
    * - 0x6
-     - \_\_le16
-     - ee\_start\_hi
+     - __le16
+     - ee_start_hi
      - Upper 16-bits of the block number to which this extent points.
    * - 0x8
-     - \_\_le32
-     - ee\_start\_lo
+     - __le32
+     - ee_start_lo
      - Lower 32-bits of the block number to which this extent points.
 
 Prior to the introduction of metadata checksums, the extent header +
@@ -182,8 +182,8 @@ including) the checksum itself.
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - eb\_checksum
+     - __le32
+     - eb_checksum
      - Checksum of the extent block, crc32c(uuid+inum+igeneration+extentblock)
 
 Inline Data
diff --git a/Documentation/filesystems/ext4/inlinedata.rst b/Documentation/filesystems/ext4/inlinedata.rst
index d1075178ce0b..a728af0d2fd0 100644
--- a/Documentation/filesystems/ext4/inlinedata.rst
+++ b/Documentation/filesystems/ext4/inlinedata.rst
@@ -11,12 +11,12 @@ file is smaller than 60 bytes, then the data are stored inline in
 attribute space, then it might be found as an extended attribute
 “system.data” within the inode body (“ibody EA”). This of course
 constrains the amount of extended attributes one can attach to an inode.
-If the data size increases beyond i\_block + ibody EA, a regular block
+If the data size increases beyond i_block + ibody EA, a regular block
 is allocated and the contents moved to that block.
 
 Pending a change to compact the extended attribute key used to store
 inline data, one ought to be able to store 160 bytes of data in a
-256-byte inode (as of June 2015, when i\_extra\_isize is 28). Prior to
+256-byte inode (as of June 2015, when i_extra_isize is 28). Prior to
 that, the limit was 156 bytes due to inefficient use of inode space.
 
 The inline data feature requires the presence of an extended attribute
@@ -25,12 +25,12 @@ for “system.data”, even if the attribute value is zero length.
 Inline Directories
 ~~~~~~~~~~~~~~~~~~
 
-The first four bytes of i\_block are the inode number of the parent
+The first four bytes of i_block are the inode number of the parent
 directory. Following that is a 56-byte space for an array of directory
 entries; see ``struct ext4_dir_entry``. If there is a “system.data”
 attribute in the inode body, the EA value is an array of
 ``struct ext4_dir_entry`` as well. Note that for inline directories, the
-i\_block and EA space are treated as separate dirent blocks; directory
+i_block and EA space are treated as separate dirent blocks; directory
 entries cannot span the two.
 
 Inline directory entries are not checksummed, as the inode checksum
diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index 6c5ce666e63f..cfc6c1659931 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -38,138 +38,138 @@ The inode table entry is laid out in ``struct ext4_inode``.
      - Name
      - Description
    * - 0x0
-     - \_\_le16
-     - i\_mode
+     - __le16
+     - i_mode
      - File mode. See the table i_mode_ below.
    * - 0x2
-     - \_\_le16
-     - i\_uid
+     - __le16
+     - i_uid
      - Lower 16-bits of Owner UID.
    * - 0x4
-     - \_\_le32
-     - i\_size\_lo
+     - __le32
+     - i_size_lo
      - Lower 32-bits of size in bytes.
    * - 0x8
-     - \_\_le32
-     - i\_atime
-     - Last access time, in seconds since the epoch. However, if the EA\_INODE
+     - __le32
+     - i_atime
+     - Last access time, in seconds since the epoch. However, if the EA_INODE
        inode flag is set, this inode stores an extended attribute value and
        this field contains the checksum of the value.
    * - 0xC
-     - \_\_le32
-     - i\_ctime
+     - __le32
+     - i_ctime
      - Last inode change time, in seconds since the epoch. However, if the
-       EA\_INODE inode flag is set, this inode stores an extended attribute
+       EA_INODE inode flag is set, this inode stores an extended attribute
        value and this field contains the lower 32 bits of the attribute value's
        reference count.
    * - 0x10
-     - \_\_le32
-     - i\_mtime
+     - __le32
+     - i_mtime
      - Last data modification time, in seconds since the epoch. However, if the
-       EA\_INODE inode flag is set, this inode stores an extended attribute
+       EA_INODE inode flag is set, this inode stores an extended attribute
        value and this field contains the number of the inode that owns the
        extended attribute.
    * - 0x14
-     - \_\_le32
-     - i\_dtime
+     - __le32
+     - i_dtime
      - Deletion Time, in seconds since the epoch.
    * - 0x18
-     - \_\_le16
-     - i\_gid
+     - __le16
+     - i_gid
      - Lower 16-bits of GID.
    * - 0x1A
-     - \_\_le16
-     - i\_links\_count
+     - __le16
+     - i_links_count
      - Hard link count. Normally, ext4 does not permit an inode to have more
        than 65,000 hard links. This applies to files as well as directories,
        which means that there cannot be more than 64,998 subdirectories in a
        directory (each subdirectory's '..' entry counts as a hard link, as does
-       the '.' entry in the directory itself). With the DIR\_NLINK feature
+       the '.' entry in the directory itself). With the DIR_NLINK feature
        enabled, ext4 supports more than 64,998 subdirectories by setting this
        field to 1 to indicate that the number of hard links is not known.
    * - 0x1C
-     - \_\_le32
-     - i\_blocks\_lo
-     - Lower 32-bits of “block” count. If the huge\_file feature flag is not
+     - __le32
+     - i_blocks_lo
+     - Lower 32-bits of “block” count. If the huge_file feature flag is not
        set on the filesystem, the file consumes ``i_blocks_lo`` 512-byte blocks
-       on disk. If huge\_file is set and EXT4\_HUGE\_FILE\_FL is NOT set in
+       on disk. If huge_file is set and EXT4_HUGE_FILE_FL is NOT set in
        ``inode.i_flags``, then the file consumes ``i_blocks_lo + (i_blocks_hi
-       << 32)`` 512-byte blocks on disk. If huge\_file is set and
-       EXT4\_HUGE\_FILE\_FL IS set in ``inode.i_flags``, then this file
+       << 32)`` 512-byte blocks on disk. If huge_file is set and
+       EXT4_HUGE_FILE_FL IS set in ``inode.i_flags``, then this file
        consumes (``i_blocks_lo + i_blocks_hi`` << 32) filesystem blocks on
        disk.
    * - 0x20
-     - \_\_le32
-     - i\_flags
+     - __le32
+     - i_flags
      - Inode flags. See the table i_flags_ below.
    * - 0x24
      - 4 bytes
-     - i\_osd1
+     - i_osd1
      - See the table i_osd1_ for more details.
    * - 0x28
      - 60 bytes
-     - i\_block[EXT4\_N\_BLOCKS=15]
-     - Block map or extent tree. See the section “The Contents of inode.i\_block”.
+     - i_block[EXT4_N_BLOCKS=15]
+     - Block map or extent tree. See the section “The Contents of inode.i_block”.
    * - 0x64
-     - \_\_le32
-     - i\_generation
+     - __le32
+     - i_generation
      - File version (for NFS).
    * - 0x68
-     - \_\_le32
-     - i\_file\_acl\_lo
+     - __le32
+     - i_file_acl_lo
      - Lower 32-bits of extended attribute block. ACLs are of course one of
        many possible extended attributes; I think the name of this field is a
        result of the first use of extended attributes being for ACLs.
    * - 0x6C
-     - \_\_le32
-     - i\_size\_high / i\_dir\_acl
+     - __le32
+     - i_size_high / i_dir_acl
      - Upper 32-bits of file/directory size. In ext2/3 this field was named
-       i\_dir\_acl, though it was usually set to zero and never used.
+       i_dir_acl, though it was usually set to zero and never used.
    * - 0x70
-     - \_\_le32
-     - i\_obso\_faddr
+     - __le32
+     - i_obso_faddr
      - (Obsolete) fragment address.
    * - 0x74
      - 12 bytes
-     - i\_osd2
+     - i_osd2
      - See the table i_osd2_ for more details.
    * - 0x80
-     - \_\_le16
-     - i\_extra\_isize
+     - __le16
+     - i_extra_isize
      - Size of this inode - 128. Alternately, the size of the extended inode
        fields beyond the original ext2 inode, including this field.
    * - 0x82
-     - \_\_le16
-     - i\_checksum\_hi
+     - __le16
+     - i_checksum_hi
      - Upper 16-bits of the inode checksum.
    * - 0x84
-     - \_\_le32
-     - i\_ctime\_extra
+     - __le32
+     - i_ctime_extra
      - Extra change time bits. This provides sub-second precision. See Inode
        Timestamps section.
    * - 0x88
-     - \_\_le32
-     - i\_mtime\_extra
+     - __le32
+     - i_mtime_extra
      - Extra modification time bits. This provides sub-second precision.
    * - 0x8C
-     - \_\_le32
-     - i\_atime\_extra
+     - __le32
+     - i_atime_extra
      - Extra access time bits. This provides sub-second precision.
    * - 0x90
-     - \_\_le32
-     - i\_crtime
+     - __le32
+     - i_crtime
      - File creation time, in seconds since the epoch.
    * - 0x94
-     - \_\_le32
-     - i\_crtime\_extra
+     - __le32
+     - i_crtime_extra
      - Extra file creation time bits. This provides sub-second precision.
    * - 0x98
-     - \_\_le32
-     - i\_version\_hi
+     - __le32
+     - i_version_hi
      - Upper 32-bits for version number.
    * - 0x9C
-     - \_\_le32
-     - i\_projid
+     - __le32
+     - i_projid
      - Project ID.
 
 .. _i_mode:
@@ -183,45 +183,45 @@ The ``i_mode`` value is a combination of the following flags:
    * - Value
      - Description
    * - 0x1
-     - S\_IXOTH (Others may execute)
+     - S_IXOTH (Others may execute)
    * - 0x2
-     - S\_IWOTH (Others may write)
+     - S_IWOTH (Others may write)
    * - 0x4
-     - S\_IROTH (Others may read)
+     - S_IROTH (Others may read)
    * - 0x8
-     - S\_IXGRP (Group members may execute)
+     - S_IXGRP (Group members may execute)
    * - 0x10
-     - S\_IWGRP (Group members may write)
+     - S_IWGRP (Group members may write)
    * - 0x20
-     - S\_IRGRP (Group members may read)
+     - S_IRGRP (Group members may read)
    * - 0x40
-     - S\_IXUSR (Owner may execute)
+     - S_IXUSR (Owner may execute)
    * - 0x80
-     - S\_IWUSR (Owner may write)
+     - S_IWUSR (Owner may write)
    * - 0x100
-     - S\_IRUSR (Owner may read)
+     - S_IRUSR (Owner may read)
    * - 0x200
-     - S\_ISVTX (Sticky bit)
+     - S_ISVTX (Sticky bit)
    * - 0x400
-     - S\_ISGID (Set GID)
+     - S_ISGID (Set GID)
    * - 0x800
-     - S\_ISUID (Set UID)
+     - S_ISUID (Set UID)
    * -
      - These are mutually-exclusive file types:
    * - 0x1000
-     - S\_IFIFO (FIFO)
+     - S_IFIFO (FIFO)
    * - 0x2000
-     - S\_IFCHR (Character device)
+     - S_IFCHR (Character device)
    * - 0x4000
-     - S\_IFDIR (Directory)
+     - S_IFDIR (Directory)
    * - 0x6000
-     - S\_IFBLK (Block device)
+     - S_IFBLK (Block device)
    * - 0x8000
-     - S\_IFREG (Regular file)
+     - S_IFREG (Regular file)
    * - 0xA000
-     - S\_IFLNK (Symbolic link)
+     - S_IFLNK (Symbolic link)
    * - 0xC000
-     - S\_IFSOCK (Socket)
+     - S_IFSOCK (Socket)
 
 .. _i_flags:
 
@@ -234,56 +234,56 @@ The ``i_flags`` field is a combination of these values:
    * - Value
      - Description
    * - 0x1
-     - This file requires secure deletion (EXT4\_SECRM\_FL). (not implemented)
+     - This file requires secure deletion (EXT4_SECRM_FL). (not implemented)
    * - 0x2
      - This file should be preserved, should undeletion be desired
-       (EXT4\_UNRM\_FL). (not implemented)
+       (EXT4_UNRM_FL). (not implemented)
    * - 0x4
-     - File is compressed (EXT4\_COMPR\_FL). (not really implemented)
+     - File is compressed (EXT4_COMPR_FL). (not really implemented)
    * - 0x8
-     - All writes to the file must be synchronous (EXT4\_SYNC\_FL).
+     - All writes to the file must be synchronous (EXT4_SYNC_FL).
    * - 0x10
-     - File is immutable (EXT4\_IMMUTABLE\_FL).
+     - File is immutable (EXT4_IMMUTABLE_FL).
    * - 0x20
-     - File can only be appended (EXT4\_APPEND\_FL).
+     - File can only be appended (EXT4_APPEND_FL).
    * - 0x40
-     - The dump(1) utility should not dump this file (EXT4\_NODUMP\_FL).
+     - The dump(1) utility should not dump this file (EXT4_NODUMP_FL).
    * - 0x80
-     - Do not update access time (EXT4\_NOATIME\_FL).
+     - Do not update access time (EXT4_NOATIME_FL).
    * - 0x100
-     - Dirty compressed file (EXT4\_DIRTY\_FL). (not used)
+     - Dirty compressed file (EXT4_DIRTY_FL). (not used)
    * - 0x200
-     - File has one or more compressed clusters (EXT4\_COMPRBLK\_FL). (not used)
+     - File has one or more compressed clusters (EXT4_COMPRBLK_FL). (not used)
    * - 0x400
-     - Do not compress file (EXT4\_NOCOMPR\_FL). (not used)
+     - Do not compress file (EXT4_NOCOMPR_FL). (not used)
    * - 0x800
-     - Encrypted inode (EXT4\_ENCRYPT\_FL). This bit value previously was
-       EXT4\_ECOMPR\_FL (compression error), which was never used.
+     - Encrypted inode (EXT4_ENCRYPT_FL). This bit value previously was
+       EXT4_ECOMPR_FL (compression error), which was never used.
    * - 0x1000
-     - Directory has hashed indexes (EXT4\_INDEX\_FL).
+     - Directory has hashed indexes (EXT4_INDEX_FL).
    * - 0x2000
-     - AFS magic directory (EXT4\_IMAGIC\_FL).
+     - AFS magic directory (EXT4_IMAGIC_FL).
    * - 0x4000
      - File data must always be written through the journal
-       (EXT4\_JOURNAL\_DATA\_FL).
+       (EXT4_JOURNAL_DATA_FL).
    * - 0x8000
-     - File tail should not be merged (EXT4\_NOTAIL\_FL). (not used by ext4)
+     - File tail should not be merged (EXT4_NOTAIL_FL). (not used by ext4)
    * - 0x10000
      - All directory entry data should be written synchronously (see
-       ``dirsync``) (EXT4\_DIRSYNC\_FL).
+       ``dirsync``) (EXT4_DIRSYNC_FL).
    * - 0x20000
-     - Top of directory hierarchy (EXT4\_TOPDIR\_FL).
+     - Top of directory hierarchy (EXT4_TOPDIR_FL).
    * - 0x40000
-     - This is a huge file (EXT4\_HUGE\_FILE\_FL).
+     - This is a huge file (EXT4_HUGE_FILE_FL).
    * - 0x80000
-     - Inode uses extents (EXT4\_EXTENTS\_FL).
+     - Inode uses extents (EXT4_EXTENTS_FL).
    * - 0x100000
-     - Verity protected file (EXT4\_VERITY\_FL).
+     - Verity protected file (EXT4_VERITY_FL).
    * - 0x200000
      - Inode stores a large extended attribute value in its data blocks
-       (EXT4\_EA\_INODE\_FL).
+       (EXT4_EA_INODE_FL).
    * - 0x400000
-     - This file has blocks allocated past EOF (EXT4\_EOFBLOCKS\_FL).
+     - This file has blocks allocated past EOF (EXT4_EOFBLOCKS_FL).
        (deprecated)
    * - 0x01000000
      - Inode is a snapshot (``EXT4_SNAPFILE_FL``). (not in mainline)
@@ -294,21 +294,21 @@ The ``i_flags`` field is a combination of these values:
      - Snapshot shrink has completed (``EXT4_SNAPFILE_SHRUNK_FL``). (not in
        mainline)
    * - 0x10000000
-     - Inode has inline data (EXT4\_INLINE\_DATA\_FL).
+     - Inode has inline data (EXT4_INLINE_DATA_FL).
    * - 0x20000000
-     - Create children with the same project ID (EXT4\_PROJINHERIT\_FL).
+     - Create children with the same project ID (EXT4_PROJINHERIT_FL).
    * - 0x80000000
-     - Reserved for ext4 library (EXT4\_RESERVED\_FL).
+     - Reserved for ext4 library (EXT4_RESERVED_FL).
    * -
      - Aggregate flags:
    * - 0x705BDFFF
      - User-visible flags.
    * - 0x604BC0FF
-     - User-modifiable flags. Note that while EXT4\_JOURNAL\_DATA\_FL and
-       EXT4\_EXTENTS\_FL can be set with setattr, they are not in the kernel's
-       EXT4\_FL\_USER\_MODIFIABLE mask, since it needs to handle the setting of
+     - User-modifiable flags. Note that while EXT4_JOURNAL_DATA_FL and
+       EXT4_EXTENTS_FL can be set with setattr, they are not in the kernel's
+       EXT4_FL_USER_MODIFIABLE mask, since it needs to handle the setting of
        these flags in a special manner and they are masked out of the set of
-       flags that are saved directly to i\_flags.
+       flags that are saved directly to i_flags.
 
 .. _i_osd1:
 
@@ -325,9 +325,9 @@ Linux:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - l\_i\_version
-     - Inode version. However, if the EA\_INODE inode flag is set, this inode
+     - __le32
+     - l_i_version
+     - Inode version. However, if the EA_INODE inode flag is set, this inode
        stores an extended attribute value and this field contains the upper 32
        bits of the attribute value's reference count.
 
@@ -342,8 +342,8 @@ Hurd:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - h\_i\_translator
+     - __le32
+     - h_i_translator
      - ??
 
 Masix:
@@ -357,8 +357,8 @@ Masix:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - m\_i\_reserved
+     - __le32
+     - m_i_reserved
      - ??
 
 .. _i_osd2:
@@ -376,30 +376,30 @@ Linux:
      - Name
      - Description
    * - 0x0
-     - \_\_le16
-     - l\_i\_blocks\_high
+     - __le16
+     - l_i_blocks_high
      - Upper 16-bits of the block count. Please see the note attached to
-       i\_blocks\_lo.
+       i_blocks_lo.
    * - 0x2
-     - \_\_le16
-     - l\_i\_file\_acl\_high
+     - __le16
+     - l_i_file_acl_high
      - Upper 16-bits of the extended attribute block (historically, the file
        ACL location). See the Extended Attributes section below.
    * - 0x4
-     - \_\_le16
-     - l\_i\_uid\_high
+     - __le16
+     - l_i_uid_high
      - Upper 16-bits of the Owner UID.
    * - 0x6
-     - \_\_le16
-     - l\_i\_gid\_high
+     - __le16
+     - l_i_gid_high
      - Upper 16-bits of the GID.
    * - 0x8
-     - \_\_le16
-     - l\_i\_checksum\_lo
+     - __le16
+     - l_i_checksum_lo
      - Lower 16-bits of the inode checksum.
    * - 0xA
-     - \_\_le16
-     - l\_i\_reserved
+     - __le16
+     - l_i_reserved
      - Unused.
 
 Hurd:
@@ -413,24 +413,24 @@ Hurd:
      - Name
      - Description
    * - 0x0
-     - \_\_le16
-     - h\_i\_reserved1
+     - __le16
+     - h_i_reserved1
      - ??
    * - 0x2
-     - \_\_u16
-     - h\_i\_mode\_high
+     - __u16
+     - h_i_mode_high
      - Upper 16-bits of the file mode.
    * - 0x4
-     - \_\_le16
-     - h\_i\_uid\_high
+     - __le16
+     - h_i_uid_high
      - Upper 16-bits of the Owner UID.
    * - 0x6
-     - \_\_le16
-     - h\_i\_gid\_high
+     - __le16
+     - h_i_gid_high
      - Upper 16-bits of the GID.
    * - 0x8
-     - \_\_u32
-     - h\_i\_author
+     - __u32
+     - h_i_author
      - Author code?
 
 Masix:
@@ -444,17 +444,17 @@ Masix:
      - Name
      - Description
    * - 0x0
-     - \_\_le16
-     - h\_i\_reserved1
+     - __le16
+     - h_i_reserved1
      - ??
    * - 0x2
-     - \_\_u16
-     - m\_i\_file\_acl\_high
+     - __u16
+     - m_i_file_acl_high
      - Upper 16-bits of the extended attribute block (historically, the file
        ACL location).
    * - 0x4
-     - \_\_u32
-     - m\_i\_reserved2[2]
+     - __u32
+     - m_i_reserved2[2]
      - ??
 
 Inode Size
@@ -466,11 +466,11 @@ In ext2 and ext3, the inode structure size was fixed at 128 bytes
 on-disk inode at format time for all inodes in the filesystem to provide
 space beyond the end of the original ext2 inode. The on-disk inode
 record size is recorded in the superblock as ``s_inode_size``. The
-number of bytes actually used by struct ext4\_inode beyond the original
+number of bytes actually used by struct ext4_inode beyond the original
 128-byte ext2 inode is recorded in the ``i_extra_isize`` field for each
-inode, which allows struct ext4\_inode to grow for a new kernel without
+inode, which allows struct ext4_inode to grow for a new kernel without
 having to upgrade all of the on-disk inodes. Access to fields beyond
-EXT2\_GOOD\_OLD\_INODE\_SIZE should be verified to be within
+EXT2_GOOD_OLD_INODE_SIZE should be verified to be within
 ``i_extra_isize``. By default, ext4 inode records are 256 bytes, and (as
 of August 2019) the inode structure is 160 bytes
 (``i_extra_isize = 32``). The extra space between the end of the inode
@@ -516,7 +516,7 @@ creation time (crtime); this field is 64-bits wide and decoded in the
 same manner as 64-bit [cma]time. Neither crtime nor dtime are accessible
 through the regular stat() interface, though debugfs will report them.
 
-We use the 32-bit signed time value plus (2^32 \* (extra epoch bits)).
+We use the 32-bit signed time value plus (2^32 * (extra epoch bits)).
 In other words:
 
 .. list-table::
@@ -525,8 +525,8 @@ In other words:
 
    * - Extra epoch bits
      - MSB of 32-bit time
-     - Adjustment for signed 32-bit to 64-bit tv\_sec
-     - Decoded 64-bit tv\_sec
+     - Adjustment for signed 32-bit to 64-bit tv_sec
+     - Decoded 64-bit tv_sec
      - valid time range
    * - 0 0
      - 1
diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index 5fad38860f17..a6bef5293a60 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -63,8 +63,8 @@ Generally speaking, the journal has this format:
    :header-rows: 1
 
    * - Superblock
-     - descriptor\_block (data\_blocks or revocation\_block) [more data or
-       revocations] commmit\_block
+     - descriptor_block (data_blocks or revocation_block) [more data or
+       revocations] commmit_block
      - [more transactions...]
    * - 
      - One transaction
@@ -93,8 +93,8 @@ superblock.
    * - 1024 bytes of padding
      - ext4 Superblock
      - Journal Superblock
-     - descriptor\_block (data\_blocks or revocation\_block) [more data or
-       revocations] commmit\_block
+     - descriptor_block (data_blocks or revocation_block) [more data or
+       revocations] commmit_block
      - [more transactions...]
    * - 
      -
@@ -117,17 +117,17 @@ Every block in the journal starts with a common 12-byte header
      - Name
      - Description
    * - 0x0
-     - \_\_be32
-     - h\_magic
+     - __be32
+     - h_magic
      - jbd2 magic number, 0xC03B3998.
    * - 0x4
-     - \_\_be32
-     - h\_blocktype
+     - __be32
+     - h_blocktype
      - Description of what this block contains. See the jbd2_blocktype_ table
        below.
    * - 0x8
-     - \_\_be32
-     - h\_sequence
+     - __be32
+     - h_sequence
      - The transaction ID that goes with this block.
 
 .. _jbd2_blocktype:
@@ -177,99 +177,99 @@ which is 1024 bytes long:
      -
      - Static information describing the journal.
    * - 0x0
-     - journal\_header\_t (12 bytes)
-     - s\_header
+     - journal_header_t (12 bytes)
+     - s_header
      - Common header identifying this as a superblock.
    * - 0xC
-     - \_\_be32
-     - s\_blocksize
+     - __be32
+     - s_blocksize
      - Journal device block size.
    * - 0x10
-     - \_\_be32
-     - s\_maxlen
+     - __be32
+     - s_maxlen
      - Total number of blocks in this journal.
    * - 0x14
-     - \_\_be32
-     - s\_first
+     - __be32
+     - s_first
      - First block of log information.
    * -
      -
      -
      - Dynamic information describing the current state of the log.
    * - 0x18
-     - \_\_be32
-     - s\_sequence
+     - __be32
+     - s_sequence
      - First commit ID expected in log.
    * - 0x1C
-     - \_\_be32
-     - s\_start
+     - __be32
+     - s_start
      - Block number of the start of log. Contrary to the comments, this field
        being zero does not imply that the journal is clean!
    * - 0x20
-     - \_\_be32
-     - s\_errno
-     - Error value, as set by jbd2\_journal\_abort().
+     - __be32
+     - s_errno
+     - Error value, as set by jbd2_journal_abort().
    * -
      -
      -
      - The remaining fields are only valid in a v2 superblock.
    * - 0x24
-     - \_\_be32
-     - s\_feature\_compat;
+     - __be32
+     - s_feature_compat;
      - Compatible feature set. See the table jbd2_compat_ below.
    * - 0x28
-     - \_\_be32
-     - s\_feature\_incompat
+     - __be32
+     - s_feature_incompat
      - Incompatible feature set. See the table jbd2_incompat_ below.
    * - 0x2C
-     - \_\_be32
-     - s\_feature\_ro\_compat
+     - __be32
+     - s_feature_ro_compat
      - Read-only compatible feature set. There aren't any of these currently.
    * - 0x30
-     - \_\_u8
-     - s\_uuid[16]
+     - __u8
+     - s_uuid[16]
      - 128-bit uuid for journal. This is compared against the copy in the ext4
        super block at mount time.
    * - 0x40
-     - \_\_be32
-     - s\_nr\_users
+     - __be32
+     - s_nr_users
      - Number of file systems sharing this journal.
    * - 0x44
-     - \_\_be32
-     - s\_dynsuper
+     - __be32
+     - s_dynsuper
      - Location of dynamic super block copy. (Not used?)
    * - 0x48
-     - \_\_be32
-     - s\_max\_transaction
+     - __be32
+     - s_max_transaction
      - Limit of journal blocks per transaction. (Not used?)
    * - 0x4C
-     - \_\_be32
-     - s\_max\_trans\_data
+     - __be32
+     - s_max_trans_data
      - Limit of data blocks per transaction. (Not used?)
    * - 0x50
-     - \_\_u8
-     - s\_checksum\_type
+     - __u8
+     - s_checksum_type
      - Checksum algorithm used for the journal.  See jbd2_checksum_type_ for
        more info.
    * - 0x51
-     - \_\_u8[3]
-     - s\_padding2
+     - __u8[3]
+     - s_padding2
      -
    * - 0x54
-     - \_\_be32
-     - s\_num\_fc\_blocks
+     - __be32
+     - s_num_fc_blocks
      - Number of fast commit blocks in the journal.
    * - 0x58
-     - \_\_u32
-     - s\_padding[42]
+     - __u32
+     - s_padding[42]
      -
    * - 0xFC
-     - \_\_be32
-     - s\_checksum
+     - __be32
+     - s_checksum
      - Checksum of the entire superblock, with this field set to zero.
    * - 0x100
-     - \_\_u8
-     - s\_users[16\*48]
+     - __u8
+     - s_users[16*48]
      - ids of all file systems sharing the log. e2fsprogs/Linux don't allow
        shared external journals, but I imagine Lustre (or ocfs2?), which use
        the jbd2 code, might.
@@ -286,7 +286,7 @@ The journal compat features are any combination of the following:
      - Description
    * - 0x1
      - Journal maintains checksums on the data blocks.
-       (JBD2\_FEATURE\_COMPAT\_CHECKSUM)
+       (JBD2_FEATURE_COMPAT_CHECKSUM)
 
 .. _jbd2_incompat:
 
@@ -299,23 +299,23 @@ The journal incompat features are any combination of the following:
    * - Value
      - Description
    * - 0x1
-     - Journal has block revocation records. (JBD2\_FEATURE\_INCOMPAT\_REVOKE)
+     - Journal has block revocation records. (JBD2_FEATURE_INCOMPAT_REVOKE)
    * - 0x2
      - Journal can deal with 64-bit block numbers.
-       (JBD2\_FEATURE\_INCOMPAT\_64BIT)
+       (JBD2_FEATURE_INCOMPAT_64BIT)
    * - 0x4
-     - Journal commits asynchronously. (JBD2\_FEATURE\_INCOMPAT\_ASYNC\_COMMIT)
+     - Journal commits asynchronously. (JBD2_FEATURE_INCOMPAT_ASYNC_COMMIT)
    * - 0x8
      - This journal uses v2 of the checksum on-disk format. Each journal
        metadata block gets its own checksum, and the block tags in the
        descriptor table contain checksums for each of the data blocks in the
-       journal. (JBD2\_FEATURE\_INCOMPAT\_CSUM\_V2)
+       journal. (JBD2_FEATURE_INCOMPAT_CSUM_V2)
    * - 0x10
      - This journal uses v3 of the checksum on-disk format. This is the same as
        v2, but the journal block tag size is fixed regardless of the size of
-       block numbers. (JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3)
+       block numbers. (JBD2_FEATURE_INCOMPAT_CSUM_V3)
    * - 0x20
-     - Journal has fast commit blocks. (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT)
+     - Journal has fast commit blocks. (JBD2_FEATURE_INCOMPAT_FAST_COMMIT)
 
 .. _jbd2_checksum_type:
 
@@ -355,11 +355,11 @@ Descriptor blocks consume at least 36 bytes, but use a full block:
      - Name
      - Descriptor
    * - 0x0
-     - journal\_header\_t
+     - journal_header_t
      - (open coded)
      - Common block header.
    * - 0xC
-     - struct journal\_block\_tag\_s
+     - struct journal_block_tag_s
      - open coded array[]
      - Enough tags either to fill up the block or to describe all the data
        blocks that follow this descriptor block.
@@ -367,7 +367,7 @@ Descriptor blocks consume at least 36 bytes, but use a full block:
 Journal block tags have any of the following formats, depending on which
 journal feature and block tag flags are set.
 
-If JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3 is set, the journal block tag is
+If JBD2_FEATURE_INCOMPAT_CSUM_V3 is set, the journal block tag is
 defined as ``struct journal_block_tag3_s``, which looks like the
 following. The size is 16 or 32 bytes.
 
@@ -380,24 +380,24 @@ following. The size is 16 or 32 bytes.
      - Name
      - Descriptor
    * - 0x0
-     - \_\_be32
-     - t\_blocknr
+     - __be32
+     - t_blocknr
      - Lower 32-bits of the location of where the corresponding data block
        should end up on disk.
    * - 0x4
-     - \_\_be32
-     - t\_flags
+     - __be32
+     - t_flags
      - Flags that go with the descriptor. See the table jbd2_tag_flags_ for
        more info.
    * - 0x8
-     - \_\_be32
-     - t\_blocknr\_high
+     - __be32
+     - t_blocknr_high
      - Upper 32-bits of the location of where the corresponding data block
-       should end up on disk. This is zero if JBD2\_FEATURE\_INCOMPAT\_64BIT is
+       should end up on disk. This is zero if JBD2_FEATURE_INCOMPAT_64BIT is
        not enabled.
    * - 0xC
-     - \_\_be32
-     - t\_checksum
+     - __be32
+     - t_checksum
      - Checksum of the journal UUID, the sequence number, and the data block.
    * -
      -
@@ -433,7 +433,7 @@ The journal tag flags are any combination of the following:
    * - 0x8
      - This is the last tag in this descriptor block.
 
-If JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3 is NOT set, the journal block tag
+If JBD2_FEATURE_INCOMPAT_CSUM_V3 is NOT set, the journal block tag
 is defined as ``struct journal_block_tag_s``, which looks like the
 following. The size is 8, 12, 24, or 28 bytes:
 
@@ -446,18 +446,18 @@ following. The size is 8, 12, 24, or 28 bytes:
      - Name
      - Descriptor
    * - 0x0
-     - \_\_be32
-     - t\_blocknr
+     - __be32
+     - t_blocknr
      - Lower 32-bits of the location of where the corresponding data block
        should end up on disk.
    * - 0x4
-     - \_\_be16
-     - t\_checksum
+     - __be16
+     - t_checksum
      - Checksum of the journal UUID, the sequence number, and the data block.
        Note that only the lower 16 bits are stored.
    * - 0x6
-     - \_\_be16
-     - t\_flags
+     - __be16
+     - t_flags
      - Flags that go with the descriptor. See the table jbd2_tag_flags_ for
        more info.
    * -
@@ -466,8 +466,8 @@ following. The size is 8, 12, 24, or 28 bytes:
      - This next field is only present if the super block indicates support for
        64-bit block numbers.
    * - 0x8
-     - \_\_be32
-     - t\_blocknr\_high
+     - __be32
+     - t_blocknr_high
      - Upper 32-bits of the location of where the corresponding data block
        should end up on disk.
    * -
@@ -483,8 +483,8 @@ following. The size is 8, 12, 24, or 28 bytes:
        ``j_uuid`` field in ``struct journal_s``, but only tune2fs touches that
        field.
 
-If JBD2\_FEATURE\_INCOMPAT\_CSUM\_V2 or
-JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3 are set, the end of the block is a
+If JBD2_FEATURE_INCOMPAT_CSUM_V2 or
+JBD2_FEATURE_INCOMPAT_CSUM_V3 are set, the end of the block is a
 ``struct jbd2_journal_block_tail``, which looks like this:
 
 .. list-table::
@@ -496,8 +496,8 @@ JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3 are set, the end of the block is a
      - Name
      - Descriptor
    * - 0x0
-     - \_\_be32
-     - t\_checksum
+     - __be32
+     - t_checksum
      - Checksum of the journal UUID + the descriptor block, with this field set
        to zero.
 
@@ -538,25 +538,25 @@ length, but use a full block:
      - Name
      - Description
    * - 0x0
-     - journal\_header\_t
-     - r\_header
+     - journal_header_t
+     - r_header
      - Common block header.
    * - 0xC
-     - \_\_be32
-     - r\_count
+     - __be32
+     - r_count
      - Number of bytes used in this block.
    * - 0x10
-     - \_\_be32 or \_\_be64
+     - __be32 or __be64
      - blocks[0]
      - Blocks to revoke.
 
-After r\_count is a linear array of block numbers that are effectively
+After r_count is a linear array of block numbers that are effectively
 revoked by this transaction. The size of each block number is 8 bytes if
 the superblock advertises 64-bit block number support, or 4 bytes
 otherwise.
 
-If JBD2\_FEATURE\_INCOMPAT\_CSUM\_V2 or
-JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3 are set, the end of the revocation
+If JBD2_FEATURE_INCOMPAT_CSUM_V2 or
+JBD2_FEATURE_INCOMPAT_CSUM_V3 are set, the end of the revocation
 block is a ``struct jbd2_journal_revoke_tail``, which has this format:
 
 .. list-table::
@@ -568,8 +568,8 @@ block is a ``struct jbd2_journal_revoke_tail``, which has this format:
      - Name
      - Description
    * - 0x0
-     - \_\_be32
-     - r\_checksum
+     - __be32
+     - r_checksum
      - Checksum of the journal UUID + revocation block
 
 Commit Block
@@ -592,38 +592,38 @@ bytes long (but uses a full block):
      - Name
      - Descriptor
    * - 0x0
-     - journal\_header\_s
+     - journal_header_s
      - (open coded)
      - Common block header.
    * - 0xC
      - unsigned char
-     - h\_chksum\_type
+     - h_chksum_type
      - The type of checksum to use to verify the integrity of the data blocks
        in the transaction. See jbd2_checksum_type_ for more info.
    * - 0xD
      - unsigned char
-     - h\_chksum\_size
+     - h_chksum_size
      - The number of bytes used by the checksum. Most likely 4.
    * - 0xE
      - unsigned char
-     - h\_padding[2]
+     - h_padding[2]
      -
    * - 0x10
-     - \_\_be32
-     - h\_chksum[JBD2\_CHECKSUM\_BYTES]
+     - __be32
+     - h_chksum[JBD2_CHECKSUM_BYTES]
      - 32 bytes of space to store checksums. If
-       JBD2\_FEATURE\_INCOMPAT\_CSUM\_V2 or JBD2\_FEATURE\_INCOMPAT\_CSUM\_V3
+       JBD2_FEATURE_INCOMPAT_CSUM_V2 or JBD2_FEATURE_INCOMPAT_CSUM_V3
        are set, the first ``__be32`` is the checksum of the journal UUID and
        the entire commit block, with this field zeroed. If
-       JBD2\_FEATURE\_COMPAT\_CHECKSUM is set, the first ``__be32`` is the
+       JBD2_FEATURE_COMPAT_CHECKSUM is set, the first ``__be32`` is the
        crc32 of all the blocks already written to the transaction.
    * - 0x30
-     - \_\_be64
-     - h\_commit\_sec
+     - __be64
+     - h_commit_sec
      - The time that the transaction was committed, in seconds since the epoch.
    * - 0x38
-     - \_\_be32
-     - h\_commit\_nsec
+     - __be32
+     - h_commit_nsec
      - Nanoseconds component of the above timestamp.
 
 Fast commits
diff --git a/Documentation/filesystems/ext4/mmp.rst b/Documentation/filesystems/ext4/mmp.rst
index 25660981d93c..174dd6538737 100644
--- a/Documentation/filesystems/ext4/mmp.rst
+++ b/Documentation/filesystems/ext4/mmp.rst
@@ -7,8 +7,8 @@ Multiple mount protection (MMP) is a feature that protects the
 filesystem against multiple hosts trying to use the filesystem
 simultaneously. When a filesystem is opened (for mounting, or fsck,
 etc.), the MMP code running on the node (call it node A) checks a
-sequence number. If the sequence number is EXT4\_MMP\_SEQ\_CLEAN, the
-open continues. If the sequence number is EXT4\_MMP\_SEQ\_FSCK, then
+sequence number. If the sequence number is EXT4_MMP_SEQ_CLEAN, the
+open continues. If the sequence number is EXT4_MMP_SEQ_FSCK, then
 fsck is (hopefully) running, and open fails immediately. Otherwise, the
 open code will wait for twice the specified MMP check interval and check
 the sequence number again. If the sequence number has changed, then the
@@ -40,38 +40,38 @@ The MMP structure (``struct mmp_struct``) is as follows:
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - mmp\_magic
+     - __le32
+     - mmp_magic
      - Magic number for MMP, 0x004D4D50 (“MMP”).
    * - 0x4
-     - \_\_le32
-     - mmp\_seq
+     - __le32
+     - mmp_seq
      - Sequence number, updated periodically.
    * - 0x8
-     - \_\_le64
-     - mmp\_time
+     - __le64
+     - mmp_time
      - Time that the MMP block was last updated.
    * - 0x10
      - char[64]
-     - mmp\_nodename
+     - mmp_nodename
      - Hostname of the node that opened the filesystem.
    * - 0x50
      - char[32]
-     - mmp\_bdevname
+     - mmp_bdevname
      - Block device name of the filesystem.
    * - 0x70
-     - \_\_le16
-     - mmp\_check\_interval
+     - __le16
+     - mmp_check_interval
      - The MMP re-check interval, in seconds.
    * - 0x72
-     - \_\_le16
-     - mmp\_pad1
+     - __le16
+     - mmp_pad1
      - Zero.
    * - 0x74
-     - \_\_le32[226]
-     - mmp\_pad2
+     - __le32[226]
+     - mmp_pad2
      - Zero.
    * - 0x3FC
-     - \_\_le32
-     - mmp\_checksum
+     - __le32
+     - mmp_checksum
      - Checksum of the MMP block.
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index 123ebfde47ee..0fad6eda6e15 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -7,7 +7,7 @@ An ext4 file system is split into a series of block groups. To reduce
 performance difficulties due to fragmentation, the block allocator tries
 very hard to keep each file's blocks within the same group, thereby
 reducing seek times. The size of a block group is specified in
-``sb.s_blocks_per_group`` blocks, though it can also calculated as 8 \*
+``sb.s_blocks_per_group`` blocks, though it can also calculated as 8 *
 ``block_size_in_bytes``. With the default block size of 4KiB, each group
 will contain 32,768 blocks, for a length of 128MiB. The number of block
 groups is the size of the device divided by the size of a block group.
diff --git a/Documentation/filesystems/ext4/special_inodes.rst b/Documentation/filesystems/ext4/special_inodes.rst
index 94f304e3a0a7..fc0636901fa0 100644
--- a/Documentation/filesystems/ext4/special_inodes.rst
+++ b/Documentation/filesystems/ext4/special_inodes.rst
@@ -34,7 +34,7 @@ ext4 reserves some inode for special features, as follows:
    * - 10
      - Replica inode, used for some non-upstream feature?
    * - 11
-     - Traditional first non-reserved inode. Usually this is the lost+found directory. See s\_first\_ino in the superblock.
+     - Traditional first non-reserved inode. Usually this is the lost+found directory. See s_first_ino in the superblock.
 
 Note that there are also some inodes allocated from non-reserved inode numbers
 for other filesystem features which are not referenced from standard directory
@@ -47,9 +47,9 @@ hierarchy. These are generally reference from the superblock. They are:
    * - Superblock field
      - Description
 
-   * - s\_lpf\_ino
+   * - s_lpf_ino
      - Inode number of lost+found directory.
-   * - s\_prj\_quota\_inum
+   * - s_prj_quota_inum
      - Inode number of quota file tracking project quotas
-   * - s\_orphan\_file\_inum
+   * - s_orphan_file_inum
      - Inode number of file tracking orphan inodes.
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index f6a548e957bb..268888522e35 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -7,7 +7,7 @@ The superblock records various information about the enclosing
 filesystem, such as block counts, inode counts, supported features,
 maintenance information, and more.
 
-If the sparse\_super feature flag is set, redundant copies of the
+If the sparse_super feature flag is set, redundant copies of the
 superblock and group descriptors are kept only in the groups whose group
 number is either 0 or a power of 3, 5, or 7. If the flag is not set,
 redundant copies are kept in all groups.
@@ -27,107 +27,107 @@ The ext4 superblock is laid out as follows in
      - Name
      - Description
    * - 0x0
-     - \_\_le32
-     - s\_inodes\_count
+     - __le32
+     - s_inodes_count
      - Total inode count.
    * - 0x4
-     - \_\_le32
-     - s\_blocks\_count\_lo
+     - __le32
+     - s_blocks_count_lo
      - Total block count.
    * - 0x8
-     - \_\_le32
-     - s\_r\_blocks\_count\_lo
+     - __le32
+     - s_r_blocks_count_lo
      - This number of blocks can only be allocated by the super-user.
    * - 0xC
-     - \_\_le32
-     - s\_free\_blocks\_count\_lo
+     - __le32
+     - s_free_blocks_count_lo
      - Free block count.
    * - 0x10
-     - \_\_le32
-     - s\_free\_inodes\_count
+     - __le32
+     - s_free_inodes_count
      - Free inode count.
    * - 0x14
-     - \_\_le32
-     - s\_first\_data\_block
+     - __le32
+     - s_first_data_block
      - First data block. This must be at least 1 for 1k-block filesystems and
        is typically 0 for all other block sizes.
    * - 0x18
-     - \_\_le32
-     - s\_log\_block\_size
-     - Block size is 2 ^ (10 + s\_log\_block\_size).
+     - __le32
+     - s_log_block_size
+     - Block size is 2 ^ (10 + s_log_block_size).
    * - 0x1C
-     - \_\_le32
-     - s\_log\_cluster\_size
-     - Cluster size is 2 ^ (10 + s\_log\_cluster\_size) blocks if bigalloc is
-       enabled. Otherwise s\_log\_cluster\_size must equal s\_log\_block\_size.
+     - __le32
+     - s_log_cluster_size
+     - Cluster size is 2 ^ (10 + s_log_cluster_size) blocks if bigalloc is
+       enabled. Otherwise s_log_cluster_size must equal s_log_block_size.
    * - 0x20
-     - \_\_le32
-     - s\_blocks\_per\_group
+     - __le32
+     - s_blocks_per_group
      - Blocks per group.
    * - 0x24
-     - \_\_le32
-     - s\_clusters\_per\_group
+     - __le32
+     - s_clusters_per_group
      - Clusters per group, if bigalloc is enabled. Otherwise
-       s\_clusters\_per\_group must equal s\_blocks\_per\_group.
+       s_clusters_per_group must equal s_blocks_per_group.
    * - 0x28
-     - \_\_le32
-     - s\_inodes\_per\_group
+     - __le32
+     - s_inodes_per_group
      - Inodes per group.
    * - 0x2C
-     - \_\_le32
-     - s\_mtime
+     - __le32
+     - s_mtime
      - Mount time, in seconds since the epoch.
    * - 0x30
-     - \_\_le32
-     - s\_wtime
+     - __le32
+     - s_wtime
      - Write time, in seconds since the epoch.
    * - 0x34
-     - \_\_le16
-     - s\_mnt\_count
+     - __le16
+     - s_mnt_count
      - Number of mounts since the last fsck.
    * - 0x36
-     - \_\_le16
-     - s\_max\_mnt\_count
+     - __le16
+     - s_max_mnt_count
      - Number of mounts beyond which a fsck is needed.
    * - 0x38
-     - \_\_le16
-     - s\_magic
+     - __le16
+     - s_magic
      - Magic signature, 0xEF53
    * - 0x3A
-     - \_\_le16
-     - s\_state
+     - __le16
+     - s_state
      - File system state. See super_state_ for more info.
    * - 0x3C
-     - \_\_le16
-     - s\_errors
+     - __le16
+     - s_errors
      - Behaviour when detecting errors. See super_errors_ for more info.
    * - 0x3E
-     - \_\_le16
-     - s\_minor\_rev\_level
+     - __le16
+     - s_minor_rev_level
      - Minor revision level.
    * - 0x40
-     - \_\_le32
-     - s\_lastcheck
+     - __le32
+     - s_lastcheck
      - Time of last check, in seconds since the epoch.
    * - 0x44
-     - \_\_le32
-     - s\_checkinterval
+     - __le32
+     - s_checkinterval
      - Maximum time between checks, in seconds.
    * - 0x48
-     - \_\_le32
-     - s\_creator\_os
+     - __le32
+     - s_creator_os
      - Creator OS. See the table super_creator_ for more info.
    * - 0x4C
-     - \_\_le32
-     - s\_rev\_level
+     - __le32
+     - s_rev_level
      - Revision level. See the table super_revision_ for more info.
    * - 0x50
-     - \_\_le16
-     - s\_def\_resuid
+     - __le16
+     - s_def_resuid
      - Default uid for reserved blocks.
    * - 0x52
-     - \_\_le16
-     - s\_def\_resgid
+     - __le16
+     - s_def_resgid
      - Default gid for reserved blocks.
    * -
      -
@@ -143,50 +143,50 @@ The ext4 superblock is laid out as follows in
        about a feature in either the compatible or incompatible feature set, it
        must abort and not try to meddle with things it doesn't understand...
    * - 0x54
-     - \_\_le32
-     - s\_first\_ino
+     - __le32
+     - s_first_ino
      - First non-reserved inode.
    * - 0x58
-     - \_\_le16
-     - s\_inode\_size
+     - __le16
+     - s_inode_size
      - Size of inode structure, in bytes.
    * - 0x5A
-     - \_\_le16
-     - s\_block\_group\_nr
+     - __le16
+     - s_block_group_nr
      - Block group # of this superblock.
    * - 0x5C
-     - \_\_le32
-     - s\_feature\_compat
+     - __le32
+     - s_feature_compat
      - Compatible feature set flags. Kernel can still read/write this fs even
        if it doesn't understand a flag; fsck should not do that. See the
        super_compat_ table for more info.
    * - 0x60
-     - \_\_le32
-     - s\_feature\_incompat
+     - __le32
+     - s_feature_incompat
      - Incompatible feature set. If the kernel or fsck doesn't understand one
        of these bits, it should stop. See the super_incompat_ table for more
        info.
    * - 0x64
-     - \_\_le32
-     - s\_feature\_ro\_compat
+     - __le32
+     - s_feature_ro_compat
      - Readonly-compatible feature set. If the kernel doesn't understand one of
        these bits, it can still mount read-only. See the super_rocompat_ table
        for more info.
    * - 0x68
-     - \_\_u8
-     - s\_uuid[16]
+     - __u8
+     - s_uuid[16]
      - 128-bit UUID for volume.
    * - 0x78
      - char
-     - s\_volume\_name[16]
+     - s_volume_name[16]
      - Volume label.
    * - 0x88
      - char
-     - s\_last\_mounted[64]
+     - s_last_mounted[64]
      - Directory where filesystem was last mounted.
    * - 0xC8
-     - \_\_le32
-     - s\_algorithm\_usage\_bitmap
+     - __le32
+     - s_algorithm_usage_bitmap
      - For compression (Not used in e2fsprogs/Linux)
    * -
      -
@@ -194,18 +194,18 @@ The ext4 superblock is laid out as follows in
      - Performance hints.  Directory preallocation should only happen if the
        EXT4_FEATURE_COMPAT_DIR_PREALLOC flag is on.
    * - 0xCC
-     - \_\_u8
-     - s\_prealloc\_blocks
+     - __u8
+     - s_prealloc_blocks
      - #. of blocks to try to preallocate for ... files? (Not used in
        e2fsprogs/Linux)
    * - 0xCD
-     - \_\_u8
-     - s\_prealloc\_dir\_blocks
+     - __u8
+     - s_prealloc_dir_blocks
      - #. of blocks to preallocate for directories. (Not used in
        e2fsprogs/Linux)
    * - 0xCE
-     - \_\_le16
-     - s\_reserved\_gdt\_blocks
+     - __le16
+     - s_reserved_gdt_blocks
      - Number of reserved GDT entries for future filesystem expansion.
    * -
      -
@@ -213,281 +213,281 @@ The ext4 superblock is laid out as follows in
      - Journalling support is valid only if EXT4_FEATURE_COMPAT_HAS_JOURNAL is
        set.
    * - 0xD0
-     - \_\_u8
-     - s\_journal\_uuid[16]
+     - __u8
+     - s_journal_uuid[16]
      - UUID of journal superblock
    * - 0xE0
-     - \_\_le32
-     - s\_journal\_inum
+     - __le32
+     - s_journal_inum
      - inode number of journal file.
    * - 0xE4
-     - \_\_le32
-     - s\_journal\_dev
+     - __le32
+     - s_journal_dev
      - Device number of journal file, if the external journal feature flag is
        set.
    * - 0xE8
-     - \_\_le32
-     - s\_last\_orphan
+     - __le32
+     - s_last_orphan
      - Start of list of orphaned inodes to delete.
    * - 0xEC
-     - \_\_le32
-     - s\_hash\_seed[4]
+     - __le32
+     - s_hash_seed[4]
      - HTREE hash seed.
    * - 0xFC
-     - \_\_u8
-     - s\_def\_hash\_version
+     - __u8
+     - s_def_hash_version
      - Default hash algorithm to use for directory hashes. See super_def_hash_
        for more info.
    * - 0xFD
-     - \_\_u8
-     - s\_jnl\_backup\_type
-     - If this value is 0 or EXT3\_JNL\_BACKUP\_BLOCKS (1), then the
+     - __u8
+     - s_jnl_backup_type
+     - If this value is 0 or EXT3_JNL_BACKUP_BLOCKS (1), then the
        ``s_jnl_blocks`` field contains a duplicate copy of the inode's
        ``i_block[]`` array and ``i_size``.
    * - 0xFE
-     - \_\_le16
-     - s\_desc\_size
+     - __le16
+     - s_desc_size
      - Size of group descriptors, in bytes, if the 64bit incompat feature flag
        is set.
    * - 0x100
-     - \_\_le32
-     - s\_default\_mount\_opts
+     - __le32
+     - s_default_mount_opts
      - Default mount options. See the super_mountopts_ table for more info.
    * - 0x104
-     - \_\_le32
-     - s\_first\_meta\_bg
-     - First metablock block group, if the meta\_bg feature is enabled.
+     - __le32
+     - s_first_meta_bg
+     - First metablock block group, if the meta_bg feature is enabled.
    * - 0x108
-     - \_\_le32
-     - s\_mkfs\_time
+     - __le32
+     - s_mkfs_time
      - When the filesystem was created, in seconds since the epoch.
    * - 0x10C
-     - \_\_le32
-     - s\_jnl\_blocks[17]
+     - __le32
+     - s_jnl_blocks[17]
      - Backup copy of the journal inode's ``i_block[]`` array in the first 15
-       elements and i\_size\_high and i\_size in the 16th and 17th elements,
+       elements and i_size_high and i_size in the 16th and 17th elements,
        respectively.
    * -
      -
      -
      - 64bit support is valid only if EXT4_FEATURE_COMPAT_64BIT is set.
    * - 0x150
-     - \_\_le32
-     - s\_blocks\_count\_hi
+     - __le32
+     - s_blocks_count_hi
      - High 32-bits of the block count.
    * - 0x154
-     - \_\_le32
-     - s\_r\_blocks\_count\_hi
+     - __le32
+     - s_r_blocks_count_hi
      - High 32-bits of the reserved block count.
    * - 0x158
-     - \_\_le32
-     - s\_free\_blocks\_count\_hi
+     - __le32
+     - s_free_blocks_count_hi
      - High 32-bits of the free block count.
    * - 0x15C
-     - \_\_le16
-     - s\_min\_extra\_isize
+     - __le16
+     - s_min_extra_isize
      - All inodes have at least # bytes.
    * - 0x15E
-     - \_\_le16
-     - s\_want\_extra\_isize
+     - __le16
+     - s_want_extra_isize
      - New inodes should reserve # bytes.
    * - 0x160
-     - \_\_le32
-     - s\_flags
+     - __le32
+     - s_flags
      - Miscellaneous flags. See the super_flags_ table for more info.
    * - 0x164
-     - \_\_le16
-     - s\_raid\_stride
+     - __le16
+     - s_raid_stride
      - RAID stride. This is the number of logical blocks read from or written
        to the disk before moving to the next disk. This affects the placement
        of filesystem metadata, which will hopefully make RAID storage faster.
    * - 0x166
-     - \_\_le16
-     - s\_mmp\_interval
+     - __le16
+     - s_mmp_interval
      - #. seconds to wait in multi-mount prevention (MMP) checking. In theory,
        MMP is a mechanism to record in the superblock which host and device
        have mounted the filesystem, in order to prevent multiple mounts. This
        feature does not seem to be implemented...
    * - 0x168
-     - \_\_le64
-     - s\_mmp\_block
+     - __le64
+     - s_mmp_block
      - Block # for multi-mount protection data.
    * - 0x170
-     - \_\_le32
-     - s\_raid\_stripe\_width
+     - __le32
+     - s_raid_stripe_width
      - RAID stripe width. This is the number of logical blocks read from or
        written to the disk before coming back to the current disk. This is used
        by the block allocator to try to reduce the number of read-modify-write
        operations in a RAID5/6.
    * - 0x174
-     - \_\_u8
-     - s\_log\_groups\_per\_flex
+     - __u8
+     - s_log_groups_per_flex
      - Size of a flexible block group is 2 ^ ``s_log_groups_per_flex``.
    * - 0x175
-     - \_\_u8
-     - s\_checksum\_type
+     - __u8
+     - s_checksum_type
      - Metadata checksum algorithm type. The only valid value is 1 (crc32c).
    * - 0x176
-     - \_\_le16
-     - s\_reserved\_pad
+     - __le16
+     - s_reserved_pad
      -
    * - 0x178
-     - \_\_le64
-     - s\_kbytes\_written
+     - __le64
+     - s_kbytes_written
      - Number of KiB written to this filesystem over its lifetime.
    * - 0x180
-     - \_\_le32
-     - s\_snapshot\_inum
+     - __le32
+     - s_snapshot_inum
      - inode number of active snapshot. (Not used in e2fsprogs/Linux.)
    * - 0x184
-     - \_\_le32
-     - s\_snapshot\_id
+     - __le32
+     - s_snapshot_id
      - Sequential ID of active snapshot. (Not used in e2fsprogs/Linux.)
    * - 0x188
-     - \_\_le64
-     - s\_snapshot\_r\_blocks\_count
+     - __le64
+     - s_snapshot_r_blocks_count
      - Number of blocks reserved for active snapshot's future use. (Not used in
        e2fsprogs/Linux.)
    * - 0x190
-     - \_\_le32
-     - s\_snapshot\_list
+     - __le32
+     - s_snapshot_list
      - inode number of the head of the on-disk snapshot list. (Not used in
        e2fsprogs/Linux.)
    * - 0x194
-     - \_\_le32
-     - s\_error\_count
+     - __le32
+     - s_error_count
      - Number of errors seen.
    * - 0x198
-     - \_\_le32
-     - s\_first\_error\_time
+     - __le32
+     - s_first_error_time
      - First time an error happened, in seconds since the epoch.
    * - 0x19C
-     - \_\_le32
-     - s\_first\_error\_ino
+     - __le32
+     - s_first_error_ino
      - inode involved in first error.
    * - 0x1A0
-     - \_\_le64
-     - s\_first\_error\_block
+     - __le64
+     - s_first_error_block
      - Number of block involved of first error.
    * - 0x1A8
-     - \_\_u8
-     - s\_first\_error\_func[32]
+     - __u8
+     - s_first_error_func[32]
      - Name of function where the error happened.
    * - 0x1C8
-     - \_\_le32
-     - s\_first\_error\_line
+     - __le32
+     - s_first_error_line
      - Line number where error happened.
    * - 0x1CC
-     - \_\_le32
-     - s\_last\_error\_time
+     - __le32
+     - s_last_error_time
      - Time of most recent error, in seconds since the epoch.
    * - 0x1D0
-     - \_\_le32
-     - s\_last\_error\_ino
+     - __le32
+     - s_last_error_ino
      - inode involved in most recent error.
    * - 0x1D4
-     - \_\_le32
-     - s\_last\_error\_line
+     - __le32
+     - s_last_error_line
      - Line number where most recent error happened.
    * - 0x1D8
-     - \_\_le64
-     - s\_last\_error\_block
+     - __le64
+     - s_last_error_block
      - Number of block involved in most recent error.
    * - 0x1E0
-     - \_\_u8
-     - s\_last\_error\_func[32]
+     - __u8
+     - s_last_error_func[32]
      - Name of function where the most recent error happened.
    * - 0x200
-     - \_\_u8
-     - s\_mount\_opts[64]
+     - __u8
+     - s_mount_opts[64]
      - ASCIIZ string of mount options.
    * - 0x240
-     - \_\_le32
-     - s\_usr\_quota\_inum
+     - __le32
+     - s_usr_quota_inum
      - Inode number of user `quota <quota>`__ file.
    * - 0x244
-     - \_\_le32
-     - s\_grp\_quota\_inum
+     - __le32
+     - s_grp_quota_inum
      - Inode number of group `quota <quota>`__ file.
    * - 0x248
-     - \_\_le32
-     - s\_overhead\_blocks
+     - __le32
+     - s_overhead_blocks
      - Overhead blocks/clusters in fs. (Huh? This field is always zero, which
        means that the kernel calculates it dynamically.)
    * - 0x24C
-     - \_\_le32
-     - s\_backup\_bgs[2]
-     - Block groups containing superblock backups (if sparse\_super2)
+     - __le32
+     - s_backup_bgs[2]
+     - Block groups containing superblock backups (if sparse_super2)
    * - 0x254
-     - \_\_u8
-     - s\_encrypt\_algos[4]
+     - __u8
+     - s_encrypt_algos[4]
      - Encryption algorithms in use. There can be up to four algorithms in use
        at any time; valid algorithm codes are given in the super_encrypt_ table
        below.
    * - 0x258
-     - \_\_u8
-     - s\_encrypt\_pw\_salt[16]
+     - __u8
+     - s_encrypt_pw_salt[16]
      - Salt for the string2key algorithm for encryption.
    * - 0x268
-     - \_\_le32
-     - s\_lpf\_ino
+     - __le32
+     - s_lpf_ino
      - Inode number of lost+found
    * - 0x26C
-     - \_\_le32
-     - s\_prj\_quota\_inum
+     - __le32
+     - s_prj_quota_inum
      - Inode that tracks project quotas.
    * - 0x270
-     - \_\_le32
-     - s\_checksum\_seed
-     - Checksum seed used for metadata\_csum calculations. This value is
-       crc32c(~0, $orig\_fs\_uuid).
+     - __le32
+     - s_checksum_seed
+     - Checksum seed used for metadata_csum calculations. This value is
+       crc32c(~0, $orig_fs_uuid).
    * - 0x274
-     - \_\_u8
-     - s\_wtime_hi
+     - __u8
+     - s_wtime_hi
      - Upper 8 bits of the s_wtime field.
    * - 0x275
-     - \_\_u8
-     - s\_mtime_hi
+     - __u8
+     - s_mtime_hi
      - Upper 8 bits of the s_mtime field.
    * - 0x276
-     - \_\_u8
-     - s\_mkfs_time_hi
+     - __u8
+     - s_mkfs_time_hi
      - Upper 8 bits of the s_mkfs_time field.
    * - 0x277
-     - \_\_u8
-     - s\_lastcheck_hi
+     - __u8
+     - s_lastcheck_hi
      - Upper 8 bits of the s_lastcheck_hi field.
    * - 0x278
-     - \_\_u8
-     - s\_first_error_time_hi
+     - __u8
+     - s_first_error_time_hi
      - Upper 8 bits of the s_first_error_time_hi field.
    * - 0x279
-     - \_\_u8
-     - s\_last_error_time_hi
+     - __u8
+     - s_last_error_time_hi
      - Upper 8 bits of the s_last_error_time_hi field.
    * - 0x27A
-     - \_\_u8
-     - s\_pad[2]
+     - __u8
+     - s_pad[2]
      - Zero padding.
    * - 0x27C
-     - \_\_le16
-     - s\_encoding
+     - __le16
+     - s_encoding
      - Filename charset encoding.
    * - 0x27E
-     - \_\_le16
-     - s\_encoding_flags
+     - __le16
+     - s_encoding_flags
      - Filename charset encoding flags.
    * - 0x280
-     - \_\_le32
-     - s\_orphan\_file\_inum
+     - __le32
+     - s_orphan_file_inum
      - Orphan file inode number.
    * - 0x284
-     - \_\_le32
-     - s\_reserved[94]
+     - __le32
+     - s_reserved[94]
      - Padding to the end of the block.
    * - 0x3FC
-     - \_\_le32
-     - s\_checksum
+     - __le32
+     - s_checksum
      - Superblock checksum.
 
 .. _super_state:
@@ -574,44 +574,44 @@ following:
    * - Value
      - Description
    * - 0x1
-     - Directory preallocation (COMPAT\_DIR\_PREALLOC).
+     - Directory preallocation (COMPAT_DIR_PREALLOC).
    * - 0x2
      - “imagic inodes”. Not clear from the code what this does
-       (COMPAT\_IMAGIC\_INODES).
+       (COMPAT_IMAGIC_INODES).
    * - 0x4
-     - Has a journal (COMPAT\_HAS\_JOURNAL).
+     - Has a journal (COMPAT_HAS_JOURNAL).
    * - 0x8
-     - Supports extended attributes (COMPAT\_EXT\_ATTR).
+     - Supports extended attributes (COMPAT_EXT_ATTR).
    * - 0x10
      - Has reserved GDT blocks for filesystem expansion
-       (COMPAT\_RESIZE\_INODE). Requires RO\_COMPAT\_SPARSE\_SUPER.
+       (COMPAT_RESIZE_INODE). Requires RO_COMPAT_SPARSE_SUPER.
    * - 0x20
-     - Has directory indices (COMPAT\_DIR\_INDEX).
+     - Has directory indices (COMPAT_DIR_INDEX).
    * - 0x40
      - “Lazy BG”. Not in Linux kernel, seems to have been for uninitialized
-       block groups? (COMPAT\_LAZY\_BG)
+       block groups? (COMPAT_LAZY_BG)
    * - 0x80
-     - “Exclude inode”. Not used. (COMPAT\_EXCLUDE\_INODE).
+     - “Exclude inode”. Not used. (COMPAT_EXCLUDE_INODE).
    * - 0x100
      - “Exclude bitmap”. Seems to be used to indicate the presence of
        snapshot-related exclude bitmaps? Not defined in kernel or used in
-       e2fsprogs (COMPAT\_EXCLUDE\_BITMAP).
+       e2fsprogs (COMPAT_EXCLUDE_BITMAP).
    * - 0x200
-     - Sparse Super Block, v2. If this flag is set, the SB field s\_backup\_bgs
+     - Sparse Super Block, v2. If this flag is set, the SB field s_backup_bgs
        points to the two block groups that contain backup superblocks
-       (COMPAT\_SPARSE\_SUPER2).
+       (COMPAT_SPARSE_SUPER2).
    * - 0x400
      - Fast commits supported. Although fast commits blocks are
        backward incompatible, fast commit blocks are not always
        present in the journal. If fast commit blocks are present in
        the journal, JBD2 incompat feature
-       (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT) gets
-       set (COMPAT\_FAST\_COMMIT).
+       (JBD2_FEATURE_INCOMPAT_FAST_COMMIT) gets
+       set (COMPAT_FAST_COMMIT).
    * - 0x1000
      - Orphan file allocated. This is the special file for more efficient
        tracking of unlinked but still open inodes. When there may be any
        entries in the file, we additionally set proper rocompat feature
-       (RO\_COMPAT\_ORPHAN\_PRESENT).
+       (RO_COMPAT_ORPHAN_PRESENT).
 
 .. _super_incompat:
 
@@ -625,45 +625,45 @@ following:
    * - Value
      - Description
    * - 0x1
-     - Compression (INCOMPAT\_COMPRESSION).
+     - Compression (INCOMPAT_COMPRESSION).
    * - 0x2
-     - Directory entries record the file type. See ext4\_dir\_entry\_2 below
-       (INCOMPAT\_FILETYPE).
+     - Directory entries record the file type. See ext4_dir_entry_2 below
+       (INCOMPAT_FILETYPE).
    * - 0x4
-     - Filesystem needs recovery (INCOMPAT\_RECOVER).
+     - Filesystem needs recovery (INCOMPAT_RECOVER).
    * - 0x8
-     - Filesystem has a separate journal device (INCOMPAT\_JOURNAL\_DEV).
+     - Filesystem has a separate journal device (INCOMPAT_JOURNAL_DEV).
    * - 0x10
      - Meta block groups. See the earlier discussion of this feature
-       (INCOMPAT\_META\_BG).
+       (INCOMPAT_META_BG).
    * - 0x40
-     - Files in this filesystem use extents (INCOMPAT\_EXTENTS).
+     - Files in this filesystem use extents (INCOMPAT_EXTENTS).
    * - 0x80
-     - Enable a filesystem size of 2^64 blocks (INCOMPAT\_64BIT).
+     - Enable a filesystem size of 2^64 blocks (INCOMPAT_64BIT).
    * - 0x100
-     - Multiple mount protection (INCOMPAT\_MMP).
+     - Multiple mount protection (INCOMPAT_MMP).
    * - 0x200
      - Flexible block groups. See the earlier discussion of this feature
-       (INCOMPAT\_FLEX\_BG).
+       (INCOMPAT_FLEX_BG).
    * - 0x400
      - Inodes can be used to store large extended attribute values
-       (INCOMPAT\_EA\_INODE).
+       (INCOMPAT_EA_INODE).
    * - 0x1000
-     - Data in directory entry (INCOMPAT\_DIRDATA). (Not implemented?)
+     - Data in directory entry (INCOMPAT_DIRDATA). (Not implemented?)
    * - 0x2000
      - Metadata checksum seed is stored in the superblock. This feature enables
-       the administrator to change the UUID of a metadata\_csum filesystem
+       the administrator to change the UUID of a metadata_csum filesystem
        while the filesystem is mounted; without it, the checksum definition
-       requires all metadata blocks to be rewritten (INCOMPAT\_CSUM\_SEED).
+       requires all metadata blocks to be rewritten (INCOMPAT_CSUM_SEED).
    * - 0x4000
-     - Large directory >2GB or 3-level htree (INCOMPAT\_LARGEDIR). Prior to
+     - Large directory >2GB or 3-level htree (INCOMPAT_LARGEDIR). Prior to
        this feature, directories could not be larger than 4GiB and could not
        have an htree more than 2 levels deep. If this feature is enabled,
        directories can be larger than 4GiB and have a maximum htree depth of 3.
    * - 0x8000
-     - Data in inode (INCOMPAT\_INLINE\_DATA).
+     - Data in inode (INCOMPAT_INLINE_DATA).
    * - 0x10000
-     - Encrypted inodes are present on the filesystem. (INCOMPAT\_ENCRYPT).
+     - Encrypted inodes are present on the filesystem. (INCOMPAT_ENCRYPT).
 
 .. _super_rocompat:
 
@@ -678,54 +678,54 @@ the following:
      - Description
    * - 0x1
      - Sparse superblocks. See the earlier discussion of this feature
-       (RO\_COMPAT\_SPARSE\_SUPER).
+       (RO_COMPAT_SPARSE_SUPER).
    * - 0x2
      - This filesystem has been used to store a file greater than 2GiB
-       (RO\_COMPAT\_LARGE\_FILE).
+       (RO_COMPAT_LARGE_FILE).
    * - 0x4
-     - Not used in kernel or e2fsprogs (RO\_COMPAT\_BTREE\_DIR).
+     - Not used in kernel or e2fsprogs (RO_COMPAT_BTREE_DIR).
    * - 0x8
      - This filesystem has files whose sizes are represented in units of
        logical blocks, not 512-byte sectors. This implies a very large file
-       indeed! (RO\_COMPAT\_HUGE\_FILE)
+       indeed! (RO_COMPAT_HUGE_FILE)
    * - 0x10
      - Group descriptors have checksums. In addition to detecting corruption,
        this is useful for lazy formatting with uninitialized groups
-       (RO\_COMPAT\_GDT\_CSUM).
+       (RO_COMPAT_GDT_CSUM).
    * - 0x20
      - Indicates that the old ext3 32,000 subdirectory limit no longer applies
-       (RO\_COMPAT\_DIR\_NLINK). A directory's i\_links\_count will be set to 1
+       (RO_COMPAT_DIR_NLINK). A directory's i_links_count will be set to 1
        if it is incremented past 64,999.
    * - 0x40
      - Indicates that large inodes exist on this filesystem
-       (RO\_COMPAT\_EXTRA\_ISIZE).
+       (RO_COMPAT_EXTRA_ISIZE).
    * - 0x80
-     - This filesystem has a snapshot (RO\_COMPAT\_HAS\_SNAPSHOT).
+     - This filesystem has a snapshot (RO_COMPAT_HAS_SNAPSHOT).
    * - 0x100
-     - `Quota <Quota>`__ (RO\_COMPAT\_QUOTA).
+     - `Quota <Quota>`__ (RO_COMPAT_QUOTA).
    * - 0x200
      - This filesystem supports “bigalloc”, which means that file extents are
        tracked in units of clusters (of blocks) instead of blocks
-       (RO\_COMPAT\_BIGALLOC).
+       (RO_COMPAT_BIGALLOC).
    * - 0x400
      - This filesystem supports metadata checksumming.
-       (RO\_COMPAT\_METADATA\_CSUM; implies RO\_COMPAT\_GDT\_CSUM, though
-       GDT\_CSUM must not be set)
+       (RO_COMPAT_METADATA_CSUM; implies RO_COMPAT_GDT_CSUM, though
+       GDT_CSUM must not be set)
    * - 0x800
      - Filesystem supports replicas. This feature is neither in the kernel nor
-       e2fsprogs. (RO\_COMPAT\_REPLICA)
+       e2fsprogs. (RO_COMPAT_REPLICA)
    * - 0x1000
      - Read-only filesystem image; the kernel will not mount this image
        read-write and most tools will refuse to write to the image.
-       (RO\_COMPAT\_READONLY)
+       (RO_COMPAT_READONLY)
    * - 0x2000
-     - Filesystem tracks project quotas. (RO\_COMPAT\_PROJECT)
+     - Filesystem tracks project quotas. (RO_COMPAT_PROJECT)
    * - 0x8000
-     - Verity inodes may be present on the filesystem. (RO\_COMPAT\_VERITY)
+     - Verity inodes may be present on the filesystem. (RO_COMPAT_VERITY)
    * - 0x10000
      - Indicates orphan file may have valid orphan entries and thus we need
        to clean them up when mounting the filesystem
-       (RO\_COMPAT\_ORPHAN\_PRESENT).
+       (RO_COMPAT_ORPHAN_PRESENT).
 
 .. _super_def_hash:
 
@@ -761,36 +761,36 @@ The ``s_default_mount_opts`` field is any combination of the following:
    * - Value
      - Description
    * - 0x0001
-     - Print debugging info upon (re)mount. (EXT4\_DEFM\_DEBUG)
+     - Print debugging info upon (re)mount. (EXT4_DEFM_DEBUG)
    * - 0x0002
      - New files take the gid of the containing directory (instead of the fsgid
-       of the current process). (EXT4\_DEFM\_BSDGROUPS)
+       of the current process). (EXT4_DEFM_BSDGROUPS)
    * - 0x0004
-     - Support userspace-provided extended attributes. (EXT4\_DEFM\_XATTR\_USER)
+     - Support userspace-provided extended attributes. (EXT4_DEFM_XATTR_USER)
    * - 0x0008
-     - Support POSIX access control lists (ACLs). (EXT4\_DEFM\_ACL)
+     - Support POSIX access control lists (ACLs). (EXT4_DEFM_ACL)
    * - 0x0010
-     - Do not support 32-bit UIDs. (EXT4\_DEFM\_UID16)
+     - Do not support 32-bit UIDs. (EXT4_DEFM_UID16)
    * - 0x0020
      - All data and metadata are commited to the journal.
-       (EXT4\_DEFM\_JMODE\_DATA)
+       (EXT4_DEFM_JMODE_DATA)
    * - 0x0040
      - All data are flushed to the disk before metadata are committed to the
-       journal. (EXT4\_DEFM\_JMODE\_ORDERED)
+       journal. (EXT4_DEFM_JMODE_ORDERED)
    * - 0x0060
      - Data ordering is not preserved; data may be written after the metadata
-       has been written. (EXT4\_DEFM\_JMODE\_WBACK)
+       has been written. (EXT4_DEFM_JMODE_WBACK)
    * - 0x0100
-     - Disable write flushes. (EXT4\_DEFM\_NOBARRIER)
+     - Disable write flushes. (EXT4_DEFM_NOBARRIER)
    * - 0x0200
      - Track which blocks in a filesystem are metadata and therefore should not
        be used as data blocks. This option will be enabled by default on 3.18,
-       hopefully. (EXT4\_DEFM\_BLOCK\_VALIDITY)
+       hopefully. (EXT4_DEFM_BLOCK_VALIDITY)
    * - 0x0400
      - Enable DISCARD support, where the storage device is told about blocks
-       becoming unused. (EXT4\_DEFM\_DISCARD)
+       becoming unused. (EXT4_DEFM_DISCARD)
    * - 0x0800
-     - Disable delayed allocation. (EXT4\_DEFM\_NODELALLOC)
+     - Disable delayed allocation. (EXT4_DEFM_NODELALLOC)
 
 .. _super_flags:
 
@@ -820,12 +820,12 @@ The ``s_encrypt_algos`` list can contain any of the following:
    * - Value
      - Description
    * - 0
-     - Invalid algorithm (ENCRYPTION\_MODE\_INVALID).
+     - Invalid algorithm (ENCRYPTION_MODE_INVALID).
    * - 1
-     - 256-bit AES in XTS mode (ENCRYPTION\_MODE\_AES\_256\_XTS).
+     - 256-bit AES in XTS mode (ENCRYPTION_MODE_AES_256_XTS).
    * - 2
-     - 256-bit AES in GCM mode (ENCRYPTION\_MODE\_AES\_256\_GCM).
+     - 256-bit AES in GCM mode (ENCRYPTION_MODE_AES_256_GCM).
    * - 3
-     - 256-bit AES in CBC mode (ENCRYPTION\_MODE\_AES\_256\_CBC).
+     - 256-bit AES in CBC mode (ENCRYPTION_MODE_AES_256_CBC).
 
 Total size of the superblock is 1024 bytes.
-- 
2.32.0

