Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49E21CD89
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jul 2020 05:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGMDK3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Jul 2020 23:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGMDK2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 12 Jul 2020 23:10:28 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604CB2068F
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jul 2020 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594609828;
        bh=iyiLqa4Tth/0n24CoT5jN76FtenHbUedZvgZEy5lFEs=;
        h=From:To:Subject:Date:From;
        b=dhqNJevyzW2Qxrr5t9a93Ja0oUnpRL0eJPqCH+kB4vPaZlNyRnLOs3tFCIDIvJTYX
         WtRGrBuYv2EeFXdE9NbXrHIcWsKnpfE5Hwz6XznpNeMzVYM9Vkphtf5rpNyXX17+Q2
         URQ0B3cMCARhyd/6uc42tFptw/N3JyvFRpc9iNOE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: don't hardcode bit values in EXT4_FL_USER_*
Date:   Sun, 12 Jul 2020 20:10:12 -0700
Message-Id: <20200713031012.192440-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Define the EXT4_FL_USER_* constants by OR-ing together the appropriate
flags, rather than hard-coding a numeric value.  This makes it much
easier to see which flags are listed.

No change in the actual values.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..b603a28a3696 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -434,8 +434,34 @@ struct flex_groups {
 #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded directory */
 #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define EXT4_FL_USER_VISIBLE		0x725BDFFF /* User visible flags */
-#define EXT4_FL_USER_MODIFIABLE		0x624BC0FF /* User modifiable flags */
+/* User modifiable flags */
+#define EXT4_FL_USER_MODIFIABLE		(EXT4_SECRM_FL | \
+					 EXT4_UNRM_FL | \
+					 EXT4_COMPR_FL | \
+					 EXT4_SYNC_FL | \
+					 EXT4_IMMUTABLE_FL | \
+					 EXT4_APPEND_FL | \
+					 EXT4_NODUMP_FL | \
+					 EXT4_NOATIME_FL | \
+					 EXT4_JOURNAL_DATA_FL | \
+					 EXT4_NOTAIL_FL | \
+					 EXT4_DIRSYNC_FL | \
+					 EXT4_TOPDIR_FL | \
+					 EXT4_EXTENTS_FL | \
+					 0x00400000 /* EXT4_EOFBLOCKS_FL */ | \
+					 EXT4_DAX_FL | \
+					 EXT4_PROJINHERIT_FL | \
+					 EXT4_CASEFOLD_FL)
+
+/* User visible flags */
+#define EXT4_FL_USER_VISIBLE		(EXT4_FL_USER_MODIFIABLE | \
+					 EXT4_DIRTY_FL | \
+					 EXT4_COMPRBLK_FL | \
+					 EXT4_NOCOMPR_FL | \
+					 EXT4_ENCRYPT_FL | \
+					 EXT4_INDEX_FL | \
+					 EXT4_VERITY_FL | \
+					 EXT4_INLINE_DATA_FL)
 
 /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
 #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
-- 
2.27.0

