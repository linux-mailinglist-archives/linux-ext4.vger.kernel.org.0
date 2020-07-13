Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CF21D66A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jul 2020 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGMM60 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jul 2020 08:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgGMM60 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Jul 2020 08:58:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC355AC91;
        Mon, 13 Jul 2020 12:58:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9FACE1E12C5; Mon, 13 Jul 2020 14:58:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: catch integer overflow in ext4_cache_extents
Date:   Mon, 13 Jul 2020 14:58:18 +0200
Message-Id: <20200713125818.21918-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wolfgang Frisch <wolfgang.frisch@suse.com>

When extent tree is corrupted we can hit BUG_ON in
ext4_es_cache_extent(). Check for this and abort caching instead of
crashing the machine.

Signed-off-by: Wolfgang Frisch <wolfgang.frisch@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 221f240eae60..e76d00fda104 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -471,6 +471,10 @@ static void ext4_cache_extents(struct inode *inode,
 		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
 		int len = ext4_ext_get_actual_len(ex);
 
+		/* Corrupted extent tree? Stop caching... */
+		if (lblk + len < lblk || lblk + len > EXT4_MAX_LOGICAL_BLOCK)
+			return;
+
 		if (prev && (prev != lblk))
 			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
 					     EXTENT_STATUS_HOLE);
-- 
2.16.4

