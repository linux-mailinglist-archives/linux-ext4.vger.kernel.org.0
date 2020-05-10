Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD51CCE4B
	for <lists+linux-ext4@lfdr.de>; Sun, 10 May 2020 23:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEJVxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 May 2020 17:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgEJVxQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 10 May 2020 17:53:16 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F27A20801
        for <linux-ext4@vger.kernel.org>; Sun, 10 May 2020 21:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589147596;
        bh=Wiz7iWWq/oKRIxVAP0IlJmJEz4tgnLvGl6nMMUnGU1g=;
        h=From:To:Subject:Date:From;
        b=iYFMLXBFtNRGPt33zO7obQRS97iXjkeIgkOQBSRXxLv8kMNAMRKeCpc6nykhcQv7r
         /l9TauPH4Uzenl0/bXaPTNsDJ0MZOKYpt1rGHfcu7NgduBmvW6YQLTQZOszrDICjn1
         jDUhK3sQLKWmSbegzei6UReRHs29uFv+VpUcjsL4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: add casefold flag to EXT4_INODE_* flags
Date:   Sun, 10 May 2020 14:52:52 -0700
Message-Id: <20200510215252.87833-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

No one currently needs EXT4_INODE_CASEFOLD, but add it to keep the
EXT4_INODE_* definitions in sync with the EXT4_*_FL definitions.

Also make it clearer that the casefold flag is only for directories.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5b7..daa1f4d180c900 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -417,7 +417,7 @@ struct flex_groups {
 /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
 #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
-#define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
+#define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded directory */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
 #define EXT4_FL_USER_VISIBLE		0x705BDFFF /* User visible flags */
@@ -490,6 +490,7 @@ enum {
 /* 22 was formerly EXT4_INODE_EOFBLOCKS */
 	EXT4_INODE_INLINE_DATA	= 28,	/* Data in inode. */
 	EXT4_INODE_PROJINHERIT	= 29,	/* Create with parents projid */
+	EXT4_INODE_CASEFOLD	= 30,	/* Casefolded directory */
 	EXT4_INODE_RESERVED	= 31,	/* reserved for ext4 lib */
 };
 
@@ -535,6 +536,7 @@ static inline void ext4_check_flag_values(void)
 	CHECK_FLAG_VALUE(EA_INODE);
 	CHECK_FLAG_VALUE(INLINE_DATA);
 	CHECK_FLAG_VALUE(PROJINHERIT);
+	CHECK_FLAG_VALUE(CASEFOLD);
 	CHECK_FLAG_VALUE(RESERVED);
 }
 
-- 
2.26.2

