Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8628CF3D
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgJMNiv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Oct 2020 09:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbgJMNiv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Oct 2020 09:38:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EC9AB17C;
        Tue, 13 Oct 2020 13:38:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E38CF1E12FB; Tue, 13 Oct 2020 15:38:49 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] mke2fs.8: Improve valid block size documentation
Date:   Tue, 13 Oct 2020 15:38:48 +0200
Message-Id: <20201013133848.23287-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Explain which valid block sizes mke2fs supports in more detail.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/mke2fs.8.in | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6fd2d..0814d216f3a4 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -207,10 +207,11 @@ manual page for more details.
 .SH OPTIONS
 .TP
 .BI \-b " block-size"
-Specify the size of blocks in bytes.  Valid block-size values are 1024,
-2048 and 4096 bytes per block.  If omitted,
-block-size is heuristically determined by the filesystem size and
-the expected usage of the filesystem (see the
+Specify the size of blocks in bytes.  Valid block-size values are powers of two
+from 1024 up to 65536 (however note that the kernel is able to mount only
+filesystems with block-size smaller or equal to the system page size - 4k on
+x86 systems). If omitted, block-size is heuristically determined by the
+filesystem size and the expected usage of the filesystem (see the
 .B \-T
 option).  If
 .I block-size
-- 
2.16.4

