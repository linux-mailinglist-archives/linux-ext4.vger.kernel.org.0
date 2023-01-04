Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB065CEF9
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjADJDK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjADJC7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:02:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A05B1B
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA97B810FA
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD38C433D2
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822975;
        bh=96PysuTJcji9VxGtfhjyLfRcj6J+QiTMPndHE/BKAYU=;
        h=From:To:Subject:Date:From;
        b=X+6Jagt49+kF+NshW7m1+2X07ergEa0StTwzN80WJwbCf1vzT7c98s06pyrvUR+tJ
         +SGX5EHinupfR2RffXP/75RCZJqKvGTbOCtHZM4h68EYte5gNaiWb4DB/u9hz0J+ww
         6voFg5JO0JDBNger/f4QS8rWw1dOw0qq+pjWjejST8pk6c+RwGaLUif9T5rIOv+6iA
         lT3oGBL8i3/imaAkDPai3aDqf7niMT3XNTKIMLUgi/vJYKMdluLGt6cvhjMkOWk5gi
         OrhRWQD7KYzph1QjdRNnVYDMd7YqEkOUPFZ7zg5PMxmDxYAppLXKVja8WDwE/v782Z
         tGRHBBaUVtZQQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH] libext2fs: consistently use #ifdefs in ext2fs_print_bmap_statistics()
Date:   Wed,  4 Jan 2023 01:01:16 -0800
Message-Id: <20230104090116.275764-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since the 'now' variable is only used to calculate 'inuse', and 'inuse'
is only used when defined(ENABLE_BMAP_STATS_OPS), it makes sense to
guard the declaration and initialization of 'now' and 'inuse' by the
same condition, just like the '*_perc' variables in the same function.

This addresses the following compiler warning with clang -Wall:

gen_bitmap64.c:187:9: warning: variable 'inuse' set but not used [-Wunused-but-set-variable]
        double inuse;
               ^

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/gen_bitmap64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index c860c10e..1a1eeefe 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -183,11 +183,9 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
 #ifdef ENABLE_BMAP_STATS_OPS
 	float mark_seq_perc = 0.0, test_seq_perc = 0.0;
 	float mark_back_perc = 0.0, test_back_perc = 0.0;
-#endif
-	double inuse;
 	struct timeval now;
+	double inuse;
 
-#ifdef ENABLE_BMAP_STATS_OPS
 	if (stats->test_count) {
 		test_seq_perc = ((float)stats->test_seq /
 				 stats->test_count) * 100;
@@ -201,7 +199,6 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
 		mark_back_perc = ((float)stats->mark_back /
 				  stats->mark_count) * 100;
 	}
-#endif
 
 	if (gettimeofday(&now, (struct timezone *) NULL) == -1) {
 		perror("gettimeofday");
@@ -212,6 +209,7 @@ static void ext2fs_print_bmap_statistics(ext2fs_generic_bitmap_64 bitmap)
 		(((double) now.tv_usec) * 0.000001);
 	inuse -= (double) stats->created.tv_sec + \
 		(((double) stats->created.tv_usec) * 0.000001);
+#endif /* ENABLE_BMAP_STATS_OPS */
 
 	fprintf(stderr, "\n[+] %s bitmap (type %d)\n", bitmap->description,
 		stats->type);
-- 
2.39.0

