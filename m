Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368BA4D4461
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 11:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiCJKTv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 05:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiCJKTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 05:19:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E47114FD2
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 02:18:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EACB7210ED;
        Thu, 10 Mar 2022 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646907515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n4PlAHdokU/XCpIbq0HompyPwgwmsXwntf2B5M21hcs=;
        b=xWEyiwcQnJ5KIDpp5KmJ0RND3UP9bdE5ur/rXcSN2h0L0iwQNkJsjoTEorGSYlrHpKEp7h
        WeLMDkkysJArRPQ3K7UmrPfekPlZyw0sIH3FZNn3pwLClpw7M/gq8fl3rkObDtXnpwysNq
        SGQ93Omu/qsoCY6wm1V3beve+OH1v7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646907515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=n4PlAHdokU/XCpIbq0HompyPwgwmsXwntf2B5M21hcs=;
        b=hDbCjwGt79NYeuZl+PXXpjgepBz/qTcg10koeQ0YAUelTH+EDoJXQtm5BVtHY2WmeYGZrG
        NNzX4a88NbWCgnAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEF6CA3B81;
        Thu, 10 Mar 2022 10:18:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 68C27A0610; Thu, 10 Mar 2022 11:18:35 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Warn when dirtying page without buffers in data=journal mode
Date:   Thu, 10 Mar 2022 11:18:32 +0100
Message-Id: <20220310101832.5645-1-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; h=from:subject; bh=E5+XbH4zTAxdnimwCkvRkwuJi6x6iZkBdBwH5zF2LbA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiKdBxpg4+s7G4WVxB9gdLJclDtY6grSykPmyhwSpn kRV03CWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYinQcQAKCRCcnaoHP2RA2YfWB/ 90a3aeC0kfEeOyH42hJ7y1W+wh8W7wa3lLKDvxRvqcPVX1dZueZ6KW5rtdSMk/AJSQ//u2+bZx5iMs aN7Le9jiDlzLcSMETZMGdKFr65PohBvVuzE+OMe2jii3hfc+DWanQE2DKxHGVLKPlowEZ91Bk5Uh6J TADWvfjeZQDKi2O4zReXmryU/x80k0FLTGR8SP0nVmdRJ9ES8cxmgyGnOc5W88eZfEZ1ax97HRXszm ifmCkW9fQklh4o7lqQrGizGVeQbRxFf1IZt4isXt6s0BMDdbv7V+Z5a03+AcgfG7ok/rTazTjjiwtY IU+HOT5csKNw8z/mcSBGKaDgK55uR6
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Recently I've got a report of BUG_ON trigerring during transaction
commit in ext4_journalled_writepage_callback() because we've spotted a
dirty page without buffers. Add WARN_ON_ONCE to
ext4_journalled_set_page_dirty() to catch the problematic condition
earlier where we have better chance of understanding which code path is
creating dirty data without preparing the page properly. Also update the
comment with current information when we are at it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..f8f15fd25c6f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3541,10 +3541,11 @@ const struct iomap_ops ext4_iomap_report_ops = {
 };
 
 /*
- * Pages can be marked dirty completely asynchronously from ext4's journalling
- * activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.  We cannot do
- * much here because ->set_page_dirty is called under VFS locks.  The page is
- * not necessarily locked.
+ * Whenever the page is being dirtied, corresponding buffers should already be
+ * attached to the transaction (we take care of this in ext4_page_mkwrite() and
+ * ext4_write_begin()). However we cannot move buffers to dirty transaction
+ * lists here because ->set_page_dirty is called under VFS locks and the page
+ * is not necessarily locked.
  *
  * We cannot just dirty the page and leave attached buffers clean, because the
  * buffers' dirty state is "definitive".  We cannot just set the buffers dirty
@@ -3555,6 +3556,7 @@ const struct iomap_ops ext4_iomap_report_ops = {
  */
 static int ext4_journalled_set_page_dirty(struct page *page)
 {
+	WARN_ON_ONCE(!page_has_buffers(page));
 	SetPageChecked(page);
 	return __set_page_dirty_nobuffers(page);
 }
-- 
2.34.1

