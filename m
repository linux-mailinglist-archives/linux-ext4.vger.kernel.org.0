Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDD16A499
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXLGw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 06:06:52 -0500
Received: from mail.windriver.com ([147.11.1.11]:49339 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXLGw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 06:06:52 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01OB6hT8007746
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 24 Feb 2020 03:06:43 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.468.0; Mon, 24 Feb 2020 03:06:43 -0800
From:   Robert Yang <liezhi.yang@windriver.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH][e2fsprogs] misc/create_inode.c: set dir's mode correctly
Date:   Mon, 24 Feb 2020 19:08:42 +0800
Message-ID: <1582542522-97508-1-git-send-email-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The dir's mode has been set by ext2fs_mkdir() with umask, so
reset it to the source's mode in set_inode_extra().

Fixed when source dir's mode is 521, but dst dir's mode is 721 which was
incorrect.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 misc/create_inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index 5161d5e..f82f74e 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -124,7 +124,14 @@ static errcode_t set_inode_extra(ext2_filsys fs, ext2_ino_t ino,
 	ext2fs_set_i_uid_high(inode, st->st_uid >> 16);
 	inode.i_gid = st->st_gid;
 	ext2fs_set_i_gid_high(inode, st->st_gid >> 16);
-	inode.i_mode |= st->st_mode;
+	/*
+	 * The dir's mode has been set by ext2fs_mkdir() with umask, so
+	 * reset it to the source's mode
+	 */
+	if S_ISDIR(st->st_mode)
+		inode.i_mode = LINUX_S_IFDIR | st->st_mode;
+	else
+		inode.i_mode |= st->st_mode;
 	inode.i_atime = st->st_atime;
 	inode.i_mtime = st->st_mtime;
 	inode.i_ctime = st->st_ctime;
-- 
2.7.4

