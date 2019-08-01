Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC157D955
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2019 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfHAK0V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Aug 2019 06:26:21 -0400
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:57445 "EHLO
        cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbfHAK0V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Aug 2019 06:26:21 -0400
X-Greylist: delayed 782 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 06:26:20 EDT
Received: from cpsps-ews07.kpnxchange.com ([10.94.84.174]) by cpsmtpb-ews06.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Thu, 1 Aug 2019 12:13:16 +0200
X-Brand: 7Ljiz6bi2A==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e4=10;e1=10;e3=10;e2=11);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.3 cv=Ts83ewfh c=1 sm=1 tr=0 cx=a_idp_d
         a=dZ5u/0G9QtS9WKCcNUBnHQ==:117 a=dZ5u/0G9QtS9WKCcNUBnHQ==:17
         a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=UhJ12kwm0HYA:10 a=FmdZ9Uzk2mMA:10
         a=r77TgQKjGQsHNAKrUKIA:9 a=M-rc62OlvcSaV9L3cLUA:9
         a=hOO6_UPpzl2U96Ot:21 a=BVo32mUrhiHiCgx8:21 a=QEXdDO2ut3YA:10
         a=NbuKjTMiSAsWWIzmN0sA:9 a=R2cbvPwrlzGk4xld:21 a=C87xB8CrJAm-BvCX:21
         a=B2y7HmGcmWMA:10
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.13]) by cpsps-ews07.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 1 Aug 2019 12:13:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kpnmail.nl; s=kpnmail01;
        h=content-type:mime-version:date:message-id:from:to:subject;
        bh=dERS7ecwKT/KaYdVxeGYsSGm6pOl1HlR5/bPZwv1EsU=;
        b=miL2DKdGUOPTQZ5Q33S3t/LnoyscLDcYeSAPgpr5aA+1ERPoXuCo4kTpY9fKVbdWgE+nYVX/ZGFeY
         8LGP8W8iLlNvoS9nGRyudTyRDc2i0Ol3YR2tanTmTP1zSLbgEl/lUDwaDzvWGB2HQd9mOenSzbdeCM
         b2IDHve6NlO2v+u4=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|chbpyXWllezQk0E0QPssg8Sr7XRtEls4tws9xhhyIlRwd0rZuJ0cx6W7wl1RJD4
 iRcwKkRRDhe752m7T9avpGg==
X-Originating-IP: 77.173.60.12
Received: from [192.168.1.37] (unknown [77.173.60.12])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id f8f6df0e-b444-11e9-aa6d-005056998788;
        Thu, 01 Aug 2019 12:13:14 +0200 (CEST)
Subject: Re: [PATCH] po: remove unnecessary/buggy positional parameter
 specifiers
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
References: <20190713165752.7820-1-tytso@mit.edu>
From:   Benno Schulenberg <coordinator@translationproject.org>
Openpgp: preference=signencrypt
Message-ID: <366cbf75-891e-a799-ea4a-f67f935cfdd4@translationproject.org>
Date:   Thu, 1 Aug 2019 12:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190713165752.7820-1-tytso@mit.edu>
Content-Type: multipart/mixed;
 boundary="------------782203746864B24412C31F2B"
Content-Language: en-US
X-OriginalArrivalTime: 01 Aug 2019 10:13:16.0927 (UTC) FILETIME=[BC7EB8F0:01D54851]
X-RcptDomain: vger.kernel.org
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------782203746864B24412C31F2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


Op 13-07-19 om 18:57 schreef Theodore Ts'o:
> The strings in e2fsck/problem.c use a special %-expansion scheme,
> where %b gets expanded to a block number, %i gets expanded to an inode
> number, etc., where these values are in a problem context data
> structure.  As such, there is no need to use a printf style positional
> indicator (e.g., %2$s).  Indeed, the use of things like %1$i or %2$b
> will cause the %-expansion code to just print %1$i or %2$b, instead of
> the inode or block number, respectively.
> 
> Addresses-Debian-Bug: #892173

The proposed corrections have been applied by the translators to the Czech,
Dutch and German PO files, and manually by myself to the Vietnamese PO file .

Attached is a small patch to remove a superfluous no-c-format tag.

Benno

--------------782203746864B24412C31F2B
Content-Type: text/x-patch;
 name="0001-e2fsck-remove-an-ineffective-because-trailing-xgette.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-e2fsck-remove-an-ineffective-because-trailing-xgette.pa";
 filename*1="tch"

From eaf3e708719d60942cfadfb64c8f73e8bb54a2a5 Mon Sep 17 00:00:00 2001
From: Benno Schulenberg <bensberg@telfort.nl>
Date: Thu, 1 Aug 2019 12:03:31 +0200
Subject: [PATCH] e2fsck: remove an ineffective (because trailing)
 xgettext:no-c-format tag

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 e2fsck/problem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index c45c6b78..5971a503 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -705,7 +705,7 @@ static struct e2fsck_problem problem_table[] = {
 	/* Relocating group number's information to X */
 	{ PR_1_RELOC_TO,
 	  /* xgettext:no-c-format */
-	  N_("Relocating @g %g's %s to %c...\n"), /* xgettext:no-c-format */
+	  N_("Relocating @g %g's %s to %c...\n"),
 	  PROMPT_NONE, PR_PREEN_OK, 0, 0, 0 },
 
 	/* Warning: could not read block number of relocation process */
-- 
2.22.0


--------------782203746864B24412C31F2B--
