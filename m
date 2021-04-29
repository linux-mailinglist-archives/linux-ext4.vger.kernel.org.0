Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA136E87F
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbhD2KRy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 06:17:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53756 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232858AbhD2KRy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Apr 2021 06:17:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UX9cx-I_1619691410;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UX9cx-I_1619691410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Apr 2021 18:16:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ext4: Remove redundant assignment to error
Date:   Thu, 29 Apr 2021 18:16:49 +0800
Message-Id: <1619691409-83160-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Variable error is set to zero but this value is never read as it's not
used later on, hence it is a redundant assignment and can be removed.

Cleans up the following clang-analyzer warning:

fs/ext4/ioctl.c:657:3: warning: Value stored to 'error' is never read
[clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ext4/ioctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e9b0a1f..796dcee 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -654,7 +654,6 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 	info.gi_data = arg;
 	error = ext4_getfsmap(sb, &xhead, ext4_getfsmap_format, &info);
 	if (error == EXT4_QUERY_RANGE_ABORT) {
-		error = 0;
 		aborted = true;
 	} else if (error)
 		return error;
-- 
1.8.3.1

