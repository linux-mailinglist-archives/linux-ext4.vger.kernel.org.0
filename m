Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B349A97A8C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfHUNSP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Aug 2019 09:18:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbfHUNSP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Aug 2019 09:18:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E66AE8535D
        for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2019 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-107.brq.redhat.com [10.40.204.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3375D9D3
        for <linux-ext4@vger.kernel.org>; Wed, 21 Aug 2019 13:18:14 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] mke2fs: Warn if page size != blocksize when ecnrypt is enabled
Date:   Wed, 21 Aug 2019 15:18:12 +0200
Message-Id: <20190821131813.9456-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 21 Aug 2019 13:18:14 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With encrypt feature enabled the file system block size must match
system page size. Currently mke2fs will not complain at all when we try
to create a file system that does not satisfy this requirement for the
system. Add a warning for this case.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 misc/mke2fs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index d7cf257e..aa9590d8 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2468,6 +2468,26 @@ profile_error:
 		      exit (1);
 	}
 
+	/*
+	 * Encrypt feature requires blocksize to be the same as page size,
+	 * otherwise file system won't mount
+	 */
+	if (ext2fs_has_feature_encrypt(&fs_param) &&
+	   (blocksize != sys_page_size)) {
+		if (!force) {
+			com_err(program_name, 0,
+				_("Encrypt feature is enabled, but block size "
+				  "(%dB) does not match system page size "
+				  "(%dB)"),
+				blocksize, sys_page_size);
+			proceed_question(proceed_delay);
+		}
+		fprintf(stderr,_("Warning: Encrypt feature enabled, but block "
+				 "size (%dB) does not match system page size "
+				 "(%dB), forced to continue\n"),
+			blocksize, sys_page_size);
+	}
+
 	/* Don't allow user to set both metadata_csum and uninit_bg bits. */
 	if (ext2fs_has_feature_metadata_csum(&fs_param) &&
 	    ext2fs_has_feature_gdt_csum(&fs_param))
-- 
2.21.0

