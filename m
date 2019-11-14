Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1FFC073
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 08:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfKNHDm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 02:03:42 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34404 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfKNHDm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 02:03:42 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C2C702E0D62;
        Thu, 14 Nov 2019 10:03:38 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id LWxSFmZsF8-3c48bh4j;
        Thu, 14 Nov 2019 10:03:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573715018; bh=k4z9VHt5dBV8QCXhkxzOvom+pDZ+LyhbIhx5jyxThHk=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=zTb1FsIS73eXHNi7XxeEDE4N7I//ge9xSYnxcWzEIo9Jj11CgqKiySMd/3tnxGQ72
         Rg3MLh9NsVWfGXfEk0kkj+DPTkCj6gM7ok97WEY2Q7PFWbCncjj3Y/NsSMOtw+m3i4
         1soQKcbb+QpGzxwhs5XOv1WuxTdR601W1VGXiWh0=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by myt4-4db2488e778a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id RDpTFQknMP-3cVOPCni;
        Thu, 14 Nov 2019 10:03:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH 1/2] ext4: Use raw numbers for EXT4_MAP_XXX flags
Date:   Thu, 14 Nov 2019 07:03:29 +0000
Message-Id: <20191114070330.14115-2-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191114070330.14115-1-dmonakhov@gmail.com>
References: <20191114070330.14115-1-dmonakhov@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Trace's macro __print_flags() produce raw event's decraration w/o knowing actual flags value

cat /sys/kernel/debug/tracing/events/ext4/ext4_ext_map_blocks_exit/format
..
__print_flags(REC->mflags, "", { (1 << BH_New),
..
This means that  perf-script can not decode bintrace file because BH_XXX is just a text and it is
unknown for perf's userspace. As result perf will dump this field as raw hex number
This patch use explicit numbers to describe EXT4_MAP_XXX flags so __print_flags will works as expected.

#Before patch
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags 0x20 ret 1
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34304 len 1 mflags 0x60 ret 1

#With patch
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags M ret 1
ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34816 len 1 mflags NM ret 1

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/ext4.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa..9ccf736 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -169,14 +169,32 @@ struct ext4_allocation_request {
  * This structure is used to pass requests into ext4_map_blocks() as
  * well as to store the information returned by ext4_map_blocks().  It
  * takes less room on the stack than a struct buffer_head.
+ *
+ * Use explicit mapping of EXT4_MAP_XXX flags to corresponding BH_XXX bits
  */
-#define EXT4_MAP_NEW		(1 << BH_New)
-#define EXT4_MAP_MAPPED		(1 << BH_Mapped)
-#define EXT4_MAP_UNWRITTEN	(1 << BH_Unwritten)
-#define EXT4_MAP_BOUNDARY	(1 << BH_Boundary)
+#define EXT4_MAP_NEW		0x40
+#define EXT4_MAP_MAPPED		0x20
+#define EXT4_MAP_UNWRITTEN	0x1000
+#define EXT4_MAP_BOUNDARY	0x400
 #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
 				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
 
+/*
+ * Assert that EXT4_MAP_XX is consistent with respect to BH_XXX. If all is well,
+ * the macros will be dropped, so, it won't cost any extra space in the compiled
+ * kernel image, otherwise, the build will fail.
+ */
+#define TEST_MAP_VALUE(FLAG, BIT) (EXT4_MAP_##FLAG == (1 << BH_##BIT))
+#define CHECK_MAP_VALUE(FLAG, BIT) BUILD_BUG_ON(!TEST_MAP_VALUE(FLAG, BIT))
+
+static inline void ext4_check_map_values(void)
+{
+	CHECK_MAP_VALUE(NEW, New);
+	CHECK_MAP_VALUE(MAPPED, Mapped);
+	CHECK_MAP_VALUE(UNWRITTEN, Unwritten);
+	CHECK_MAP_VALUE(BOUNDARY, Boundary);
+}
+
 struct ext4_map_blocks {
 	ext4_fsblk_t m_pblk;
 	ext4_lblk_t m_lblk;
-- 
2.7.4

