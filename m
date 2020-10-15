Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19A528FA2F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgJOUiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbgJOUiN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E3C0613D2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:12 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f19so113076pfj.11
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCy4vP8UA+pfczkhHL/oVySRNrGMn2s4GxOpMv0W6ss=;
        b=m+K9RvU60YqeAoQHpaZ3D5HtMm5p1LOFjNaINRcKj77IeD4gczPOQBmNGtxPVIciA/
         /DDQrWtxdwoTbNhMLxNvuty1ls7ZGPfBLoMS9pThyaUAg0F96uvX8pDJ+oZu2X8VQGMc
         f88lm+Gku5b8mfveRQ7ohYrzpALA71xZV+mlppAzQLVXxDq1zIT+kkN7BzatiI35hTEt
         ruxXcIfthb8roLm6fo5utZPvK0HpnCNl31EKLHJ3cB6i3gKhTzME50TZmI6bPNpU3MND
         fNsFg0kRv8kEtnoIWGJMRWhGpP6VRZ6dJ5fV41uvG/eMME3l52tNjVSvNye87yiVKx5l
         gfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCy4vP8UA+pfczkhHL/oVySRNrGMn2s4GxOpMv0W6ss=;
        b=CZzqScSIsw9r9TlrN3NjnjB/2705PKMz59nFr1XVsehTOG+ZDKOsmIDtX7aa2iDH1i
         fn0E1R27o3NzzG2iYIVaiCboE2ePb436hCSM89mfDRzaO1pzX44Q9gf3PanJUmwQ19bH
         vyZ45a8vTuvDUDk7Pn6sYYUWWc8oieDQQt9gaKc8ULtvhufZ9KiT2/IdTVguDnoEssbn
         qRSsej0UTrRoCphvxkcD3CuODSgHQPvW5TKHAsANhqfka0lMjziejtTw5AEDyouKW9MZ
         hWrYbntG88ut4Ipbl80vczJUaUVmWeoONbEUixajNzbs5pqkD2OztHnYoZ24cDA83qW5
         DL5g==
X-Gm-Message-State: AOAM532rNisGMaNyMGC+dQ3+b7LT5kjYyI36rSZovaZQq4xl83Z6YHsP
        KT6llKo0ekIw2pC2xYBDOrTWvTJ1ZJA=
X-Google-Smtp-Source: ABdhPJwkEw5/pe3rQMLkdFhgI7Rv8619zQ4epqFnLmmMwUij4HgzllanWDhSEUXtvwHQfzuz2U1CgA==
X-Received: by 2002:a63:f015:: with SMTP id k21mr287741pgh.422.1602794290936;
        Thu, 15 Oct 2020 13:38:10 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:10 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 1/9] doc: update ext4 and journalling docs to include fast commit feature
Date:   Thu, 15 Oct 2020 13:37:53 -0700
Message-Id: <20201015203802.3597742-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds necessary documentation for fast commits.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
 Documentation/filesystems/journalling.rst  | 33 +++++++++++
 2 files changed, 99 insertions(+)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index ea613ee701f5..a522037a28cf 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -28,6 +28,17 @@ metadata are written to disk through the journal. This is slower but
 safest. If ``data=writeback``, dirty data blocks are not flushed to the
 disk before the metadata are written to disk through the journal.
 
+In case of ``data=ordered`` mode, Ext4 also supports fast commits which
+help reduce commit latency significantly. The default ``data=ordered``
+mode works by logging metadata blocks to the journal. In fast commit
+mode, Ext4 only stores the minimal delta needed to recreate the
+affected metadata in fast commit space that is shared with JBD2.
+Once the fast commit area fills in or if fast commit is not possible
+or if JBD2 commit timer goes off, Ext4 performs a traditional full commit.
+A full commit invalidates all the fast commits that happened before
+it and thus it makes the fast commit area empty for further fast
+commits. This feature needs to be enabled at mkfs time.
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
+Fast commit area is organized as a log of tag length values. Each TLV has
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
index 7e2be2faf653..5a5f70b4063e 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -132,6 +132,39 @@ The opportunities for abuse and DOS attacks with this should be obvious,
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
+:c:func:`jbd2_fc_begin_commit()`. Once a fast commit is done, the client
+file  system should tell JBD2 about it by calling
+:c:func:`jbd2_fc_end_commit()`. If file system wants JBD2 to perform a full
+commit immediately after stopping the fast commit it can do so by calling
+:c:func:`jbd2_fc_end_commit_fallback()`. This is useful if fast commit operation
+fails for some reason and the only way to guarantee consistency is for JBD2 to
+perform the full traditional commit.
+
+JBD2 helper functions to manage fast commit buffers. File system can use
+:c:func:`jbd2_fc_get_buf()` and :c:func:`jbd2_fc_wait_bufs()` to allocate
+and wait on IO completion of fast commit buffers.
+
+Currently, only Ext4 implements fast commits. For details of its implementation
+of fast commits, please refer to the top level comments in
+fs/ext4/fast_commit.c.
+
 Summary
 ~~~~~~~
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

