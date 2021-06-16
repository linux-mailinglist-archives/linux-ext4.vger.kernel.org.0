Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112993A90D7
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFPE6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhFPE6r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E40D61375
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819402;
        bh=Gkoksc4ydaJpOKo/fJKbpiCJNijqA118um3jqF+tvoI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AS8a2oVUIRL+4BJHaky0scOnstxl5au4NnM7+eNFXCHnhgP/L0/2o5/BtUcJeRbAv
         QEaWFo8TIL9G3IWU/aXv9S52kRi9Xv7duAdxg1jbsLJTvYqrNqxu4HFEHf10inef3u
         fs/zIwgfAvUri5PNI1TLkfDPWrywjF5stI6KlSbWgEWAXVK4DYdG3cQbEvi8SFE7kj
         +EZtoATmLCcHcXVNjpwQXIP1wSUe+aN24+emhqkJg7gcdqxbypIuMaiKqtebqMHzMd
         mI+fHyPMGQFIRH/tVoCKJOOrgcDZEzKhbWP9LNLdXcWxQuZyJKZ9GX/y7KMhdAzLou
         lRtkFpiJKUggg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/6] mke2fs: use ext2fs_get_device_size2() on all platforms
Date:   Tue, 15 Jun 2021 21:53:31 -0700
Message-Id: <20210616045334.1655288-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since commit e8c858047be6 ("libext2fs: fix build issue for on
Windows/Cygwin systems"), ext2fs_get_device_size2() is available in
Windows builds of libext2fs.  So there is no need for mke2fs to call
ext2fs_get_device_size() instead.

This fixes a -Wincompatible-pointer-types warning because
ext2fs_get_device_size() was being passed a 'blk64_t *', but it expected
a 'blk_t *'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/mke2fs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index afbcf486..d5ab334e 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1989,15 +1989,9 @@ profile_error:
 		dev_size = fs_blocks_count;
 		retval = 0;
 	} else
-#ifndef _WIN32
 		retval = ext2fs_get_device_size2(device_name,
 						 EXT2_BLOCK_SIZE(&fs_param),
 						 &dev_size);
-#else
-		retval = ext2fs_get_device_size(device_name,
-						EXT2_BLOCK_SIZE(&fs_param),
-						&dev_size);
-#endif
 	if (retval && (retval != EXT2_ET_UNIMPLEMENTED)) {
 		com_err(program_name, retval, "%s",
 			_("while trying to determine filesystem size"));
-- 
2.32.0.272.g935e593368-goog

