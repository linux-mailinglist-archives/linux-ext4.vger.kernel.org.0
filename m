Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626D9319BFD
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhBLJiz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Feb 2021 04:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhBLJiv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Feb 2021 04:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613122644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AqGE9fwP+VHM6BqJNdLrJ/X6dr91TFMUpr8G6AtULv4=;
        b=BPvsTYkVp+0AKc+ZFujtl2jwWUXQo3PX5L6V7fQp3d+WgSkf18X28jQnM7YeArpUaeP+Iu
        2AbxOWG+O3CHlI8Lknoq98EBP0t3qtfH5pf3LbuBXF2AR/n/T7Lw352D1IFwNcqZKGMRiA
        SuOFyFnvP+JeeDqA3Y5X5R1lQuFAfh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-yrroi2GbMD-4ZWDbUJWrGA-1; Fri, 12 Feb 2021 04:37:22 -0500
X-MC-Unique: yrroi2GbMD-4ZWDbUJWrGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A356A100CC86
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EFCD60657
        for <linux-ext4@vger.kernel.org>; Fri, 12 Feb 2021 09:37:20 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] mmp: do not use O_DIRECT when working with regular file
Date:   Fri, 12 Feb 2021 10:37:19 +0100
Message-Id: <20210212093719.162065-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the mmp block is read using O_DIRECT to avoid any caching tha
may be done by the VM. However when working with regular files this
creates alignment issues when the device of the host file system has
sector size smaller than the blocksize of the file system in the file
we're working with.

This can be reproduced with t_mmp_fail test when run on the device with
4k sector size because the mke2fs fails when trying to read the mmp
block.

Fix it by disabling O_DIRECT when working with regular file. I don't
think there is any risk of doing so since the file system layer, unlike
shared block device, should guarantee cache consistency.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ext2fs/mmp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index c21ae272..1ac22194 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 	 * regardless of how the io_manager is doing reads, to avoid caching of
 	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
 	if (fs->mmp_fd <= 0) {
+		struct stat st;
 		int flags = O_RDWR | O_DIRECT;
 
-retry:
+		/*
+		 * There is no reason for using O_DIRECT if we're working with
+		 * regular file. Disabling it also avoids problems with
+		 * alignment when the device of the host file system has sector
+		 * size smaller than blocksize of the fs we're working with.
+		 */
+		if (stat(fs->device_name, &st) == 0 &&
+		    S_ISREG(st.st_mode))
+			flags &= ~O_DIRECT;
+
 		fs->mmp_fd = open(fs->device_name, flags);
 		if (fs->mmp_fd < 0) {
-			struct stat st;
-
-			/* Avoid O_DIRECT for filesystem image files if open
-			 * fails, since it breaks when running on tmpfs. */
-			if (errno == EINVAL && (flags & O_DIRECT) &&
-			    stat(fs->device_name, &st) == 0 &&
-			    S_ISREG(st.st_mode)) {
-				flags &= ~O_DIRECT;
-				goto retry;
-			}
 			retval = EXT2_ET_MMP_OPEN_DIRECT;
 			goto out;
 		}
-- 
2.26.2

