Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF522EB62
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgG0Lof (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgG0Lod (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:44:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00729B695;
        Mon, 27 Jul 2020 11:44:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E6A51E12CF; Mon, 27 Jul 2020 13:44:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 5/6] ext4: Handle add_system_zone() failure in ext4_setup_system_zone()
Date:   Mon, 27 Jul 2020 13:44:28 +0200
Message-Id: <20200727114429.1478-6-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200727114429.1478-1-jack@suse.cz>
References: <20200727114429.1478-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's one place that fails to handle error from add_system_zone() call
and thus we can fail to protect superblock and group-descriptor blocks
properly in case of ENOMEM. Fix it.

Reported-by: Lukas Czerner <lczerner@redhat.com>
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

