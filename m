Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3E1B69F7
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDWXhZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55816 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXhY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:24 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPG-0003rR-Oj
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:22 +0000
Received: by mail-qt1-f198.google.com with SMTP id g23so8910154qto.0
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSed4JUXi/HyjuJlyffDm+hQm9Ni9+VRVy9sgrrLJM8=;
        b=p4Mty57030fwJF03ySotVbAj14OeINmPskp+BZJyimL9jA5oIjn90ZQ/XaXWkb8dYb
         bgVqZf80gHfPQwVxphGlwgvS+r5+ujWlOiypcx1rU723Q5OzjyQahKp/v7t8f8g3mISM
         3gfx+nTGbAQtSJYJ8lWHSISSxsNsJktMGTeafQX0FOso3Dgb/+dEyrsEpi+rwLRdTBGb
         RMqvnD/u7JRG0Tdb1bBtAsyyVAS6yXzoEhLDNnlKTIH8qx5y27zIhTw4O1fvVHmKN2TL
         DByFPm9EXkP8Z0REz4nkP/XHuvc2kA0+t/Wu9xyMl9+ZElYLSoHUc8rQf3rmaln/p7cZ
         InOw==
X-Gm-Message-State: AGi0PuZhs3jDOxyXsC6O4T7AdXv+PVQQAnamou2pkUwpx8cd+C1CYVf6
        mNhNcz02vJLnVcQ8ehU+dMbE1+Vr8E2C2FWEnTeXYWRAdgxNA2btpmzE8oaAiqYkYut+2MFd1dH
        hbVZVieIVXhozsxtWjRRQzSl2yH67azp3633W5Cs=
X-Received: by 2002:a37:7202:: with SMTP id n2mr5582371qkc.427.1587685041714;
        Thu, 23 Apr 2020 16:37:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJi5NA+IU6SWhMq/cJeuyOTGtxPV8ugIPNC1CotvKS1GP1xkIrvaXT+Np+DdcE0tDwzk9cvyg==
X-Received: by 2002:a37:7202:: with SMTP id n2mr5582354qkc.427.1587685041449;
        Thu, 23 Apr 2020 16:37:21 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:21 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 05/11] ext4: data=journal: prevent journalled writeback deadlock in __ext4_journalled_writepage()
Date:   Thu, 23 Apr 2020 20:36:59 -0300
Message-Id: <20200423233705.5878-6-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch checks for and prevents the deadlock with a page in
journalled writeback in __ext4_journalled_writepage().

It turns out that __ext4_journalled_writepage() may race with itself
in another task (e.g., two tasks set the same mmap'ed page dirty and
called msync(), one after the other), so we have to check/handle it.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 574a062b8bcd..401313be8a5b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1910,6 +1910,7 @@ static noinline int __ext4_journalled_writepage(struct page *page,
 	 */
 	ejwp = kmem_cache_alloc(ext4_journalled_wb_page_cachep,	GFP_KERNEL);
 
+retry_journal:
 	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
 				    ext4_writepage_trans_blocks(inode));
 	if (IS_ERR(handle)) {
@@ -1948,7 +1949,20 @@ static noinline int __ext4_journalled_writepage(struct page *page,
 			goto out;
 		}
 
-		/* Data integrity writeback; have to wait and do it. */
+		/*
+		 * Data integrity writeback; have to wait and do it.
+		 *
+		 * Check for deadlock with page in journalled writeback
+		 * (i.e. another task running/ran this function as well)
+		 */
+		if (ext4_check_journalled_writeback(handle, page)) {
+			get_page(page);
+			unlock_page(page);
+			ext4_journal_stop(handle);
+			ext4_start_commit_datasync(inode);
+			wait_on_page_writeback(page);
+			goto retry_journal;
+		}
 		wait_on_page_writeback(page);
 	}
 
-- 
2.20.1

