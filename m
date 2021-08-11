Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A03E8E5D
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhHKKTv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:19:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbhHKKTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:19:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15CA9221CE;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AFtyfEb4QAnld532v/wbJ0KrEr4VEJtS7Mhiw+3tPc=;
        b=scXp54JU33yRb8loFYogYsD1rpmUXsKshoza8XuyZQirQaOJ1R/td7G2pcbXSsZbjQYpoF
        3P8ygy/k0jkP/QwCWvmTE/ACTrewL25EL7kVxh6094Qk+XnhT4JSsDb+hpBGZfI91PrZcU
        7lwpWQRUFCcfbG+uZw734a4j04ka37Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AFtyfEb4QAnld532v/wbJ0KrEr4VEJtS7Mhiw+3tPc=;
        b=ucj0+0UdMvRQbWKPwyS3vOl0aXjgWy8g7gwQEjHXsoDQIp9e2EJ/BpBnpslsZ+G4HlEzcB
        NxARlbRxa/qHCvCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 092ADA3BFE;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E0D1A1F2BBE; Wed, 11 Aug 2021 12:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] ext4: Orphan file documentation
Date:   Wed, 11 Aug 2021 12:19:14 +0200
Message-Id: <20210811101925.6973-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811101006.2033-1-jack@suse.cz>
References: <20210811101006.2033-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7500; h=from:subject; bh=xod2ry+f7Yrr56cb+FC1F7xd56Zu5lbV32v87XClP98=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6QhBm3oTNfGZeEEMohXQPX4/7qcIvK6r2SBY5db FoVHOUOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROkIQAKCRCcnaoHP2RA2QnGB/ 4zD9J6iuAV0a8e0PthHrUf/i8Ct5FHomAgpHAskvt0K4jDa2LIF9xR2vWgrX6jGI8Ei14Mhv16734q oik5Gpshkd3O/loBrE9CKaSKhtR2JVgoKIQQn0u2MxB+WbmTYqfTXpmqDNHxygxQlQ2Aa6/bKL1Pef dCrcHvXXbGPbP2vLvpagm780GvfdYuknZhlxxnuSty9f+OyVe+TsDF2NxlB4MJzaZLGPBCkuqdyIxO wHVUASOCH5pMVCd+Swonl16T4+DnSiimX6n9NTLJSxyXxFTDeZJP2XxgksD8kABloyExDXLIJkueQY rghT4QtwRMmtmc2P9b691SsqWJ/NQk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add documentation about the orphan file feature.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/ext4/globals.rst    |  1 +
 Documentation/filesystems/ext4/inodes.rst     | 10 ++--
 Documentation/filesystems/ext4/orphan.rst     | 52 +++++++++++++++++++
 .../filesystems/ext4/special_inodes.rst       | 17 ++++++
 Documentation/filesystems/ext4/super.rst      | 15 +++++-
 5 files changed, 89 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/orphan.rst

diff --git a/Documentation/filesystems/ext4/globals.rst b/Documentation/filesystems/ext4/globals.rst
index 368bf7662b96..b17418974fd3 100644
--- a/Documentation/filesystems/ext4/globals.rst
+++ b/Documentation/filesystems/ext4/globals.rst
@@ -11,3 +11,4 @@ have static metadata at fixed locations.
 .. include:: bitmaps.rst
 .. include:: mmp.rst
 .. include:: journal.rst
+.. include:: orphan.rst
diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index a65baffb4ebf..6c5ce666e63f 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -498,11 +498,11 @@ structure -- inode change time (ctime), access time (atime), data
 modification time (mtime), and deletion time (dtime). The four fields
 are 32-bit signed integers that represent seconds since the Unix epoch
 (1970-01-01 00:00:00 GMT), which means that the fields will overflow in
-January 2038. For inodes that are not linked from any directory but are
-still open (orphan inodes), the dtime field is overloaded for use with
-the orphan list. The superblock field ``s_last_orphan`` points to the
-first inode in the orphan list; dtime is then the number of the next
-orphaned inode, or zero if there are no more orphans.
+January 2038. If the filesystem does not have orphan_file feature, inodes
+that are not linked from any directory but are still open (orphan inodes) have
+the dtime field overloaded for use with the orphan list. The superblock field
+``s_last_orphan`` points to the first inode in the orphan list; dtime is then
+the number of the next orphaned inode, or zero if there are no more orphans.
 
 If the inode structure size ``sb->s_inode_size`` is larger than 128
 bytes and the ``i_inode_extra`` field is large enough to encompass the
diff --git a/Documentation/filesystems/ext4/orphan.rst b/Documentation/filesystems/ext4/orphan.rst
new file mode 100644
index 000000000000..bb19ecd1b626
--- /dev/null
+++ b/Documentation/filesystems/ext4/orphan.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Orphan file
+-----------
+
+In unix there can inodes that are unlinked from directory hierarchy but that
+are still alive because they are open. In case of crash the filesystem has to
+clean up these inodes as otherwise they (and the blocks referenced from them)
+would leak. Similarly if we truncate or extend the file, we need not be able
+to perform the operation in a single journalling transaction. In such case we
+track the inode as orphan so that in case of crash extra blocks allocated to
+the file get truncated.
+
+Traditionally ext4 tracks orphan inodes in a form of single linked list where
+superblock contains the inode number of the last orphan inode (s\_last\_orphan
+field) and then each inode contains inode number of the previously orphaned
+inode (we overload i\_dtime inode field for this). However this filesystem
+global single linked list is a scalability bottleneck for workloads that result
+in heavy creation of orphan inodes. When orphan file feature
+(COMPAT\_ORPHAN\_FILE) is enabled, the filesystem has a special inode
+(referenced from the superblock through s\_orphan_file_inum) with several
+blocks. Each of these blocks has a structure:
+
+.. list-table::
+   :widths: 8 8 24 40
+   :header-rows: 1
+
+   * - Offset
+     - Type
+     - Name
+     - Description
+   * - 0x0
+     - Array of \_\_le32 entries
+     - Orphan inode entries
+     - Each \_\_le32 entry is either empty (0) or it contains inode number of
+       an orphan inode.
+   * - blocksize - 8
+     - \_\_le32
+     - ob\_magic
+     - Magic value stored in orphan block tail (0x0b10ca04)
+   * - blocksize - 4
+     - \_\_le32
+     - ob\_checksum
+     - Checksum of the orphan block.
+
+When a filesystem with orphan file feature is writeably mounted, we set
+RO\_COMPAT\_ORPHAN\_PRESENT feature in the superblock to indicate there may
+be valid orphan entries. In case we see this feature when mounting the
+filesystem, we read the whole orphan file and process all orphan inodes found
+there as usual. When cleanly unmounting the filesystem we remove the
+RO\_COMPAT\_ORPHAN\_PRESENT feature to avoid unnecessary scanning of the orphan
+file and also make the filesystem fully compatible with older kernels.
diff --git a/Documentation/filesystems/ext4/special_inodes.rst b/Documentation/filesystems/ext4/special_inodes.rst
index 9061aabba827..94f304e3a0a7 100644
--- a/Documentation/filesystems/ext4/special_inodes.rst
+++ b/Documentation/filesystems/ext4/special_inodes.rst
@@ -36,3 +36,20 @@ ext4 reserves some inode for special features, as follows:
    * - 11
      - Traditional first non-reserved inode. Usually this is the lost+found directory. See s\_first\_ino in the superblock.
 
+Note that there are also some inodes allocated from non-reserved inode numbers
+for other filesystem features which are not referenced from standard directory
+hierarchy. These are generally reference from the superblock. They are:
+
+.. list-table::
+   :widths: 20 50
+   :header-rows: 1
+
+   * - Superblock field
+     - Description
+
+   * - s\_lpf\_ino
+     - Inode number of lost+found directory.
+   * - s\_prj\_quota\_inum
+     - Inode number of quota file tracking project quotas
+   * - s\_orphan\_file\_inum
+     - Inode number of file tracking orphan inodes.
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 2eb1ab20498d..f6a548e957bb 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -479,7 +479,11 @@ The ext4 superblock is laid out as follows in
      - Filename charset encoding flags.
    * - 0x280
      - \_\_le32
-     - s\_reserved[95]
+     - s\_orphan\_file\_inum
+     - Orphan file inode number.
+   * - 0x284
+     - \_\_le32
+     - s\_reserved[94]
      - Padding to the end of the block.
    * - 0x3FC
      - \_\_le32
@@ -603,6 +607,11 @@ following:
        the journal, JBD2 incompat feature
        (JBD2\_FEATURE\_INCOMPAT\_FAST\_COMMIT) gets
        set (COMPAT\_FAST\_COMMIT).
+   * - 0x1000
+     - Orphan file allocated. This is the special file for more efficient
+       tracking of unlinked but still open inodes. When there may be any
+       entries in the file, we additionally set proper rocompat feature
+       (RO\_COMPAT\_ORPHAN\_PRESENT).
 
 .. _super_incompat:
 
@@ -713,6 +722,10 @@ the following:
      - Filesystem tracks project quotas. (RO\_COMPAT\_PROJECT)
    * - 0x8000
      - Verity inodes may be present on the filesystem. (RO\_COMPAT\_VERITY)
+   * - 0x10000
+     - Indicates orphan file may have valid orphan entries and thus we need
+       to clean them up when mounting the filesystem
+       (RO\_COMPAT\_ORPHAN\_PRESENT).
 
 .. _super_def_hash:
 
-- 
2.26.2

