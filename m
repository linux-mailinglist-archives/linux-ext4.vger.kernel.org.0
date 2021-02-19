Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08331F7D0
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBSLBJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 06:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhBSK6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Feb 2021 05:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613732244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7LMWOkJCMH3WfOoS9JsrRIfV3D5dYTOEERH9KDfO+s=;
        b=aYXub7bCcirbhvC00fELRO3CtcRHaHw1FVnw7+fVTvgBligi5rqZHwQeUeU/1e5Ko2JQ2g
        bd0yk501i8NRK5gGyEtCAFkkLUfBbKo1uXtqRHY2V3E1FcjxwX20wfYU+WP+fzqv8B4ZC3
        oPYNyx/lhiEv+kxjcfiOGflDneJrwK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-0Te4qAuhOoSVeyfPJsARBQ-1; Fri, 19 Feb 2021 05:57:23 -0500
X-MC-Unique: 0Te4qAuhOoSVeyfPJsARBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E431005501;
        Fri, 19 Feb 2021 10:57:21 +0000 (UTC)
Received: from work (unknown [10.40.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BD6A6268F;
        Fri, 19 Feb 2021 10:57:17 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:57:13 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
Message-ID: <20210219105713.uu2mywenytfd2e5j@work>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 19, 2021 at 01:08:17PM +0300, Alexey Lyashkov wrote:
> Andreas,
> 
> What about to disable a O_DIRECT global on any block devices in the e2fsprogs library as this don’t work on 4k disk drives at all ?
> Instead of fixing an O_DIRECT access with patches sends early.

Why would it not work at all ? This is a fix for a specific problem and
I am not currently aware of ony other problems e2fsprogs should have
with 4k sector size drives. Do you have a specific problem in mind ?

Thanks!
-Lukas

> 
> 
> Alex
> 
> > 19 февр. 2021 г., в 1:20, Andreas Dilger <adilger@dilger.ca> написал(а):
> > 
> > On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> >> 
> >> Currently the mmp block is read using O_DIRECT to avoid any caching that
> >> may be done by the VM. However when working with regular files this
> >> creates alignment issues when the device of the host file system has
> >> sector size larger than the blocksize of the file system in the file
> >> we're working with.
> >> 
> >> This can be reproduced with t_mmp_fail test when run on the device with
> >> 4k sector size because the mke2fs fails when trying to read the mmp
> >> block.
> >> 
> >> Fix it by disabling O_DIRECT when working with regular files. I don't
> >> think there is any risk of doing so since the file system layer, unlike
> >> shared block device, should guarantee cache consistency.
> >> 
> >> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> >> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > 
> >> ---
> >> v2: Fix comment - it avoids problems when the sector size is larger not
> >>   smaller than blocksize
> >> 
> >> lib/ext2fs/mmp.c | 22 +++++++++++-----------
> >> 1 file changed, 11 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> >> index c21ae272..cca2873b 100644
> >> --- a/lib/ext2fs/mmp.c
> >> +++ b/lib/ext2fs/mmp.c
> >> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
> >> 	 * regardless of how the io_manager is doing reads, to avoid caching of
> >> 	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
> >> 	if (fs->mmp_fd <= 0) {
> >> +		struct stat st;
> >> 		int flags = O_RDWR | O_DIRECT;
> >> 
> >> -retry:
> >> +		/*
> >> +		 * There is no reason for using O_DIRECT if we're working with
> >> +		 * regular file. Disabling it also avoids problems with
> >> +		 * alignment when the device of the host file system has sector
> >> +		 * size larger than blocksize of the fs we're working with.
> >> +		 */
> >> +		if (stat(fs->device_name, &st) == 0 &&
> >> +		    S_ISREG(st.st_mode))
> >> +			flags &= ~O_DIRECT;
> >> +
> >> 		fs->mmp_fd = open(fs->device_name, flags);
> >> 		if (fs->mmp_fd < 0) {
> >> -			struct stat st;
> >> -
> >> -			/* Avoid O_DIRECT for filesystem image files if open
> >> -			 * fails, since it breaks when running on tmpfs. */
> >> -			if (errno == EINVAL && (flags & O_DIRECT) &&
> >> -			    stat(fs->device_name, &st) == 0 &&
> >> -			    S_ISREG(st.st_mode)) {
> >> -				flags &= ~O_DIRECT;
> >> -				goto retry;
> >> -			}
> >> 			retval = EXT2_ET_MMP_OPEN_DIRECT;
> >> 			goto out;
> >> 		}
> >> --
> >> 2.26.2
> >> 
> > 
> > 
> > Cheers, Andreas
> > 
> > 
> > 
> > 
> > 
> 

