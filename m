Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624771FFC1A
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 21:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgFRT6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 15:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbgFRT6v (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 18 Jun 2020 15:58:51 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A2D20890;
        Thu, 18 Jun 2020 19:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592510330;
        bh=dSy3+3MsJtnQCrUsIwwOwY3jSdccZWKXyDHHQVRMuh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z1u4g0KEqnRmBd+xd6z5SjF2uSDu/BS0hojj4vVYYigVXXpj6HE5C4HSWl0f/+fjM
         YZog0PcY8XNGQHvuwODS93zDUkVET1AMaMtJ1PjpD4sALqCpl71vhTBXDYNWDAQCoc
         EAtJhG+IcZ+pnw+OQuW8/oqitjWl1eZ6Mt6jC5bg=
Date:   Thu, 18 Jun 2020 12:58:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] ext2fs: fix to avoid invalid memory access
Message-ID: <20200618195849.GE2957@sol.localdomain>
References: <1592493363-24778-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592493363-24778-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 19, 2020 at 12:16:03AM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Valgrind reported error messages like following:
> 
> ==129205==  Address 0x1b804b04 is 4 bytes after a block of size 4,096 alloc'd
> ==129205==    at 0x483980B: malloc (vg_replace_malloc.c:307)
> ==129205==    by 0x44F973: ext2fs_get_mem (ext2fs.h:1846)
> ==129205==    by 0x44F973: ext2fs_get_pathname (get_pathname.c:162)
> ==129205==    by 0x430917: print_pathname (message.c:212)
> ==129205==    by 0x430FB1: expand_percent_expression (message.c:462)
> ==129205==    by 0x430FB1: print_e2fsck_message (message.c:544)
> ==129205==    by 0x430BED: expand_at_expression (message.c:262)
> ==129205==    by 0x430BED: print_e2fsck_message (message.c:528)
> ==129205==    by 0x430450: fix_problem (problem.c:2494)
> ==129205==    by 0x423F8B: e2fsck_process_bad_inode (pass2.c:1929)
> ==129205==    by 0x425AE8: check_dir_block (pass2.c:1407)
> ==129205==    by 0x426942: check_dir_block2 (pass2.c:961)
> ==129205==    by 0x445736: ext2fs_dblist_iterate3.part.0 (dblist.c:254)
> ==129205==    by 0x423835: e2fsck_pass2 (pass2.c:187)
> ==129205==    by 0x414B19: e2fsck_run (e2fsck.c:257)
> 
> Dir block might be corrupted and cause the next dirent is out
> of block size boundary, even though we have the check to avoid
> problem, memory check tools like valgrind still complains it.
> 
> Patch try to fix the problem by checking if offset exceed max
> offset firstly before getting the pointer.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  lib/ext2fs/csum.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
> index c2550365..643777fd 100644
> --- a/lib/ext2fs/csum.c
> +++ b/lib/ext2fs/csum.c
> @@ -260,22 +260,24 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
>  	void *top;
>  	struct ext2_dir_entry_tail *t;
>  	unsigned int rec_len;
> +	unsigned int max_len;
>  	errcode_t retval = 0;
>  	__u16 (*translate)(__u16) = (need_swab ? disk_to_host16 : do_nothing16);
>  
>  	d = dirent;
>  	top = EXT2_DIRENT_TAIL(dirent, fs->blocksize);
>  
> +	max_len = (char *)top - (char *)dirent;
>  	rec_len = translate(d->rec_len);
>  	while ((void *) d < top) {
>  		if ((rec_len < 8) || (rec_len & 0x03))
>  			return EXT2_ET_DIR_CORRUPTED;
> +		if ((char *)d - (char *)dirent + rec_len > max_len)
> +			return EXT2_ET_DIR_CORRUPTED;
>  		d = (struct ext2_dir_entry *)(((char *)d) + rec_len);
>  		rec_len = translate(d->rec_len);
>  	}
>  
> -	if ((char *)d > ((char *)dirent + fs->blocksize))
> -			return EXT2_ET_DIR_CORRUPTED;
>  	if (d != top)
>  		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;

This looks buggy.  Previously this returned EXT2_ET_DIR_NO_SPACE_FOR_CSUM if the
last dirent extends beyond where the metadata checksum entry is supposed to
begin, but doesn't exceed fs->blocksize.  But your change makes it return
EXT2_ET_DIR_CORRUPTED in that case, which is potentially a regression.

How about:

diff --git a/lib/ext2fs/csum.c b/lib/ext2fs/csum.c
index 54b53a3c..0dbb4963 100644
--- a/lib/ext2fs/csum.c
+++ b/lib/ext2fs/csum.c
@@ -266,16 +266,14 @@ static errcode_t __get_dirent_tail(ext2_filsys fs,
 	d = dirent;
 	top = EXT2_DIRENT_TAIL(dirent, fs->blocksize);
 
-	rec_len = translate(d->rec_len);
 	while ((void *) d < top) {
-		if ((rec_len < 8) || (rec_len & 0x03))
+		rec_len = translate(d->rec_len);
+		if ((rec_len < 8) || (rec_len & 0x03) ||
+		    (rec_len > (char *)dirent + fs->blocksize - (char *)d))
 			return EXT2_ET_DIR_CORRUPTED;
 		d = (struct ext2_dir_entry *)(((char *)d) + rec_len);
-		rec_len = translate(d->rec_len);
 	}
 
-	if ((char *)d > ((char *)dirent + fs->blocksize))
-			return EXT2_ET_DIR_CORRUPTED;
 	if (d != top)
 		return EXT2_ET_DIR_NO_SPACE_FOR_CSUM;
 
