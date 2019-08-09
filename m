Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2432A8704C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbfHIDqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405241AbfHIDqi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so45258657pff.9
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJqXJqAeOKVKiXAlejo9+7GDfeBArCeFG4cEOTw+pTU=;
        b=OfnPzcWv8+39mwnRXgtCsKtvTZ6avLBKvVXO28HFn4texfTnOD8IvM17wJfbXTlorl
         8VF0EfJuehNiYCQK3R8cQgeyj9/YhtfI5RLob0HPUKTdWxniDYpgtshCkliwzYXmO70c
         nmxPolfKFmLTZiFI+lfQuSI2cl8C5syF/1ZG2n/xiSS1ARnHGgEdieumVBFrd5sqgM/J
         7eLnwrFCQ6nkLLU5s+N1ZEVmltuZ2fxAfhiM0kilwa3HoY2TCCJTaaBXBigDKp4tDwOy
         zB+B8mgOYwa4QLoA+F/7mtzSDGhaga15OH21AoJNNaM2YPR0IEyqK+N6mvm4pzfZtcYj
         GIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJqXJqAeOKVKiXAlejo9+7GDfeBArCeFG4cEOTw+pTU=;
        b=QvduoshRAZ9zkS5FZc7uZcMKGenZqUp+8bZ7G2E3oSWyKEUV7W5qSEEGkDmRVgdhiG
         e1LZf13V39uCBu0AL6H8fzEYoryq/Bmaq+za0H3DDNPr32vkKt53bl90+SW7vEx7IbM6
         lRYYH5DPwpM+KC2MvkgMxlcN136OE8/tdyGd1ufVdEpS4MvyeP8m+oZ+dRWyBxQKeAxp
         oTcfq+uiday6C2emYiOXbHnBHktO3MEXhKJAYemA6PIk5hkjH2ovSxGhdZ/2LXbHtjKH
         i6fUwlzeYvpmSKUzgS34/mFycpxw2h5q3f6sNhOSSyERAZZNyDywAb6yWhdwP7ydiBmO
         RDsA==
X-Gm-Message-State: APjAAAVj8UtPV2fR7WVed5xbGkv6bl+2aeJ465VVZjocqYWh8QhGUXkL
        pemedcU/R22PZybrjZzgu23QX0ry
X-Google-Smtp-Source: APXvYqzutHbG91AccfanqnTTnwpNMJDEGNrhhlOfeS/n1UQzyesI7Ltph5pveu0eb9PosYiof+oL5Q==
X-Received: by 2002:a63:d301:: with SMTP id b1mr15422849pgg.379.1565322396609;
        Thu, 08 Aug 2019 20:46:36 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:36 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 12/12] docs: Add fast commit documentation
Date:   Thu,  8 Aug 2019 20:45:52 -0700
Message-Id: <20190809034552.148629-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds necessary documentation to
Documentation/filesystems/journalling.rst and
Documentation/filesystems/ext4/journal.rst.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 96 ++++++++++++++++++++--
 Documentation/filesystems/journalling.rst  | 15 ++++
 2 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index ea613ee701f5..d6e4a698e208 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -29,10 +29,14 @@ safest. If ``data=writeback``, dirty data blocks are not flushed to the
 disk before the metadata are written to disk through the journal.
 
 The journal inode is typically inode 8. The first 68 bytes of the
-journal inode are replicated in the ext4 superblock. The journal itself
-is normal (but hidden) file within the filesystem. The file usually
-consumes an entire block group, though mke2fs tries to put it in the
-middle of the disk.
+journal inode are replicated in the ext4 superblock. The journal
+itself is normal (but hidden) file within the filesystem. The file
+usually consumes an entire block group, though mke2fs tries to put it
+in the middle of the disk. Last 128 blocks in the journal are reserved
+for fast commits. Fast commits store metadata changes to inodes in an
+incremental fashion. A fast commit is valid only if there is no full
+commit after that particular fast commit. That makes fast commit space
+reusable after every full commit.
 
 All fields in jbd2 are written to disk in big-endian order. This is the
 opposite of ext4.
@@ -48,16 +52,18 @@ Layout
 Generally speaking, the journal has this format:
 
 .. list-table::
-   :widths: 16 48 16
+   :widths: 16 48 16 18
    :header-rows: 1
 
    * - Superblock
      - descriptor\_block (data\_blocks or revocation\_block) [more data or
        revocations] commmit\_block
      - [more transactions...]
+     - [Fast commits...]
    * - 
      - One transaction
      -
+     -
 
 Notice that a transaction begins with either a descriptor and some data,
 or a block revocation list. A finished transaction always ends with a
@@ -76,7 +82,7 @@ The journal superblock will be in the next full block after the
 superblock.
 
 .. list-table::
-   :widths: 12 12 12 32 12
+   :widths: 12 12 12 32 12 12
    :header-rows: 1
 
    * - 1024 bytes of padding
@@ -85,11 +91,13 @@ superblock.
      - descriptor\_block (data\_blocks or revocation\_block) [more data or
        revocations] commmit\_block
      - [more transactions...]
+     - [Fast commits...]
    * - 
      -
      -
      - One transaction
      -
+     -
 
 Block Header
 ~~~~~~~~~~~~
@@ -609,3 +617,79 @@ bytes long (but uses a full block):
      - h\_commit\_nsec
      - Nanoseconds component of the above timestamp.
 
+Fast Commit Block
+~~~~~~~~~~~~~~~~~
+
+The fast commit block indicates an append to the last commit block
+that was written to the journal. One fast commit block records updates
+to one inode. So, typically you would find as many fast commit blocks
+as the number of inodes that got changed since the last commit. A fast
+commit block is valid only if there is no commit block present with
+transaction ID greater than that of the fast commit block. If such a
+block a present, then there is no need to replay the fast commit
+block.
+
+Multiple fast commit blocks are a part of one sub-transaction. To
+indicate the last block in a fast commit transaction, fc_flags field
+in the last block in every subtransaction is marked with "LAST" (0x1)
+flag. A subtransaction is valid only if all the following conditions
+are met:
+
+1) SUBTID of all blocks is either equal to or greater than SUBTID of
+   the previous fast commit block.
+2) For every sub-transaction, last block is marked with LAST flag.
+3) There are no invalid blocks in between.
+
+.. list-table::
+   :widths: 8 8 24 40
+   :header-rows: 1
+
+   * - Offset
+     - Type
+     - Name
+     - Descriptor
+   * - 0x0
+     - journal\_header\_s
+     - (open coded)
+     - Common block header.
+   * - 0xC
+     - \_\_le32
+     - fc\_magic
+     - Magic value which should be set to 0xE2540090. This identifies
+       that this block is a fast commit block.
+   * - 0x10
+     - \_\_le32
+     - fc\_subtid
+     - Sub-transaction ID for this commit block
+   * - 0x14
+     - \_\_u8
+     - fc\_features
+     - Features used by this fast commit block.
+   * - 0x15
+     - \_\_u8
+     - fc_flags
+     - Flags. (0x1(Last) - Indicates that this is the last block in sub-transaction)
+   * - 0x16
+     - \_\_le16
+     - fc_num_tlvs
+     - Number of TLVs contained in this fast commit block
+   * - 0x18
+     - \_\_le32
+     - \_\_fc\_len
+     - Length of the fast commit block in terms of number of blocks
+   * - 0x2c
+     - \_\_le32
+     - fc\_ino
+     - Inode number of the inode that will be recovered using this fast commit
+   * - 0x30
+     - struct ext4\_inode
+     - inode
+     - On-disk copy of the inode at the commit time
+   * - 0x34
+     - struct ext4\_fc\_tl
+     - Array of struct ext4\_fc\_tl
+     - The actual delta with the last commit. Starting at this offset,
+       there is an array of TLVs that indicates which all extents
+       should be present in the corresponding inode. Currently, the
+       only tag that is supported is EXT4\_FC\_TAG\_EXT. That tag
+       indicates that the corresponding value is an extent.
diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 58ce6b395206..2e0d550b546c 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -115,6 +115,21 @@ called after each transaction commit. You can also use
 ``transaction->t_private_list`` for attaching entries to a transaction
 that need processing when the transaction commits.
 
+JBD2 also allows client file systems to implement file system specific
+commits which are called as ``fast commits``. File systems that wish
+to use this feature should first set
+``journal->j_fc_commit_callback``. That function is called before
+performing a commit. File system can call :c:func:`jbd2_map_fc_buf()`
+to get buffers reserved for fast commits. If file system returns 0,
+JBD2 assumes that file system performed a fast commit and it backs off
+from performing a commit. Otherwise, JBD2 falls back to normal full
+commit. After performing either a fast or a full commit, JBD2 calls
+``journal->j_fc_cleanup_cb`` to allow file systems to perform cleanups
+for their internal fast commit related data structures. At the replay
+time, JBD2 passes each and every fast commit block to the file system
+via ``journal->j_fc_replay_cb``. Ext4 effectively uses this fast
+commit mechanism to improve journal commit performance.
+
 JBD2 also provides a way to block all transaction updates via
 :c:func:`jbd2_journal_lock_updates()` /
 :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants a
-- 
2.23.0.rc1.153.gdeed80330f-goog

