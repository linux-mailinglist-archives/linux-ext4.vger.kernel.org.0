Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7403A228D88
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jul 2020 03:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgGVBZc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 21:25:32 -0400
Received: from mail1.windriver.com ([147.11.146.13]:40179 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGVBZc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 21:25:32 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 06M1PKOp005238
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 21 Jul 2020 18:25:20 -0700 (PDT)
Received: from ala-lpggp7.wrs.com (147.11.105.171) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Jul 2020
 18:25:03 -0700
From:   Hongxu Jia <hongxu.jia@windriver.com>
To:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <wshilong@ddn.com>,
        <adilger@dilger.ca>
Subject: [PATCH] mke2fs: fix up check for hardlinks always false if inode > 0xFFFFFFFF
Date:   Tue, 21 Jul 2020 18:25:03 -0700
Message-ID: <20200722012503.42711-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

While file has a large inode number (> 0xFFFFFFFF), mkfs.ext4 could
not parse hardlink correctly.

Prepare three hardlink files for mkfs.ext4

$ ls -il rootfs_ota/a rootfs_ota/boot/b rootfs_ota/boot/c
11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/a
11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/boot/b
11026675846 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 rootfs_ota/boot/c

$ truncate -s 1M rootfs_ota.ext4

$ mkfs.ext4 -F -i 8192 rootfs_ota.ext4 -L otaroot -U fd5f8768-c779-4dc9-adde-165a3d863349 -d rootfs_ota

$ mkdir mnt && sudo mount rootfs_ota.ext4 mnt

$ ls -il mnt/a mnt/boot/b mnt/boot/c
12 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/a
14 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/boot/b
15 -rw-r--r-- 1 hjia users 0 Jul 20 17:44 mnt/boot/c

After applying this fix
$ ls -il mnt/a mnt/boot/b mnt/boot/c
12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/a
12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/boot/b
12 -rw-r--r-- 3 hjia users 0 Jul 20 17:44 mnt/boot/c

Since commit [382ed4a1 e2fsck: use proper types for variables][1]
applied, it used ext2_ino_t instead of ino_t for referencing inode
numbers, but the type of is_hardlink's `ino' should not be instead,
The ext2_ino_t is 32bit, if inode > 0xFFFFFFFF, its value will be
truncated.

Add a debug printf to show the value of inode, when it check for hardlink
files, it will always return false if inode > 0xFFFFFFFF
|--- a/misc/create_inode.c
|+++ b/misc/create_inode.c
|@@ -605,6 +605,7 @@ static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ext2_ino_t ino)
| {
|        int i;
|
|+       printf("%s %d, %lX, %lX\n", __FUNCTION__, __LINE__, hdlinks->hdl[i].src_ino, ino);
|        for (i = 0; i < hdlinks->count; i++) {
|                if (hdlinks->hdl[i].src_dev == dev &&
|                    hdlinks->hdl[i].src_ino == ino)

Here is debug message:
is_hardlink 608, 2913DB886, 913DB886

The length of ext2_ino_t is 32bit (typedef __u32 __bitwise ext2_ino_t;),
and ino_t is 64bit on 64bit system (such as x86-64), recover `ino' to ino_t.

[1] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?id=382ed4a1c2b60acb9db7631e86dda207bde6076e

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 misc/create_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index e8d1df6b..837f3875 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -601,7 +601,7 @@ out:
 	return err;
 }
 
-static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ext2_ino_t ino)
+static int is_hardlink(struct hdlinks_s *hdlinks, dev_t dev, ino_t ino)
 {
 	int i;
 
-- 
2.21.0

