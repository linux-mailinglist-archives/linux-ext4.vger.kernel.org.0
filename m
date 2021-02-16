Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF33431D25C
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 22:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBPVxO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 16:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBPVxN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Feb 2021 16:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613512306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIi6PCRiId6ElulcUf71zS/s2SqefOTIdpzwxMq2jPw=;
        b=CAOPzJGcoCMwr14toi1N4TTtkNm7Lp/Gm8IAgpff8Uttl5d/rQeWWpaGCA12oqwH3d8ghM
        vdik81HYN7z7t3SAFbR2QXYRySLe4Mru1wmN2Fb03r0cTHiFMLzy51p1Z/iSzE7sH99yuf
        7FS4g75xPcCFYsjheCLRy3Re5GxEDYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-M938W1sPPSyDMVTIftJW1w-1; Tue, 16 Feb 2021 16:51:44 -0500
X-MC-Unique: M938W1sPPSyDMVTIftJW1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF2778030D9;
        Tue, 16 Feb 2021 21:51:43 +0000 (UTC)
Received: from work (unknown [10.40.192.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DAC15D72F;
        Tue, 16 Feb 2021 21:51:42 +0000 (UTC)
Date:   Tue, 16 Feb 2021 22:51:40 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mmp: do not use O_DIRECT when working with regular file
Message-ID: <20210216215140.e3yu3vl7hmcv4jss@work>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <d7fd3943-ac80-6c13-6afe-8ec34f3af5c5@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fd3943-ac80-6c13-6afe-8ec34f3af5c5@sandeen.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 16, 2021 at 03:24:00PM -0600, Eric Sandeen wrote:
> On 2/12/21 3:37 AM, Lukas Czerner wrote:
> > Currently the mmp block is read using O_DIRECT to avoid any caching tha
> > may be done by the VM. However when working with regular files this
> > creates alignment issues when the device of the host file system has
> > sector size smaller than the blocksize of the file system in the file
> > we're working with.
> > 
> > This can be reproduced with t_mmp_fail test when run on the device with
> > 4k sector size because the mke2fs fails when trying to read the mmp
> > block.
> > 
> > Fix it by disabling O_DIRECT when working with regular file. I don't
> > think there is any risk of doing so since the file system layer, unlike
> > shared block device, should guarantee cache consistency.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  lib/ext2fs/mmp.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> > index c21ae272..1ac22194 100644
> > --- a/lib/ext2fs/mmp.c
> > +++ b/lib/ext2fs/mmp.c
> > @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
> >  	 * regardless of how the io_manager is doing reads, to avoid caching of
> >  	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
> >  	if (fs->mmp_fd <= 0) {
> > +		struct stat st;
> >  		int flags = O_RDWR | O_DIRECT;
> >  
> > -retry:
> > +		/*
> > +		 * There is no reason for using O_DIRECT if we're working with
> > +		 * regular file. Disabling it also avoids problems with
> > +		 * alignment when the device of the host file system has sector
> > +		 * size smaller than blocksize of the fs we're working with.
> 
> I think the problem is when the host filesystem that contains the image is on
> a device with a logical sector size which is /larger/ than the image filesystem's
> block size, right? Not smaller?

Yeah, it is supposed to be *larger*, of course. If it is smaller, then
there is no problem. Thanks for pointing this out I'll change the
comment and the description.

> 
> Because then you might not be able to do an image-filesystem-block-aligned direct
> IO on it, if it's sub-logical-block-size for the host filesystem/device, and lands
> within the larger host sector at an offset?
> 
> otherwise, this seems at least as reasonable to me as the previous tmpfs work
> around, so other than the question about the comment,
> 
> Reviewed-by: Eric Sandeen <sandeen@redhat.com>

Thanks!
-Lukas

> 
> 
> > +		 */
> > +		if (stat(fs->device_name, &st) == 0 &&
> > +		    S_ISREG(st.st_mode))
> > +			flags &= ~O_DIRECT;
> > +
> >  		fs->mmp_fd = open(fs->device_name, flags);
> >  		if (fs->mmp_fd < 0) {
> > -			struct stat st;
> > -
> > -			/* Avoid O_DIRECT for filesystem image files if open
> > -			 * fails, since it breaks when running on tmpfs. */
> > -			if (errno == EINVAL && (flags & O_DIRECT) &&
> > -			    stat(fs->device_name, &st) == 0 &&
> > -			    S_ISREG(st.st_mode)) {
> > -				flags &= ~O_DIRECT;
> > -				goto retry;
> > -			}
> >  			retval = EXT2_ET_MMP_OPEN_DIRECT;
> >  			goto out;
> >  		}
> > 
> 

