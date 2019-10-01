Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69FFC2E5E
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbfJAHmM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHmM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so9030026pgl.1
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/Q7WPV+S23Bdpz0IUKjn+ilGhjsHlGDPmfP9B95hwQ=;
        b=G8s5Mhab2UX7r2+OJ0FjAYzzc0GGDFgvLFbUPaXzvhDoMPIVJYQQyaFpWsubhJt0SL
         MtD6amJ/h4w6eiTBk9cX0s2ix748E0GfOTA3bVK0CMCJtWpgNj4okoTb8IxEMKKon6L5
         UHh/5WCaXnNecAVuXB6uLLt87f3IZMWvtZ/0tPdOv/duh4mwSv71xRGUGBezzojRh0MD
         Gf4YvneEBsxdl95do13kxJPDmUKD0h6xkEjqXbQRX+/3sC63s27K5fIUdqTEj9lyIRoA
         5s0lHvtclNVbE9tgif6pvUDkCOXpGRfsSccvL/zPD3snaqM7mQmzhOIuGiVxXT4JzvOF
         Jdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/Q7WPV+S23Bdpz0IUKjn+ilGhjsHlGDPmfP9B95hwQ=;
        b=mZPYqFROYxz+bGJgb1JE3+hHqCfhj+zT4wMOpb1FDe4dPXrxxrNzgDZo6K+Xr72z3k
         OvJ+XL+mmn8ucE7OTkv9vxBtPJqQ/aL9NDfUdsdnU18rjdpXCYw6ZP4Az2L6fcNosWhA
         QCbnKC94fYTNiFablwMrLwLGqp4aZZ6dfyRGT5BkUCohbCy1hDPCiCTqXyCCrkMv44kI
         ZrlfNYsEndCZKT6DRe/3SsrB02YXwVdH1D4E+qZPIlf3IhwlnTU8c1zPK1qDaYPDWSxR
         JO51PoJfDWNibmEqCXFsxtkKUsSaaHgM3sfmZdIegykzAiKW12g/Cy+0tz5UTacCnWwI
         68sw==
X-Gm-Message-State: APjAAAUYi10tX9XjPkbmzYa+5ogl1bHBzc67xRsJv9ntBaoOy6FAXVdz
        F3LYIo9UarAzxCZXDBPrmsH6wO6gLnA=
X-Google-Smtp-Source: APXvYqz2NuiwYyIsLKfakqWI6kqonZDf4bO15NaRjuhpA0KYVEW9tQIfCSiNpvQC3f/HyIKbooTjcQ==
X-Received: by 2002:a17:90a:356d:: with SMTP id q100mr4053408pjb.53.1569915730109;
        Tue, 01 Oct 2019 00:42:10 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:09 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 12/13] docs: Add fast commit documentation
Date:   Tue,  1 Oct 2019 00:41:01 -0700
Message-Id: <20191001074101.256523-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
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
 Documentation/filesystems/ext4/journal.rst | 98 ++++++++++++++++++++--
 Documentation/filesystems/journalling.rst  | 22 +++++
 2 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index ea613ee701f5..23e7db89fc6a 100644
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
+in the middle of the disk. Ext4 also utilizes JBD2's fast
+commits. Fast commits store metadata changes to inodes in an
+incremental fashion. A fast commit is valid only if there is no full
+commit after that particular fast commit. Because of this fast commit
+blocks are overwritten by a following transaction.
 
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
@@ -609,3 +617,81 @@ bytes long (but uses a full block):
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
+       should be present in the corresponding inode. Currently,
+       following tags are supported: EXT4\_FC\_TAG\_EXT (extent that
+       should be present in the inode), EXT4\_FC\_TAG\_DNAME (dentry
+       name of the inode), EXT4\_FC\_TAG\_PARENT\_INO (inode number of
+       the directory that should contain the dentry of the inode).
diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 58ce6b395206..217f66d67f9d 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -115,6 +115,28 @@ called after each transaction commit. You can also use
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
+It is possible for the file systems to perform fast commits
+asynchronously (without involvement of journalling thread). All file
+systems really need to do is to call :c:func:`jbd2_start_async_fc()`
+before starting the commit and call :c:func:`jbd2_stop_async_fc()`
+after the commit. This makes sure that the journalling thread and
+other async fast committers don't interfere.
+
 JBD2 also provides a way to block all transaction updates via
 :c:func:`jbd2_journal_lock_updates()` /
 :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants a
-- 
2.23.0.444.g18eeb5a265-goog

