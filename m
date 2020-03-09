Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F047217E77A
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 19:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCISso (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 14:48:44 -0400
Received: from gateway36.websitewelcome.com ([192.185.196.23]:31791 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbgCISso (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 14:48:44 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 14:48:43 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 2E150400CA8C6
        for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2020 12:17:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BMiYjQrX9RP4zBMiYjnLza; Mon, 09 Mar 2020 13:01:30 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SVIZ6aSCvoUYSnrHD4goqt9sqbglq/pYjhmAtIcFfaQ=; b=WkO42XKTXRVsEmWdlFbqQyrgSR
        UrfmbY32ut+eoh2k7q/LHBEWv9GlZ0qZ8W4hJLgZLXXKqTCrTW4Ld91Eij0kLASucsseUKc1mg5qg
        /8sp2IndDgYPBMrTy9CVA8Jqsxb5vOHp5guQ5tXce6GOAiwVphWX0hpGTP8hotE7fbNtAMIuQFb4B
        eQTWo6M5J5QMYQqn2BLmnPJzXxHcus2oY2TBZDX6/aBLBZmet3IvsUMIUWlpCqXTwEHhWfgVrIuRq
        gyCPBmpI/ei2f3SRT2sKAxD2zCF6TERTIlL6TpqlF4CFmgvvQI+gnBsSUC/tvLcVcblMBf6jCP4/X
        wUR/yjvw==;
Received: from [201.162.240.150] (port=16235 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBMiW-004BFk-Dm; Mon, 09 Mar 2020 13:01:28 -0500
Date:   Mon, 9 Mar 2020 13:04:41 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ext2: xattr.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309180441.GA2992@embeddedor>
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
X-Source-IP: 201.162.240.150
X-Source-L: No
X-Exim-ID: 1jBMiW-004BFk-Dm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:16235
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
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
 fs/ext2/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.h b/fs/ext2/xattr.h
index cee888cdc235..16272e6ddcf4 100644
--- a/fs/ext2/xattr.h
+++ b/fs/ext2/xattr.h
@@ -39,7 +39,7 @@ struct ext2_xattr_entry {
 	__le32	e_value_block;	/* disk block attribute is stored on (n/i) */
 	__le32	e_value_size;	/* size of attribute value */
 	__le32	e_hash;		/* hash value of name and value */
-	char	e_name[0];	/* attribute name */
+	char	e_name[];	/* attribute name */
 };
 
 #define EXT2_XATTR_PAD_BITS		2
-- 
2.25.0

