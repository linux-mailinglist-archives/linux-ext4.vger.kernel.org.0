Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46253F520
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiFGEZv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbiFGEZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6985B82CA
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PROu005547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575929; bh=zOsVw5bDkSUoeQceMKYtvoFOGcPx0MEwi/XBnWUvwMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mHI0Kj+B0jblXMqpXsJaxMvSLfRUWVQBeePcoAQz+NUSXfWvxOK7FxbIjflxCVI+I
         XSdTo0ZwSWaiEKTqvvmAG8CNT1TDhpl6eVucr2G4XQ7f70MymiZ8Hm96OmG0oSw+OP
         bEDRHGf7VPQaMouoDj9Izgd1jRjDxb9fjZumfNtP8OjimOIWo1wT72JcjOJGcDBoRd
         U9gSVNnuzcgWYxXgaNVQDnm9pEZM2a7dNaD95R4Pbpzgc3p/ou94UMFBPDolSFi2xv
         90RRtsuWuOjsJCTa/FwifCNs3Wt2xAohIt/xYiSVZoy2i+fOVvc5eao31qAQLgdjcy
         jogJcGSbvhRZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C2B2D15C3E29; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/7] libext2fs: add check for too-short directory blocks
Date:   Tue,  7 Jun 2022 00:24:40 -0400
Message-Id: <20220607042444.1798015-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220607042444.1798015-1-tytso@mit.edu>
References: <20220607042444.1798015-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there is an inline data directory which is smaller than 8 bytes
(which should never happen but for corrupted or fuzzed file systems),
ext2fs_process_dir_block() will now abort EXT2_ET_DIR_CORRUPTED to
avoid an out-of-bounds read.

Reported-by: Nils Bars <nils.bars@rub.de>
Reported-by: Moritz Schlögel <moritz.schloegel@rub.de>
Reported-by: Nico Schiller <nico.schiller@rub.de>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/dir_iterate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/ext2fs/dir_iterate.c b/lib/ext2fs/dir_iterate.c
index b2b77693..7798a482 100644
--- a/lib/ext2fs/dir_iterate.c
+++ b/lib/ext2fs/dir_iterate.c
@@ -221,6 +221,10 @@ int ext2fs_process_dir_block(ext2_filsys fs,
 	if (ext2fs_has_feature_metadata_csum(fs->super))
 		csum_size = sizeof(struct ext2_dir_entry_tail);
 
+	if (buflen < 8) {
+		ctx->errcode = EXT2_ET_DIR_CORRUPTED;
+		return BLOCK_ABORT;
+	}
 	while (offset < buflen - 8) {
 		dirent = (struct ext2_dir_entry *) (ctx->buf + offset);
 		if (ext2fs_get_rec_len(fs, dirent, &rec_len))
-- 
2.31.0

