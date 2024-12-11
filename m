Return-Path: <linux-ext4+bounces-5567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59719EDA34
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51963283871
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Dec 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A0020E6E6;
	Wed, 11 Dec 2024 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j/ejm0YH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5A1F2360
	for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 22:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956416; cv=none; b=Dlgaotr9vWBdRtgRsH5a/KikvUBQ71UHI4EXNU8AiP/xNBfQCRQKUIvkcrKBH1t9W7Cr5JR7FIabheYNkJhqe3DhgXi4z0zSAec4A72lZsjCl+8fvre4FExp1H17n+LpyR6Hn/uMav+cQn1OifDS1PR/uEfuot1M5VvWsabaYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956416; c=relaxed/simple;
	bh=VOGzIGGSxqcC7jyFVRhHAo+5MH48iBCMJkB64VO7HdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS56IJill4oVZsrdavx2ZeHPzpdriCZ2bxoT1JWZny0JSYkEG6DPafFmJ03TaDVLwhzVDi3k4gDgnX/te3LFY6qESi0eRzktL8wt5PGCnI6XmE3VgoPFQOtZSABx32+r1u73Uv6DKei2tW9sdKG+9yn4kbesfxpCr/osNMwS0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j/ejm0YH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef748105deso4234257a91.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Dec 2024 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733956414; x=1734561214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=j/ejm0YH6vC3JTn6aSaULZwKVb89iCsaOgno1knpGPttaxzaexerLkwhwtTgTAYe3i
         6Q2kT/jo7vdHRRcLmk+qxinVMGJWI/wgVjkal81UtOU3esAlKVxiJ12O1QhU1uWvvI8X
         ZSxrcig/cUDx+ROYR1l0ciOET5DvuSjfDeuONsH1i0wqXUmYDuhm/KUq3Uh5iBa/a/rC
         Up0NzYZQezfMvegZ6nMR4LICpIUHTEBLpt6+bS47f98Ush3v5BkEHaPPlZSMSOOExoo5
         8dnh69STWKdciRv4FW8E2707xhq9LVyjTJLasZ7EUpFsj0J6eGhtGRoKO2RIsoebYdg/
         NMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733956414; x=1734561214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngWPL7F+k5wxiISlgKbwW4fjhxxXTEP4BljwhbzST3s=;
        b=jmaU8izIgM7DvCOT8ikl3Rlhhv1STQPEvzl1V8OeacIASbSWMFw1VYHTn62rumuwTZ
         LaP703NDR23+DmAktVwsSv0xLWk2J8ROxb5Dwy5K2xb16GqibyeNRW6JA88q+8RG+6a4
         HfWItHQ7ihKQWOoRGsONScKOgiH+FyuOGZZwDZs/CCahzObqrD5JLcPwEJg65Y0LiRC1
         tp6WVGWn7LYIwqnRYCQB/3TBMiWsi6gKWSOI2Te9wR66jyxsRSKyFxARS37SVX5Po4CW
         C3AqWKvVuVxc5WWDX4AkV3F91Dcn3x5vabdvSizt8wBAMCn3JHqK5pfDoiITqn599uFW
         gnbg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVfFFqccklSdRQkBDbu/ytiJ4PPu6VnfwJYtW7bDnbeYqFtaTq0j9jxPsB80HzHMTX8g0t6RGMrS5@vger.kernel.org
X-Gm-Message-State: AOJu0YypTq5YLICgAZJJiWBv1dp3HlRr3vkoJ9UK58e7B+tIGYyEuU4Z
	dGS77xVtYZz0QPw0q9+ilI0h/jL2nZyT6MJxg2kQL4Yf88puJZwAwj2e4Yo3MD0=
X-Gm-Gg: ASbGncvCcSSqWzIhVnZlCY6KBBBB9sXAObajhKjUVXpqmPXSAXDTTRaN3XM7PQU4sUZ
	CSSitmqpzz7y4zsLD+mDwVY75vNk+nyLOqGivZv1uII6WcsH4zRCjMx4lPXcffW+Mt4ZGPgQ7pr
	OqSWgUHoycytSL1hm89mqFcd/EqdC9F0W/4bCwQemPUxbOrGuB1s+C30+AcdMfy8f80U655SEWr
	CzNUr3Vv83jbf5FJA+mEfWOAWsYkAalyNVuYQKKdTWDaxkzHYHUcj1721k9aUxTtJ3IFwe6EyDd
	l2bYaIFMKbR2944wyCyP3zCCR7M=
X-Google-Smtp-Source: AGHT+IEVKuZamiHIkIRgt4sKWSN/CxUsh7q1Rtn5YMJ8loDhLinrZmWvhpreTWA49/k9SjEkFUp/vQ==
X-Received: by 2002:a17:90b:358b:b0:2ee:c457:bf83 with SMTP id 98e67ed59e1d1-2f1392b7518mr2309164a91.19.1733956413993;
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff77b9sm12072842a91.36.2024.12.11.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:33:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLVGr-00000009ZKP-40OP;
	Thu, 12 Dec 2024 09:33:29 +1100
Date: Thu, 12 Dec 2024 09:33:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1oTOUCui9vTgNoM@dread.disaster.area>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211181706.GB6678@frogsfrogsfrogs>

On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > Currently with stat we only show FS_IOC_FSGETXATTR details
> > if the filesystem is XFS. With extsize support also coming
> > to ext4 make sure to show these details when -c "stat" or "statx"
> > is used.
> > 
> > No functional changes for filesystems other than ext4.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  io/stat.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/io/stat.c b/io/stat.c
> > index 326f2822e276..d06c2186cde4 100644
> > --- a/io/stat.c
> > +++ b/io/stat.c
> > @@ -97,14 +97,14 @@ print_file_info(void)
> >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> >  }
> >  
> > -static void
> > -print_xfs_info(int verbose)
> > +static void print_extended_info(int verbose)
> >  {
> > -	struct dioattr	dio;
> > -	struct fsxattr	fsx, fsxa;
> > +	struct dioattr dio;
> > +	struct fsxattr fsx, fsxa;
> > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> >  
> > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> 
> Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> print whatever is returned, no matter what filesystem we think is
> feeding us information?

Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
some time, we should treat it the same way for all filesystems.

> e.g.
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> 				  errno != ENOTTY))
> 			perror("FS_IOC_GETXATTR");

Why do we even need "is_xfs_fd" there? XFS will never give a
EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

