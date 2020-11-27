Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7342C63F1
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgK0LeJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 06:34:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbgK0LeJ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Nov 2020 06:34:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2443AAD71;
        Fri, 27 Nov 2020 11:34:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1B9E1E131D; Fri, 27 Nov 2020 12:34:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/12] ext4: Standardize error message in ext4_protect_reserved_inode()
Date:   Fri, 27 Nov 2020 12:33:56 +0100
Message-Id: <20201127113405.26867-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201127113405.26867-1-jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We use __ext4_error() when ext4_protect_reserved_inode() finds
filesystem corruption. However EXT4_ERROR_INODE_ERR() is perfectly
capable of reporting all the needed information. So just use that.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 8e6ca23ed172..13ffda871227 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -176,12 +176,10 @@ static int ext4_protect_reserved_inode(struct super_block *sb,
 			err = add_system_zone(system_blks, map.m_pblk, n, ino);
 			if (err < 0) {
 				if (err == -EFSCORRUPTED) {
-					__ext4_error(sb, __func__, __LINE__,
-						     -err, map.m_pblk,
-						     "blocks %llu-%llu from inode %u overlap system zone",
-						     map.m_pblk,
-						     map.m_pblk + map.m_len - 1,
-						     ino);
+					EXT4_ERROR_INODE_ERR(inode, -err,
+						"blocks %llu-%llu from inode overlap system zone",
+						map.m_pblk,
+						map.m_pblk + map.m_len - 1);
 				}
 				break;
 			}
-- 
2.16.4

