Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20CC67694B
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjAUUgw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjAUUgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C029143
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10D260B6A
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724ADC4339E;
        Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333401;
        bh=mYuMEikLUJ9WzfsPcciIqqBc8WId6z72Oq+uxwsfhkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zy9E218R/rcw9ngYvrn+HubwFzeqNRyNtQ9+8i8c3lVWXyvJVa6ZzCbrA+XRsRqEb
         C4bQXu4t7VICDdZlDP3Lucyn/bCHVW5HN+5Yqg9ERzPcWbsu3vfJpyKbC/0qbDBQez
         RRBmPnvPHZnCyC7pXT2TmWB/1LQOsUKxBGb0wi+laB3xHWsrg0AYR88yak8CUz4vSA
         b3yLQSJBW/8/l2n9YGco8p9gGiHs0/TQMrDKzuED7tgJJK6nM8nfcwPVd1hM8RW+T3
         JgkGiL0fHyi660SQbz7mEM07FgnI803KCD77Az0BxtcPpfsbJkC6wa5wNvLUPR0m+j
         b7pfvZcoNlszw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 16/38] lib/ext2fs: consistently use #ifdefs in ext2fs_print_bmap_statistics()
Date:   Sat, 21 Jan 2023 12:32:08 -0800
Message-Id: <20230121203230.27624-17-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
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
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/gen_bitmap64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index c860c10ed..1a1eeefeb 100644
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

