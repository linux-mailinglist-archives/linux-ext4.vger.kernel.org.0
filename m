Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2463A37FF96
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhEMVGe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 17:06:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35257 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233247AbhEMVGd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 May 2021 17:06:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14DL5Kp2004827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 17:05:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A0D3D15C3C45; Thu, 13 May 2021 17:05:20 -0400 (EDT)
Date:   Thu, 13 May 2021 17:05:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
Message-ID: <YJ2UkN2GRVAeAM1G@mit.edu>
References: <20210511180428.3358267-1-leah.rumancik@gmail.com>
 <20210511180428.3358267-2-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511180428.3358267-2-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 11, 2021 at 06:04:27PM +0000, Leah Rumancik wrote:
> +static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
> +{
> +	int err = 0;
> +	unsigned long long flags = 0;
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +
> +	if (copy_from_user(&flags, (__u64 __user *)arg,
> +				sizeof(__u64)))
> +		return -EFAULT;
> +
> +	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
> +		return 0;

We should document exactly what "Dry run" means.  Right now, it looks
like it's used so we can tell whether the ioctl is support at all.  It
might be better to do all of the checks first, so that if
EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN is set, and the ioctl returns
success, we know that all of the ioctl would succeed.  This would
allow us to use DRY_RUN to check to see if a future flag bit is supported.

> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	/* file argument is not the mount point */
> +	if (file_dentry(filp) != sb->s_root)
> +		return -EINVAL;

I'm not sure we need to require that EXT4_IOC_CHECKPOINT has to be
called with the mount point, especially given that only process with
root privs will be allowed to call the ioctl.  SoI'd suggest removing
the check above, and allowing a file descriptor opened on any file or
directory on the file system to be sufficient to trigger the ioctl.

> +	/* filesystem is not backed by block device */
> +	if (sb->s_bdev == NULL)
> +		return -ENODEV;

This should never be the case for ext4....

> +
> +	/* check for invalid bits set */
> +	if (flags & ~(EXT4_IOC_CHECKPOINT_FLAG_DISCARD |
> +				EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT))
> +		return -EINVAL;
> +
> +	/* both discard and zeroout cannot be set */
> +	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DISCARD &
> +				EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT)
> +		return -EINVAL;

This check isn't correct; see a similar comment that I made on patch
#1 of this series.

> +
> +	if (flags & EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT)
> +		pr_info_ratelimited("warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow");
> +
> +	if (!EXT4_SB(sb)->s_journal)
> +		return -ENODEV;

So this is where I would actually move the DRY_RUN flag check (and
then I'd move the pr_info_ratelimited check after the DRY_RUN check).

Cheers,

						- Ted
