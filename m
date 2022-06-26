Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFE55B2DE
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jun 2022 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiFZQkf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jun 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFZQke (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jun 2022 12:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567F9594
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jun 2022 09:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1A260B50
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jun 2022 16:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CF1C34114;
        Sun, 26 Jun 2022 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261632;
        bh=V9Svx3ReGMWFL0Xk6mqT9SYn/lKp+AKIxer1JwRQenU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JBZXdMSqwFjPnB4OMLMNUse7OrKq2fqiChq+cnSoMSZIfAXxtQC5eZDxLeSJ2CjnI
         WkcJgyyM6IaGlPB5/gH3AShVCy+miYNUTbe6vfuVDk/8GDa8L0z3GOfwdUElc5gX+Q
         e6jYgCteGO3WsB7tOKan06aUxVEifDHOxdR7tsngfHNx6e/3ZmVCMs+2rcIkmNkkZc
         U0v5mDk/Td7mYYNjUzI36smJnITZKWObE8a8aI/Hcm+ofKAtOvUyQYnfhm8AvmuJA+
         qZeeutG+sTmkNLPd9L/hWGtOnhv3u9OLY1DLgZy9uIk0F04D6BIhue3z2+5loMN2Vn
         u0B02XqnxFQzw==
Date:   Sun, 26 Jun 2022 09:40:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeremy Bongio <bongiojp@gmail.com>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] Add ioctls to get/set the ext4 superblock uuid.
Message-ID: <YriL/2ixE6fsdkpP@magnolia>
References: <20220625082225.103574-1-bongiojp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625082225.103574-1-bongiojp@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 25, 2022 at 01:22:25AM -0700, Jeremy Bongio wrote:
> This fixes a race between changing the ext4 superblock uuid and operations
> like mounting, resizing, changing features, etc.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>

This is a userspace abi change; it really should cc linux-fsdevel and
linux-api.

> ---
>  fs/ext4/ext4.h  | 10 ++++++
>  fs/ext4/ioctl.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 75b8d81b2469..00747532cc4a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -724,6 +724,8 @@ enum {
>  #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
>  #define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
>  #define EXT4_IOC_CHECKPOINT		_IOW('f', 43, __u32)
> +#define EXT4_IOC_GETFSUUID		_IOR('f', 44, struct fsuuid)
> +#define EXT4_IOC_SETFSUUID		_IOW('f', 45, struct fsuuid)

One thing I've noticed people rarely do with a get/set ioctl pair -- the
_IOR and _IOW macros encode the direction (R/W) in the ioctl number,
which means that you don't need to use both 44 and 45 here.  We get 8
bits of namespace ('f') and 8 bits of call number (44), and while
they're generally not in /that/ short supply, a u16 will eventually fill
up.

If you want to be paranoid, you could also encode a BUILD_BUG_ON to
check that they're not the same.

>  
>  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
>  
> @@ -753,6 +755,14 @@ enum {
>  						EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
>  						EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
>  
> +/*
> + * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
> + */
> +struct fsuuid {
> +	size_t len;

size_t... is a mess for userspace ABI.  If the kernel is running in a
multiarch environment (e.g. i386 program running on x64 kernel) then
you'll have to make sure that the field length is what you think it is.
Given the current typedef hell w.r.t. size_t, I suggest making life
easier on the reviewers and making @len explicitly sized.

Also, please put in a @flags argument just in case someone someday needs
to add some.

> +	__u8 __user *b;

Putting a pointer in an ioctl struct argument is a /very/ bad idea,
because doing so (a) makes it harder for things like seccomp to inspect
arguments, and (b) usually means you have to implement a bunch of fugly
compat ioctl thunking code for multiarch systems (e.g. i386 program
running on x64 kernel) to extract the pointer and convert it to a native
pointer.

You /could/ avoid both of these problems by requiring that the uuid data
be stored in an unsized VLA at the end of the struct:

	struct fsuuid {
		__u32	fu_len;
		__u32	fu_flags;

		__u8	fu_uuid[];
	};

Then your set uuid validation code looks like this:

	int ret = 0;
	__u8 uuid[UUID_SIZE];
	struct fsuuid fsuuid;

	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
		return -EFAULT;

	if (fsuuid.fu_flags || fsuuid.fu_len != UUID_SIZE)
		return -EINVAL;

	if (copy_from_user(uuid, &fsuuid.fu_uuid[0], UUID_SIZE))
		return -EFAULT;

	/* actually set uuid... */

--D

> +};
> +
>  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
>  /*
>   * ioctl commands in 32 bit emulation
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index cb01c1da0f9d..a47e24fc8c67 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -20,6 +20,7 @@
>  #include <linux/delay.h>
>  #include <linux/iversion.h>
>  #include <linux/fileattr.h>
> +#include <linux/uuid.h>
>  #include "ext4_jbd2.h"
>  #include "ext4.h"
>  #include <linux/fsmap.h>
> @@ -41,6 +42,15 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
>  	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
>  }
>  
> +/*
> + * Superblock modification callback function for changing file system
> + * UUID.
> + */
> +static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
> +{
> +	memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
> +}
> +
>  static
>  int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
>  			   ext4_update_sb_callback func,
> @@ -1131,6 +1141,74 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
>  	return 0;
>  }
>  
> +static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
> +			struct fsuuid __user *ufsuuid)
> +{
> +	int ret = 0;
> +	__u8 uuid[UUID_SIZE];
> +	struct fsuuid fsuuid;
> +
> +	/* read uuid from userspace*/
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;
> +
> +	/* If invalid, return EINVAL */
> +	if (fsuuid.len != UUID_SIZE)
> +		return -EINVAL;
> +
> +
> +	lock_buffer(sbi->s_sbh);
> +	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
> +	unlock_buffer(sbi->s_sbh);
> +
> +	if (copy_to_user(fsuuid.b, uuid, UUID_SIZE))
> +		ret = -EFAULT;
> +
> +	return ret;
> +}
> +
> +static int ext4_ioctl_setuuid(struct file *filp,
> +			const struct fsuuid __user *ufsuuid)
> +{
> +	int ret = 0;
> +	struct super_block *sb = file_inode(filp)->i_sb;
> +	struct fsuuid fsuuid;
> +	__u8 uuid[UUID_SIZE];
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	/*
> +	 * If any checksums (group descriptors or metadata) are being used
> +	 * then the checksum seed feature is required to change the UUID.
> +	 */
> +	if (((ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb))
> +			&& !ext4_has_feature_csum_seed(sb))
> +		|| ext4_has_feature_stable_inodes(sb))
> +		return -EOPNOTSUPP;
> +
> +	/* Read the length uuid and userspace pointer to uuid from userspace. */
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;
> +
> +	/* If invalid, return EINVAL */
> +	if (fsuuid.len != UUID_SIZE)
> +		return -EINVAL;
> +
> +	/* Read uuid from userspace*/
> +	if (copy_from_user(uuid, fsuuid.b, UUID_SIZE))
> +		return -EFAULT;
> +
> +	ret = mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
> +	mnt_drop_write_file(filp);
> +
> +	return ret;
> +}
> +
>  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -1509,6 +1587,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return ext4_ioctl_setlabel(filp,
>  					   (const void __user *)arg);
>  
> +	case EXT4_IOC_GETFSUUID:
> +		return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
> +	case EXT4_IOC_SETFSUUID:
> +		return ext4_ioctl_setuuid(filp, (const void __user *)arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -1586,6 +1668,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case EXT4_IOC_CHECKPOINT:
>  	case FS_IOC_GETFSLABEL:
>  	case FS_IOC_SETFSLABEL:
> +	case EXT4_IOC_GETFSUUID:
> +	case EXT4_IOC_SETFSUUID:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
