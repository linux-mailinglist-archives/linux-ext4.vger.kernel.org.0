Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D801E9F53
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jun 2020 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFAHeh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Jun 2020 03:34:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbgFAHeh (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 1 Jun 2020 03:34:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7821477F46E464539ED2;
        Mon,  1 Jun 2020 15:34:35 +0800 (CST)
Received: from code-website.localdomain (10.175.104.175) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 15:34:27 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jaegeuk@kernel.org>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: [PATCH] ext4: stop overwrite the errcode in ext4_setup_super
Date:   Mon, 1 Jun 2020 15:34:04 +0800
Message-ID: <20200601073404.3712492-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now the errcode from ext4_commit_super will overwrite EROFS exists in
ext4_setup_super. Actually, no need to call ext4_commit_super since we
will return EROFS. Fix it by goto done directly.

Fixes: c89128a00838 ("ext4: handle errors on ext4_commit_super")
Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..87c5611a4c67 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2344,6 +2344,7 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 		ext4_msg(sb, KERN_ERR, "revision level too high, "
 			 "forcing read-only mode");
 		err = -EROFS;
+		goto done;
 	}
 	if (read_only)
 		goto done;
-- 
2.25.4

