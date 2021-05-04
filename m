Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334D372E28
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhEDQgy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhEDQgy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 12:36:54 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E1C061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 09:35:58 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id h18so5064130vsp.8
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjpcbPdAoo5U5rYlXElHkRRW1JHd3S9QPcvC34VOHIo=;
        b=V3kpRo0y7oAijahjI8cLElyyI4j3WQn6/vPb9kl44EG8CNDR2dSmLDcZta8k0Po6nq
         JM9WiHprpB+6q3eDvoitdO0esWZ40VFGPlfvlPm7hjF99/5OWWeNF57wTjZ38i5g4Eq9
         Yv4EWv1Bld7hBGkw3K17H08a2RbqZH2W+uh4xF1XVnw4FPFFgQhjBoHYwr04TAQEETM/
         RR8SHDosqGl+KiL+ZQU0XPTPcx9cFKJVmMybRZ6N8kF/j/443oQECzOXLxYtA2pycaDr
         fBPt4hV116NGeyrgJdK6x6RwfdYBwhc+8eOGQhPizt3Zm5nUG3RLexlcInNW3xXOh5WN
         z9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjpcbPdAoo5U5rYlXElHkRRW1JHd3S9QPcvC34VOHIo=;
        b=lycOv41Y8zdpUkWdDpCTqD1bvUtyMTeNoYiJzYRWIMhcjo173Cy7gPhRNUy85XXKtt
         D8li1Lt9RdddO4b1BVZg5xNKCkivecHr6bmRO/7YJltr71DTY0MfjVWgl2L1yHJY+r07
         advs+yh4q3Rbwz0jQoga9RKHF/DTVI0mTfLBaSa8mZOkc4E2hzdwlF69gl4aUq9AAQks
         td3ohb7vZU2A8ecFAqA5mOjT/U7vjk5P9zK/tbAPr3GDpYHNHop7NkH1/kZOVPIOy4nd
         3lcJlh83fZBN4k3gazRKWvrULR5uE0ULClrLnv9s3kV7UQRJE9lH1lKG00g8ztOzsC/q
         X8dg==
X-Gm-Message-State: AOAM531+4tq8rWcQW/zS1pIYkCRejj0McLAyGZn1MndQ5LScGHm0rnb0
        Wt8ejbMkrdFkoEbrLuKcADHH10uDQsw=
X-Google-Smtp-Source: ABdhPJxwBrcw1MDYflN4hokAAeYL0CeMVbenuO1vvn6JqSYcIrHVOej1ufSksYwX9bYc1EVy4sF5kQ==
X-Received: by 2002:a05:6102:951:: with SMTP id a17mr13393108vsi.39.1620146154373;
        Tue, 04 May 2021 09:35:54 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id x1sm749879vse.0.2021.05.04.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:35:54 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v3 3/3] ext4: update journal documentation
Date:   Tue,  4 May 2021 16:35:50 +0000
Message-Id: <20210504163550.1486337-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210504163550.1486337-1-leah.rumancik@gmail.com>
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a section about journal checkpointing, including information about
the ioctl EXT4_IOC_CHECKPOINT which can be used to trigger a journal
checkpoint from userspace.

Also, update the journal allocation information to reflect that up to
1GB is used for the journal and that the journal is not necessarily
contiguous.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 Documentation/filesystems/ext4/journal.rst | 26 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index cdbfec473167..0404e99f9988 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -4,12 +4,11 @@ Journal (jbd2)
 --------------
 
 Introduced in ext3, the ext4 filesystem employs a journal to protect the
-filesystem against corruption in the case of a system crash. A small
-continuous region of disk (default 128MiB) is reserved inside the
-filesystem as a place to land “important” data writes on-disk as quickly
-as possible. Once the important data transaction is fully written to the
-disk and flushed from the disk write cache, a record of the data being
-committed is also written to the journal. At some later point in time,
+filesystem against corruption in the case of a system crash. Up to 1GB is
+reserved inside the filesystem as a place to land “important” data writes
+on-disk as quickly as possible. Once the important data transaction is fully
+written to the disk and flushed from the disk write cache, a record of the data
+being committed is also written to the journal. At some later point in time,
 the journal code writes the transactions to their final locations on
 disk (this could involve a lot of seeking or a lot of small
 read-write-erases) before erasing the commit record. Should the system
@@ -731,3 +730,18 @@ point, the refcount for inode 11 is not reliable, but that gets fixed by the
 replay of last inode 11 tag. Thus, by converting a non-idempotent procedure
 into a series of idempotent outcomes, fast commits ensured idempotence during
 the replay.
+
+Journal Checkpoint
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Checkpointing the journal ensures all transactions and their associated buffers
+are submitted to the disk. This is used internally during critical updates to
+the filesystem including journal recovery, filesystem resizing, and freeing
+of the journal_t structure.
+
+A journal checkpoint can be triggered from userspace via the ioctl
+EXT4_IOC_CHECKPOINT. This ioctl takes a single, u64 argument for flags.
+Currently, the only flag supported is EXT4_IOC_CHECKPOINT_FLAG_DISCARD. When
+this flag is set, the journal blocks are discarded after the journal checkpoint
+is complete. The ioctl may be useful when snapshotting a system or for complying
+with content deletion SLOs (when discard is supported and the discard flag is set).
-- 
2.31.1.527.g47e6f16901-goog

