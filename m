Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C008F22887C
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgGUSpU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGUSpT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3DC0619DA
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so11145602pfn.7
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8ADIxiuHigG2VXq49u7DaSdDqqjT1XI4gZq1G174BI=;
        b=pLzS9NxCYxcQYxxT03O5PDytvxxBZz1Kz7eLRDktaJR1uuUhSJnlxpadjH7cWaFrX3
         KgjxRht/eR0qNTBXLEjZqlH5srb2xc5a21MiCHrCqf1N8WunUjAmYt/4lUJmG75G1hjO
         lZvVY7O47IsAVo0cQeTj2UeTnMZbP17NxkfdNUjyfyMgCSDwsUaNJAKcehqsoghA2+xk
         1S8xglzVvE+13o62lRRrPii1n7jgtdgM7Q2d2nFq1dW/ExOXEuR7TfDZPhClqB7s8Dw1
         9k7uDDp6WonANiabf8tzjr2PL9wtXpvbTKIJOiWWRRNgLXZN52p4qdrWPU984C5EJF8H
         oKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8ADIxiuHigG2VXq49u7DaSdDqqjT1XI4gZq1G174BI=;
        b=svdL0x2+CN5il2HVJcrWO1pQbaquv0XuC6YytgjmcR7uOJsWCeRLHsRbCzktQklgZP
         Pk6NykT7WuXSuMzcdx7mcaEdBPzw6tQYHU9FaEHZsZEIuYOpRvuuYXP268vCTg0dEQAi
         pVnDOycvqQf1h9NVY5kUo6lLzESvKXVaBwRITR5r1H/NldcinRC5iZMn7rIHQefwTrmD
         1xzd+VEJ9YhDKtkH8pFRTM0aH53LRsvY+K4G/NERFkcRbzoY4SpAVPXo/RCIihi8Wxwo
         MHl0dFQRo24ITi0WQVXTESZj0vtD6q4MswlBwHAcczQuRenQh9SiCtxpmsX01T5DhH1F
         rE2g==
X-Gm-Message-State: AOAM531aqdVIMoMYI+4QI3nxOj4/a9h/hOUTka8Uvd/pj2GFFRKXpipp
        bI3Neb9lFAF/g4qZOY5oKdzx4Fi4
X-Google-Smtp-Source: ABdhPJwuCq96DW6GQn5VhrDPjMu1RJmrWgtnSU6pQx33f0IoQNkCKkETuBOLQw7oY/Hs1HtcEcIecA==
X-Received: by 2002:aa7:9736:: with SMTP id k22mr24491521pfg.62.1595357117753;
        Tue, 21 Jul 2020 11:45:17 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 1/7] doc: update ext4 and journalling docs to include fast commit feature
Date:   Tue, 21 Jul 2020 11:43:49 -0700
Message-Id: <20200721184355.1616986-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
References: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds necessary documentation for fast commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
 Documentation/filesystems/journalling.rst  | 28 +++++++++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index ea613ee701f5..c2e4d010a201 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -28,6 +28,17 @@ metadata are written to disk through the journal. This is slower but
 safest. If ``data=writeback``, dirty data blocks are not flushed to the
 disk before the metadata are written to disk through the journal.
 
+In case of ``data=ordered`` mode, Ext4 also supports fast commits which
+help reduce commit latency significantly. The default ``data=ordered``
+mode works by logging metadata blocks tothe journal. In fast commit
+mode, Ext4 only stores the minimal delta needed to recreate the
+affected metadata in fast commit space that is shared with JBD2.
+Once the fast commit area fills in or if fast commit is not possible
+or if JBD2 commit timer goes off, Ext4 performs a traditional full commit.
+A full commit invalidates all the fast commits that happened before
+it and thus it makes the fast commit area empty for further fast
+commits. This feature needs to be enabled at compile time.
+
 The journal inode is typically inode 8. The first 68 bytes of the
 journal inode are replicated in the ext4 superblock. The journal itself
 is normal (but hidden) file within the filesystem. The file usually
@@ -609,3 +620,58 @@ bytes long (but uses a full block):
      - h\_commit\_nsec
      - Nanoseconds component of the above timestamp.
 
+Fast commits
+~~~~~~~~~~~~
+
+Fast commit area is organized as a log of tag tag length values. Each TLV has
+a ``struct ext4_fc_tl`` in the beginning which stores the tag and the length
+of the entire field. It is followed by variable length tag specific value.
+Here is the list of supported tags and their meanings:
+
+.. list-table::
+   :widths: 8 20 20 32
+   :header-rows: 1
+
+   * - Tag
+     - Meaning
+     - Value struct
+     - Description
+   * - EXT4_FC_TAG_HEAD
+     - Fast commit area header
+     - ``struct ext4_fc_head``
+     - Stores the TID of the transaction after which these fast commits should
+       be applied.
+   * - EXT4_FC_TAG_ADD_RANGE
+     - Add extent to inode
+     - ``struct ext4_fc_add_range``
+     - Stores the inode number and extent to be added in this inode
+   * - EXT4_FC_TAG_DEL_RANGE
+     - Remove logical offsets to inode
+     - ``struct ext4_fc_del_range``
+     - Stores the inode number and the logical offset range that needs to be
+       removed
+   * - EXT4_FC_TAG_CREAT
+     - Create directory entry for a newly created file
+     - ``struct ext4_fc_dentry_info``
+     - Stores the parent inode numer, inode number and directory entry of the
+       newly created file
+   * - EXT4_FC_TAG_LINK
+     - Link a directory entry to an inode
+     - ``struct ext4_fc_dentry_info``
+     - Stores the parent inode numer, inode number and directory entry
+   * - EXT4_FC_TAG_UNLINK
+     - Unink a directory entry of an inode
+     - ``struct ext4_fc_dentry_info``
+     - Stores the parent inode numer, inode number and directory entry
+
+   * - EXT4_FC_TAG_PAD
+     - Padding (unused area)
+     - None
+     - Unused bytes in the fast commit area.
+
+   * - EXT4_FC_TAG_TAIL
+     - Mark the end of a fast commit
+     - ``struct ext4_fc_tail``
+     - Stores the TID of the commit, CRC of the fast commit of which this tag
+       represents the end of
+
diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 58ce6b395206..a9817220dc9b 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -132,6 +132,34 @@ The opportunities for abuse and DOS attacks with this should be obvious,
 if you allow unprivileged userspace to trigger codepaths containing
 these calls.
 
+Fast commits
+~~~~~~~~~~~~
+
+JBD2 to also allows you to perform file-system specific delta commits known as
+fast commits. In order to use fast commits, you first need to call
+:c:func:`jbd2_fc_init` and tell how many blocks at the end of journal
+area should be reserved for fast commits. Along with that, you will also need
+to set following callbacks that perform correspodning work:
+
+`journal->j_fc_cleanup_cb`: Cleanup function called after every full commit and
+fast commit.
+
+`journal->j_fc_replay_cb`: Replay function called for replay of fast commit
+blocks.
+
+File system is free to perform fast commits as and when it wants as long as it
+gets permission from JBD2 to do so by calling the function
+:c:func:`jbd2_fc_start()`. Once a fast commit is done, the client
+file  system should tell JBD2 about it by calling :c:func:`jbd2_fc_stop()`.
+If file system wants JBD2 to perform a full commit immediately after stopping
+the fast commit it can do so by calling :c:func:`jbd2_fc_stop_do_commit()`.
+This is useful if fast commit operation fails for some reason and the only way
+to guarantee consistency is for JBD2 to perform the full traditional commit.
+
+JBD2 helper functions to manage fast commit buffers. File system can use
+:c:func:`jbd2_fc_get_buf()` and :c:func:`jbd2_fc_wait_bufs()` to allocate
+and wait on IO completion of fast commit buffers.
+
 Summary
 ~~~~~~~
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog

