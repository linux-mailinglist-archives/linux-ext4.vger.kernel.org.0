Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112A79AFC7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 01:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjIKVVM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjIKJOf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 05:14:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224FCCD;
        Mon, 11 Sep 2023 02:14:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.218.185])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6FB06607186;
        Mon, 11 Sep 2023 10:14:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694423669;
        bh=9wEA6kj/8qL09liKb87plaPguZEAHq2kFG8kWKL8ugk=;
        h=From:To:Cc:Subject:Date:From;
        b=onT3hW2nuSZ+Llw31Ags4TTIrqfFFb7HPREmgpc985AZJ93ChdJGtJX38PPv9X4Qt
         On1ZuDtOGbUmb9NUIRiSm2GSzUHC/M6hndGMERADezsogGx9Hi+tyD0/KR8//7yZkO
         SR7YxRL4a+VT3UnkXRNfL94VGhkuslODCcep473JNopjjSN0jocx96CjhEWe3ToSmv
         2ikbpjxHZK5rnEyHLqmNolnh1JKWgbqGxoPPCqTEZ0cinpUt5rJuSXQOmr6Yr0Omhm
         6WhsvVEffoTRMR6xrC7/2fOH9IhCDxEqVp9MsJos7mfpBcIBiadJisGCQ0Fl0MORBF
         a67rTdugS8dlA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Allison Henderson <achender@linux.vnet.ibm.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, stable@vger.kernel.org,
        syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] ext4: don't' remove already removed extent
Date:   Mon, 11 Sep 2023 14:13:58 +0500
Message-Id: <20230911091358.3528530-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzbot has hit the following bug on current and all older kernels:
BUG: KASAN: out-of-bounds in ext4_ext_rm_leaf fs/ext4/extents.c:2736 [inline]
BUG: KASAN: out-of-bounds in ext4_ext_remove_space+0x2482/0x4d90 fs/ext4/extents.c:2958
Read of size 18446744073709551508 at addr ffff888073aea078 by task syz-executor420/6443

On investigation, I've found that eh->eh_entries is zero, ex is
referring to last entry and EXT_LAST_EXTENT(eh) is referring to first.
Hence EXT_LAST_EXTENT(eh) - ex becomes negative and causes the wrong
buffer read.

element: FFFF8882F8F0D06C       <----- ex
element: FFFF8882F8F0D060
element: FFFF8882F8F0D054
element: FFFF8882F8F0D048
element: FFFF8882F8F0D03C
element: FFFF8882F8F0D030
element: FFFF8882F8F0D024
element: FFFF8882F8F0D018
element: FFFF8882F8F0D00C	<------  EXT_FIRST_EXTENT(eh)
header:  FFFF8882F8F0D000	<------  EXT_LAST_EXTENT(eh) and eh

Cc: stable@vger.kernel.org
Reported-by: syzbot+6e5f2db05775244c73b7@syzkaller.appspotmail.com
Closes: https://groups.google.com/g/syzkaller-bugs/c/G6zS-LKgDW0/m/63MgF6V7BAAJ
Fixes: d583fb87a3ff ("ext4: punch out extents")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
This patch is only fixing the local issue. There may be bigger bug. Why
is ex set to last entry if the eh->eh_entries is 0. If any ext4
developer want to look at the bug, please don't hesitate.
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f101..7b7779b4cb87f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2726,7 +2726,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		 * If the extent was completely released,
 		 * we need to remove it from the leaf
 		 */
-		if (num == 0) {
+		if (num == 0 && eh->eh_entries) {
 			if (end != EXT_MAX_BLOCKS - 1) {
 				/*
 				 * For hole punching, we need to scoot all the
-- 
2.40.1

