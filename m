Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4E31D202
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 22:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBPVYp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 16:24:45 -0500
Received: from sandeen.net ([63.231.237.45]:45270 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhBPVYp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Feb 2021 16:24:45 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id A162F4872E4;
        Tue, 16 Feb 2021 15:23:55 -0600 (CST)
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
References: <20210212093719.162065-1-lczerner@redhat.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH] mmp: do not use O_DIRECT when working with regular file
Message-ID: <d7fd3943-ac80-6c13-6afe-8ec34f3af5c5@sandeen.net>
Date:   Tue, 16 Feb 2021 15:24:00 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210212093719.162065-1-lczerner@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/12/21 3:37 AM, Lukas Czerner wrote:
> Currently the mmp block is read using O_DIRECT to avoid any caching tha
> may be done by the VM. However when working with regular files this
> creates alignment issues when the device of the host file system has
> sector size smaller than the blocksize of the file system in the file
> we're working with.
> 
> This can be reproduced with t_mmp_fail test when run on the device with
> 4k sector size because the mke2fs fails when trying to read the mmp
> block.
> 
> Fix it by disabling O_DIRECT when working with regular file. I don't
> think there is any risk of doing so since the file system layer, unlike
> shared block device, should guarantee cache consistency.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  lib/ext2fs/mmp.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> index c21ae272..1ac22194 100644
> --- a/lib/ext2fs/mmp.c
> +++ b/lib/ext2fs/mmp.c
> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
>  	 * regardless of how the io_manager is doing reads, to avoid caching of
>  	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
>  	if (fs->mmp_fd <= 0) {
> +		struct stat st;
>  		int flags = O_RDWR | O_DIRECT;
>  
> -retry:
> +		/*
> +		 * There is no reason for using O_DIRECT if we're working with
> +		 * regular file. Disabling it also avoids problems with
> +		 * alignment when the device of the host file system has sector
> +		 * size smaller than blocksize of the fs we're working with.

I think the problem is when the host filesystem that contains the image is on
a device with a logical sector size which is /larger/ than the image filesystem's
block size, right? Not smaller?

Because then you might not be able to do an image-filesystem-block-aligned direct
IO on it, if it's sub-logical-block-size for the host filesystem/device, and lands
within the larger host sector at an offset?

otherwise, this seems at least as reasonable to me as the previous tmpfs work
around, so other than the question about the comment,

Reviewed-by: Eric Sandeen <sandeen@redhat.com>


> +		 */
> +		if (stat(fs->device_name, &st) == 0 &&
> +		    S_ISREG(st.st_mode))
> +			flags &= ~O_DIRECT;
> +
>  		fs->mmp_fd = open(fs->device_name, flags);
>  		if (fs->mmp_fd < 0) {
> -			struct stat st;
> -
> -			/* Avoid O_DIRECT for filesystem image files if open
> -			 * fails, since it breaks when running on tmpfs. */
> -			if (errno == EINVAL && (flags & O_DIRECT) &&
> -			    stat(fs->device_name, &st) == 0 &&
> -			    S_ISREG(st.st_mode)) {
> -				flags &= ~O_DIRECT;
> -				goto retry;
> -			}
>  			retval = EXT2_ET_MMP_OPEN_DIRECT;
>  			goto out;
>  		}
> 
