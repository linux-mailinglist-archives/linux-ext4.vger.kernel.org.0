Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78456D8130
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbjDEPMY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjDEPMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 11:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D411769A;
        Wed,  5 Apr 2023 08:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D175F6272E;
        Wed,  5 Apr 2023 15:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353F3C433EF;
        Wed,  5 Apr 2023 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707368;
        bh=+aefmgXHXWQivw0zE6f7l8O069i+hkWlRKpgwCfgkhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaui7DNs5zR82qFwoJqlHJGtdjxtNEKuV49OBzaU1JlhtGdDYmTgoB7Cg2oP8kuF6
         llkjHDUdha3QByAfdxqMYc98qQ+8ePQOOGLfMYXv7iryNRKikleW4/Rv2KpJZ+dG+R
         hqqk2yOgcJkfZwcFmwaxyL/C4cW8DC4atYXvjSG94RQwISX4hL8V8dC7qMnS2GbmwG
         xxCnzKlA3g+4SzfCaBYH98ENyrqmXYnLMN9ZwmfOIOHAYdZ2+3ckQ45BzFODINTzEK
         guTSkMAP9TBQ1TjgYouk94BaRFrPHtC5b2sMJBCMYjozrgR384v+W/44ayI8qoH62X
         9Z0ZXiDNSLnow==
Date:   Wed, 5 Apr 2023 08:09:27 -0700
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
Message-ID: <20230405150927.GD303486@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 05, 2023 at 05:01:42PM +0200, Andrey Albershteyn wrote:
> On Tue, Apr 04, 2023 at 09:10:47AM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> > > The direct path is not supported on verity files. Attempts to use direct
> > > I/O path on such files should fall back to buffered I/O path.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 947b5c436172..9e072e82f6c1 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -244,7 +244,8 @@ xfs_file_dax_read(
> > >  	struct kiocb		*iocb,
> > >  	struct iov_iter		*to)
> > >  {
> > > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > >  	ssize_t			ret = 0;
> > >  
> > >  	trace_xfs_file_dax_read(iocb, to);
> > > @@ -297,10 +298,17 @@ xfs_file_read_iter(
> > >  
> > >  	if (IS_DAX(inode))
> > >  		ret = xfs_file_dax_read(iocb, to);
> > > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> > >  		ret = xfs_file_dio_read(iocb, to);
> > > -	else
> > > +	else {
> > > +		/*
> > > +		 * In case fs-verity is enabled, we also fallback to the
> > > +		 * buffered read from the direct read path. Therefore,
> > > +		 * IOCB_DIRECT is set and need to be cleared
> > > +		 */
> > > +		iocb->ki_flags &= ~IOCB_DIRECT;
> > >  		ret = xfs_file_buffered_read(iocb, to);
> > 
> > XFS doesn't usually allow directio fallback to the pagecache. Why
> > would fsverity be any different?
> 
> Didn't know that, this is what happens on ext4 so I did the same.
> Then it probably make sense to just error on DIRECT on verity
> sealed file.

Thinking about this a little more -- I suppose we shouldn't just go
breaking directio reads from a verity file if we can help it.  Is there
a way to ask fsverity to perform its validation against some arbitrary
memory buffer that happens to be fs-block aligned?  In which case we
could support fsblock-aligned directio reads without falling back to the
page cache?

--D

> > 
> > --D
> > 
> > > +	}
> > >  
> > >  	if (ret > 0)
> > >  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> > > -- 
> > > 2.38.4
> > > 
> > 
> 
> -- 
> - Andrey
> 
