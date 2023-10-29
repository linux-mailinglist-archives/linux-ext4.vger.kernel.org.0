Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D97DAA4A
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Oct 2023 02:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjJ2AnD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Oct 2023 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2AnC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Oct 2023 20:43:02 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 Oct 2023 17:42:58 PDT
Received: from tulikuusama2.dnainternet.net (tulikuusama2.dnainternet.net [83.102.40.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8555DD3
        for <linux-ext4@vger.kernel.org>; Sat, 28 Oct 2023 17:42:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id BA5F320468;
        Sun, 29 Oct 2023 03:35:38 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.251
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
Authentication-Results: tulikuusama2.dnainternet.net (DNA Internet);
        dkim=pass (1024-bit key) header.d=anssih.iki.fi
Received: from tulikuusama2.dnainternet.net ([83.102.40.151])
        by localhost (tulikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id FAVsPegAGPs5; Sun, 29 Oct 2023 03:35:38 +0300 (EEST)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net [83.102.40.52])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 826E320097;
        Sun, 29 Oct 2023 03:35:38 +0300 (EEST)
Received: from mail.onse.fi (87-95-225-209.bb.dnainternet.fi [87.95.225.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by kirsikkapuu2.dnainternet.net (Postfix) with ESMTPS id 3ED7E3FF7;
        Sun, 29 Oct 2023 03:35:36 +0300 (EEST)
Received: by mail.onse.fi (Postfix, from userid 1000)
        id D230B32033B; Sun, 29 Oct 2023 03:35:35 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.onse.fi D230B32033B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anssih.iki.fi;
        s=default; t=1698539735;
        bh=u9jqFsQ9TTJFw0kwpXKo1Z7Fh8LXErWI9HXlzoMaQuc=;
        h=From:To:Subject:From;
        b=IBwpIoZpOqtAeuqGIlE034PkS41sDjGIxCxnI7rL1A1u4L9fGps3MjcgLhD/vzk8q
         PwUwqUZNpP0z97qLG8B/dR3+/6nH7KFOgUBaMH/jg6bfjyzBYiO8cxCK0pry1KMly6
         xGL596zXwSl06lqUKejNdoAEcH/uiWXNA0Bfn5O4=
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] resize2fs: account for META_BG in group descriptor check
Date:   Sun, 29 Oct 2023 03:34:33 +0300
Message-ID: <20231029003505.656956-1-anssi.hannula@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The block group descriptor count sanity check added in 21bad2b6797f
("resize2fs: prevent block group descriptors from overflowing the first
bg") prevents enlarging the filesystem when the block group descriptors
would not fit in the first block group.

However, this does not take into account the META_BG feature in which
case not all the descriptors need to be stored in the first block group.

This prevents, for example, enlarging filesystems with 4KiB block size
past 256TiB.

Relax the check to allow resizing META_BG filesystems past the limit.

Also, always allow on-line resizing as the kernel takes care of
converting the filesystem to use META_BG when needed.

Link: https://github.com/tytso/e2fsprogs/issues/117
Fixes: 21bad2b6797f ("resize2fs: prevent block group descriptors from overflowing the first bg")
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 resize/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/resize/main.c b/resize/main.c
index f914c050..8c626202 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -556,11 +556,13 @@ int main (int argc, char ** argv)
 						 EXT2_BLOCKS_PER_GROUP(fs->super));
 	new_desc_blocks = ext2fs_div_ceil(new_group_desc_count,
 					  EXT2_DESC_PER_BLOCK(fs->super));
-	if ((new_desc_blocks + fs->super->s_first_data_block) >
+	if (!ext2fs_has_feature_meta_bg(fs->super) &&
+	    !(mount_flags & EXT2_MF_MOUNTED) &&
+	    (new_desc_blocks + fs->super->s_first_data_block) >
 	    EXT2_BLOCKS_PER_GROUP(fs->super)) {
 		com_err(program_name, 0,
-			_("New size results in too many block group "
-			  "descriptors.\n"));
+			_("New size requires on-line resizing for meta_bg "
+			  "conversion, please mount the filesystem first\n"));
 		goto errout;
 	}
 
-- 
2.41.0

