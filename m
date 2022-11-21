Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0450B632BB8
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 19:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKUSGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 13:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKUSGB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 13:06:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FC60342;
        Mon, 21 Nov 2022 10:06:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8507F613DC;
        Mon, 21 Nov 2022 18:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF042C433D7;
        Mon, 21 Nov 2022 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669053959;
        bh=KcGeGgzdL/p3lg4gYpR7RzGwN+Oh/2fke6kb0RNFCo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fbjpmu0apb0B/gPVUQF/BOfrLTJh+BJHKq6ndxkoFyDbK5Dw0dtFpZ1RM7AWSl1jz
         OCCyuxnfS0wVLHqi5cUWvlaeNAO/457k8CArDDbq5TSlOkm3Rf8PQRSdcck+qhLJ7c
         qxWDuxG4vj9omLs7ES137q4KZfqmkBTHulCyz4OnbjyBUISyn9Pxyu1rMfYqR4rWur
         UfIY379UtRM3RrjaQOWcyahoT0UDJftQM8nx0IQZrM8uSK7PtnxYkoVegfuWxwgsId
         qLV6HsHNqeEaP2dtD5GDROTV9qxtgRX3E5KwRTtLMJs5A4/4ZOaJlvVi/hmoWNZVPc
         QJVPdWzbbMA8A==
Date:   Mon, 21 Nov 2022 10:05:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: add FS_IOC_GETFSUUID ioctl
Message-ID: <Y3u+ByGRghPOnyVM@magnolia>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
 <20221118211408.72796-3-catherine.hoang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118211408.72796-3-catherine.hoang@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 18, 2022 at 01:14:08PM -0800, Catherine Hoang wrote:
> Add a new ioctl to retrieve the UUID of a mounted xfs filesystem. This is a
> precursor to adding the SETFSUUID ioctl.
> 
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 1f783e979629..cf77715afe9e 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1865,6 +1865,39 @@ xfs_fs_eofblocks_from_user(
>  	return 0;
>  }
>  
> +static int
> +xfs_ioctl_getuuid(
> +	struct xfs_mount	*mp,
> +	struct fsuuid __user	*ufsuuid)
> +{
> +	struct fsuuid		fsuuid;
> +	__u8			uuid[UUID_SIZE];
> +
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;
> +
> +	if (fsuuid.fsu_len == 0) {
> +		fsuuid.fsu_len = UUID_SIZE;
> +		if (copy_to_user(&ufsuuid->fsu_len, &fsuuid.fsu_len,
> +					sizeof(fsuuid.fsu_len)))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	if (fsuuid.fsu_len < UUID_SIZE || fsuuid.fsu_flags != 0)
> +		return -EINVAL;
> +
> +	spin_lock(&mp->m_sb_lock);
> +	memcpy(uuid, &mp->m_sb.sb_uuid, UUID_SIZE);
> +	spin_unlock(&mp->m_sb_lock);
> +
> +	fsuuid.fsu_len = UUID_SIZE;
> +	if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
> +	    copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  /*
>   * These long-unused ioctls were removed from the official ioctl API in 5.17,
>   * but retain these definitions so that we can log warnings about them.
> @@ -2153,6 +2186,9 @@ xfs_file_ioctl(
>  		return error;
>  	}
>  
> +	case FS_IOC_GETFSUUID:
> +		return xfs_ioctl_getuuid(mp, arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> -- 
> 2.25.1
> 
