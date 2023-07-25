Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26E76089E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGYEeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGYEeM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 00:34:12 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id EDC1BE64;
        Mon, 24 Jul 2023 21:34:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id DCCA66032EB7E;
        Tue, 25 Jul 2023 12:34:04 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH v2] ext4: mballoc: avoid garbage value from err
Date:   Tue, 25 Jul 2023 12:33:11 +0800
Message-Id: <20230725043310.1227621-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

clang's static analysis warning: fs/ext4/mballoc.c
line 4178, column 6, Branch condition evaluates to a garbage value.

err is uninitialized and will be judged when 'len <= 0' or
it first enters the loop while the condition "!ext4_sb_block_valid()"
is true. Although this can't make problems now, it's better to
correct it.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - modify commit message

 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 21b903fe546e..769000c970b0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4084,7 +4084,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, err;
+	int i, err = 0;
 	int already;
 	unsigned int clen, clen_changed, thisgrp_len;
 
-- 
2.30.2

