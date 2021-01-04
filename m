Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7282E9697
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jan 2021 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhADOCd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jan 2021 09:02:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbhADOCd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 4 Jan 2021 09:02:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB05AAF2C;
        Mon,  4 Jan 2021 14:01:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33B651E07FD; Mon,  4 Jan 2021 15:01:51 +0100 (CET)
Date:   Mon, 4 Jan 2021 15:01:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: discard block reservation on last writable file
 release
Message-ID: <20210104140151.GD4018@quack2.suse.cz>
References: <20210102101805.355106-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102101805.355106-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 02-01-21 18:18:05, Chengguang Xu wrote:
> Currently reserved blocks are discarded on every writable
> file release, it's not efficient for multiple writer case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for the patch. I agree that in principle something like this is
desirable but there's a small catch. i_writecount is also elevated from
vfs_truncate() which does not have inode open. So it can happen that
->release() gets called, sees inode->i_writecount > 1, but never gets
called again (and thus reservation is not properly released). So I prefer
to leave ext2 as is until this gets resolved - especially since ext2 fs
driver isn't really used on any performance sensitive multi-writer
workloads AFAIK (ext4 driver is usually used in such cases).

								Honza

> ---
>  fs/ext2/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 96044f5dbc0e..9a19d8fe7ffd 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -141,7 +141,7 @@ static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
>   */
>  static int ext2_release_file (struct inode * inode, struct file * filp)
>  {
> -	if (filp->f_mode & FMODE_WRITE) {
> +	if (filp->f_mode & FMODE_WRITE && (atomic_read(&inode->i_writecount) == 1)) {
>  		mutex_lock(&EXT2_I(inode)->truncate_mutex);
>  		ext2_discard_reservation(inode);
>  		mutex_unlock(&EXT2_I(inode)->truncate_mutex);
> -- 
> 2.18.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
