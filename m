Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFB61B69F8
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgDWXh1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55823 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXh1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:27 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPI-0003rw-Rv
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:25 +0000
Received: by mail-qt1-f198.google.com with SMTP id n22so8858727qtp.15
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRIKYRyoMTAWH9jWxTyGjX0T1FPSl6M3+WcsneoeAWQ=;
        b=an+qyuCKxsB8DP1GfIYZbkiGYsamN7LT/+kzdCCkfqnTmfL9J3SUPy54bo57V5P+Ya
         n7dCFjgLFOiqu8A/yb63+4IV2NycGWfbA7LISE2leAe+6JmQ5QiKrRoh1EEJc+kEUkq0
         I+oHqjfXCnGWq9nwzopSB9yiCTwtKe9huS9IoO/7T6EvbQbDAyNHOsKgzpyqtJFLCwq/
         TZuNLCgcVgwSMLlWWfTG07iw0nJobRwvSbzHcZ+tEJE8AaNHUKfJKnYNuo8DfsMgtfCo
         /jiUBxSVSCKUl95meVZ88d4nbTHB/tHBx9Pv59RKYv/yfF02S+EydNHFktyjjNk3WNR+
         tXnQ==
X-Gm-Message-State: AGi0PuaYGtiKZWpdUPGXubkrS72SQlD/CZqyHSVAd9u4Ycw2/5/JnOQN
        urTL1fSfzH99L0SRu3iRYlSpf9hscUJtVXJgTR15Tng8E8DYl71HKILxIv+IJ3SzssP1rifqrlI
        Md6oZJOdx4CnHB5dcO7Fi76lvZgg4L0xjKx8DFVI=
X-Received: by 2002:ad4:50c3:: with SMTP id e3mr6398569qvq.116.1587685043890;
        Thu, 23 Apr 2020 16:37:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypLuJt1Hbr3wAduXuiqk/4hUZzEwVYoApgyePdBD5buPQP8tcwZSn50hggGnXptQSp3WD+xhPw==
X-Received: by 2002:ad4:50c3:: with SMTP id e3mr6398558qvq.116.1587685043691;
        Thu, 23 Apr 2020 16:37:23 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:23 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 06/11] ext4: data=journal: prevent journalled writeback deadlock in ext4_write_begin()
Date:   Thu, 23 Apr 2020 20:37:00 -0300
Message-Id: <20200423233705.5878-7-mfo@canonical.com>
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
journalled writeback in ext4_write_begin().

Finally, add wait_on_page_writeback() if data=journal mode.

Note: similar changes are not needed in ext4_da_write_begin()
as delayed allocation is not applicable to data journalling
(different struct address_space_operations).

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 401313be8a5b..f58c426aaca1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1149,6 +1149,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	page = grab_cache_page_write_begin(mapping, index, flags);
 	if (!page)
 		return -ENOMEM;
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 	unlock_page(page);
 
 retry_journal:
@@ -1165,9 +1167,19 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		put_page(page);
 		ext4_journal_stop(handle);
 		goto retry_grab;
+	} else if (ext4_should_journal_data(inode) &&
+		   ext4_check_journalled_writeback(handle, page)) {
+		/* Or transaction may block page writeback */
+		unlock_page(page);
+		put_page(page);
+		ext4_journal_stop(handle);
+		ext4_start_commit_datasync(inode);
+		goto retry_grab;
 	}
 	/* In case writeback began while the page was unlocked */
 	wait_for_stable_page(page);
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (ext4_should_dioread_nolock(inode))
-- 
2.20.1

