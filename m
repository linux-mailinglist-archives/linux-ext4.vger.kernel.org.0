Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8B65CF00
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjADJDn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjADJD3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9B15F2A
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 01:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74570615F7
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 09:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DECC433D2;
        Wed,  4 Jan 2023 09:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822998;
        bh=IBRh2ipcWVWg09S9BWqomTqx71XgiCEBxdpbpMDtH1I=;
        h=From:To:Cc:Subject:Date:From;
        b=qjqK0iVK3EGLGl96nDeQfFt4Zd7fSvZDD9+/ZoKLIOxwckovbhWehpyuKEsgYjGXD
         n+eJTx8FDczeWsss5alLkR/JVo+YbaYAaXE7o8UAPlX0T+oUPUBNrJkTmHQI7GYiiH
         rkIo243mkVqYgspqFDEshHlPrxvGiDkFZ+nP8hcCT9mTuFiUoue299T4mnwLcDA0zl
         ozcBDnS3HBAcFNIw050ExREWMPAtucjdmU/26hCjRDmVhzar6wzbhTOS1eL1oXP1T3
         n5GnVIrGpU4ea32pp44GeHyyaqoCSjQRygOfIUIjoIs6wZFObrPkwKVTbtpT/BP4DC
         v/HItsBcC1iWw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Andreas Dilger <adilger@dilger.ca>
Subject: [e2fsprogs PATCH] libext2fs: remove unused variable in ext2fs_xattrs_read_inode()
Date:   Wed,  4 Jan 2023 01:03:14 -0800
Message-Id: <20230104090314.276028-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Address the following compiler warning with gcc -Wall:

ext_attr.c: In function ‘ext2fs_xattrs_read_inode’:
ext_attr.c:1000:16: warning: unused variable ‘i’ [-Wunused-variable]
 1000 |         size_t i;
      |                ^

Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/ext_attr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index d36fe68d..6fc4214c 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -997,7 +997,6 @@ errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
 	unsigned int storage_size;
 	char *start, *block_buf = NULL;
 	blk64_t blk;
-	size_t i;
 	errcode_t err = 0;
 
 	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
-- 
2.39.0

