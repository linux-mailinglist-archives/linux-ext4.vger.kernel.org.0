Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06992DBE8E
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgLPKWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:22:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:51108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLPKWt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:22:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F6ECAC7F;
        Wed, 16 Dec 2020 10:22:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 010BA1E135E; Wed, 16 Dec 2020 11:22:07 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] mke2fs.8: Improve valid block size documentation
Date:   Wed, 16 Dec 2020 11:22:06 +0100
Message-Id: <20201216102206.23127-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Explain which valid block sizes mke2fs supports in more detail.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/mke2fs.8.in | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6fd2d..171315b142bc 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -207,12 +207,14 @@ manual page for more details.
 .SH OPTIONS
 .TP
 .BI \-b " block-size"
-Specify the size of blocks in bytes.  Valid block-size values are 1024,
-2048 and 4096 bytes per block.  If omitted,
-block-size is heuristically determined by the filesystem size and
+Specify the size of blocks in bytes.  Valid block-size values are powers of two
+from 1024 up to 65536 (however note that the kernel is able to mount only
+filesystems with block-size smaller or equal to the system page size - 4k on
+x86 systems, upto 64k on ppc64 or aarch64 depending on kernel configuration).
+If omitted, block-size is heuristically determined by the filesystem size and
 the expected usage of the filesystem (see the
 .B \-T
-option).  If
+option).  In most common cases, the default block size is 4k. If
 .I block-size
 is preceded by a negative sign ('-'), then
 .B mke2fs
-- 
2.16.4

