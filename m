Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391B611469E
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2019 19:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfLESKu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Dec 2019 13:10:50 -0500
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:59453 "EHLO
        cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLESKu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Dec 2019 13:10:50 -0500
X-Greylist: delayed 782 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Dec 2019 13:10:48 EST
Received: from cpsps-ews18.kpnxchange.com ([10.94.84.184]) by cpsmtpb-ews04.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 5 Dec 2019 18:57:44 +0100
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e1=10;e3=10;e2=11;e4=10);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=F4kpiZpN c=1 sm=1 tr=0 cx=a_idp_e
         a=YnLMpE5S06+Zisl5ga1zfg==:117 a=X0PnwcQ2/mKcBfosUKIoXQ==:17
         a=UhJ12kwm0HYA:10 a=pxVhFHJ0LMsA:10 a=hp87a6Tc9CnFrHl3gmsA:9
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.46]) by cpsps-ews18.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 5 Dec 2019 18:57:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=2ct422Lmt5ryCUqmlZ+RK841MNmNnRSb+1vF0uxtwJ4=;
        b=Htj9XuRcokIWpZfBSggKDEhf+C8mmyNVElhw2eYEj31t437pZ6BIcqbcrmZ5lQt2/SvHgul7OQTWo
         uZIUpyrU+C6UfsO1JTEAW3nRzX4DNVW2s2a7fg/TH0Hg4WlEhpW7XcxrCyL83JrdFxrlAffGsktrVh
         il1Z/72ttsU0JDQw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|k69kBFYvrR34wxH221K7HKNqdD9SaH5IZqNJRN3cuxf9eMLQoWUef9zztMpDi9D
 5m//u+kWJ4+Loji3YI8Fq4Q==
X-Originating-IP: 77.173.60.12
Received: from localhost (unknown [77.173.60.12])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id b7a70281-1788-11ea-885b-005056ab7584;
        Thu, 05 Dec 2019 18:57:35 +0100 (CET)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] e2image: remove redundant -fr from man page and usage message
Date:   Thu,  5 Dec 2019 18:57:35 +0100
Message-Id: <20191205175735.28054-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Dec 2019 17:57:45.0029 (UTC) FILETIME=[7F3A1F50:01D5AB95]
X-RcptDomain: vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Also, add a missing dash and two missing brackets and two missing
spaces, and remove three excess spaces.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc/e2image.8.in | 7 +++----
 misc/e2image.c    | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/misc/e2image.8.in b/misc/e2image.8.in
index bbbb57ae..ef124867 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -8,10 +8,12 @@ e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
 .SH SYNOPSIS
 .B e2image
 [
-.B \-r|Q
+.B \-r|\-Q
 ]
 [
 .B \-f
+]
+[
 .B \-b
 .I superblock
 ]
@@ -19,9 +21,6 @@ e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
 .B \-B
 .I blocksize
 ]
-[
-.B \-fr
-]
 .I device
 .I image-file
 .br
diff --git a/misc/e2image.c b/misc/e2image.c
index 30f25432..56183ad6 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -104,11 +104,11 @@ static int get_bits_from_size(size_t size)
 
 static void usage(void)
 {
-	fprintf(stderr, _("Usage: %s [ -r|Q ] [ -f ] [ -b superblock ] [ -B blocksize]"
-			  "[ -fr ] device image-file\n"),
+	fprintf(stderr, _("Usage: %s [ -r|-Q ] [ -f ] [ -b superblock ] [ -B blocksize ] "
+			  "device image-file\n"),
 		program_name);
 	fprintf(stderr, _("       %s -I device image-file\n"), program_name);
-	fprintf(stderr, _("       %s -ra  [  -cfnp  ] [ -o src_offset ] "
+	fprintf(stderr, _("       %s -ra [ -cfnp ] [ -o src_offset ] "
 			  "[ -O dest_offset ] src_fs [ dest_fs ]\n"),
 		program_name);
 	exit (1);
-- 
2.24.0

