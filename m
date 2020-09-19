Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC927098C
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgISAzM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAzK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F660C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kk9so3873890pjb.2
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7spz+IXsCmdsMYIemNtfJ2gEnb+/gRHHms10klLi+c=;
        b=B5oLGn3lxHzxdfubcqBoNTTE1JunqqJ3yv3IIu3vsfUNZBgoeqV+cLDnqGnjW97dSw
         FPbAyVRvakxPEDjPlfPbe1dqp1cDQEfd2Sgme5ybVmuGz+ee/BkizTQpQyOvRmdgc9AK
         5ztLWmiv+0Ge2hKQ8dlmf1lRLaBTz0YCUrM3inXzflwijbjZVqhDBzPR1OCZTwhRmIiz
         1hHGYLLCHS9TzCM+TrLFdP4P/12i038MFMolnQFemG+RF7rWhVhPB528ptMMt9vuoCnv
         0nHYLNm+ta857QCdO+IiWEXm/XO1wK+0ciF9S1729zulMt0ZM4Z8usv/iGjA6e952bVH
         WJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7spz+IXsCmdsMYIemNtfJ2gEnb+/gRHHms10klLi+c=;
        b=t/Gj8vBDjV41ZrNFuFO9iohe+RWXg3eQI/wzThOoLG1dWrZc95bA3hSG8mSyECWp1f
         aMrXyLXrjLnXB9LAufQEi/sW/JYSD0y3oWjLzW2ESAtVvBmufoGzNLyaN5Y9Or/yyDJM
         5jaWsnOFOcOrPK/X5zFDtS8qdoqdbddNta6szE8pLTHK0xLxfhIvb8EeAghhRKuPhIeq
         k9nwc2F57bS6zSy2YP7tPcwi+E2FGoa7PcI4q3sw/PcOMnp1WVGk7z5e0Qy9RYOrLc47
         FaJu9skGuzueDu21SbXsmuECJpqkb1xgEs1waDrmTpUifx448p7Rv3JtG/fZ5wAZxxkw
         9QEA==
X-Gm-Message-State: AOAM533n+MatszCvV1tQauPlqIBlCnDVNpunnsqx4XZinIxhnx7Kv/qK
        lpmWyLa0nDXkYKbNMyswk84H4frjTMc=
X-Google-Smtp-Source: ABdhPJypddrOxy05OHlPiSSPzYbzEhrAuUmU2vlr1lqgWLrGGLESCsnUMJuA9pbXAASc9VoEQGUlPg==
X-Received: by 2002:a17:90a:9708:: with SMTP id x8mr15805991pjo.213.1600476909107;
        Fri, 18 Sep 2020 17:55:09 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:08 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 1/9] doc: update ext4 and journalling docs to include fast commit feature
Date:   Fri, 18 Sep 2020 17:54:43 -0700
Message-Id: <20200919005451.3899779-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.28.0.681.g6f77f65b4e-goog

