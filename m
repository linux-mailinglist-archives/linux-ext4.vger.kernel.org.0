Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B436D6875
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Apr 2023 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbjDDQKv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Apr 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjDDQKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Apr 2023 12:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ACC40FF;
        Tue,  4 Apr 2023 09:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54679636AC;
        Tue,  4 Apr 2023 16:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4C9C433EF;
        Tue,  4 Apr 2023 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680624647;
        bh=cBqdfxJ4/qr/q04Tci5Hs37l8eHYTOelhRrgiW3Uwf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgHRWLTCkqbhQJVQYOFgw7vgvG+evZpMFPQE3BK+NKfG3cv7mkTYvSjSZwUJVW74F
         K14dkJfauCFJHDDCUXlIxSRzdyH2edPaV9HANIzKMvT9IAgdDnDE1HqEUc02iReeaJ
         orYrmNkHGPGryJLpjJ7qvF6bBuxz5aNV69iyq9YN3D+pp0G3uDdF4psOaXxuZC9vXM
         nRMQHt/XeB26wxV2sQX9DGIph62bdZ4eJDYVwpAfkJPWXzs3LngddHSAWGo1p81PYw
         rCo6ejeqCtXdG61LFdDonKljtov+H9DP8RMw0QnrckE5J96shsm1Ah2uROts9KXiXW
         TqnbqfF1/V+UA==
Date:   Tue, 4 Apr 2023 09:10:47 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     dchinner@redhat.com, ebiggers@kernel.org, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230404161047.GA109974@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-20-aalbersh@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 947b5c436172..9e072e82f6c1 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -244,7 +244,8 @@ xfs_file_dax_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	ssize_t			ret = 0;
>  
>  	trace_xfs_file_dax_read(iocb, to);
> @@ -297,10 +298,17 @@ xfs_file_read_iter(
>  
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {
> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
>  		ret = xfs_file_buffered_read(iocb, to);

XFS doesn't usually allow directio fallback to the pagecache.  Why would
fsverity be any different?

--D

> +	}
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> -- 
> 2.38.4
> 
