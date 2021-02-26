Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE023269E5
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 23:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBZWV6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 17:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhBZWVy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Feb 2021 17:21:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5532264EC4;
        Fri, 26 Feb 2021 22:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378068;
        bh=M/OuyHOjC9MzHNaxSVLYAi5rdaxbhm5uZgeZBX2G6Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3t3FNtryc1UhKe1+Jg4VDk5bK0a4sz/j8ZV0Dwr1mngV5ykWhd3zHyxSVBiFcnlb
         25z0XmZMv6MzhyIB4KqyEK02gz9gsn/TW5g+RYE6lJYcDHEbShLDrRW82+2t3YgepL
         Mgf9okJ40C2y6SsVqPIF/cBsgR8zaXaCiW757EEibC8nxSe7QumqXLRExNNCbIRoZf
         Nhn1s8EoJMR2E3NneNVsVlsE879Y0hG5HcOMPxNYvMXXlHKvsACmcxa284SVATJmAv
         stZpCmigY4bwXpXroYD/LQq5M7KXG9THiyFiSsUokO/t19mImZpaQ+SzgKASca/NgC
         /GjP2gg7ZbeVw==
Date:   Fri, 26 Feb 2021 14:21:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] ext4: Add xattr commands to compat ioctl handler
Message-ID: <YDl0UlcgobAHx0v5@gmail.com>
References: <20210226221441.70071-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226221441.70071-1-sarthakkukreti@chromium.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 26, 2021 at 02:14:41PM -0800, Sarthak Kukreti wrote:
> This allows 32-bit userspace utils to use FS_IOC_FSGETXATTR and 
> FS_IOC_FSSETXATTR on a 64-bit kernel.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  fs/ext4/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index f0381876a7e5b..055c26296ab46 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1371,6 +1371,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  			return -EFAULT;
>  		return ext4_ioctl_group_add(file, &input);
>  	}
> +	case EXT4_IOC_FSGETXATTR:
> +	case EXT4_IOC_FSSETXATTR:
>  	case EXT4_IOC_MOVE_EXT:
>  	case EXT4_IOC_RESIZE_FS:
>  	case FITRIM:

These were already added to the list by commit a54d8d34d235
("ext4: Add EXT4_IOC_FSGETXATTR/EXT4_IOC_FSSETXATTR to compat_ioctl").

- Eric
