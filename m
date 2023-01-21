Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2087767694D
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjAUUgy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAUUgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8B29149
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93CEBCE0A19
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684DC433EF
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333398;
        bh=nHfz2otl4U+5Pr63vSB63sCCWYB9/BfF30kLLccFCno=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Sd0eWdH5u6kem3h3qzFW5pDw4LaRSeVAQOu/OG9q+aEkumJYx3uSjOHRXpK0svnUA
         VPiLoOQaIa8EmXqUGBL86aSu1xAkgiim2Tb5WL/ITjsmD82MeKYZyEZFkLZt1YtdfX
         XoYk0PhuHfX4RZSo47tXOOeDeU9NbHTNBjUMmbQnAd88L2obInmPTpkS0hR+FVgL3M
         k/CEx4z/vb7qU2C702451osJ6bSBG2Ir+6/unTDrXkQhwbzTezVh568n38Ek2LbvIq
         zolUy0s8YYSDHmDv8hPwZA0oDDf3k+SiYSz0bP8VVloZ/0dZ3BSHU6FUNUMSe2rUTi
         XiqGBiVOmWd0Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 02/38] configure.ac: disable tdb by default on Windows
Date:   Sat, 21 Jan 2023 12:31:54 -0800
Message-Id: <20230121203230.27624-3-ebiggers@kernel.org>
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

The tdb support does not build for Windows, due to the use of various
UNIX-isms, so disable it by default when building for Windows.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 configure.ac | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5f440f1fc..e3884db60 100644
--- a/configure.ac
+++ b/configure.ac
@@ -845,23 +845,39 @@ dnl
 AH_TEMPLATE([CONFIG_TDB], [Define to 1 to enable tdb support])
 AC_ARG_ENABLE([tdb],
 AS_HELP_STRING([--disable-tdb],[disable tdb support]),
+[
 if test "$enableval" = "no"
 then
 	AC_MSG_RESULT([Disabling tdb support])
-	TDB_CMT="#"
-	TDB_MAN_COMMENT='.\"'
+	CONFIG_TDB=0
 else
 	AC_MSG_RESULT([Enabling tdb support])
+	CONFIG_TDB=1
+fi
+]
+,
+[
+case "$host_os" in
+mingw*)
+	AC_MSG_RESULT([Disabling tdb support by default])
+	CONFIG_TDB=0
+	;;
+*)
+	AC_MSG_RESULT([Enabling tdb support by default])
+	CONFIG_TDB=1
+	;;
+esac
+]
+)
+if test "$CONFIG_TDB" = "1"
+then
 	AC_DEFINE(CONFIG_TDB, 1)
 	TDB_CMT=""
 	TDB_MAN_COMMENT=""
+else
+	TDB_CMT="#"
+	TDB_MAN_COMMENT='.\"'
 fi
-,
-AC_MSG_RESULT([Enabling mmp support by default])
-AC_DEFINE(CONFIG_TDB, 1)
-TDB_CMT=""
-TDB_MAN_COMMENT=""
-)
 AC_SUBST(TDB_CMT)
 AC_SUBST(TDB_MAN_COMMENT)
 dnl
-- 
2.39.0

