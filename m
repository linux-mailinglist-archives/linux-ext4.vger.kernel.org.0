Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E70632E5F
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 22:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKUVCy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKUVCw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 16:02:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31065DD0
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 13:02:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so12263724pgh.4
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CTLQFhADzE3dTllfvu5X3oDge9IC1KTSOr/JLTdcdI=;
        b=i5wVDXUvz1Z7aO2IIkuSoLru+C9Lbky9Rr/PWRji+3mpJegUUEl0q2TMBOYVz8zeMy
         910Hq21QWlR/iUmqi4aQApFC6yZZkkK3GqPuHX0FHjCIk+T0ocp/z/67rfg1pO6o2asK
         CAa+evsWbS7glCaDCUtE1qMm29gH51TGXQ8jyEkPI8PEd4zVn8YEe01zWe4Gq8g78kSk
         Rb5xbzHtcXmCP8nW/PziN+9f5RBP9uomFG3WfUafwUfM+gMlPpQVwRv3Z7ZUPFU1dy3v
         553V35yHBH0nUyDx5bALXhRvOOhzzmUJQjZjS4WSNtVbuYDBw03SqKubWcH3pjZmtSNh
         OW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CTLQFhADzE3dTllfvu5X3oDge9IC1KTSOr/JLTdcdI=;
        b=5i1S5HHE8d3VDOb+9gml5pIsgca1AZTzmMC/PmPzfZxcJyn7pzBYkN+JaiZbJ5Jzvt
         bMZtmvmHtDUqXVVKscoZ1qTkgLHAcpdH9ijHtzLtx0M9NyrK60f6tLETdVSsjcq8nR8E
         x/YBzcmj4wPTtCgEx6gLcKdxs6syHttsiWZvNjq+ebqBnMsEm2ipStATm7/0PKJFBMMN
         4gydZ8bQFsBnRwcxIp91Gv9VximlEnDpChpqVetpwlfVel2ML6tF9G6C1ymmkLbHZ3pM
         guG4GkB3G7S0OGRY+L4JXEjErScsemwTNieyev9OoDxrxdMdOy7B1IVFblngbRqrQ540
         DrSA==
X-Gm-Message-State: ANoB5pll6UunjeOPrRwXKMboXb0+RJ6u4LTa4Cnd0CyyohTVnNXojT4M
        1nh1TmXMr6HLFHLNKXP8tUaMJk+eaHZUyg==
X-Google-Smtp-Source: AA0mqf5P6g2NtmeRkT3aUS78NMI/LVKEGuMGE1jGWsgSK+LbDFFpN2LUzPff3CqzvPmQZsMEdRpcpw==
X-Received: by 2002:a62:fb11:0:b0:56b:dbab:5362 with SMTP id x17-20020a62fb11000000b0056bdbab5362mr21945413pfm.47.1669064546790;
        Mon, 21 Nov 2022 13:02:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b0017fe9b038fdsm10179926plc.14.2022.11.21.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 13:02:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oxDvr-00H0tW-IY; Tue, 22 Nov 2022 08:02:23 +1100
Date:   Tue, 22 Nov 2022 08:02:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: add FS_IOC_GETFSUUID ioctl
Message-ID: <20221121210223.GJ3600936@dread.disaster.area>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
 <20221118211408.72796-3-catherine.hoang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118211408.72796-3-catherine.hoang@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

uuid_t, please, not an open coded uuid_t.

> +
> +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> +		return -EFAULT;

I still think this failing to copy the flex array member and then
having to declare a local uuid buffer is an ugly wart, not just on
the API side of things.

> +	if (fsuuid.fsu_len == 0) {
> +		fsuuid.fsu_len = UUID_SIZE;

XFS uses sizeof(uuid_t) for the size of it's uuids, not UUID_SIZE.

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

Hmmmm. Shouldn't we be promoting xfs_fs_get_uuid() to xfs_super.c
(without the pNFS warning!) and calling that here, rather than open
coding another "get the XFS superblock UUID" function here?

i.e.
	if (fsuuid.fsu_flags != 0)
		return -EINVAL;

	error = xfs_fs_get_uuid(&mp->m_sb, uuid, &fsuuid.fsu_len, NULL);
	if (error)
		return -EINVAL;

Also, uuid_copy()?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
