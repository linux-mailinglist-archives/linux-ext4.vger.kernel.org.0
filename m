Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCD1AD80
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfELR0b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 May 2019 13:26:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52154 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726478AbfELR0b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 May 2019 13:26:31 -0400
Received: from callcc.thunk.org ([91.207.175.60])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4CHQOQV025911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 May 2019 13:26:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 21DCE420024; Sun, 12 May 2019 13:26:23 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] unicode: update to Unicode 12.1.0 final
Date:   Sun, 12 May 2019 13:26:20 -0400
Message-Id: <20190512172620.10462-1-tytso@mit.edu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/unicode/README.utf8data | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/fs/unicode/README.utf8data b/fs/unicode/README.utf8data
index 9307cf0727de..c73786807d3b 100644
--- a/fs/unicode/README.utf8data
+++ b/fs/unicode/README.utf8data
@@ -5,29 +5,15 @@ The full set of files can be found here:
 
   http://www.unicode.org/Public/12.1.0/ucd/
 
-Note!
-
-The URL's listed below are not stable.  That's because Unicode 12.1.0
-has not been officially released yet; it is scheduled to be released
-on May 8, 2019.  We taking Unicode 12.1.0 a few weeks early because it
-contains a new Japanese character which is required in order to
-specify Japenese dates after May 1, 2019, when Crown Prince Naruhito
-ascends to the Chrysanthemum Throne.  (Isn't internationalization fun?
-The abdication of Emperor Akihito of Japan is requiring dozens of
-software packages to be updated with only a month's notice.  :-)
-
-We will update the URL's (and any needed changes to the checksums)
-after the final Unicode 12.1.0 is released.
-
 Individual source links:
 
-  https://www.unicode.org/Public/12.1.0/ucd/CaseFolding-12.1.0d2.txt
-  https://www.unicode.org/Public/12.1.0/ucd/DerivedAge-12.1.0d3.txt
-  https://www.unicode.org/Public/12.1.0/ucd/extracted/DerivedCombiningClass-12.1.0d2.txt
-  https://www.unicode.org/Public/12.1.0/ucd/DerivedCoreProperties-12.1.0d2.txt
-  https://www.unicode.org/Public/12.1.0/ucd/NormalizationCorrections-12.1.0d1.txt
-  https://www.unicode.org/Public/12.1.0/ucd/NormalizationTest-12.1.0d3.txt
-  https://www.unicode.org/Public/12.1.0/ucd/UnicodeData-12.1.0d2.txt
+  https://www.unicode.org/Public/12.1.0/ucd/CaseFolding.txt
+  https://www.unicode.org/Public/12.1.0/ucd/DerivedAge.txt
+  https://www.unicode.org/Public/12.1.0/ucd/extracted/DerivedCombiningClass.txt
+  https://www.unicode.org/Public/12.1.0/ucd/DerivedCoreProperties.txt
+  https://www.unicode.org/Public/12.1.0/ucd/NormalizationCorrections.txt
+  https://www.unicode.org/Public/12.1.0/ucd/NormalizationTest.txt
+  https://www.unicode.org/Public/12.1.0/ucd/UnicodeData.txt
 
 md5sums (verify by running "md5sum -c README.utf8data"):
 
-- 
2.19.1

