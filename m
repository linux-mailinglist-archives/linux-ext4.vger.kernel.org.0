Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166F32BE9B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfE1Fct convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 28 May 2019 01:32:49 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25489 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbfE1Fct (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 May 2019 01:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559021564; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=EqOEtk8qucCN7YdvnrmAMBFAjt5qLQel1PQZCiqqJX0fGbm+U+dl8q+K/wkLVVtytX2F8vlx3RCWhrNRpPHXXje3/x37C6Qu/JxPIELlAHdp9gW0egkVV65XjZbfVi1chx7kjmlKFCEnA01/jM5DgeBK/PUWvR6wHtuZCtndhvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559021564; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=TX2d7ooSgpyTJ05XY7A5k8B7PFqyAJjedqMpa5qYD5A=; 
        b=CHl0oosM8BIIxKnDTs9AAboW7C6Eb4EIkT0fbwjt1504XAwkvsDygPtT3BomS5F8u5CE+74VDBP0jeraBN2QZ8/B7T4AsBS+nHQ5hiBPvXTAyjjdmrVk3jCaorG55DLZg1Tkf7DwzC7vFzx7jRagk2s0VOG4W5ftdPlZnx0uZ5g=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1559021563543332.7210176466501; Tue, 28 May 2019 13:32:43 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190528053231.12364-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: code cleanup for ext2_preread_inode()
Date:   Tue, 28 May 2019 13:32:31 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Calling bdi_rw_congested() instead of calling
bdi_read_congested() and bdi_write_congested().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/ialloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index a0c5ea91fcd4..334dea4e499d 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -172,9 +172,7 @@ static void ext2_preread_inode(struct inode *inode)
 	struct backing_dev_info *bdi;
 
 	bdi = inode_to_bdi(inode);
-	if (bdi_read_congested(bdi))
-		return;
-	if (bdi_write_congested(bdi))
+	if (bdi_rw_congested(bdi))
 		return;
 
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-- 
2.20.1



