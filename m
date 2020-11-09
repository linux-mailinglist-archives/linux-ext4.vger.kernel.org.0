Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3312AC4B1
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgKITKY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 14:10:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbgKITKV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 14:10:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1F1DB016;
        Mon,  9 Nov 2020 19:10:19 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ext4: show the dax option in mount options
Date:   Mon,  9 Nov 2020 20:10:09 +0100
Message-Id: <936bf701626dfdf5b2e51186067cf5e5f5bdb282.1604948373.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604948373.git.msuchanek@suse.de>
References: <cover.1604948373.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 accepts both dax and dax_always option but shows only dax_always.
Show both options.

Fixes: 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ef4734b40e2a..7656c519cbe6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2647,7 +2647,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		if (IS_EXT2_SB(sb))
 			SEQ_OPTS_PUTS("dax");
 		else
-			SEQ_OPTS_PUTS("dax=always");
+			SEQ_OPTS_PUTS("dax,dax=always");
 	} else if (test_opt2(sb, DAX_NEVER)) {
 		SEQ_OPTS_PUTS("dax=never");
 	} else if (test_opt2(sb, DAX_INODE)) {
-- 
2.26.2

