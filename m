Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08E517E790
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 19:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCISx0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 14:53:26 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.109]:20487 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbgCISxZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 14:53:25 -0400
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 14:53:24 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 7EBDB937A
        for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2020 13:05:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BMm1jL3Ov8vkBBMm1jDv4i; Mon, 09 Mar 2020 13:05:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M/+spNsZHyAg8E48D01jPchiqr2VpON3QaUIuLiE4zI=; b=nM5LyMf+ug8N0+yKKxSEt0RQFL
        yXvC+Ggrf0AssBa4PKtsX5zlzfSmlVZWeGIRVws/AdO6jkACKRjzCYJaVYgtdnYcWrCIMAep9T8X/
        Fiqi4MBuKb3qgZuWMBUcT5ithvxtb5qt05qjwyM1sgwG5VhHYlllU1o2IRGeHh3kJKxrDPpuqWp9K
        lMRbNu4U059rr9yvP7gmuEtOKqrbZi4afar1Mpk1Xi/vUPJIlH2DH8FX1QNqXsh17b/LweyBXF3ar
        A081rcBuXV5DOte4jBE5L9iTIh7yZHMzskJiPNaye9VCR8CXAp3WQC32lmpnWuTrj+BpCOXEB+yoM
        UtHGmRAw==;
Received: from [201.162.240.150] (port=3342 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBMlw-004D0Z-Ry; Mon, 09 Mar 2020 13:05:01 -0500
Date:   Mon, 9 Mar 2020 13:08:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] ext4: xattr.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309180813.GA3347@embeddedor>
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
X-Exim-ID: 1jBMlw-004D0Z-Ry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.240.150]:3342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
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
 fs/ext4/xattr.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index f39cad2abe2a..ffe21ac77f78 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -48,7 +48,7 @@ struct ext4_xattr_entry {
 	__le32	e_value_inum;	/* inode in which the value is stored */
 	__le32	e_value_size;	/* size of attribute value */
 	__le32	e_hash;		/* hash value of name and value */
-	char	e_name[0];	/* attribute name */
+	char	e_name[];	/* attribute name */
 };
 
 #define EXT4_XATTR_PAD_BITS		2
@@ -118,7 +118,7 @@ struct ext4_xattr_ibody_find {
 
 struct ext4_xattr_inode_array {
 	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[0];
+	struct inode *inodes[];
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.25.0

