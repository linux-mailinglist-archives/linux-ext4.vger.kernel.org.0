Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296582400A2
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Aug 2020 03:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHJBC2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Aug 2020 21:02:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36787 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJBC2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Aug 2020 21:02:28 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1k4wCo-00071K-J2
        for linux-ext4@vger.kernel.org; Mon, 10 Aug 2020 01:02:26 +0000
Received: by mail-qk1-f197.google.com with SMTP id x18so1777822qkb.16
        for <linux-ext4@vger.kernel.org>; Sun, 09 Aug 2020 18:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aT+TjmaBdGsCMxrZDeHyxopgcjq6gYSzqyWVPJ4XfFs=;
        b=RzuLr9/INP4Qe03GTXEF/58S/3k9MUPuEQandBY1nYomZKzF6/c3pTucIU+VHpHcFm
         TssyxFVe5FiidZA4eIjbG8bjiLF/p0y9q5v3aomJJaw4yKdM/0VCd42eKZ199cRSdUfW
         jpMR3+0kmLrioAEP1oCrJIY+9maH/1wLu0X9ekVPuMJbKyXCVnxeStGOalMiw95ZtiOx
         tdjvLzdgePaGdGnZRIpO2F9g1eCOla0vzaGJ5vvXte5N1Yr59uDG2MQzd5OBVkmX5OA5
         GYRECHuv+hPNJ9GcOX0PZOOiGuIwhqwVBHH4qu+nBDtgm6U6To7ruIrEecSylI/IJmGY
         xmug==
X-Gm-Message-State: AOAM5335+cKxzeT5uxDfqwRpZgJ+cGnWcvSgeADhhKJoqYuYdn0v3qQu
        EGiR9xSF8v5hVSbgV6Q+3Rjb14SW0CiNxgiwZ5/dsRBHpr2kmxeRuzP2zPszrTAPtPjG+gojZxR
        CV42XZ4I3aFk7R5BNd4EX7Fb+K/peG9lpb2P6JDc=
X-Received: by 2002:a37:64d7:: with SMTP id y206mr23010306qkb.133.1597021345287;
        Sun, 09 Aug 2020 18:02:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqDSExeByhzT3Alk1fW7vv+rAm3ND+Q5u7mGBL0p7LY12Xb2zMm16sOFRp9Ft6HlFekogAjw==
X-Received: by 2002:a37:64d7:: with SMTP id y206mr23010281qkb.133.1597021345027;
        Sun, 09 Aug 2020 18:02:25 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id 95sm44815qtc.29.2020.08.09.18.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 18:02:24 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Subject: [RFC PATCH v2 4/5] ext4: data=journal: add inode to transaction inode list in ext4_page_mkwrite()
Date:   Sun,  9 Aug 2020 22:02:07 -0300
Message-Id: <20200810010210.3305322-5-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810010210.3305322-1-mfo@canonical.com>
References: <20200810010210.3305322-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since we only add the inode to the transaction's inode list in
__ext4_journalled_writepage(), we depend on msync() or writeback work
(which call it) for the write-protect mechanism to work.

This test snippet shows that, as pwrite() gets the inode into a
transaction (!= than into transaction's inode list), and addr[]
write access gets the page writeably mapped.

    fd = open("file");
    addr = mmap(fd);
    pwrite(fd, "a", 1, 0); // journals inode via ext4_write_begin()
    addr[0] = 'a'; // page is writeably mapped to user space.
    // periodic journal commit / jbd2 thread runs now.
    // __ext4_journalled_writepage() was not called yet.

Now it's possible for a subsequent addr[] write access to race
with the commit function, and possibly hit the window to cause
invalid checksums.
---
 fs/ext4/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 978ccde8454f..ce5464f92a7e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6008,9 +6008,10 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		len = PAGE_SIZE;
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
-	 * journal_start/journal_stop which can block and take a long time
+	 * journal_start/journal_stop which can block and take a long time. But
+	 * not on data journalling, as we have to add the inode to the txn list.
 	 */
-	if (page_has_buffers(page)) {
+	if (page_has_buffers(page) && !ext4_should_journal_data(inode)) {
 		if (!ext4_walk_page_buffers(NULL, page_buffers(page),
 					    0, len, NULL,
 					    ext4_bh_unmapped)) {
@@ -6043,6 +6044,12 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 			goto out;
 		}
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
+		if (ext4_jbd2_inode_add_write(handle, inode, 0, PAGE_SIZE)) {
+			unlock_page(page);
+			ret = VM_FAULT_SIGBUS;
+			ext4_journal_stop(handle);
+			goto out;
+		}
 	}
 	ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
-- 
2.17.1

