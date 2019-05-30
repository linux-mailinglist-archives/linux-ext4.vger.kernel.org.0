Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4B2F9FE
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfE3KK5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 30 May 2019 06:10:57 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25600 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726540AbfE3KK5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 06:10:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559211053; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=TYvnd1i6N+wj0o1/9lfuBpLqA7dBHvpcB8Rmrs4GyKnSn4OT/QD/24gfr8U1bzzJIzqEQk2qeRrSGAo7gXojNaP0pd5UIJrnu8VIkVSy/FT3oWZAqpKTL+ymE4IR4MncJDBsauHdaOzLOmwvVw6q6vuwpPuw2lMBXesLEIFCDf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1559211053; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=iVT5py7ZXzsjfNNeRjRLKcSJZ8f6vaO99+wUktgX/Bw=; 
        b=GTjJ37FtulP8T2+12tpuKBxOHyi2NkKxR8DBmYwg6R/Ek0DsQ98mH46d+xPmauMHHryVgckVWmBRr4AjsGHoYKeLX0r/F/4SyVwtO+Ouu/UuRnigPg3cEpR6rhwzcHUqNVhhOkVQ053wsFjYTG4whgdb9AQWAauEuG96L5+r51o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1559211050837961.0793955546817; Thu, 30 May 2019 18:10:50 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190530101042.32197-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: add missing brelse() in ext2_new_inode()
Date:   Thu, 30 May 2019 18:10:42 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a missing brelse of bitmap_bh in an error
path of ext2_new_inode().

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/ialloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 334dea4e499d..fda7d3f5b4be 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -509,6 +509,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 	/*
 	 * Scanned all blockgroups.
 	 */
+	brelse(bitmap_bh);
 	err = -ENOSPC;
 	goto fail;
 got:
-- 
2.20.1



