Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6949815C82F
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 17:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgBMQZI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 11:25:08 -0500
Received: from gateway20.websitewelcome.com ([192.185.50.28]:47082 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgBMQZH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 11:25:07 -0500
X-Greylist: delayed 1254 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 11:25:07 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 506B9400D0583
        for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2020 08:50:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 2GyKjLuLNRP4z2GyKjnN52; Thu, 13 Feb 2020 10:04:12 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZL5WVuzgrAtBBzwYaaIVNCF0hyg528WYef2HDaMl400=; b=uhGOQ/8CfRje+NLyrIz/IEHO1s
        H4I2Fhqely8byoKM5cbN5oPiunktLDbhqhaqjXmjbfLepEic3CtFPQ7lt3UBrfVurigiOCfxru7EM
        kQdrnYcQXrvYP1Jx2V0YLSOa06raJ6oDpdMLNNafvNvicvNICScKIB69MYCNjI2B+q4fcA7s+kvho
        152CvPjpLXE3tmD9EFsM8PW2ZM2JET2+HS25Xe3XnOm5H1PChdWRcianqZZBJc9Buu3iF3X52tC2E
        w34Hh4w3xXc76YlvAxpfaOhquqdk8EWMM6AObf5f5V7z4iDZLN95EkJYh07ddxirO9O05eUmwV1Lp
        nXrkNP6g==;
Received: from [200.68.140.15] (port=1293 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j2GyJ-003bdU-5e; Thu, 13 Feb 2020 10:04:11 -0600
Date:   Thu, 13 Feb 2020 10:06:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ext4: namei: Replace zero-length array with flexible-array
 member
Message-ID: <20200213160648.GA7054@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.15
X-Source-L: No
X-Exim-ID: 1j2GyJ-003bdU-5e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.15]:1293
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ext4/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129d2ebae00d..77c327d904bf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -233,13 +233,13 @@ struct dx_root
 		u8 unused_flags;
 	}
 	info;
-	struct dx_entry	entries[0];
+	struct dx_entry	entries[];
 };
 
 struct dx_node
 {
 	struct fake_dirent fake;
-	struct dx_entry	entries[0];
+	struct dx_entry	entries[];
 };
 
 
-- 
2.25.0

