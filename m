Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D83F0346
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfKEQop (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:41606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390337AbfKEQok (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7474B272;
        Tue,  5 Nov 2019 16:44:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 433B41E4AB7; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 08/25] ext4: Use ext4_journal_extend() instead of jbd2_journal_extend()
Date:   Tue,  5 Nov 2019 17:44:14 +0100
Message-Id: <20191105164437.32602-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use ext4 helper ext4_journal_extend() instead of opencoding it in
ext4_try_to_expand_extra_isize().

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 81bc2fb23c40..facc5ddb4d75 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5974,8 +5974,7 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 	 * If this is felt to be critical, then e2fsck should be run to
 	 * force a large enough s_min_extra_isize.
 	 */
-	if (ext4_handle_valid(handle) &&
-	    jbd2_journal_extend(handle,
+	if (ext4_journal_extend(handle,
 				EXT4_DATA_TRANS_BLOCKS(inode->i_sb)) != 0)
 		return -ENOSPC;
 
-- 
2.16.4

