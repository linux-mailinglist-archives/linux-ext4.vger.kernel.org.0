Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96ACB1AF
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfJCWF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:49698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387926AbfJCWF4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E333B15C;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FD701E4818; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 20/22] jbd2: Make credit checking more strict
Date:   Fri,  4 Oct 2019 00:06:06 +0200
Message-Id: <20191003220613.10791-20-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Make checking of available credits in jbd2_journal_dirty_metadata() more
strict. There should be always enough credits in the handle to write all
potential revoke descriptors. Also we warn in case there are not enough
credits since this is a bug in the filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8851cbbe3579..66fad49d45df 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1458,7 +1458,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		 * of the transaction. This needs to be done
 		 * once a transaction -bzzz
 		 */
-		if (handle->h_total_credits <= 0) {
+		if (WARN_ON_ONCE(jbd2_handle_buffer_credits(handle) <= 0)) {
 			ret = -ENOSPC;
 			goto out_unlock_bh;
 		}
-- 
2.16.4

