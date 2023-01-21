Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD849676950
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjAUUg5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160029154
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01E560B7C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA06AC4339B;
        Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333401;
        bh=+eGPEt51BBekWdXR79kV7nTD9loilI/eFpEPnjT8EvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ca5WJoT/bSu14MaHRbJjdoRmRhTv3DstH89xoXENj2ge+vwr/NEge81cIGarWfFnu
         OfY6QWZ3J5WVfgyen1BN7yqSiHrqvrHf04LVAb9MCD5yJoAv8dnf2hTy5Sk/oq3a01
         9PcBINYjB2pQ9S25Sefm7niim6CzvmqnJzBFYDp7KOLAW6HGcwSDSPD+Z/Z6kLU9ay
         9l5vuel2mr4GgBBIhv7fIhni7MsF4sG4ETxW/erberD+F9O+h/y04Ny74dZOTaHGkv
         2geyEHKa2lnTGKRcBPwV2tVZvS1KfKJkk4B+X3UyxLnK1rd2AS6iyarnFuNvCZF9T1
         ZkbToXp/oS2Cg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 17/38] lib/ext2fs: remove unused variable in ext2fs_xattrs_read_inode()
Date:   Sat, 21 Jan 2023 12:32:09 -0800
Message-Id: <20230121203230.27624-18-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
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
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/ext_attr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/ext2fs/ext_attr.c b/lib/ext2fs/ext_attr.c
index d36fe68dd..359c8e3cb 100644
--- a/lib/ext2fs/ext_attr.c
+++ b/lib/ext2fs/ext_attr.c
@@ -991,13 +991,11 @@ static void xattrs_free_keys(struct ext2_xattr_handle *h)
 errcode_t ext2fs_xattrs_read_inode(struct ext2_xattr_handle *handle,
 				   struct ext2_inode_large *inode)
 {
-
 	struct ext2_ext_attr_header *header;
 	__u32 ea_inode_magic;
 	unsigned int storage_size;
 	char *start, *block_buf = NULL;
 	blk64_t blk;
-	size_t i;
 	errcode_t err = 0;
 
 	EXT2_CHECK_MAGIC(handle, EXT2_ET_MAGIC_EA_HANDLE);
-- 
2.39.0

