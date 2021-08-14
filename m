Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E291D3EC35F
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhHNOlU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:41:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55864 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238512AbhHNOlU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:41:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEenQR024623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:40:50 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5FDBD15C37C1; Sat, 14 Aug 2021 10:40:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] mke2fs: warn that bigalloc is experimental only for large cluster sizes
Date:   Sat, 14 Aug 2021 10:40:48 -0400
Message-Id: <20210814144048.479490-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since we have done a lot of testing with a cluster size equal to 64k
(or 16 times the default 4k block size), mke2fs will only warn for
bigalloc file systems where the cluster size is greater than 16 times
the block size.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/mke2fs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index a4573972..effe963c 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2526,11 +2526,12 @@ profile_error:
 		exit(1);
 	}
 
-	if (!quiet && ext2fs_has_feature_bigalloc(&fs_param))
-		fprintf(stderr, "%s", _("\nWarning: the bigalloc feature is "
-				  "still under development\n"
-				  "See https://ext4.wiki.kernel.org/"
-				  "index.php/Bigalloc for more information\n\n"));
+	if (!quiet && ext2fs_has_feature_bigalloc(&fs_param) &&
+	    EXT2_CLUSTER_SIZE(&fs_param) > 16 * EXT2_BLOCK_SIZE(&fs_param))
+		fprintf(stderr, "%s", _("\nWarning: bigalloc file systems "
+				"with a cluster size greater than\n"
+				"16 times the block size is considered "
+				"experimental\n"));
 
 	/*
 	 * Since sparse_super is the default, we would only have a problem
-- 
2.31.0

