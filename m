Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD551B69F9
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDWXha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55829 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXh3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:29 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPL-0003sN-9K
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:27 +0000
Received: by mail-qk1-f200.google.com with SMTP id k138so8608569qke.15
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/lbCuYd3uGj8b6lArf9qCaYsM0sCOp4pF0Xg1Q8aiU=;
        b=SFe/kgaDCLgZdrq2kr39W/6eo2PJe9QjrHpwMNfyqmwxd2IspENSj/h10ECRUr9XIo
         mRqdATa4qd8Ht9m2wwCdKek7L/l7fvZQRYxtgsJon5pZ63P70KVu1DfA4Yx9cDyJzRcm
         0cxFB6RbJTevpRwMKxfjQo+xwal54HGNXk31o3OGKlr9sduNav7NB1lGMYV2gyCVcdEZ
         SFZlQuy7Hzt+aYzUlq1g7hin+epWdSFkip4lKcCOhtFO0ejp3+Xio33iGgTRE4YT8PDW
         W6Odmm2RVWKlGRLo2TAEoL7zV8SATbPq5atYDPnfW4nZgss6jL2lCXCgan46RA9RLoLB
         Vaaw==
X-Gm-Message-State: AGi0PubQxmZrU59RRyjwczmiY5RdsTmyIogkx779ToBR5SnH+9gvMgqr
        aU5SCopsEET+ibzKWpfsf0vWLRQeaDzcORFOe7GMKvfNG+Itro61y6GxvjUOSI8v5UPBTOZ8sBX
        3HoylJmO8rCFxhBGlA+/vlvVX0ZNfk0DeLtbaP80=
X-Received: by 2002:a0c:a899:: with SMTP id x25mr6804157qva.232.1587685046194;
        Thu, 23 Apr 2020 16:37:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypKtz9fcw6weIuzt1WVwlkIn6bIM82Dp6KTZ5PcOliZ0ICksOqTb4iObqcKvBxCN0JREQOh6mA==
X-Received: by 2002:a0c:a899:: with SMTP id x25mr6804145qva.232.1587685045938;
        Thu, 23 Apr 2020 16:37:25 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:25 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 07/11] ext4: grab page before starting transaction handle in ext4_convert_inline_data_to_extent()
Date:   Thu, 23 Apr 2020 20:37:01 -0300
Message-Id: <20200423233705.5878-8-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since even just grab_cache_page_write_begin() might deadlock with
page writeback from __ext4_journalled_writepage() if stable pages
are required (as it does "lock_page(); wait_for_stable_page();")
and the handle to the same/running transaction is currently held,
it _cannot_ be called between ext4_journal_start/stop() as usual,
we have to be careful.

We have two options:

1) open-code the first part of grab_cache_page_write_begin()
   (before wait_for_stable_pages()) just before calling it,
   then check for deadlock and retry (a bit ugly but valid.)

2) move it before ext4_journal_start() to avoid the deadlock.

Option 2 has been done as optimization to ext4_write_begin()
in commit 47564bfb95bf ("ext4: grab page before starting
transaction handle in write_begin()"), and can similarly
apply to this case.

Since it sounds more official, counts as optimization that
prevents long transaction hold time, and isn't ugly, do it.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inline.c | 48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index f35e289e17aa..5fd275098d10 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -548,23 +548,42 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	if (ret)
 		return ret;
 
-retry:
+	/*
+	 * grab_cache_page_write_begin() can take a long time if the
+	 * system is thrashing due to memory pressure, or if the page
+	 * is being written back.  So grab it first before we start
+	 * the transaction handle.  This also allows us to allocate
+	 * the page (if needed) without using GFP_NOFS.
+	 */
+retry_grab:
+	page = grab_cache_page_write_begin(mapping, 0, flags);
+	if (!page) {
+		ret = -ENOMEM;
+		handle = NULL;
+		goto out;
+	}
+	unlock_page(page);
+
+retry_journal:
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, needed_blocks);
 	if (IS_ERR(handle)) {
+		put_page(page);
 		ret = PTR_ERR(handle);
 		handle = NULL;
+		page = NULL;
 		goto out;
 	}
 
-	/* We cannot recurse into the filesystem as the transaction is already
-	 * started */
-	flags |= AOP_FLAG_NOFS;
-
-	page = grab_cache_page_write_begin(mapping, 0, flags);
-	if (!page) {
-		ret = -ENOMEM;
-		goto out;
+	lock_page(page);
+	if (page->mapping != mapping) {
+		/* The page got truncated from under us */
+		unlock_page(page);
+		put_page(page);
+		ext4_journal_stop(handle);
+		goto retry_grab;
 	}
+	/* In case writeback began while the page was unlocked */
+	wait_for_stable_page(page);
 
 	ext4_write_lock_xattr(inode, &no_expand);
 	sem_held = 1;
@@ -600,8 +619,6 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 
 	if (ret) {
 		unlock_page(page);
-		put_page(page);
-		page = NULL;
 		ext4_orphan_add(handle, inode);
 		ext4_write_unlock_xattr(inode, &no_expand);
 		sem_held = 0;
@@ -616,10 +633,13 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		 */
 		if (inode->i_nlink)
 			ext4_orphan_del(NULL, inode);
-	}
 
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
-		goto retry;
+		if (ret == -ENOSPC &&
+		    ext4_should_retry_alloc(inode->i_sb, &retries))
+			goto retry_journal;
+		put_page(page);
+		page = NULL;
+	}
 
 	if (page)
 		block_commit_write(page, from, to);
-- 
2.20.1

