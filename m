Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD227B586
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgI1TlT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 15:41:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38913 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1TlT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 15:41:19 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kMz1Q-0002AS-2i
        for linux-ext4@vger.kernel.org; Mon, 28 Sep 2020 19:41:16 +0000
Received: by mail-qt1-f198.google.com with SMTP id h31so1406675qtd.14
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 12:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCau5di699grODyFgnJe+SR4ba0hdB+A8OoiSVqP36Y=;
        b=bPU863MScTZzL7bF+ZkZbAB6wyYY8zdfKZwKs+58EiNREVBPPSbuL0nOe+9CGgmFae
         ZR/A/X6XwyRugZuDRoppJ15PZeFgNgEv8Ivxou5+lcrpQkxy9mm+FVZr2/Wm+c6eZQf3
         kvo0EDw8/KFKBbRpj3WaXc17eagMS2iCtFWpFiyFGSwGa/YItDXXcCuIFgqAV9kYxqJ3
         41NFMfGr6DrxlOuBiyZMx6MjbKArepsgBHuhkw/zOvHjMmUiu+PPE6hR/+zAPKFcWEMB
         krsH+9N+yaoIYOThPzEIKFfUGu6fX6no4v3pABcdv/queyFU396V30jc5G+C50HyfNuQ
         O1uA==
X-Gm-Message-State: AOAM5313sDe4M5J+eW7WcelySKMjhebh+fX73z64lRldBcoecSaeVvIU
        Te7mewH5N5Jztyk2HsTAA/v9MCVuak2OC6I7U4X0JJAVonmTpHWg7F3ZiuPBfEnNNpuQ/vHdDW8
        NXDqUy2nLzBDUhzdcdMJngq+OcA5C6sJMSDZtYvc=
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr3318991qtw.167.1601322075052;
        Mon, 28 Sep 2020 12:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjm1+NxWMR7TE19FtY2Iwy5UDlIFICf81ckydbVpoTs03//KHJ9ugCmfSS5MThiLIC37UCbg==
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr3318973qtw.167.1601322074779;
        Mon, 28 Sep 2020 12:41:14 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id u15sm2360222qtj.3.2020.09.28.12.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 12:41:13 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Subject: [RFC PATCH v4 3/4] ext4: data=journal: fixes for ext4_page_mkwrite()
Date:   Mon, 28 Sep 2020 16:41:02 -0300
Message-Id: <20200928194103.244692-4-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928194103.244692-1-mfo@canonical.com>
References: <20200928194103.244692-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These are two fixes for data journalling required by
the next patch, discovered while testing it.

First, the optimization to return early if all buffers
are mapped is not appropriate for the next patch:

The inode _must_ be added to the transaction's list in
data=journal mode (so to write-protect pages on commit)
thus we cannot return early there.

Second, once that optimization to reduce transactions
was disabled for data=journal mode, more transactions
happened, and occasionally hit this warning message:
'JBD2: Spotted dirty metadata buffer'.

Reason is, block_page_mkwrite() will set_buffer_dirty()
before do_journal_get_write_access() that is there to
prevent it. This issue was masked by the optimization.

So, on data=journal use __block_write_begin() instead.
This also requires page locking and len recalculation.
(see block_page_mkwrite() for implementation details.)

Finally, as Jan noted there is little sharing between
data=journal and other modes in ext4_page_mkwrite().

However, a prototype of ext4_journalled_page_mkwrite()
showed there still would be lots of duplicated lines
(tens of) that didn't seem worth it.

Thus this patch ends up with an ugly goto to skip all
non-data journalling code (to avoid long indentations,
but that can be changed..) in the beginning, and just
a conditional in the transaction section.

Well, we skip a common part to data journalling which
is the page truncated check, but we do it again after
ext4_journal_start() when we re-acquire the page lock
(so not to acquire the page lock twice needlessly for
data journalling.)

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234..ac153e340a6f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5977,9 +5977,17 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	if (err)
 		goto out_ret;
 
+	/*
+	 * On data journalling we skip straight to the transaction handle:
+	 * there's no delalloc; page truncated will be checked later; the
+	 * early return w/ all buffers mapped (calculates size/len) can't
+	 * be used; and there's no dioread_nolock, so only ext4_get_block.
+	 */
+	if (ext4_should_journal_data(inode))
+		goto retry_alloc;
+
 	/* Delalloc case is easy... */
 	if (test_opt(inode->i_sb, DELALLOC) &&
-	    !ext4_should_journal_data(inode) &&
 	    !ext4_nonda_switch(inode->i_sb)) {
 		do {
 			err = block_page_mkwrite(vma, vmf,
@@ -6005,6 +6013,9 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
 	 * journal_start/journal_stop which can block and take a long time
+	 *
+	 * This cannot be done for data journalling, as we have to add the
+	 * inode to the transaction's list to writeprotect pages on commit.
 	 */
 	if (page_has_buffers(page)) {
 		if (!ext4_walk_page_buffers(NULL, page_buffers(page),
@@ -6029,16 +6040,42 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 		goto out;
 	}
-	err = block_page_mkwrite(vma, vmf, get_block);
-	if (!err && ext4_should_journal_data(inode)) {
-		if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
-			  PAGE_SIZE, NULL, do_journal_get_write_access)) {
+	/*
+	 * Data journalling can't use block_page_mkwrite() because it
+	 * will set_buffer_dirty() before do_journal_get_write_access()
+	 * thus might hit warning messages for dirty metadata buffers.
+	 */
+	if (!ext4_should_journal_data(inode)) {
+		err = block_page_mkwrite(vma, vmf, get_block);
+	} else {
+		lock_page(page);
+		size = i_size_read(inode);
+		/* Page got truncated from under us? */
+		if (page->mapping != mapping || page_offset(page) > size) {
 			unlock_page(page);
-			ret = VM_FAULT_SIGBUS;
+			ret = VM_FAULT_NOPAGE;
 			ext4_journal_stop(handle);
 			goto out;
 		}
-		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
+
+		if (page->index == size >> PAGE_SHIFT)
+			len = size & ~PAGE_MASK;
+		else
+			len = PAGE_SIZE;
+
+		err = __block_write_begin(page, 0, len, ext4_get_block);
+		if (!err) {
+			if (ext4_walk_page_buffers(handle, page_buffers(page),
+					0, len, NULL, do_journal_get_write_access)) {
+				unlock_page(page);
+				ret = VM_FAULT_SIGBUS;
+				ext4_journal_stop(handle);
+				goto out;
+			}
+			ext4_set_inode_state(inode, EXT4_STATE_JDATA);
+		} else {
+			unlock_page(page);
+		}
 	}
 	ext4_journal_stop(handle);
 	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
-- 
2.17.1

