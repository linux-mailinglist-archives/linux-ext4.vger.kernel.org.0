Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5994A045F
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jan 2022 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351806AbiA1XkK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 18:40:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43464 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243675AbiA1XkH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 18:40:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 028A0B82722;
        Fri, 28 Jan 2022 23:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C0AC340F2;
        Fri, 28 Jan 2022 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643413203;
        bh=LuDFDhqfRMf5XNrJxODhsKvMEoMr5mmsePqMCFxBMwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4mBSoJ6eUvtHyPrP4gwPfdZRKUbE5cORinvPjBDH3fLCbfPpOsgdEK9mfPgXiatk
         +IOvMbz45hpLUufIIFh591vHBZKCWrpJr6UVb2daSwOfq6apsXEeZdxG1AM2sTCrSD
         9jMU34IAOJrl/oVzg1IVzS+ZgXp+7Wfrjx6lerJYkN9y/1oC1KuG2EZPkYv9nbaRX1
         Ao4IFDkkteu8DugSNoKhIX75sxHXmlyKyu2+Um1GKfCjVsBSPAWo4PRkUtJkaXuRBK
         R8xzXV6+/s/aGrLoVLdGbQXKayJ0i+z2ZnFcHcRTisC6ds2XE64tcwMP5ZqMQP/OxO
         Gk7gN9UpoWejA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v11 4/5] f2fs: support direct I/O with fscrypt using blk-crypto
Date:   Fri, 28 Jan 2022 15:39:39 -0800
Message-Id: <20220128233940.79464-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128233940.79464-1-ebiggers@kernel.org>
References: <20220128233940.79464-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Encrypted files traditionally haven't supported DIO, due to the need to
encrypt/decrypt the data.  However, when the encryption is implemented
using inline encryption (blk-crypto) instead of the traditional
filesystem-layer encryption, it is straightforward to support DIO.

Therefore, make f2fs support DIO on files that are using inline
encryption.  Since f2fs uses iomap for DIO, and fscrypt support was
already added to iomap DIO, this just requires two small changes:

- Let DIO proceed when supported, by checking fscrypt_dio_supported()
  instead of assuming that encrypted files never support DIO.

- In f2fs_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
  length of the mapping in the rare case where a DUN discontiguity
  occurs in the middle of an extent.  The iomap DIO implementation
  requires this, since it assumes that it can submit a bio covering (up
  to) the whole mapping, without checking fscrypt constraints itself.

Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/data.c | 7 +++++++
 fs/f2fs/f2fs.h | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66ae..020d47f97969c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4044,6 +4044,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->offset = blks_to_bytes(inode, map.m_lblk);
 
+	/*
+	 * When inline encryption is enabled, sometimes I/O to an encrypted file
+	 * has to be broken up to guarantee DUN contiguity.  Handle this by
+	 * limiting the length of the mapping returned.
+	 */
+	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
+
 	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		if (map.m_flags & F2FS_MAP_MAPPED) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb22fa91c2b26..db46f3cf0885d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4371,7 +4371,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 
 	/* disallow direct IO if any of devices has unaligned blksize */
-- 
2.35.0

