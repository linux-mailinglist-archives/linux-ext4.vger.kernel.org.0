Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C669429D4B0
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgJ1Vxq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:53:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgJ1Vxm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E19EAD46;
        Wed, 28 Oct 2020 15:55:45 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id b70607d5;
        Wed, 28 Oct 2020 15:55:52 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] filefrag: handle invalid st_dev and blksize cases
Date:   Wed, 28 Oct 2020 15:55:50 +0000
Message-Id: <20201028155550.24680-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is possible to crash filefrag with a "Floating point exception" in
two different scenarios:

1. When fstat() returns a device ID set to 0
2. When FIGETBSZ ioctl returns a blocksize of 0

In both scenarios a divide-by-zero will occur in frag_report() because
variable blksize will be set to zero.

I've managed to trigger this crash with an old CephFS kernel client,
using xfstest generic/519.  The first scenario has been fixed by kernel
commit 75c9627efb72 ("ceph: map snapid to anonymous bdev ID").  The
second scenario is also fixed with commit 8f97d1e99149 ("vfs: fix
FIGETBSZ ioctl on an overlayfs file").

However, it is desirable to handle these two scenarios gracefully by
checking these conditions explicitly.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 misc/filefrag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/filefrag.c b/misc/filefrag.c
index 6308bc6d1f91..62d583b2ea23 100644
--- a/misc/filefrag.c
+++ b/misc/filefrag.c
@@ -438,13 +438,13 @@ static int frag_report(const char *filename)
 		goto out_close;
 	}
 
-	if (last_device != st.st_dev) {
+	if ((last_device != st.st_dev) || !st.st_dev) {
 		if (fstatfs(fd, &fsinfo) < 0) {
 			rc = -errno;
 			perror("fstatfs");
 			goto out_close;
 		}
-		if (ioctl(fd, FIGETBSZ, &blksize) < 0)
+		if ((ioctl(fd, FIGETBSZ, &blksize) < 0) || !blksize)
 			blksize = fsinfo.f_bsize;
 		if (verbose)
 			printf("Filesystem type is: %lx\n",
