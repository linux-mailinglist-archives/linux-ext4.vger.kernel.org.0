Return-Path: <linux-ext4+bounces-5600-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894809EFD95
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 21:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A64328851F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 20:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3981B21B4;
	Thu, 12 Dec 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fISalG7f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3E19E968
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036249; cv=none; b=siG+Kcbgs2/rPmv6t4jICbnnGpfp4wTnWgLZK3JtPQk0G7iB67ktKa+1v8BpHYEyA9ep+1BDYAN6MSuwwM5ffYcVSIEDfKdOO1DqfPmAgnwxc2GaU5Ns/gL6SIX3qC34E6O6WWkMZd+yoLrfW98KotZc9S6yzpsRVESn4M7sZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036249; c=relaxed/simple;
	bh=z7dvnp1wJwcgR0OOhWAnXX3y6XFU/RaQbm+Wh5D5GIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjcCWEpgdk5Golr71vrjbkayPp6fDPXZ21a28Q1U9pidArRJWQlNvpFnaTd2euRzUjJ84/T2mItkq7xRlP3HxxE0F8te4QQ5ejxYM3Rb2GVUmQBDocAYho1TszfHL1JoiR+DNQRB9l2tUPgx0jQDcw3Pc8P+GKLyIXBg4zDrlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fISalG7f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf3e36a76so10417365ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734036245; x=1734641045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gY9QpSeXkRgHpm7Ku8b4o1XavyERhHEQqI9K8o9LNoI=;
        b=fISalG7fFANAr5rVUIbasREP6o7UE4XM7eAJbEGWcnRRR4R2IIsObu/t3TNL9a2Dnn
         SaKXJdhkQI0V0J5LsKzl9yMSFXs6pDTy+pKoV0SjPUkOgS7JcWFVNeaI5I8i33Ff6NVx
         +TQQCvwKyQz6O3A9imOCo1wshh+jOWFTa62apsZ/LO/BIbxBRY5yJWiiVesq1Sa+rjYa
         +mH2CJMDmkywPuFr2F0bfseXEq/D69a+//KLdAg1J1wcGcGj8BjAYrBzzqDbRuT+oE/y
         rubgu4DoL0mufdPFMSOkHlQtYjGl2fTRZta8j6IbnLkCwE0d0RNAVtI3lyqtXhuCeNDN
         +CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036245; x=1734641045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY9QpSeXkRgHpm7Ku8b4o1XavyERhHEQqI9K8o9LNoI=;
        b=eVHVN1sZf7xmFFY4YttHBVC4sjh/B1ZRa+rK3lLS/IHSFWvslshEh+U1nlI4uHA3iU
         Id9tfLACu3QzjmX5zthE6Xcg1PyA0FmYx5vgC8T89A+cRAayqq7VqtNrd41zxuin4tv0
         dip5PuTGlSX5JAh08U0H3U1CRgllTe8DMmEQCzFBqEpvL8w6v/RDotG9rpDjxLUfFhiV
         t48gAWf5vi3plvT7QirQjJAgc8X6SNsO2yYJgKdJNmse9iyfa2nN3Es2dxUELTKuNUi/
         j3wibff1lM1xORJI07/FjK2NMBQJQ5d7lVLwd1zdEZrUfGqQ7kgOYo6dmI+6FAaHuMN9
         mmTA==
X-Forwarded-Encrypted: i=1; AJvYcCULOGDO/+mvfUHadm3KUF5fHDXX3hHOaMeWeTzxUGrYOuIxm7yoc+7P40Z0ruc7yLGKfAM5e6kpBs+X@vger.kernel.org
X-Gm-Message-State: AOJu0YzFy078mEJFxC6a8uqTUSKnkmovisC/xiLcIjihdfTF/d7c3Tg1
	ddK6xLT9KieZOEjNdMc+BTLnWys6VkRpHO332XzQCnlE64WomT8ppRk8FwfxUu4=
X-Gm-Gg: ASbGncvJtPcLVflMPWwu51TKjOLFmts7KIFakBWcgEQRk1IRiCYC9njn5ejk11XNRvn
	7fRjhpwIwqpRwFHn2glNfGtIllnZuTpGVd/3ad3cYIDjVO3H3z5r1ibv+DojG9FfVm0Gh1uR04G
	iMzFrQ7Kf2HGXO5WwDCMu8HRa40y+7NI/UFCnYIUdijUyXtMO/wKLk7LdjpvyulAXuF1KWNah+i
	3AQ+SS0WNXKmPIF3lc6Jl31tiJZVhKywR5eiRNz9R1RefDCiua7bYPFO4D+Vzs/sgduaOhan9he
	HgXnHKVrJXAWPvYjF+CzTinkCxQvsA==
X-Google-Smtp-Source: AGHT+IFikBPMpBDF7pd2lmWNowKlEuQrYWQcmYnDsTJx6agqxEvZabEob6zJiQBYVY3pZ7/94b/Img==
X-Received: by 2002:a17:902:e748:b0:215:577b:ab77 with SMTP id d9443c01a7336-21892a40509mr1511235ad.39.1734036245314;
        Thu, 12 Dec 2024 12:44:05 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21674098324sm50638695ad.52.2024.12.12.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:44:04 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLq2T-00000009wiF-3FPn;
	Fri, 13 Dec 2024 07:44:01 +1100
Date: Fri, 13 Dec 2024 07:44:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1tLEQmRiZc7alBo@dread.disaster.area>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
 <Z1oTOUCui9vTgNoM@dread.disaster.area>
 <20241212161919.GA6657@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212161919.GA6657@frogsfrogsfrogs>

On Thu, Dec 12, 2024 at 08:19:19AM -0800, Darrick J. Wong wrote:
> On Thu, Dec 12, 2024 at 09:33:29AM +1100, Dave Chinner wrote:
> > On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> > > On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > > > Currently with stat we only show FS_IOC_FSGETXATTR details
> > > > if the filesystem is XFS. With extsize support also coming
> > > > to ext4 make sure to show these details when -c "stat" or "statx"
> > > > is used.
> > > > 
> > > > No functional changes for filesystems other than ext4.
> > > > 
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >  io/stat.c | 38 +++++++++++++++++++++-----------------
> > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/io/stat.c b/io/stat.c
> > > > index 326f2822e276..d06c2186cde4 100644
> > > > --- a/io/stat.c
> > > > +++ b/io/stat.c
> > > > @@ -97,14 +97,14 @@ print_file_info(void)
> > > >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> > > >  }
> > > >  
> > > > -static void
> > > > -print_xfs_info(int verbose)
> > > > +static void print_extended_info(int verbose)
> > > >  {
> > > > -	struct dioattr	dio;
> > > > -	struct fsxattr	fsx, fsxa;
> > > > +	struct dioattr dio;
> > > > +	struct fsxattr fsx, fsxa;
> > > > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> > > >  
> > > > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > > > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> > > 
> > > Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> > > print whatever is returned, no matter what filesystem we think is
> > > feeding us information?
> > 
> > Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
> > some time, we should treat it the same way for all filesystems.
> > 
> > > e.g.
> > > 
> > > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> > > 				  errno != ENOTTY))
> > > 			perror("FS_IOC_GETXATTR");
> > 
> > Why do we even need "is_xfs_fd" there? XFS will never give a
> > EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...
> 
> Yeah, in hindsight I don't think it's needed for FS_IOC_FSGETXATTR, but

*nod*

> it's definitely nice for XFS_IOC_FSGETXATTRA (which is not implemented
> outside xfs) so that you don't get unnecessary error messages on ext4.

I don't think we even need it for FS_IOC_GETXATTRA - if the
filesystem does not support that ioctl, we don't print the fields,
nor do we output an error.

After all, this "extended info" and it's only ever been printed
for XFS, so we can define whatever semantics we want for foreign
filesystem output right now. As long as XFS always prints the same
info as it always has (i.e. all of it), we can do whatever we want
with the foreign filesystem stuff.

Keep in mind that we don't need platform tests for XFS files - that
has already been done when the file was opened and the state stored
in file->flags via the IO_FOREIGN flag. We already use that in the
stat_f() to determine whether we print the "xfs info" or not.

IOWs, I think all we need to do is  move where we check the
IO_FOREIGN flag. i.e.:

print_extented_info(file)
{
	struct dioattr  dio = {};
        struct fsxattr  fsx = {}, fsxa = {};

	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
		perror("FS_IOC_GETXATTR");
		exitcode = 1;
		return;
	}

	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);

	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
	if (file->flags & IO_FOREIGN)
		return;

	if (ioctl(file->fd, FS_IOC_FSGETXATTRA, &fsxa)) < 0) {
		perror("FS_IOC_GETXATTRA");
		exitcode = 1;
		return;
	}
	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
		perror("XFS_IOC_DIOINFO");
		exitcode = 1;
		return;
	}

	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
}

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

