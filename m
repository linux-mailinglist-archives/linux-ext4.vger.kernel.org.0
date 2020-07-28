Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B4230AEB
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 15:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgG1NEt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jul 2020 09:04:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729965AbgG1NEs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jul 2020 09:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C447EB142;
        Tue, 28 Jul 2020 13:04:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 81A291E12D1; Tue, 28 Jul 2020 15:04:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/6] ext4: Handle add_system_zone() failure in ext4_setup_system_zone()
Date:   Tue, 28 Jul 2020 15:04:36 +0200
Message-Id: <20200728130437.7804-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200728130437.7804-1-jack@suse.cz>
References: <20200728130437.7804-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's one place that fails to handle error from add_system_zone() call
and thus we can fail to protect superblock and group-descriptor blocks
properly in case of ENOMEM. Fix it.

Reported-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 9c40214f31f9..2d008c1b58f2 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -235,10 +235,13 @@ int ext4_setup_system_zone(struct super_block *sb)
 	for (i=0; i < ngroups; i++) {
 		cond_resched();
 		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0)))
-			add_system_zone(system_blks,
+		    ((i < 5) || ((i % flex_size) == 0))) {
+			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
 					ext4_bg_num_gdb(sb, i) + 1, 0);
+			if (ret)
+				goto err;
+		}
 		gdp = ext4_get_group_desc(sb, i, NULL);
 		ret = add_system_zone(system_blks,
 				ext4_block_bitmap(sb, gdp), 1, 0);
-- 
2.16.4

