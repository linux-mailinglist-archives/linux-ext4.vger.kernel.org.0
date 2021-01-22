Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54E300143
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 12:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAVLMT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 06:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbhAVLD1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 06:03:27 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15A3C0613D6
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jan 2021 03:02:39 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id Kn2c240014C55Sk01n2cRg; Fri, 22 Jan 2021 12:02:36 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2uD5-005kge-L9; Fri, 22 Jan 2021 12:02:35 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l2uD5-00Br6K-5O; Fri, 22 Jan 2021 12:02:35 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of selecting it
Date:   Fri, 22 Jan 2021 12:02:34 +0100
Message-Id: <20210122110234.2825685-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
user may not want to enable.  Fix this by making the test depend on
EXT4_FS instead.

Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Discussion after previous submission at
https://lore.kernel.org/linux-ext4/20201020073740.29081-1-geert@linux-m68k.org/
---
 fs/ext4/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 619dd35ddd48a973..86699c8cab281cbc 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,8 +103,7 @@ config EXT4_DEBUG
 
 config EXT4_KUNIT_TESTS
 	tristate "KUnit tests for ext4" if !KUNIT_ALL_TESTS
-	select EXT4_FS
-	depends on KUNIT
+	depends on EXT4_FS && KUNIT
 	default KUNIT_ALL_TESTS
 	help
 	  This builds the ext4 KUnit tests.
-- 
2.25.1

