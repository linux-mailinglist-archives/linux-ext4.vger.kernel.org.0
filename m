Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BB15CFDD
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 03:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBNCVR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 21:21:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbgBNCVR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 21:21:17 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95AA1FFA0827CC083DCD;
        Fri, 14 Feb 2020 10:21:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Feb 2020
 10:21:06 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH] ext4/021: make sure the fdatasync subprocess exits
Date:   Fri, 14 Feb 2020 10:20:01 +0800
Message-ID: <20200214022001.15563-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now we just kill fdatasync_work process and wait nothing after the
test, so a busy unmount failure may appear if the fdatasync syscall
doesn't return in time.

  umount: /tmp/scratch: target is busy.
  mount: /tmp/scratch: /dev/sdb already mounted on /tmp/scratch.
  !!! failed to remount /dev/sdb on /tmp/scratch

This patch kill and wait the xfs_io fdatasync subprocess to make sure
_check_scratch_fs success.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 tests/ext4/021 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 519737e1..1b4a1ced 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -18,6 +18,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
 {
+	$KILLALL_PROG -wq xfs_io
 	cd /
 	rm -f $tmp.*
 }
-- 
2.23.0.rc2.8.gff66981f45

