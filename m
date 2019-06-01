Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3383831A9C
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Jun 2019 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFAIt4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Jun 2019 04:49:56 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25748 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbfFAIt4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Jun 2019 04:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559378991; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=gxm0x66jP6eYcz4rRLmfkP2tD0yjRkfCZxiAEyT1QxZTBK6ugT7Fmo2VX1wT0jrDZdCpJiMUTqKIjfmuQo0j4AzccGA+8wPTRQBHAfszhiCPnBVpdldOuoq4bgJs9OEhUsnc/ZyXlXZOl+GYWd9gqRIvuMKp3VszR+sZwY5ZOu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559378991; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=59uL/ZmJqKQPqkp32zb+M9Got93eG8nKExiBaqJgcDM=; 
        b=cBstIBjBGxOVowKGQK96ESajJUwcOJEdF1FMleZoP5YysymOQj7FOI4fvEY7WAUSGO2S7aWxvv/wlHH4v6xcaBe9gGOtTDQD1JNqbd4UzE9Au3bLFg+jS1NDg5xmt4G8C71+vd8UVw0Ue4HdD2xBT95pCcURUz83ooWSMaOiPNM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (116.30.193.185 [116.30.193.185]) by mx.zoho.com.cn
        with SMTPS id 1559378989636115.68480972131044; Sat, 1 Jun 2019 16:49:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: start from parent blockgroup when trying linear search for a free inode
Date:   Sat,  1 Jun 2019 16:49:41 +0800
Message-Id: <20190601084941.22792-1-cgxu519@zoho.com.cn>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Start from parent blockgroup when trying linear search
for a free indoe because for non directory inode it's
better to keep in same blockgroup with parent.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/ialloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index fda7d3f5b4be..435463a255e6 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -411,11 +411,11 @@ static int find_group_other(struct super_block *sb, struct inode *parent)
 	 */
 	group = parent_group;
 	for (i = 0; i < ngroups; i++) {
-		if (++group >= ngroups)
-			group = 0;
 		desc = ext2_get_group_desc (sb, group, NULL);
 		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
 			goto found;
+		if (++group >= ngroups)
+			group = 0;
 	}
 
 	return -1;
-- 
2.17.2


