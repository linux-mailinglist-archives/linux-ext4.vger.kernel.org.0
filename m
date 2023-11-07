Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF87E4D73
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Nov 2023 00:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjKGXeY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Nov 2023 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbjKGXeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Nov 2023 18:34:10 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CFB25A8
        for <linux-ext4@vger.kernel.org>; Tue,  7 Nov 2023 15:33:30 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     linux-ext4@vger.kernel.org
Cc:     Mike Gilbert <floppym@gentoo.org>, Sam James <sam@gentoo.org>
Subject: [PATCH e2fsprogs 1/2] configure.ac: call AC_SYS_LARGEFILE before checking the size of off_t
Date:   Tue,  7 Nov 2023 23:33:21 +0000
Message-ID: <20231107233323.2013334-1-sam@gentoo.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Mike Gilbert <floppym@gentoo.org>

Signed-off-by: Mike Gilbert <floppym@gentoo.org>
Signed-off-by: Sam James <sam@gentoo.org>
---
 configure.ac | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index b905e999..6b4484b0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1116,6 +1116,7 @@ AC_CHECK_DECL(fsmap_sizeof,[AC_DEFINE(HAVE_FSMAP_SIZEOF, 1,
 dnl
 dnl Word sizes...
 dnl
+AC_SYS_LARGEFILE
 AC_CHECK_SIZEOF(short)
 AC_CHECK_SIZEOF(int)
 AC_CHECK_SIZEOF(long)
@@ -1901,8 +1902,6 @@ OS_IO_FILE=""
 esac]
 AC_SUBST(OS_IO_FILE)
 
-AC_SYS_LARGEFILE
-
 dnl
 dnl Make our output files, being sure that we create the some miscellaneous 
 dnl directories
-- 
2.42.1

