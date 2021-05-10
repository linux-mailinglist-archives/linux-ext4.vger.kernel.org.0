Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031E8378245
	for <lists+linux-ext4@lfdr.de>; Mon, 10 May 2021 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEJKdn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 May 2021 06:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhEJKbk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 May 2021 06:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3CBF6162A;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=z7JSlEgory1thI0OdgTtvt1rFZpyAysnsodFMyxfc20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0tjwWmpuE9/1VMx72sh+mHFrMtV5i8RPQfFlXLaafrnB4yFSQXnTeAYoRRrPXLbw
         5Ey6Y1cxKinb4gztXldN9g/spX/lMg4UbnATBsUQqaGallEmWb/VY20DHziZhWv2jr
         rfPHeINVmiqVCcYem0B+/mT8JGPtYj+X6Sw9k8yAlV+o3d53YWakZ0VqxLoSkZFQca
         NiQWsgxT56yB4cqo43LH1G3qh40w4LqddN/vjYRqAzYiWUgXKb3Wd1s719qAafeFsv
         QbrUuQz9JFD3yvnm3ingOYYpeZrZNDUkt+pNdkFJKm5aiQ6Yw3t63Tjj4FuvppsEx1
         0xoQNE8eqsPxA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQ8-M5; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/53] docs: filesystems: ext4: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:40 +0200
Message-Id: <9d8a6fdf5aec2dfa3e5ff459319c77698815f3d7.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK
	- U+2217 ('∗'): ASTERISK OPERATOR

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/ext4/attributes.rst | 20 +++++++++----------
 Documentation/filesystems/ext4/bigalloc.rst   |  6 +++---
 Documentation/filesystems/ext4/blockgroup.rst |  8 ++++----
 Documentation/filesystems/ext4/blocks.rst     |  2 +-
 Documentation/filesystems/ext4/directory.rst  | 16 +++++++--------
 Documentation/filesystems/ext4/eainode.rst    |  2 +-
 Documentation/filesystems/ext4/inlinedata.rst |  6 +++---
 Documentation/filesystems/ext4/inodes.rst     |  6 +++---
 Documentation/filesystems/ext4/journal.rst    |  8 ++++----
 Documentation/filesystems/ext4/mmp.rst        |  2 +-
 .../filesystems/ext4/special_inodes.rst       |  4 ++--
 Documentation/filesystems/ext4/super.rst      | 10 +++++-----
 12 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/Documentation/filesystems/ext4/attributes.rst b/Documentation/filesystems/ext4/attributes.rst
index 54386a010a8d..39e695678c01 100644
--- a/Documentation/filesystems/ext4/attributes.rst
+++ b/Documentation/filesystems/ext4/attributes.rst
@@ -8,7 +8,7 @@ block on the disk and referenced from inodes via ``inode.i_file_acl*``.
 The first use of extended attributes seems to have been for storing file
 ACLs and other security data (selinux). With the ``user_xattr`` mount
 option it is possible for users to store extended attributes so long as
-all attribute names begin with “user”; this restriction seems to have
+all attribute names begin with "user"; this restriction seems to have
 disappeared as of Linux 3.0.
 
 There are two places where extended attributes can be found. The first
@@ -165,22 +165,22 @@ the key name. Here is a map of name index values to key prefixes:
    * - 0
      - (no prefix)
    * - 1
-     - “user.”
+     - "user."
    * - 2
-     - “system.posix\_acl\_access”
+     - "system.posix\_acl\_access"
    * - 3
-     - “system.posix\_acl\_default”
+     - "system.posix\_acl\_default"
    * - 4
-     - “trusted.”
+     - "trusted."
    * - 6
-     - “security.”
+     - "security."
    * - 7
-     - “system.” (inline\_data only?)
+     - "system." (inline\_data only?)
    * - 8
-     - “system.richacl” (SuSE kernels only?)
+     - "system.richacl" (SuSE kernels only?)
 
-For example, if the attribute key is “user.fubar”, the attribute name
-index is set to 1 and the “fubar” name is recorded on disk.
+For example, if the attribute key is "user.fubar", the attribute name
+index is set to 1 and the "fubar" name is recorded on disk.
 
 POSIX ACLs
 ~~~~~~~~~~
diff --git a/Documentation/filesystems/ext4/bigalloc.rst b/Documentation/filesystems/ext4/bigalloc.rst
index 72075aa608e4..897e1b284c97 100644
--- a/Documentation/filesystems/ext4/bigalloc.rst
+++ b/Documentation/filesystems/ext4/bigalloc.rst
@@ -27,8 +27,8 @@ stored in the s\_log\_cluster\_size field in the superblock); from then
 on, the block bitmaps track clusters, not individual blocks. This means
 that block groups can be several gigabytes in size (instead of just
 128MiB); however, the minimum allocation unit becomes a cluster, not a
-block, even for directories. TaoBao had a patchset to extend the “use
-units of clusters instead of blocks” to the extent tree, though it is
+block, even for directories. TaoBao had a patchset to extend the "use
+units of clusters instead of blocks" to the extent tree, though it is
 not clear where those patches went-- they eventually morphed into
-“extent tree v2” but that code has not landed as of May 2015.
+"extent tree v2" but that code has not landed as of May 2015.
 
diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index 3da156633339..99aa1f330bd1 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -41,8 +41,8 @@ across the disk in case the beginning of the disk gets trashed, though
 not all block groups necessarily host a redundant copy (see following
 paragraph for more details). If the group does not have a redundant
 copy, the block group begins with the data block bitmap. Note also that
-when the filesystem is freshly formatted, mkfs will allocate “reserve
-GDT block” space after the block group descriptors and before the start
+when the filesystem is freshly formatted, mkfs will allocate "reserve
+GDT block" space after the block group descriptors and before the start
 of the block bitmaps to allow for future expansion of the filesystem. By
 default, a filesystem is allowed to increase in size by a factor of
 1024x over the original filesystem size.
@@ -84,7 +84,7 @@ Without the option META\_BG, for safety concerns, all block group
 descriptors copies are kept in the first block group. Given the default
 128MiB(2^27 bytes) block group size and 64-byte group descriptors, ext4
 can have at most 2^27/64 = 2^21 block groups. This limits the entire
-filesystem size to 2^21 ∗ 2^27 = 2^48bytes or 256TiB.
+filesystem size to 2^21 * 2^27 = 2^48bytes or 256TiB.
 
 The solution to this problem is to use the metablock group feature
 (META\_BG), which is already in ext3 for all 2.6 releases. With the
@@ -131,5 +131,5 @@ rely on the kernel to initialize the inode tables in the background.
 
 By not writing zeroes to the bitmaps and inode table, mkfs time is
 reduced considerably. Note the feature flag is RO\_COMPAT\_GDT\_CSUM,
-but the dumpe2fs output prints this as “uninit\_bg”. They are the same
+but the dumpe2fs output prints this as "uninit\_bg". They are the same
 thing.
diff --git a/Documentation/filesystems/ext4/blocks.rst b/Documentation/filesystems/ext4/blocks.rst
index bd722ecd92d6..ca16435d469e 100644
--- a/Documentation/filesystems/ext4/blocks.rst
+++ b/Documentation/filesystems/ext4/blocks.rst
@@ -3,7 +3,7 @@
 Blocks
 ------
 
-ext4 allocates storage space in units of “blocks”. A block is a group of
+ext4 allocates storage space in units of "blocks". A block is a group of
 sectors between 1KiB and 64KiB, and the number of sectors must be an
 integral power of 2. Blocks are in turn grouped into larger units called
 block groups. Block size is specified at mkfs time and typically is
diff --git a/Documentation/filesystems/ext4/directory.rst b/Documentation/filesystems/ext4/directory.rst
index 55f618b37144..317e672cd457 100644
--- a/Documentation/filesystems/ext4/directory.rst
+++ b/Documentation/filesystems/ext4/directory.rst
@@ -15,8 +15,8 @@ is desired.
 Linear (Classic) Directories
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-By default, each directory lists its entries in an “almost-linear”
-array. I write “almost” because it's not a linear array in the memory
+By default, each directory lists its entries in an "almost-linear"
+array. I write "almost" because it's not a linear array in the memory
 sense because directory entries are not split across filesystem blocks.
 Therefore, it is more accurate to say that a directory is a series of
 data blocks and that each block contains a linear array of directory
@@ -26,7 +26,7 @@ takes it all the way to the end of the block. The end of the entire
 directory is of course signified by reaching the end of the file. Unused
 directory entries are signified by inode = 0. By default the filesystem
 uses ``struct ext4_dir_entry_2`` for directory entries unless the
-“filetype” feature flag is not set, in which case it uses
+"filetype" feature flag is not set, in which case it uses
 ``struct ext4_dir_entry``.
 
 The original directory entry format is ``struct ext4_dir_entry``, which
@@ -197,7 +197,7 @@ balanced tree keyed off a hash of the directory entry name. If the
 EXT4\_INDEX\_FL (0x1000) flag is set in the inode, this directory uses a
 hashed btree (htree) to organize and find directory entries. For
 backwards read-only compatibility with ext2, this tree is actually
-hidden inside the directory file, masquerading as “empty” directory data
+hidden inside the directory file, masquerading as "empty" directory data
 blocks! It was stated previously that the end of the linear directory
 entry table was signified with an entry pointing to inode 0; this is
 (ab)used to fool the old linear-scan algorithm into thinking that the
@@ -263,7 +263,7 @@ of a data block:
    * - 0x8
      - char
      - dot.name[4]
-     - “.\\0\\0\\0”
+     - ".\\0\\0\\0"
    * - 0xC
      - \_\_le32
      - dotdot.inode
@@ -284,7 +284,7 @@ of a data block:
    * - 0x14
      - char
      - dotdot\_name[4]
-     - “..\\0\\0”
+     - "..\\0\\0"
    * - 0x18
      - \_\_le32
      - struct dx\_root\_info.reserved\_zero
@@ -372,11 +372,11 @@ also the full length of a data block:
    * - 0x6
      - u8
      - name\_len
-     - Zero. There is no name for this “unused” directory entry.
+     - Zero. There is no name for this "unused" directory entry.
    * - 0x7
      - u8
      - file\_type
-     - Zero. There is no file type for this “unused” directory entry.
+     - Zero. There is no file type for this "unused" directory entry.
    * - 0x8
      - \_\_le16
      - limit
diff --git a/Documentation/filesystems/ext4/eainode.rst b/Documentation/filesystems/ext4/eainode.rst
index ecc0d01a0a72..71e64aadaa89 100644
--- a/Documentation/filesystems/ext4/eainode.rst
+++ b/Documentation/filesystems/ext4/eainode.rst
@@ -6,7 +6,7 @@ Large Extended Attribute Values
 To enable ext4 to store extended attribute values that do not fit in the
 inode or in the single extended attribute block attached to an inode,
 the EA\_INODE feature allows us to store the value in the data blocks of
-a regular file inode. This “EA inode” is linked only from the extended
+a regular file inode. This "EA inode" is linked only from the extended
 attribute name index and must not appear in a directory entry. The
 inode's i\_atime field is used to store a checksum of the xattr value;
 and i\_ctime/i\_version store a 64-bit reference count, which enables
diff --git a/Documentation/filesystems/ext4/inlinedata.rst b/Documentation/filesystems/ext4/inlinedata.rst
index d1075178ce0b..8efa8a1cf273 100644
--- a/Documentation/filesystems/ext4/inlinedata.rst
+++ b/Documentation/filesystems/ext4/inlinedata.rst
@@ -9,7 +9,7 @@ data is so tiny that it readily fits inside the inode, which
 file is smaller than 60 bytes, then the data are stored inline in
 ``inode.i_block``. If the rest of the file would fit inside the extended
 attribute space, then it might be found as an extended attribute
-“system.data” within the inode body (“ibody EA”). This of course
+"system.data" within the inode body ("ibody EA"). This of course
 constrains the amount of extended attributes one can attach to an inode.
 If the data size increases beyond i\_block + ibody EA, a regular block
 is allocated and the contents moved to that block.
@@ -20,14 +20,14 @@ inline data, one ought to be able to store 160 bytes of data in a
 that, the limit was 156 bytes due to inefficient use of inode space.
 
 The inline data feature requires the presence of an extended attribute
-for “system.data”, even if the attribute value is zero length.
+for "system.data", even if the attribute value is zero length.
 
 Inline Directories
 ~~~~~~~~~~~~~~~~~~
 
 The first four bytes of i\_block are the inode number of the parent
 directory. Following that is a 56-byte space for an array of directory
-entries; see ``struct ext4_dir_entry``. If there is a “system.data”
+entries; see ``struct ext4_dir_entry``. If there is a "system.data"
 attribute in the inode body, the EA value is an array of
 ``struct ext4_dir_entry`` as well. Note that for inline directories, the
 i\_block and EA space are treated as separate dirent blocks; directory
diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index a65baffb4ebf..cd3bbc3c1e33 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -90,7 +90,7 @@ The inode table entry is laid out in ``struct ext4_inode``.
    * - 0x1C
      - \_\_le32
      - i\_blocks\_lo
-     - Lower 32-bits of “block” count. If the huge\_file feature flag is not
+     - Lower 32-bits of "block" count. If the huge\_file feature flag is not
        set on the filesystem, the file consumes ``i_blocks_lo`` 512-byte blocks
        on disk. If huge\_file is set and EXT4\_HUGE\_FILE\_FL is NOT set in
        ``inode.i_flags``, then the file consumes ``i_blocks_lo + (i_blocks_hi
@@ -109,7 +109,7 @@ The inode table entry is laid out in ``struct ext4_inode``.
    * - 0x28
      - 60 bytes
      - i\_block[EXT4\_N\_BLOCKS=15]
-     - Block map or extent tree. See the section “The Contents of inode.i\_block”.
+     - Block map or extent tree. See the section "The Contents of inode.i\_block".
    * - 0x64
      - \_\_le32
      - i\_generation
@@ -507,7 +507,7 @@ orphaned inode, or zero if there are no more orphans.
 If the inode structure size ``sb->s_inode_size`` is larger than 128
 bytes and the ``i_inode_extra`` field is large enough to encompass the
 respective ``i_[cma]time_extra`` field, the ctime, atime, and mtime
-inode fields are widened to 64 bits. Within this “extra” 32-bit field,
+inode fields are widened to 64 bits. Within this "extra" 32-bit field,
 the lower two bits are used to extend the 32-bit seconds field to be 34
 bit wide; the upper 30 bits are used to provide nanosecond timestamp
 accuracy. Therefore, timestamps should not overflow until May 2446.
diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index cdbfec473167..9e12d5366ad6 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -6,7 +6,7 @@ Journal (jbd2)
 Introduced in ext3, the ext4 filesystem employs a journal to protect the
 filesystem against corruption in the case of a system crash. A small
 continuous region of disk (default 128MiB) is reserved inside the
-filesystem as a place to land “important” data writes on-disk as quickly
+filesystem as a place to land "important" data writes on-disk as quickly
 as possible. Once the important data transaction is fully written to the
 disk and flushed from the disk write cache, a record of the data being
 committed is also written to the journal. At some later point in time,
@@ -507,7 +507,7 @@ Data Block
 In general, the data blocks being written to disk through the journal
 are written verbatim into the journal file after the descriptor block.
 However, if the first four bytes of the block match the jbd2 magic
-number then those four bytes are replaced with zeroes and the “escaped”
+number then those four bytes are replaced with zeroes and the "escaped"
 flag is set in the descriptor block tag.
 
 Revocation Block
@@ -520,8 +520,8 @@ block is freed and re-allocated as a file data block; in this case, a
 journal replay after the file block was written to disk will cause
 corruption.
 
-**NOTE**: This mechanism is NOT used to express “this journal block is
-superseded by this other journal block”, as the author (djwong)
+**NOTE**: This mechanism is NOT used to express "this journal block is
+superseded by this other journal block", as the author (djwong)
 mistakenly thought. Any block being added to a transaction will cause
 the removal of all existing revocation records for that block.
 
diff --git a/Documentation/filesystems/ext4/mmp.rst b/Documentation/filesystems/ext4/mmp.rst
index 25660981d93c..20631883a32b 100644
--- a/Documentation/filesystems/ext4/mmp.rst
+++ b/Documentation/filesystems/ext4/mmp.rst
@@ -42,7 +42,7 @@ The MMP structure (``struct mmp_struct``) is as follows:
    * - 0x0
      - \_\_le32
      - mmp\_magic
-     - Magic number for MMP, 0x004D4D50 (“MMP”).
+     - Magic number for MMP, 0x004D4D50 ("MMP").
    * - 0x4
      - \_\_le32
      - mmp\_seq
diff --git a/Documentation/filesystems/ext4/special_inodes.rst b/Documentation/filesystems/ext4/special_inodes.rst
index 9061aabba827..407537be8fe5 100644
--- a/Documentation/filesystems/ext4/special_inodes.rst
+++ b/Documentation/filesystems/ext4/special_inodes.rst
@@ -26,11 +26,11 @@ ext4 reserves some inode for special features, as follows:
    * - 6
      - Undelete directory.
    * - 7
-     - Reserved group descriptors inode. (“resize inode”)
+     - Reserved group descriptors inode. ("resize inode")
    * - 8
      - Journal inode.
    * - 9
-     - The “exclude” inode, for snapshots(?)
+     - The "exclude" inode, for snapshots(?)
    * - 10
      - Replica inode, used for some non-upstream feature?
    * - 11
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 2eb1ab20498d..8c52ccc6dd04 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -572,7 +572,7 @@ following:
    * - 0x1
      - Directory preallocation (COMPAT\_DIR\_PREALLOC).
    * - 0x2
-     - “imagic inodes”. Not clear from the code what this does
+     - "imagic inodes". Not clear from the code what this does
        (COMPAT\_IMAGIC\_INODES).
    * - 0x4
      - Has a journal (COMPAT\_HAS\_JOURNAL).
@@ -584,12 +584,12 @@ following:
    * - 0x20
      - Has directory indices (COMPAT\_DIR\_INDEX).
    * - 0x40
-     - “Lazy BG”. Not in Linux kernel, seems to have been for uninitialized
+     - "Lazy BG". Not in Linux kernel, seems to have been for uninitialized
        block groups? (COMPAT\_LAZY\_BG)
    * - 0x80
-     - “Exclude inode”. Not used. (COMPAT\_EXCLUDE\_INODE).
+     - "Exclude inode". Not used. (COMPAT\_EXCLUDE\_INODE).
    * - 0x100
-     - “Exclude bitmap”. Seems to be used to indicate the presence of
+     - "Exclude bitmap". Seems to be used to indicate the presence of
        snapshot-related exclude bitmaps? Not defined in kernel or used in
        e2fsprogs (COMPAT\_EXCLUDE\_BITMAP).
    * - 0x200
@@ -695,7 +695,7 @@ the following:
    * - 0x100
      - `Quota <Quota>`__ (RO\_COMPAT\_QUOTA).
    * - 0x200
-     - This filesystem supports “bigalloc”, which means that file extents are
+     - This filesystem supports "bigalloc", which means that file extents are
        tracked in units of clusters (of blocks) instead of blocks
        (RO\_COMPAT\_BIGALLOC).
    * - 0x400
-- 
2.30.2

