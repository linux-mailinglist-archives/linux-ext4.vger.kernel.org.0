Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67900C1F64
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfI3Kn3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730790AbfI3KnY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B282B152;
        Mon, 30 Sep 2019 10:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0AE531E4838; Mon, 30 Sep 2019 12:43:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 18/19] jbd2: Make credit checking more strict
Date:   Mon, 30 Sep 2019 12:43:36 +0200
Message-Id: <20190930104339.24919-18-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
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
index df92bc257f85..f22ec7132afc 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1453,7 +1453,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
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

