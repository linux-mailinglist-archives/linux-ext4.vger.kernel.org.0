Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660561B69F5
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgDWXhU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbgDWXhU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:20 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPC-0003qP-8g
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:18 +0000
Received: by mail-qv1-f69.google.com with SMTP id g6so6844609qvn.3
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S08XaWl9ipqo9NnYNrRI2lIrUPT/IqkCWzZE7TLQZM0=;
        b=HDN/ijATjBuiDukC9mP+XKOK4sD3qewnNXwbKwBDz+vmAL/MA3KUPe3CQpBis9V+rJ
         qrjb9SltunrUkl+QcrhBZU4Izo4rfhWRzQigVOPO+UwDMehJL4BuHYP1zYrumvLMFENr
         EPtCHP9aJ0BXPLC5bWGlrtl+ftadsHMAyPynJWWVx9i0h/YMvO/OkkBoXdEV98A3Rta6
         24lMGFSctVe0bAbhpRm3DmmLPh92hhhWChgFoDxj9i109+5AMG43cLqsJd7BXQ00Nx+F
         jXr7jcyw57VUKVg/5YUJfd4NG2Xmh1rndG6lN+OyCJaKE8jfN0lA+PygaJBmeZ/qOg9T
         7ZRw==
X-Gm-Message-State: AGi0PuYJWuYjmqFNT31BRfBK7sIbgewwxNjU+maTbCcYemxq9G2xNv0S
        zWD8/kDhBgEZWWrNvgMVX+Xh+o+YoQp3HlgagFhpW6mLTVPvwUSK1agARz5DRps3JPJNj0pYzul
        ptwcVyrep9DXoQqBujuev7gjPCTAo+Ndc3cCQW0Q=
X-Received: by 2002:ac8:27cb:: with SMTP id x11mr6962200qtx.272.1587685037206;
        Thu, 23 Apr 2020 16:37:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6w0sORBZrbGEOXWDnlXlJYc6S9M6c07Vm7ErvfN/zIIA8zHAaxuw5RNQ9J2adZVxOcXswng==
X-Received: by 2002:ac8:27cb:: with SMTP id x11mr6962182qtx.272.1587685036942;
        Thu, 23 Apr 2020 16:37:16 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:16 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 03/11] ext4: data=journal: call ext4_force_commit() in ext4_writepages() for msync()
Date:   Thu, 23 Apr 2020 20:36:57 -0300
Message-Id: <20200423233705.5878-4-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The data-integrity syscalls (not memory-cleansing writeback)
use file_write_and_wait_range() that wait_on_page_writeback()
for every page in the range after do_writepages().

If any of these pages is mmap'ed pagecache, i.e., goes into
__ext4_journalled_writepage(), with the last couple patches
end_page_writeback() will be done on (or, not be done until)
transaction commit, which can take seconds (commit interval,
max commit age), which delays msync().

Let's fix this so that msync() syscall should just return
quickly without a delay of up to a few seconds by default.

For data=journal the next thing these syscalls do anyway is
ext4_force_commit() (see ext4_sync_file()), which is needed
for the buffered pagecache, as __filemap_fdatawrite_range()
doesn't do anything: the buffers are clean, so it returns
early without calling do_writepages() / ext4_write_pages().
So it's not possible to just move/replace that call here.

(This is better/more correct than to use ext4_handle_sync()
for mmap'ed pagecache, which triggers one commit per page,
as synchronous transaction batching in jbd2 targets other,
concurrent tasks, but in this case one single task writes
all pages back serially.)

Now for memory-cleansing writeback, even though it is not
supposed to wait, we should not wait for seconds either,
as it could delay an upcoming data-integrity syscall in
write_cache_pages() on a call to wait_on_page_writeback().
(another fix is needed for such calls to ext4_writepage()).

So just do not check for wbc->sync_mode to cover it too.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inode.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d385a11ba31e..574a062b8bcd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2709,7 +2709,37 @@ static int ext4_writepages(struct address_space *mapping,
 		goto out_writepages;
 
 	if (ext4_should_journal_data(inode)) {
+		journal_t *journal = sbi->s_journal;
+
 		ret = generic_writepages(mapping, wbc);
+		/*
+		 * On the data-integrity syscalls, file_write_and_wait_range()
+		 * will wait on page writeback after calling ext4_writepages().
+		 * For mmaped pagecache that only ends on transaction commit,
+		 * which may take up to commit interval (seconds!) to happen.
+		 *
+		 * So, ensure that ext4_force_commit() happens before return,
+		 * and after all pages in the range are set_page_writeback(),
+		 * but only if needed (i.e. check for datasync transaction
+		 * set in the inode by __ext4_journalled_writepage().)
+		 *
+		 * Do it for memory-cleasing writeback too, because it might
+		 * delay another data-integrity syscall in write_cache_pages()
+		 * on wait_on_page_writeback().
+		 */
+		if (!ret && journal) {
+			bool force_commit = false;
+
+			read_lock(&journal->j_state_lock);
+			if (journal->j_running_transaction &&
+			    journal->j_running_transaction->t_tid ==
+				EXT4_I(inode)->i_datasync_tid)
+				force_commit = true;
+			read_unlock(&journal->j_state_lock);
+
+			if (force_commit)
+				ret = ext4_force_commit(inode->i_sb);
+		}
 		goto out_writepages;
 	}
 
-- 
2.20.1

