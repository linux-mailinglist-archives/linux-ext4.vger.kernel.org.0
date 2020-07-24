Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD79422CE0A
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXSpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jul 2020 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGXSpS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jul 2020 14:45:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C3C0619E8
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 11:45:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e135so11677802ybf.4
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oZN8SnIpsU7aOjS5+8MoI/0a82Ym0e3d0O/7K4J6ac4=;
        b=wIgyWZnmLwySzWDZSlBrKLMi9o7JvXabuPmirleI8ql4xoXo7sERCN6n1iqc7ulrPe
         +0bTFhJB6lh8er/OHOe2MXTTa4FGq9Z3I6vsRXEScezsqzlDDr2vnow9hUL76dFd4t73
         LSY7AXOCLmvkf5lykey7j+KVR2MMALlndNl2R6YrkZFHfXwGZkrfnHwyHn1h/uaaOf9l
         uJnX4cyIXqW+w1n+7Eb7Pxn4EQVXztt3YcG5WdnGQg5++z/bnqsVqqqlx/TYg5agIJhj
         WavGB7UKwBzo7jCeULL7RegHdYo0aLeV9COGmhAu19Pyol/rjfmG50iF+cCQ2zkbz44I
         mBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oZN8SnIpsU7aOjS5+8MoI/0a82Ym0e3d0O/7K4J6ac4=;
        b=MuebNI1ae1FlwLY1LJy+TREf2+7yLgMRC2ukEikN5W3saIRYhDhV96ZRE/+9ocP0xL
         mdvV//2ZZMUofE3S4FFCpGP/XefLSGIE+U3bVrt+8uXZasdk9xaeuwJSazSq66h1oz6B
         fAkeZ7XWv/MGaayRiZqDJU1Tnif5IT2XG5j0M5ytrxQmC3EUAQ097CnANdv4J55oV6Zk
         yd1WLd/wZfg7Ll8suTwZ4X/4QpnW1lPTaQ+IZjQcHex7B31dGhceVH5cofkOO2LQFgbn
         yHYRfJzj9EUvsYE5Vk5KcBJK/Pwv2QgdH4aKD9DDN2xd0+nm+iL9w0rGIMQrHtDc0Dxp
         Pqcw==
X-Gm-Message-State: AOAM532elE6OJrdNZilKgcrdIx6iTAqpZZayUO5E3cgYfERC5Hk8fSWc
        bjRZDAMAFHMMjMsGd2phfIEirJztpvo=
X-Google-Smtp-Source: ABdhPJzmZ43+VRZcOd+tePRiD99mq4GfMup1JpMkWtUBzFz9rcQiFfN2MHUCR4TgOqatdZ2Tf8jsOOl0B2c=
X-Received: by 2002:a25:c483:: with SMTP id u125mr16946975ybf.194.1595616314284;
 Fri, 24 Jul 2020 11:45:14 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:59 +0000
In-Reply-To: <20200724184501.1651378-1-satyat@google.com>
Message-Id: <20200724184501.1651378-6-satyat@google.com>
Mime-Version: 1.0
References: <20200724184501.1651378-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 5/7] f2fs: support direct I/O with fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..978130b5a195 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4082,7 +4082,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.28.0.rc0.142.g3c755180ce-goog

