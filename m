Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BDC1F60
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfI3KnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:57584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730737AbfI3KnW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B437DAF2A;
        Mon, 30 Sep 2019 10:43:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCF7C1E4808; Mon, 30 Sep 2019 12:43:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/19] ext4: Use ext4_journal_extend() instead of jbd2_journal_extend()
Date:   Mon, 30 Sep 2019 12:43:22 +0200
Message-Id: <20190930104339.24919-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use ext4 helper ext4_journal_extend() instead of opencoding it in
ext4_try_to_expand_extra_isize().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..8d8e51ae7812 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5989,8 +5989,7 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
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

