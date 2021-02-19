Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20131FB1E
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBSOnS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 09:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231165AbhBSOnL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Feb 2021 09:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613745704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0AOs9Yu2TLttVCPd0p1YmQ1clq9UfWxILXrIQGwA4E=;
        b=h3pRusKNIv9k+1se/rAXt5ycWtNm4+v0fwNX++fE3CZAJcmMqAil+hBc5jdK+TJCV9a7Nm
        pLt+x91PGazsJGr3fClImtv/w8lWaQWszqGqEJ/1s2EBrP6xYTnX0QA9r32GgfbFlOpC6d
        2VM5C+stKgLdiOCMGZetXYG2B/TsAYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-XlnScZ2UOjaMYIkMpCt9Uw-1; Fri, 19 Feb 2021 09:41:40 -0500
X-MC-Unique: XlnScZ2UOjaMYIkMpCt9Uw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5E50C73A5;
        Fri, 19 Feb 2021 14:41:38 +0000 (UTC)
Received: from work (unknown [10.40.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EDA36085D;
        Fri, 19 Feb 2021 14:41:34 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:41:29 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
Message-ID: <20210219144129.lcijkpxjduxezwgp@work>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
 <20210219105713.uu2mywenytfd2e5j@work>
 <E16FB371-5DFC-4A10-A9E2-36541FCF7D30@gmail.com>
 <20210219133459.vezgrlkjpmaizvb4@work>
 <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 19, 2021 at 04:53:05PM +0300, Alexey Lyashkov wrote:
> 
> 
> > 19 февр. 2021 г., в 16:34, Lukas Czerner <lczerner@redhat.com> написал(а):
> > 
> > On Fri, Feb 19, 2021 at 02:49:16PM +0300, Alexey Lyashkov wrote:
> >> Lukas,
> >> 
> >> because e2fsprogs have an bad assumption about IO size for the O_DIRECT case.
> >> and because library uses a code like
> >>>> 
> >> set_block_size(1k);
> >> seek(fs, 1);
> >> read_block();
> >>>>> 
> >> which caused an 1k read inside of 4k disk block size not aligned by block size, which is prohibited and caused an error report.
> >> 
> >> Reference to patch.
> >> https://patchwork.ozlabs.org/project/linux-ext4/patch/20201023112659.1559-1-artem.blagodarenko@gmail.com/
> > 
> > Alright, I skimmed through your patch proposal and I am not sure I
> > completely understand the problem because you have not provided the code
> > adding O_DIRECT support for e2image.
> 
> debugfs -D … will hit same problem.
> 
> > 
> > However I think that it is a reasonable assumption to make that there is
> > not going to be a file system on a block device such that the fs blocksize
> > is smaller than device sector size. You can't create such fs with mke2fs
> > and you can't mount such file system either.
> > 
> This is don’t need to be create this FS, calling an ext2_open2 is enough.
> 
> 
> > All that said I can now see that there is a problem in case of mke2fs
> > and debugfs when used with O_DIRECT (-D) on a file system image with 1k
> > block size stored on a file in the host file system on the block device
> > with sector size larger than 1k (...I am getting Inception flashbacks now)
> 
> if you have open a large (>256T) device with debugfs without -D you will be see a large swap.
> once this FS want to consume a ~10G for bitmaps and other parts.
> with cached read you memory consumption increased by two.
> 
> btw.
> you can easy replicate it with losetup which able to specify a block size.
> 
> > 
> > In fact I can confirm that indeed, both mke2fs and debugfs will fail in
> > such scenario. The question is whether we care enough to support
> > O_DIRECT in such situations. Personally I don't care enough about this.
> > However it would be nice to at least have a check (probably in
> > ext2fs_open2, unix_open_channel or such) and notify user about the
> > problem.
> 
> it’s not a tools problem. It’s problem of e2fsprogs library as ext2_open2 affected by this bug.
> But this is not a single function where bug lives.

Sure, I am aware of what the problem is. All I am saying is that the
situation where it is manifesting itself is marginal enough for me that I
personally would be fine with just not suporting O_DIRECT in that case.

However your patch does seem to fix this particular problem on e2fsprogs
v1.45.7. It no longer applies cleanly on the current code so maybe
you should resend it ? Preferably along with added tests excercising it.

-Lukas

> 
> 
> > 
> > Note that this conversation does not affect my patch since
> > ext2fs_mmp_read() does not use the unix_io infrastructure.
> > 
> It’s good to convert to use it.
> 
> Alex
> 
> 
> > -Lukas
> > 
> >> 
> >> Alex
> >> 
> >>> 19 февр. 2021 г., в 13:57, Lukas Czerner <lczerner@redhat.com> написал(а):
> >>> 
> >>> On Fri, Feb 19, 2021 at 01:08:17PM +0300, Alexey Lyashkov wrote:
> >>>> Andreas,
> >>>> 
> >>>> What about to disable a O_DIRECT global on any block devices in the e2fsprogs library as this don’t work on 4k disk drives at all ?
> >>>> Instead of fixing an O_DIRECT access with patches sends early.
> >>> 
> >>> Why would it not work at all ? This is a fix for a specific problem and
> >>> I am not currently aware of ony other problems e2fsprogs should have
> >>> with 4k sector size drives. Do you have a specific problem in mind ?
> >>> 
> >>> Thanks!
> >>> -Lukas
> >>> 
> >>>> 
> >>>> 
> >>>> Alex
> >>>> 
> >>>>> 19 февр. 2021 г., в 1:20, Andreas Dilger <adilger@dilger.ca> написал(а):
> >>>>> 
> >>>>> On Feb 18, 2021, at 2:51 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> >>>>>> 
> >>>>>> Currently the mmp block is read using O_DIRECT to avoid any caching that
> >>>>>> may be done by the VM. However when working with regular files this
> >>>>>> creates alignment issues when the device of the host file system has
> >>>>>> sector size larger than the blocksize of the file system in the file
> >>>>>> we're working with.
> >>>>>> 
> >>>>>> This can be reproduced with t_mmp_fail test when run on the device with
> >>>>>> 4k sector size because the mke2fs fails when trying to read the mmp
> >>>>>> block.
> >>>>>> 
> >>>>>> Fix it by disabling O_DIRECT when working with regular files. I don't
> >>>>>> think there is any risk of doing so since the file system layer, unlike
> >>>>>> shared block device, should guarantee cache consistency.
> >>>>>> 
> >>>>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> >>>>>> Reviewed-by: Eric Sandeen <sandeen@redhat.com>
> >>>>> 
> >>>>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> >>>>> 
> >>>>>> ---
> >>>>>> v2: Fix comment - it avoids problems when the sector size is larger not
> >>>>>> smaller than blocksize
> >>>>>> 
> >>>>>> lib/ext2fs/mmp.c | 22 +++++++++++-----------
> >>>>>> 1 file changed, 11 insertions(+), 11 deletions(-)
> >>>>>> 
> >>>>>> diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
> >>>>>> index c21ae272..cca2873b 100644
> >>>>>> --- a/lib/ext2fs/mmp.c
> >>>>>> +++ b/lib/ext2fs/mmp.c
> >>>>>> @@ -57,21 +57,21 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
> >>>>>> 	 * regardless of how the io_manager is doing reads, to avoid caching of
> >>>>>> 	 * the MMP block by the io_manager or the VM.  It needs to be fresh. */
> >>>>>> 	if (fs->mmp_fd <= 0) {
> >>>>>> +		struct stat st;
> >>>>>> 		int flags = O_RDWR | O_DIRECT;
> >>>>>> 
> >>>>>> -retry:
> >>>>>> +		/*
> >>>>>> +		 * There is no reason for using O_DIRECT if we're working with
> >>>>>> +		 * regular file. Disabling it also avoids problems with
> >>>>>> +		 * alignment when the device of the host file system has sector
> >>>>>> +		 * size larger than blocksize of the fs we're working with.
> >>>>>> +		 */
> >>>>>> +		if (stat(fs->device_name, &st) == 0 &&
> >>>>>> +		    S_ISREG(st.st_mode))
> >>>>>> +			flags &= ~O_DIRECT;
> >>>>>> +
> >>>>>> 		fs->mmp_fd = open(fs->device_name, flags);
> >>>>>> 		if (fs->mmp_fd < 0) {
> >>>>>> -			struct stat st;
> >>>>>> -
> >>>>>> -			/* Avoid O_DIRECT for filesystem image files if open
> >>>>>> -			 * fails, since it breaks when running on tmpfs. */
> >>>>>> -			if (errno == EINVAL && (flags & O_DIRECT) &&
> >>>>>> -			    stat(fs->device_name, &st) == 0 &&
> >>>>>> -			    S_ISREG(st.st_mode)) {
> >>>>>> -				flags &= ~O_DIRECT;
> >>>>>> -				goto retry;
> >>>>>> -			}
> >>>>>> 			retval = EXT2_ET_MMP_OPEN_DIRECT;
> >>>>>> 			goto out;
> >>>>>> 		}
> >>>>>> --
> >>>>>> 2.26.2
> >>>>>> 
> >>>>> 
> >>>>> 
> >>>>> Cheers, Andreas
> >>>>> 
> >>>>> 
> >>>>> 
> >>>>> 
> >>>>> 
> >>>> 
> >>> 
> >> 
> > 
> 

