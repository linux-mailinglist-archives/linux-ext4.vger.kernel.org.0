Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8131419B796
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 23:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgDAV3J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 17:29:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40657 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732527AbgDAV3J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 17:29:09 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 031LSxHP027325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Apr 2020 17:29:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D1AB420EBA; Wed,  1 Apr 2020 17:28:59 -0400 (EDT)
Date:   Wed, 1 Apr 2020 17:28:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: Fix build error while CONFIG_PRINTK is n
Message-ID: <20200401212859.GN768293@mit.edu>
References: <20200401073038.33076-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401073038.33076-1-yuehaibing@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 03:30:38PM +0800, YueHaibing wrote:
> fs/ext4/balloc.c: In function ‘ext4_wait_block_bitmap’:
> fs/ext4/balloc.c:519:3: error: implicit declaration of function ‘ext4_error_err’; did you mean ‘ext4_error’? [-Werror=implicit-function-declaration]
>    ext4_error_err(sb, EIO, "Cannot read block bitmap - "
>    ^~~~~~~~~~~~~~
> 
> Add missing stub helper and fix ext4_abort.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks; the patch isn't quite correct, though.  This is what I merged
into my tree's version of the "save all error info..." commit.

     	       	       	      	    	      - Ted

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index eacd2f9cc833..91eb4381cae5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2848,6 +2848,11 @@ do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
 	__ext4_error_inode(inode, "", 0, block, 0, " ");		\
 } while (0)
+#define ext4_error_inode_err(inode, func, line, block, err, fmt, ...)	\
+do {									\
+	no_printk(fmt, ##__VA_ARGS__);					\
+	__ext4_error_inode(inode, "", 0, block, err, " ");		\
+} while (0)
 #define ext4_error_file(file, func, line, block, fmt, ...)		\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
@@ -2858,10 +2863,15 @@ do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
 	__ext4_error(sb, "", 0, 0, 0, " ");				\
 } while (0)
-#define ext4_abort(sb, fmt, ...)					\
+#define ext4_error_err(sb, err, fmt, ...)				\
+do {									\
+	no_printk(fmt, ##__VA_ARGS__);					\
+	__ext4_error(sb, "", 0, err, 0, " ");				\
+} while (0)
+#define ext4_abort(sb, err, fmt, ...)					\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_abort(sb, "", 0, " ");					\
+	__ext4_abort(sb, "", 0, err, " ");				\
 } while (0)
 #define ext4_warning(sb, fmt, ...)					\
 do {									\
