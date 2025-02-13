Return-Path: <linux-ext4+bounces-6456-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3317A350B0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 22:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFCB3AC6AF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A626982D;
	Thu, 13 Feb 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="r5oLR4Pc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B9269827
	for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483377; cv=none; b=GVWXobz1m5qjcpi6zX/z0Dy6e58tIi1VnRgkmL0uZMci8ZT0E0G+zM/YaF6fJ1xKKe55o64D0zl4ANZuYfKv9hj6UVOXdwcPW1Rpd5Knqjsv7przx7bj0Tj9D/lF2ju6C1+AMgStROxdPulQN9HTcOnZv65yZq3MtT+YzdzWzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483377; c=relaxed/simple;
	bh=KszPgrrhK+wd0rXnmnM0yKY4WgHtDszkBghHxkvkPic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cipNOA/4Nf9Iw0/kC0CGeXuZzIoGaNpdQrozWPXmEzSCsXSbY8/s6OU4tcqMKgdYBEoMnT/tIHr842Vup2ZyCWPtv77dlM0o2/C4xEbrRPw6VXo0i6WANvZXuae1Kki9M0gbRmQLkn1utVIvLHFd0+AOr3psGktA7qP0KMdMlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=r5oLR4Pc; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso1507236a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 13 Feb 2025 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739483375; x=1740088175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEDH/5BvKu8Lhm+jqz8ZDB2l0Ph7VFkq/UwmsmrA3c4=;
        b=r5oLR4PczweTkeGzIMsJpPcW83WIBZr1UTUWRSYJCQQ9PXqRvNM0IUwty2hMcKL8JK
         OurQ+Ing+xvXqizy3rLxCNciFee8D5bYb7MG6WjxccnutFNYvorcRFOQBWqihMnbs/xz
         vqKz77GrvNpOhu0Aq/i6AFo7evyqfbGKQ7ItZncn2aJzJscaGu0fV13uF2YIC/nYvkZ5
         fz9V+5W5Z6EuUTJQ0fm6TWv3s+F/D51W6boPEwdOu3/PtvpDbHpWQHX4UcuGtTqvtnuQ
         63VSfpd0OgOoh9hunixURS1pGWJEdKKnG7COKMw8pHEdKN0EAFNXBW8YrdVbGIyaXrpU
         Ji6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739483375; x=1740088175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEDH/5BvKu8Lhm+jqz8ZDB2l0Ph7VFkq/UwmsmrA3c4=;
        b=WgsxAoj62Jb5HUgEBRTmqoHFNwDVBOLrzfnfFmyUs0k2dEHswa+RWf8+2k7R+Lhbsy
         VkJcIjwV9ngKGx5a1tWUKntnVLyEnHyfhjWENXAImz2GtifLsUhXm5LFhDuv6bDZ1MWS
         FIFxBI2mvbEP/AJ+hBBxc9xjbNlGEY8SlkVFliU4v1lsVrPHO4ySePAMdNlpNCvJMmqW
         CWCdtvp9wOVvesE/bP1tFt43yecWbIZQmYxxUPF/PNqqVrDwKbfqDmpfPLsfVY2rgL52
         6BeAo9jVK/p1ltbKzYEpO40IQROl/NQR0MgsFToX+V+PXWjcqzrXlhfYNqruJpm1PXAb
         asIw==
X-Forwarded-Encrypted: i=1; AJvYcCX7eF9SonlcAAw1Qeh4Qzb0UEMVQaR4dFfl3Y/T6M7mIdSKLtPQy5quLii3VvEJ2Tlt49xh/xmLnACQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SZN6WPmpOQ6ShHc0ebRi4dqf+WH4UxDhqdCMVn9xgRhkbMY4
	CL0HZnMqkpbtROHeFb8ACQur+5meYFUcTkyB0yovSGKiWST0z2qXsBA+HOqlhtw=
X-Gm-Gg: ASbGncvys5X3fBkF69fYNB9rmmHQeGj5BeR8PkWpJEm0SxiUdWiQdOEfAjZom4tmQC2
	kdOZcDpTvMePYgZGMhxS6oYHFDEYrJ+fw8p8fRHgMoNtIOAAW1ZesSF3NaEy+fB0v1iixWzSSom
	PHCZVfy5cQ82rExLjojjVNrKWZ1vVYSkRIJFipXYKrBV0SLPzOkZDJYHY5IUf4+0QA8gqfnoaPs
	whswMOrrqBL2apupXYLiuRWfmrOW4ip08hQIgkpOdiEtvExiddKNCeGy+5D3brhTtx0kPZtUqLQ
	GZvU0PEbfASTt9KjOv20ldTsiQrXvSWeksxkxk1mZPGFIMGiOZa/8v4hg5KeCpRsMiE=
X-Google-Smtp-Source: AGHT+IGu3LA2+kviLvU8k4d19E79vb/f8ZCZw06nOlk4KtTHwgy+U6i2eoIBD3cIaYDOp5otljisbQ==
X-Received: by 2002:a17:90b:258e:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-2fbf9072b46mr11048591a91.21.1739483375252;
        Thu, 13 Feb 2025 13:49:35 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b60dsm3791784a91.39.2025.02.13.13.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 13:49:34 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tih5O-00000000s8S-1WC3;
	Fri, 14 Feb 2025 08:49:30 +1100
Date: Fri, 14 Feb 2025 08:49:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
Message-ID: <Z65o6nWxT00MaUrW@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
 <Z60W2U8raqzRKYdy@dread.disaster.area>
 <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43e4cd9-d8aa-4cc0-a5ff-35f2e0553682@gmail.com>

On Thu, Feb 13, 2025 at 03:30:50PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 2/13/25 03:17, Dave Chinner wrote:
> > On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
> > > This testcase reproduces the following bug:
> > > Bug:
> > > mount -o remount,noattr2 <device> <mount_point> succeeds
> > > unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.
> > AFAICT, this is expected behaviour. Remount intentionally ignores
> > options that cannot be changed.
> > 
> > > Ideally the above mount command should always fail with a v5 xfs
> > > filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
> > > or not.
> > No, we cannot fail remount when invalid options are passed to the
> > kernel by the mount command for historical reasons. i.e. the mount
> > command has historically passed invalid options to the kernel on
> > remount, but expects the kernel to apply just the new options that
> > they understand and ignore the rest without error.
> > 
> > i.e. to keep compatibility with older userspace, we cannot fail a
> > remount because userspace passed an option the kernel does not
> > understand or cannot change.
> > 
> > Hence, in this case, XFS emits a deprecation warning for the noattr2
> > mount option on remount (because it is understood), then ignores
> > because it it isn't a valid option that remount can change.
> 
> Thank you, Dave, for the background. This was really helpful. So just to
> confirm the behavior of mount - remount with noattr2 (or any other invalid
> option) should always pass irrespective of whether CONFIG_XFS_SUPPORT_V4 is
> set or not, correct?

Not necessarily.

It depends on whether the filesystem considers it a known option or
not. noattr2 is a known option, so if it is invalid to use it as a
remount option, the remount should always fail.

If the option is -unknown-, then the behaviour of remount is largely
dependent on filesystem implementation -and- what mount syscall
interface is being used by userspace.

e.g. a modern mount binary using
fsconfig(2) allows the kernel to reject unknown options before the
filesystem is remounted. However, we cannot do that with the
mount(2) interface because of the historic behaviour of the mount
binary (see the comment above xfs_fs_reconfigure() about this).

Hence with a modern mount binary using the fsconfig(2) interface,
the kernel can actually reject bad/unknown mount options without
breaking anything. i.e. kernel behaviour is dependent on userspace
implementation...

> This is the behavior that I have observed with CONFIG_XFS_SUPPORT_V4=n on v5
> xfs:
> 
> $ mount -o "remount,noattr2" /dev/loop0 /mnt1/test
> mount: /mnt1/test: mount point not mounted or bad option.
> $ echo "$?"
> 32

This is not useful in itself because of all the above possibilities.
i.e. What generated that error?

Was if from the mount binary, or the kernel?  What syscall is mount
using - strace output will tell us if it is fsconfig(2) or mount(2)
and what is being passed to the kernel.  What does dmesg say - did
the kernel parse the option and then fail, or something else?

i.e. this is actually really hard to write a kernel and userspace
version agnostic regression test for.

> With this test, I am also parallelly working on a kernel fix to make the
> behavior of remount with noattr2 same irrespective of the
> CONFIG_XFS_SUPPORT_V4's value, and I was under the impression that it should
> always fail. But, it seems like it should always pass (silently ignoring the
> invalid mount options) and the failure when CONFIG_XFS_SUPPORT_V4=n is a
> bug. Is my understanding correct?

As per above, the behaviour we expose to userspace is actually
dependent on the syscall interface the mount is using.

That said, I still don't see why CONFIG_XFS_SUPPORT_V4 would change
how we parse and process noattr2.....

.... Ohhh.

The new xfs_mount being used for reconfiguring the
superblock on remount doesn't have the superblock feature
flags initialised. attr2 is defined as:

__XFS_ADD_V4_FEAT(attr2, ATTR2)

Which means if CONFIG_XFS_SUPPORT_V4=n it will always return true.

However, if CONFIG_XFS_SUPPORT_V4=y, then it checks for the ATTR2
feature flag in the xfs_mount.

Hence when we are validating the noattr2 flag in
xfs_fs_validate_params(), this check:

	/*                                                                       
         * We have not read the superblock at this point, so only the attr2      
         * mount option can set the attr2 feature by this stage.                 
         */                                                                      
        if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {                          
                xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");     
                return -EINVAL;                                                  
        }

Never triggers on remount when CONFIG_XFS_SUPPORT_V4=y because
xfs_has_attr2(mp) is always false.  OTOH, when
CONFIG_XFS_SUPPORT_V4=n, xfs_has_attr2(mp) is always true because of
the __XFS_ADD_V4_FEAT() macro implementation, and so now it rejects
the noattr2 mount option because it isn't valid on a v5 filesystem.

Ok, so CONFIG_XFS_SUPPORT_V4=n is the correct behaviour (known mount
option, invalid configuration being asked for), and it is the
CONFIG_XFS_SUPPORT_V4=y behaviour that is broken.

This likely has been broken since the mount option parsing was
first changed to use the fscontext interfaces....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

