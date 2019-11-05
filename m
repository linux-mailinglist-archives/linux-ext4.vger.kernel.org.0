Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7BFF0353
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbfKEQow (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390392AbfKEQoo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A7BFB463;
        Tue,  5 Nov 2019 16:44:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 740651E4AC5; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 22/25] jbd2: Make credit checking more strict
Date:   Tue,  5 Nov 2019 17:44:28 +0100
Message-Id: <20191105164437.32602-22-jack@suse.cz>
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

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 10fd802fd222..8f11b2d48ca0 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1477,7 +1477,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
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

