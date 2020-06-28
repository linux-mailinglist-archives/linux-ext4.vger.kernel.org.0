Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651B920C59A
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jun 2020 05:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgF1Dly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Jun 2020 23:41:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgF1Dly (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 27 Jun 2020 23:41:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A97496F4DA2971F57B5;
        Sun, 28 Jun 2020 11:41:51 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 11:41:49 +0800
From:   Yi Zhuang <zhuangyi1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: lost matching-pair of trace in ext4_unlink
Date:   Sun, 28 Jun 2020 11:48:52 +0800
Message-ID: <20200628034852.85502-1-zhuangyi1@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If dquot_initialize() return non-zero and trace of ext4_unlink_enter/exit
enabled then the matching-pair of trace_exit will lost in log.

Signed-off-by: Yi Zhuang <zhuangyi1@huawei.com>
---
 fs/ext4/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56738b538ddf..5e41d45915c9 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3193,10 +3193,10 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	 * in separate transaction */
 	retval = dquot_initialize(dir);
 	if (retval)
-		return retval;
+		goto out_unlink;
 	retval = dquot_initialize(d_inode(dentry));
 	if (retval)
-		return retval;
+		goto out_unlink;
 
 	retval = -ENOENT;
 	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
@@ -3255,6 +3255,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	brelse(bh);
 	if (handle)
 		ext4_journal_stop(handle);
+out_unlink:
 	trace_ext4_unlink_exit(dentry, retval);
 	return retval;
 }
-- 
2.26.0.106.g9fadedd

