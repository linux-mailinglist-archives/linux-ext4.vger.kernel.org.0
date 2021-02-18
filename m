Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8441D31E931
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Feb 2021 12:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBRLeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Feb 2021 06:34:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232235AbhBRJ5c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 18 Feb 2021 04:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613642161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5MCTqwxlDAIBHaWmzekDNBT1EMATuiYIyXz2ggAznI=;
        b=P1VZi6l7cZNexBZFnAKiehzsiTVmJwgn10KNh/rfTIdMGN3ZQcNExBuMjfuqbL+miw8BFR
        vqGdkgn+A5AAy3hMwdfa1yTXZguEdtaYFgXAkvmh0MK3C6pKCASM/KJvbvaaTMzEdMRA9x
        UCCSDIXr0WVPXqySQbv8rRgpt0XJ/qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-oq9zX6GnOFKQlTRBgcqMIg-1; Thu, 18 Feb 2021 04:51:52 -0500
X-MC-Unique: oq9zX6GnOFKQlTRBgcqMIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A67B180364C
        for <linux-ext4@vger.kernel.org>; Thu, 18 Feb 2021 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1750B7046C;
        Thu, 18 Feb 2021 09:51:47 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH v2] mmp: do not use O_DIRECT when working with regular file
Date:   Thu, 18 Feb 2021 10:51:46 +0100
Message-Id: <20210218095146.265302-1-lczerner@redhat.com>
In-Reply-To: <20210212093719.162065-1-lczerner@redhat.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the mmp block is read using O_DIRECT to avoid any caching that
may be done by the VM. However when working with regular files this
creates alignment issues when the device of the host file system has
sector size larger than the blocksize of the file system in the file
we're working with.

This can be reproduced with t_mmp_fail test when run on the device with
4k sector size because the mke2fs fails when trying to read the mmp
block.

Fix it by disabling O_DIRECT when working with regular files. I don't
think there is any risk of doing so since the file system layer, unlike
shared block device, should guarantee cache consistency.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>
---
v2: Fix comment - it avoids problems when the sector size is larger not
    smaller than blocksize

 lib/ext2fs/mmp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index c21ae272..cca2873b 100644
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
+		 * size larger than blocksize of the fs we're working with.
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

