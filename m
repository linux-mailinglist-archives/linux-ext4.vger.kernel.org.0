Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA56035D5D2
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Apr 2021 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238029AbhDMDT4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 23:19:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16579 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237789AbhDMDT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 23:19:56 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FK9l43DmPz18Hqb;
        Tue, 13 Apr 2021 11:17:20 +0800 (CST)
Received: from [10.174.177.93] (10.174.177.93) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 11:19:30 +0800
From:   Haotian Li <lihaotian9@huawei.com>
Subject: [PATCH] e2fsck: try write_primary_superblock() again when it failed
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Message-ID: <7486f08c-7f14-9fac-fdb2-0fe78a799d90@huawei.com>
Date:   Tue, 13 Apr 2021 11:19:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.93]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Function write_primary_superblock() has two ways to flush
superblock, byte-by-byte as default. It may use
io_channel_write_byte() many times. If some errors occur
during these funcs, the superblock may become inconsistent
and produce checksum error.

Try write_primary_superblock() with whole-block way again
when it failed on byte-by-byte way.
---
 lib/ext2fs/closefs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/ext2fs/closefs.c b/lib/ext2fs/closefs.c
index 69cbdd8c..1fc27fb5 100644
--- a/lib/ext2fs/closefs.c
+++ b/lib/ext2fs/closefs.c
@@ -223,10 +223,8 @@ static errcode_t write_primary_superblock(ext2_filsys fs,
 		retval = io_channel_write_byte(fs->io,
 			       SUPERBLOCK_OFFSET + (2 * write_idx), size,
 					       new_super + write_idx);
-		if (retval == EXT2_ET_UNIMPLEMENTED)
-			goto fallback;
 		if (retval)
-			return retval;
+			goto fallback;
 	}
 	memcpy(fs->orig_super, super, SUPERBLOCK_SIZE);
 	return 0;
-- 
2.23.0
