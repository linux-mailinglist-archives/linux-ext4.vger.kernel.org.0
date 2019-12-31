Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71AC12D560
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 01:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfLaA5W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 19:57:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50285 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727766AbfLaA5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 19:57:22 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV0vEbK004740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 19:57:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89E2B420485; Mon, 30 Dec 2019 19:57:13 -0500 (EST)
Date:   Mon, 30 Dec 2019 19:57:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca, lixi@ddn.com,
        wshilong@ddn.com
Subject: Re: [PATCH 2/2] e2fsck: fix use after free in calculate_tree()
Message-ID: <20191231005713.GA3669@mit.edu>
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
 <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Here is the version which I plan to use in e2fsprogs's maint branch.

     	    	    	    	 - Ted

commit aacc234471a9a0ab6d8d6f610a0e4996e9bfc785
Author: Wang Shilong <wshilong@ddn.com>
Date:   Mon Dec 30 19:52:39 2019 -0500

    e2fsck: fix use after free in calculate_tree()
    
    The problem is alloc_blocks() will call get_next_block() which might
    reallocate outdir->buf, and memory address could be changed after
    this.  To fix this, pointers that point into outdir->buf, such as
    int_limit and root need to be recaulated based on the new starting
    address of outdir->buf.
    
    [ Changed to correctly recalculate int_limit, and to optimize how we
      reallocate outdir->buf.  -TYT ]
    
    Signed-off-by: Wang Shilong <wshilong@ddn.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 392cfe9f..54bc6803 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -301,7 +301,11 @@ static errcode_t get_next_block(ext2_filsys fs, struct out_dir *outdir,
 	errcode_t	retval;
 
 	if (outdir->num >= outdir->max) {
-		retval = alloc_size_dir(fs, outdir, outdir->max + 50);
+		int increment = outdir->max / 10;
+
+		if (increment < 50)
+			increment = 50;
+		retval = alloc_size_dir(fs, outdir, outdir->max + increment);
 		if (retval)
 			return retval;
 	}
@@ -645,6 +649,9 @@ static int alloc_blocks(ext2_filsys fs,
 	if (retval)
 		return retval;
 
+	/* outdir->buf might be reallocated */
+	*prev_ent = (struct ext2_dx_entry *) (outdir->buf + *prev_offset);
+
 	*next_ent = set_int_node(fs, block_start);
 	*limit = (struct ext2_dx_countlimit *)(*next_ent);
 	if (next_offset)
@@ -734,6 +741,9 @@ static errcode_t calculate_tree(ext2_filsys fs,
 					return retval;
 			}
 			if (c3 == 0) {
+				int delta1 = (char *)int_limit - outdir->buf;
+				int delta2 = (char *)root - outdir->buf;
+
 				retval = alloc_blocks(fs, &limit, &int_ent,
 						      &dx_ent, &int_offset,
 						      NULL, outdir, i, &c2,
@@ -741,6 +751,11 @@ static errcode_t calculate_tree(ext2_filsys fs,
 				if (retval)
 					return retval;
 
+				/* outdir->buf might be reallocated */
+				int_limit = (struct ext2_dx_countlimit *)
+					(outdir->buf + delta1);
+				root = (struct ext2_dx_entry *)
+					(outdir->buf + delta2);
 			}
 			dx_ent->block = ext2fs_cpu_to_le32(i);
 			if (c3 != limit->limit)

