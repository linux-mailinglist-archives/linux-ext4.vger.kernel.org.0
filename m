Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704B215F2B
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jul 2020 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgGFTDs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgGFTDs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jul 2020 15:03:48 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3BBC061755;
        Mon,  6 Jul 2020 12:03:48 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7EFABBC07E;
        Mon,  6 Jul 2020 19:03:45 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, corbet@lwn.net,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Ext4
Date:   Mon,  6 Jul 2020 21:03:39 +0200
Message-Id: <20200706190339.20709-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/filesystems/ext4/about.rst | 2 +-
 fs/ext4/Kconfig                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/ext4/about.rst b/Documentation/filesystems/ext4/about.rst
index 0aadba052264..cc76b577d2f4 100644
--- a/Documentation/filesystems/ext4/about.rst
+++ b/Documentation/filesystems/ext4/about.rst
@@ -39,6 +39,6 @@ entry.
 Other References
 ----------------
 
-Also see http://www.nongnu.org/ext2-doc/ for quite a collection of
+Also see https://www.nongnu.org/ext2-doc/ for quite a collection of
 information about ext2/3. Here's another old reference:
 http://wiki.osdev.org/Ext2
diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 1afa5a4bcb5f..619dd35ddd48 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -110,7 +110,7 @@ config EXT4_KUNIT_TESTS
 	  This builds the ext4 KUnit tests.
 
 	  KUnit tests run during boot and output the results to the debug log
-	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
 	  running KUnit test harness and are not for inclusion into a production
 	  build.
 
-- 
2.27.0

