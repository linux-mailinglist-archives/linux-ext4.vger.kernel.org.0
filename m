Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035AA2935E3
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgJTHhp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgJTHhp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Oct 2020 03:37:45 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2D9C061755
        for <linux-ext4@vger.kernel.org>; Tue, 20 Oct 2020 00:37:44 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id i7di230024C55Sk017died; Tue, 20 Oct 2020 09:37:42 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kUmDF-0004Tm-U5; Tue, 20 Oct 2020 09:37:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kUmDF-0007aB-Rh; Tue, 20 Oct 2020 09:37:41 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of selecting it
Date:   Tue, 20 Oct 2020 09:37:40 +0200
Message-Id: <20201020073740.29081-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
user may not want to enable.  Fix this by making the test depend on
EXT4_FS instead.

Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
See also "[PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
instead of selecting it".
https://lore.kernel.org/lkml/20201019113240.11516-1-geert@linux-m68k.org/
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
2.17.1

