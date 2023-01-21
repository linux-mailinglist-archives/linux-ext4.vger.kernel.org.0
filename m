Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA9676945
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjAUUgp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAUUgm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607629146
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B24DB807E4
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7594C433A0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333398;
        bh=g/X1fsEW6TIot+jRGRs90ZiT5k6YYFv8xrkvOgmtZfw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lISjL/TWjrBuLZswQvq07ULddsrgSHDuQnFHlbKCRVTfSMs6IBb7kdikyqmvEBiBv
         daDmP5VXrGo+NIsLTeypLPTnmHbt1FK9dUiH/ndN615RupUhmL0vY3q75A9vfo0Lin
         QmWVmG1WmnbrTEKfmevwZyAvT4a/UTCONYQLB0cqJPsj4g9KM1gqK72zFY2kZ9mSzo
         il2Mv37SOYNE8M4jAJeg4SVkHZ/+XjD4VwSUjYKmLr4LLy0efnjZuFejguRblm9jTP
         g5BtAwiNeL2Fdxt87yPZ9EzAZNOfCZIK5Oub2ggP5MUkKdmselrj2KSmPxgzjlp5UF
         Y1FFdsxcjaydg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 03/38] configure.ac: automatically add include/mingw/ headers
Date:   Sat, 21 Jan 2023 12:31:55 -0800
Message-Id: <20230121203230.27624-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since the include/mingw/ directory needs to be on the include path when
building for Windows with MinGW, add it to INCLUDES automatically, and
AC_DEFINE the corresponding HAVE_*_H constants.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 configure.ac | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/configure.ac b/configure.ac
index e3884db60..d62d99dc8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1036,6 +1036,17 @@ AC_CHECK_HEADERS(m4_flatten([
 	sys/wait.h
 	sys/xattr.h
 ]))
+case "$host_os" in
+mingw*)
+	# The above checks only detect system headers, not the headers in
+	# ./include/mingw/, so explicitly define them to be available.
+	AC_DEFINE(HAVE_LINUX_TYPES_H, 1)
+	AC_DEFINE(HAVE_SYS_STAT_H, 1)
+	AC_DEFINE(HAVE_SYS_SYSMACROS_H, 1)
+	AC_DEFINE(HAVE_SYS_TYPES_H, 1)
+	AC_DEFINE(HAVE_UNISTD_H, 1)
+	;;
+esac
 dnl Check where to find a dd(1) that supports iflag=fullblock
 dnl and oflag=append
 AC_MSG_CHECKING([for a dd(1) program that supports iflag=fullblock])
@@ -1710,6 +1721,11 @@ fi
 if test -n "$WITH_DIET_LIBC" ; then
 	INCLUDES="$INCLUDES -D_REENTRANT"
 fi
+case "$host_os" in
+mingw*)
+	INCLUDES=$INCLUDES' -I$(top_srcdir)/include/mingw'
+	;;
+esac
 AC_SUBST(INCLUDES)
 dnl
 dnl Build CFLAGS
-- 
2.39.0

