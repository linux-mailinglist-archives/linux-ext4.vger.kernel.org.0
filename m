Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602871B69FB
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDWXhe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55841 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXhd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:33 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPP-0003tJ-Rs
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:32 +0000
Received: by mail-qv1-f70.google.com with SMTP id ev8so7860449qvb.7
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UefYnRb7gYgaI4kGjX+SiRK/i9HTinlkK7uCBsJaT3E=;
        b=NKJXoD3/Dc+1gr3kaKLltXyEguXn8IcbP7JeNsOCnRXrr2kr2iR6bzQKSh6rdmIkRB
         I4g7oQUA+lQGYfD3gBBzLjSO5XY4x7MvbSs956VpSS2VeoOJIxf2PASypdlfHWb2/ZZP
         JfVbux146Z4smoIclUebFzIr90kBxZslcOjeiZ8fIO/u2YIC0tb/x6o42nL326r39JQV
         Bs1MPnsrZjGnbg7vqbXN+MkYYfupvz95VtBds/HUM/Iz4Y7xnO392pZbqSOEWbjfoEoJ
         KwJFVuosTOVUVUOJQa0qG8R8aSBMqnDn9osh3w7ddoBQkp6Dk9kb9AnwdoqAgUNw7BQQ
         7/kg==
X-Gm-Message-State: AGi0PubBkx9U5cgJ1iZNxTFv8ZBGrmxWytC3FGSai+9w9h7TP+PDf8G1
        bfop1ZmRy0tDtiNGhys/v5RQWGNsH5gNsm9hemE04tx7ey74yAKUC3hzmQx5nw0dpe4UyBJrua3
        GY0MJGFgs2Aq+Qhx5JUVbyK+FE21J/0dV9iFa0W4=
X-Received: by 2002:a05:620a:307:: with SMTP id s7mr5545345qkm.407.1587685050723;
        Thu, 23 Apr 2020 16:37:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYGf6ON1OG5Pmzt9SYfvNLsjV3P5U/gy63QEv55I20YR61DAdjWjh5hgd1+yyx4R04Zhhyug==
X-Received: by 2002:a05:620a:307:: with SMTP id s7mr5545327qkm.407.1587685050443;
        Thu, 23 Apr 2020 16:37:30 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:30 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 09/11] ext4: grab page before starting transaction handle in ext4_try_to_write_inline_data()
Date:   Thu, 23 Apr 2020 20:37:03 -0300
Message-Id: <20200423233705.5878-10-mfo@canonical.com>
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
 fs/ext4/inline.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 10665b066bb7..9bb85e06854d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -692,37 +692,65 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	if (ret)
 		return ret;
 
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
 	/*
 	 * The possible write could happen in the inode,
 	 * so try to reserve the space in inode first.
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
 	if (IS_ERR(handle)) {
+		put_page(page);
 		ret = PTR_ERR(handle);
 		handle = NULL;
 		goto out;
 	}
 
+	lock_page(page);
+	if (page->mapping != mapping) {
+		/* The page got truncated from under us */
+		unlock_page(page);
+		put_page(page);
+		ext4_journal_stop(handle);
+		goto retry_grab;
+	}
+	/* In case writeback began while the page was unlocked */
+	wait_for_stable_page(page);
+
 	ret = ext4_prepare_inline_data(handle, inode, pos + len);
-	if (ret && ret != -ENOSPC)
+	if (ret && ret != -ENOSPC) {
+		unlock_page(page);
+		put_page(page);
 		goto out;
+	}
 
 	/* We don't have space in inline inode, so convert it to extent. */
 	if (ret == -ENOSPC) {
+		unlock_page(page);
+		put_page(page);
 		ext4_journal_stop(handle);
 		brelse(iloc.bh);
 		goto convert;
 	}
 
 	ret = ext4_journal_get_write_access(handle, iloc.bh);
-	if (ret)
-		goto out;
-
-	flags |= AOP_FLAG_NOFS;
-
-	page = grab_cache_page_write_begin(mapping, 0, flags);
-	if (!page) {
-		ret = -ENOMEM;
+	if (ret) {
+		unlock_page(page);
+		put_page(page);
 		goto out;
 	}
 
-- 
2.20.1

