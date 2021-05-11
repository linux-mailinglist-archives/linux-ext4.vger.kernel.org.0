Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1765237ADB8
	for <lists+linux-ext4@lfdr.de>; Tue, 11 May 2021 20:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhEKSFm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 May 2021 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhEKSFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 May 2021 14:05:40 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7EBC06175F
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id y12so1846909vkn.8
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfshKKuToWImPdyxw4TigCm6CbS7ZnB7g9qMxkLCGwg=;
        b=dg7oZJ58jINVef3hpAohQs0LAuJ9IjwkoVURPmwtUD6RrTGfszMZNRNrqvREPE2TAJ
         UPX22qkf68xhLpB/f953Vxa0IMWU2+LdhdehE6YrVvSu/R+o0eae0VcVSNPLk7SjoyAE
         02ZzKxfFFuv46WdoMcKpD1Phx7NiJU79W9ObIKMRIPAL/1KUCx+Dnkr4v0NEaV6m7OAI
         uFP7WTQTUk/qtVO6QIUiLvpVfcjWumPeyFjsTR4P9B3/8+cNOv0MQQdoidqmrS5gxuyH
         /51Vv4QxamYdE7Qje2JMrawlvcFY/S8ev/+96ZJiVDHD6UkNTpXkA8DHCl8kCBAdIRsh
         n9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfshKKuToWImPdyxw4TigCm6CbS7ZnB7g9qMxkLCGwg=;
        b=tpmmB6s8kXPqGefQrkGTW8/IV4axEx7oEQP/mzMYSJpP2E46lrrTn2H17mXf0G03n/
         a8N2FOx16WpnnMVT96zxz/7LFBVXsnJr7uDNPXSzCDmPbIiMyG0xinN4Z1mRgof4TyK+
         EnFjGSALZAapZy+x0UtIY7keVB+BxCFrlHPXITBZFGV9czf8hw8EVvpZWvMUC8mUCcAo
         mZVWocCllHcNk1AL/Upkkw/OBdb92C55gHqD+v7lK6S0D9rR8yJ5vEI+nUkTqMXrUDBZ
         l63vub/ToAFaiacTKDLZ5Go1qt6M1sqw+jShfn7xckk8XAcqENpoazGbxYqypQiUdcvI
         ns/g==
X-Gm-Message-State: AOAM533lM3JUtstswGKmolXqc9Kjjdr2MVVrm2rEqKsNOCbcXL3d2JNZ
        IWsRwCIblhdrbP+St8uuIT2lb0JcvUs=
X-Google-Smtp-Source: ABdhPJy5sNYF9RF8hZ6yCRSPTbgrACRe602tUHG5f32SbpEOpaLNMA4iR/sazvjknwTORxCHGQkwcw==
X-Received: by 2002:a1f:5682:: with SMTP id k124mr24150949vkb.2.1620756271776;
        Tue, 11 May 2021 11:04:31 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id o35sm2166110uae.3.2021.05.11.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:04:31 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH v4 3/3] ext4: update journal documentation
Date:   Tue, 11 May 2021 18:04:28 +0000
Message-Id: <20210511180428.3358267-3-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511180428.3358267-1-leah.rumancik@gmail.com>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
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
---
 Documentation/filesystems/ext4/journal.rst | 37 +++++++++++++++++-----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index cdbfec473167..987de2a9b561 100644
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
@@ -731,3 +731,24 @@ point, the refcount for inode 11 is not reliable, but that gets fixed by the
 replay of last inode 11 tag. Thus, by converting a non-idempotent procedure
 into a series of idempotent outcomes, fast commits ensured idempotence during
 the replay.
+
+Journal Checkpoint
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Checkpointing the journal ensures all transactions and their associated buffers
+are submitted to the disk. In progress transactions are waited upon and included
+in the checkpoint. Checkpointing is used internally during critical updates to
+the filesystem including journal recovery, filesystem resizing, and freeing of
+the journal_t structure.
+
+A journal checkpoint can be triggered from userspace via the ioctl
+EXT4_IOC_CHECKPOINT. This ioctl takes a single, u64 argument for flags.
+Currently, three flags are supported. First, EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN
+can be used to check the existence of the ioctl on the system. If this flag is
+set, the ioctl returns success immediately without checkpointing the system. The
+other two flags are EXT4_IOC_CHECKPOINT_FLAG_DISCARD and
+EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT. These flags cause the journal blocks to be
+discarded and zero-filled, respectively, after the journal checkpoint is
+complete. EXT4_IOC_CHECKPOINT_FLAG_DISCARD and EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT
+cannot both be set. The ioctl may be useful when snapshotting a system or for
+complying with content deletion SLOs.
-- 
2.31.1.607.g51e8a6a459-goog

