Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C83632FB2
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiKUWTq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 17:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiKUWTI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 17:19:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EAF22B29;
        Mon, 21 Nov 2022 14:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1332A612E4;
        Mon, 21 Nov 2022 22:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00CC433D7;
        Mon, 21 Nov 2022 22:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669069128;
        bh=XaCHFytdWcCHxPKZO9WGONG28k418za/wZBf17odYj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HIIkyNVd2jZByOV9AyCNR/pVyHKF/QZTyFCaElDyP+fC2/kwZhFaqgqwfNNSnujze
         1JAf+bksN/AKoK7fLWSRxvssZ0aqgznjlsxWMw3JP/8ybFrxr+mQzDGrj+UYM6RXwY
         g7JVmj5hqlhfpDcQd9qMHIh6mKhYEtV2ti5cY9R1BdJq0/K8M7liIjpxs+b3r2lYgy
         VBUsMdQXE7iE56hxI7KNGbbkjmNSO3Y2VH/LMMH4Zvi6LapI4/5qU0tqERMtCeXFn1
         uNPNv9/dTpTTyA9fgZTIFhX/0XmapFQPaC+CxzogQ1fREQu2O267CHvk9m9/h1MwVC
         Ugw9Ud6eQPQ9g==
Date:   Mon, 21 Nov 2022 14:18:47 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: add FS_IOC_GETFSUUID ioctl
Message-ID: <Y3v5R+FlFf5KvLsb@magnolia>
References: <20221118211408.72796-1-catherine.hoang@oracle.com>
 <20221118211408.72796-3-catherine.hoang@oracle.com>
 <20221121210223.GJ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121210223.GJ3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 22, 2022 at 08:02:23AM +1100, Dave Chinner wrote:
> On Fri, Nov 18, 2022 at 01:14:08PM -0800, Catherine Hoang wrote:
> > Add a new ioctl to retrieve the UUID of a mounted xfs filesystem. This is a
> > precursor to adding the SETFSUUID ioctl.
> > 
> > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> > ---
> >  fs/xfs/xfs_ioctl.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index 1f783e979629..cf77715afe9e 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1865,6 +1865,39 @@ xfs_fs_eofblocks_from_user(
> >  	return 0;
> >  }
> >  
> > +static int
> > +xfs_ioctl_getuuid(
> > +	struct xfs_mount	*mp,
> > +	struct fsuuid __user	*ufsuuid)
> > +{
> > +	struct fsuuid		fsuuid;
> > +	__u8			uuid[UUID_SIZE];
> 
> uuid_t, please, not an open coded uuid_t.
> 
> > +
> > +	if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> > +		return -EFAULT;
> 
> I still think this failing to copy the flex array member and then
> having to declare a local uuid buffer is an ugly wart, not just on
> the API side of things.
> 
> > +	if (fsuuid.fsu_len == 0) {
> > +		fsuuid.fsu_len = UUID_SIZE;
> 
> XFS uses sizeof(uuid_t) for the size of it's uuids, not UUID_SIZE.
> 
> > +		if (copy_to_user(&ufsuuid->fsu_len, &fsuuid.fsu_len,
> > +					sizeof(fsuuid.fsu_len)))
> > +			return -EFAULT;
> > +		return 0;
> > +	}
> > +
> > +	if (fsuuid.fsu_len < UUID_SIZE || fsuuid.fsu_flags != 0)
> > +		return -EINVAL;
> > +
> > +	spin_lock(&mp->m_sb_lock);
> > +	memcpy(uuid, &mp->m_sb.sb_uuid, UUID_SIZE);
> > +	spin_unlock(&mp->m_sb_lock);
> 
> Hmmmm. Shouldn't we be promoting xfs_fs_get_uuid() to xfs_super.c
> (without the pNFS warning!) and calling that here, rather than open
> coding another "get the XFS superblock UUID" function here?

I disagree that it's worth the effort to create a helper function to
wrap four lines of code, particularly since the pnfs code has this extra
weird wart of returning the byte offset(?) of the uuid location.

> i.e.
> 	if (fsuuid.fsu_flags != 0)
> 		return -EINVAL;
> 
> 	error = xfs_fs_get_uuid(&mp->m_sb, uuid, &fsuuid.fsu_len, NULL);
> 	if (error)
> 		return -EINVAL;
> 
> Also, uuid_copy()?

Why does xfs_fs_get_uuid use memcpy then?  Did the compiler reject the
u8* -> uuid_t * type conversion?

Alternately there's export_uuid().

--D

> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
