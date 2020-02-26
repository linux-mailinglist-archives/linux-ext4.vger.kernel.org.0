Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4716F60F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 04:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgBZDYO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 22:24:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727880AbgBZDYO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 22:24:14 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE8AEC40EFCBC33E271E;
        Wed, 26 Feb 2020 11:24:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 11:24:05 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <fstests@vger.kernel.org>, <guaneryu@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4/021: make sure the fdatasync subprocess exits
Date:   Wed, 26 Feb 2020 11:22:56 +0800
Message-ID: <20200226032256.10978-1-yi.zhang@huawei.com>
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

This patch wait the xfs_io fdatasync subprocess exit to make sure
_check_scratch_fs success.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 tests/ext4/021 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 519737e1..3fc38e89 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -80,6 +80,10 @@ _scratch_mount
 
 do_fdatasync_work()
 {
+	# Wait for running subcommand before exitting so that
+	# mountpoint is not busy when we try to unmount it
+	trap "wait; exit" SIGTERM
+
 	while [ 1 ]; do
 		$XFS_IO_PROG -f -c "fdatasync" $SCRATCH_MNT/testfile
 	done
@@ -89,6 +93,7 @@ do_fdatasync_work &
 datasync_work_pid=$!
 sleep 10
 kill $datasync_work_pid >/dev/null 2>&1
+wait
 
 # success, all done
 status=0
-- 
2.17.2

