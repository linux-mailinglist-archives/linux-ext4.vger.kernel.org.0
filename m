Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED72D387C2B
	for <lists+linux-ext4@lfdr.de>; Tue, 18 May 2021 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhERPOu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbhERPOu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 May 2021 11:14:50 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03893C06175F
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:32 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id f1so3323698uaj.10
        for <linux-ext4@vger.kernel.org>; Tue, 18 May 2021 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLxani9a/zFZTfpz+TmtgaLHV/xmT1T2UnUR008STdE=;
        b=rKInA7ds7c/5hEsY0Sr1pZk5HP8ptxQQOI7tn5JqjbMTmMqlFlxgBGbNO5qrAHTYJa
         dsC/7TKfC9tk1nEy8uDdcpY1XUBvAK7pt3oJAA7VBq41MstC9a0PevKTTia4cshmn0wL
         N3Kbt1FXV+IiEgAk8wLlLRjwNgB9FvAZltTJ4VuErrUUhDjaABzXVcR2IoqslF/wEUgJ
         teS3xiDipgByXwsEdIgI931fzsNmTlVXU3Oz93/W0QQyh/Yl54kL8YrlT55nnXiS9z3c
         M/5n3stwy420R3qrstT74vtyrx4XAiVvhk7D7wS+XwgZ11AbweDCUdnLD/A38+6T6CtX
         evOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLxani9a/zFZTfpz+TmtgaLHV/xmT1T2UnUR008STdE=;
        b=WU/2c0fJtpyjWD8+SGayb8iMIu1mz8BFD5U87RVTpwbG7uBTCK+EfOh+Xg6a2zzy/y
         I+8rEYRSjt/qRzQCUSrO1JMat0w5syVf1GFI8FlMhZyIu2/PEX91QMsN8zDCJP6CcRAb
         3DZR2ZeNpTZs4RwMnXPpvhKM3Xps3adC/fta89vF6DPy+bSX3bFmlWDktFYvt+fCrAIm
         sI26KrGrr4npY7X+ZlfLayl99HHGWe2HyowtE3+U214j2dI2jXx6LZgD8/oby6lIgIcx
         vN94xhwjvB2YoREJ9Qn4OhUtt4b+HYzoiK2vKXdtilweuVuh4LWPON0TpeSJVR6YGcr5
         jH0g==
X-Gm-Message-State: AOAM531siHyLRWoTLdoahoBT6D1Wk0aTbcfLECUwWKY5IGMvEsPw6Kw4
        UP17iLrIxkJ8spmlLxdm9qZwG59DTcRAKg==
X-Google-Smtp-Source: ABdhPJwOBvNE2Hsmad6t0ZlyDC/WKPM/DCKt28h1XGforHl3zcP+k2UMoajPrsV8g3pjsNheITG8Xg==
X-Received: by 2002:ab0:b1a:: with SMTP id b26mr6924146uak.60.1621350811010;
        Tue, 18 May 2021 08:13:31 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o63sm2765340vsc.22.2021.05.18.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 08:13:30 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v5 3/3] ext4: update journal documentation
Date:   Tue, 18 May 2021 15:13:27 +0000
Message-Id: <20210518151327.130198-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518151327.130198-1-leah.rumancik@gmail.com>
References: <20210518151327.130198-1-leah.rumancik@gmail.com>
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
10240000 blocks are used for the journal and that the journal is not
necessarily contiguous.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Changes in v5:
- clarify behavior of DRY_RUN flag
---
 Documentation/filesystems/ext4/journal.rst | 39 +++++++++++++++++-----
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index cdbfec473167..5fad38860f17 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -4,14 +4,14 @@ Journal (jbd2)
 --------------
 
 Introduced in ext3, the ext4 filesystem employs a journal to protect the
-filesystem against corruption in the case of a system crash. A small
-continuous region of disk (default 128MiB) is reserved inside the
-filesystem as a place to land “important” data writes on-disk as quickly
-as possible. Once the important data transaction is fully written to the
-disk and flushed from the disk write cache, a record of the data being
-committed is also written to the journal. At some later point in time,
-the journal code writes the transactions to their final locations on
-disk (this could involve a lot of seeking or a lot of small
+filesystem against metadata inconsistencies in the case of a system crash. Up
+to 10,240,000 file system blocks (see man mke2fs(8) for more details on journal
+size limits) can be reserved inside the filesystem as a place to land
+“important” data writes on-disk as quickly as possible. Once the important
+data transaction is fully written to the disk and flushed from the disk write
+cache, a record of the data being committed is also written to the journal. At
+some later point in time, the journal code writes the transactions to their
+final locations on disk (this could involve a lot of seeking or a lot of small
 read-write-erases) before erasing the commit record. Should the system
 crash during the second slow write, the journal can be replayed all the
 way to the latest commit record, guaranteeing the atomicity of whatever
@@ -731,3 +731,26 @@ point, the refcount for inode 11 is not reliable, but that gets fixed by the
 replay of last inode 11 tag. Thus, by converting a non-idempotent procedure
 into a series of idempotent outcomes, fast commits ensured idempotence during
 the replay.
+
+Journal Checkpoint
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Checkpointing the journal ensures all transactions and their associated buffers
+are submitted to the disk. In-progress transactions are waited upon and included
+in the checkpoint. Checkpointing is used internally during critical updates to
+the filesystem including journal recovery, filesystem resizing, and freeing of
+the journal_t structure.
+
+A journal checkpoint can be triggered from userspace via the ioctl
+EXT4_IOC_CHECKPOINT. This ioctl takes a single, u64 argument for flags.
+Currently, three flags are supported. First, EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
+can be used to verify input to the ioctl. It returns error if there is any
+invalid input, otherwise it returns success without performing
+any checkpointing. This can be used to check whether the ioctl exists on a
+system and to verify there are no issues with arguments or flags. The
+other two flags are EXT4_IOC_CHECKPOINT_FLAG_DISCARD and
+EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT. These flags cause the journal blocks to be
+discarded or zero-filled, respectively, after the journal checkpoint is
+complete. EXT4_IOC_CHECKPOINT_FLAG_DISCARD and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT
+cannot both be set. The ioctl may be useful when snapshotting a system or for
+complying with content deletion SLOs.
-- 
2.31.1.751.gd2f1c929bd-goog

