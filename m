Return-Path: <linux-ext4+bounces-6308-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38AA27E19
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F02166CC2
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5923021ADCB;
	Tue,  4 Feb 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LdJ/pvS7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC19219E98
	for <linux-ext4@vger.kernel.org>; Tue,  4 Feb 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707245; cv=none; b=sSyc5BKx7PpBbPPgpFwBr8gl05/zCQW0rMDS/rwP91atlCQ+EtJIFvgt26KZtlBWuEKt+klJMeDKd24jfVcWSoemcQRGgkIFDmsk75iOXTP87IArL5+QNDkzbm8yjPlTZjPr8z2gKecdktlqjpE4Su2XKOZkEZ+Wf1xYiiDKZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707245; c=relaxed/simple;
	bh=7k7VEs6V4yvlIYtIgsJdw/4fFAfiL96U9mT+408AOFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8GXFkMgSq9FcOCClABiLO6Z7WC8+v8RyNQoX+fl4KTRm+32C0M3XVk8tS69cj4FatU/XQ2UgdLy9GfFTaT/1K/7FASfjKahtdJXuiugzZXSWCjEhQuoWbepUNgwXky6IwbcvPpxU8py/eaEGgUbVc+6xqySpCN8t4nsFsbzOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LdJ/pvS7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f0bc811dbso3382565ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 04 Feb 2025 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738707242; x=1739312042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JayNHPls2+KCB/QM9GkK/iKI+liBYw5DSmO3rqCbMoM=;
        b=LdJ/pvS7EgMOVSPYVNsF3HkTEeOEbCnqfVhbOsfg5XO11+dSnWPMmiDQLpIKCVBu7N
         uD4KVd+wTNW+nmxBa18r4fBi+d0q3watk1VL75/ecCp1Po/XC6wqJYRYwcMQWVEsaUm3
         3SkfdV5syI+9+CUQO42TSXw/yRkYOQlHPAs2WPMLPjzj6kiPzJhCMl6o6npF4C8nfJmy
         Nb1MFDxyPgYVYzKE+C3ekyHfOHy99rYSYCPPwP+wdvcnmYr3KHUqjtMlQJvFV7CaH/tH
         yD5sZkOsOGqqYQxI3gIyRlHQs4iWbL/QtsHnPLrbDa2g24tWW2CkODfLCSO20t/rcX/M
         2LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738707242; x=1739312042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JayNHPls2+KCB/QM9GkK/iKI+liBYw5DSmO3rqCbMoM=;
        b=F5n+atOHxc23nY2m14FNgJZBWSNL9LsJ3LBPEzlEKzTO7TZzR7L53d1/VwANIGoCsy
         FA2RezYhsvbc8UfwFdN81Wr4DqOnXNTR/dwNh02mtL0HVkuNY7yXa9KxQtbaF5EU2dVG
         Ah6a2RkC6y9J0dO/k/K/EIrK1zlPfUOkrqx5rBst7Ddb3f5olRQP3Nkf/1igxTwJCseO
         Bag46KGNS7AdP2maSQJnZRBqsfcRsKc+kLNXszk3eHl7uVUfI/ylY0hRqc5WcxPjGH5s
         cUvuTcSu/ZbY2BV1oTlkMwQyBisa5WwfkMMXBwkJuYhR7OEwikpgRYZbukLf6VJAUEzS
         l8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWqNgdrs289MESjk79Zmv3buVt5O7KlNe6Wox70bBAFVGjs0C27ILOssJAvpMvKy58AP+Yr4Os5f7Tl@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpqgDkywyOKIPfrVcXFP33Isv0rVnMfLu273/i7mU9XNPAVF/
	WOdt5Gn6SiuArFph93Kcpr7Mm05+OPCcnek3pk8t6VVe/PaAF89/93AaTI/imA0=
X-Gm-Gg: ASbGncsmMvyAEKya06U/NMvxncLQiT8AdmHNSFbdnEYVHaHVj5RelSFJ0MtMG3uJtR8
	pqST5aFtHeMr7ftNk7AtF7et5+3jwnIASnWCqFRLX5YYsJpyRnMO9wSCHVCMygx1ofKNsCkwEpy
	QE5wbwZXxMpNMZl1a2TLRbZNjJA8y4WdT0CVrXYBSsex8fC1lVxkramFtLFGH2ciHdwWNQLGuJ4
	RI7VIyL1U8BagKfqi7Jg7KxldShBvzdiy4PkFC+bM4eg2jYkcQJYTtOpuny9UrLiNb58qtYkTzN
	2G5BJ7ozL2u6qQ7IG0Xm3Q2HIb9IHB4EZ/vLopbHFD3D6WW5mV0UUeSy
X-Google-Smtp-Source: AGHT+IHkvIHDhdySNOW6VZEb8eIoNXolZYs/YoDMCWGI63BQ4T3PlFG/RA89aby7eIz+5CNjxxSWHg==
X-Received: by 2002:a05:6a00:179c:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-730271ffbd9mr9456022b3a.5.1738707242177;
        Tue, 04 Feb 2025 14:14:02 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe653ab20sm11110741b3a.76.2025.02.04.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 14:14:01 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfRB9-0000000EgYl-0ZW2;
	Wed, 05 Feb 2025 09:13:59 +1100
Date: Wed, 5 Feb 2025 09:13:59 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	dchinner@redhat.com, jack@suse.cz, tytso@mit.edu,
	linux-ext4@vger.kernel.org, nirjhar.roy.lists@gmail.com,
	zlang@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] xfstests: Centralizing filesystem configs and
 device configs
Message-ID: <Z6KRJ3lcKZGJE9sX@dread.disaster.area>
References: <Z55RXUKB5O5l8QjM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z6FFlxFEPfJT0h_P@dread.disaster.area>
 <87ed0erxl3.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed0erxl3.fsf@gmail.com>

On Tue, Feb 04, 2025 at 12:44:00PM +0530, Ritesh Harjani wrote:
> Dave Chinner <david@fromorbit.com> writes:
> 
> > On Sat, Feb 01, 2025 at 10:23:29PM +0530, Ojaswin Mujoo wrote:
> >> Greetings,
> >> 
> >> This proposal is on behalf of Me, Nirjhar and Ritesh. We would like to submit
> >> a proposal on centralizing filesystem and device configurations within xfstests
> >> and maybe a further discussion on some of the open ideas listed by Ted here [3].
> >> More details are mentioned below.
> >> 
> >> ** Background ** 
> >> There was a discussion last year at LSFMM [1] about creating a central fs-config
> >> store, that can then be used by anyone for testing different FS
> >> features/configurations. This can also bring an awareness among other developers
> >> and testers on what is being actively maintained by FS maintainers. We recently
> >> posted an RFC [2] for centralizing filesystem configuration which is under
> >> review. The next step we are considering is to centralize device configurations
> >> within xfstests itself. In line with this, Ted also suggested a similar idea (in
> >> point A) [3], where he proposed specifying the device size for the TEST and
> >> SCRATCH devices to reduce costs (especially when using cloud infrastructure) and
> >> improve the overall runtime of xfstests.
> >> 
> >> Recently Dave introduced a feature [4] to run the xfs and generic tests in
> >> parallel. This patch creates the TEST and SCRATCH devices at runtime without
> >> requiring them to be specified in any config file. However, at this stage, the
> >> automatic device initialization appears to be somewhat limited. We believe that
> >> centralizing device configuration could help enhance this functionality as well.
> >
> > Right, the point of check-parallel is to take away the need to
> > specify devices completely.  I've already added support for the
> > LOGWRITES_DEV, and I'm in the process of adding LOGDEV and RTDEV
> > support for both test and scratch devices. At this point, the need
> > for actual actual device specification in the config files goes
> > away.
> >
> > What I am expecting to need is a set of fields that specify the
> > *size* of the devices so that the hard-coded image file sizes in
> > the check-parallel script go away.
> >
> > From there, I intend to have check-parallel iterate config file run
> > sections itself, rather than have it run them internally to check.
> > That way check is only ever invoked by check-parallel with all the
> > devices completely set up.
> 
> Yes, this sounds good. This is what we were anticipating too.
> Thanks for sharing.
> 
> >
> > Hence a typical host independent config file would look like:
> 
> The work being proposed by us here was to make this config file
> centralized within xfstests itself for both fsconfig and device-config.
> This saves us from defining each of this section within local.config file
> and can be used by passing cmdling arguments to invoke a given section
> directly. 
> 
> e.g.
> 
>     ./check -c configs/xfs/64k -g auto

This strikes me as re-implementing config sections with a different
file format.

> There have been cases where testers and others have requested info to
> know about - 
> - What different FS config options to test,
> - What gets tested by the Maintainers,  
> - Is there a common place where I can find MKFS and MOUNT options which
>   I should be testing for my FS/feature testing. 

Those are questions that documentation should answer - they are not
a reason for changing config file formats.

> That is the reason, I think, centralizing fsconfig option can be
> helpful. I remember bringing this idea in our last LSFMM-2024, where you
> mentioned that - let's see the RFC [1] and maybe then we can discuss more :).
> Here is the RFC for the same. There are some additional improvements in
> that series, but it mainly adds fsconfig option.
> 
> [1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/

Yeah, that's just making a tiny config file per config section, and
having to add a heap of parsing code to do that.

I find it much easier to manage a single config file where each
config is maybe only one or two lines than it is to have to find the
needle in a haystack of hundreds of tiny files that are almost all
alike.

> > TEST_DEV_SIZE=10g
> > TEST_RTDEV_size=10g
> > TEST_LOGDEV_SIZE=128m
> > SCRATCH_DEV_SIZE=20g
> > SCRATCH_RTDEV_size=20g
> > SCRATCH_LOGDEV_SIZE=512m
> > LOGWRITES_DEV_SIZE=2g
> >
> 
> For centralizing device-configs idea, I was hoping we could mention above
> in "configs/devices/loop" config file. This can be picked up by ./check
> too if local.config hasn't been provided with these options.

Great. How do you specify where the image files are going to be
hosted when no devices have been configured?

These sorts of zero-conf chicken/egg problems have already been
solved by check-parallel - I'm really not convinced that we need
to make check itself try to solve these. I designed check-parallel
the way I did because making check itself solve these problems is
.... convoluted and difficult.

If we need zero-conf, just use ./check-parallel....

> > [xfs]
> > FSTYP=xfs
> > MKFS_OPTIONS="-b size=4k"
> > TEST_FS_MOUNT_OPTIONS=
> > MOUNT_OPTIONS=
> > USE_EXTERNAL=
> >
> > [xfs-rmapbt]
> > MKFS_OPTIONS="-b size=4k -m rmapbt=1"
> >
> > [xfs-noreflink]
> > MKFS_OPTIONS="-b size=4k -m reflink=0"
> >
> > [xfs-n64k]
> > MKFS_OPTIONS="-b size=4k -n size=64k"
> >
> > [xfs-ext]
> > MKFS_OPTIONS="-b size=4k"
> > USE_EXTERNAL=yes
> >
> > [ext4]
> > FSTYP="ext4"
> > MKFS_OPTIONS=
> > USE_EXTERNAL=
> >
> > [btrfs]
> > FSTYP="btrfs"
> > .....
> 
> Above all fs configs could be added to configs/{ext4|xfs|btrfs}/... 
> Than this can be used in 2 ways.. 
> 
> 1. ./check -c configs/xfs/4k,configs/xfs/rmapbt,configs/ext4/4k ... 

Can't say I like using relative paths to specify the config we
should use. It's not an interface I'd choose over:

	./check -s xfs -g auto

Especially as the existing config section implementation does
exactly the same thing as the proposed config file farm....

> 2. Or we may still pass fsconfig via local.config file.. e.g. 
> 
> # both configs/xfs/4k or xfs/4k can be used here
> [xfs]
> FS_CONFIG_OPTION=configs/xfs/4k
> 
> [xfs-rmapbt]
> FS_CONFIG_OPTION=xfs/rmapbt
> 
> [xfs-noreflink]
> FS_CONFIG_OPTION=xfs/noreflink
> 
> [xfs-n64k]
> FS_CONFIG_OPTION=xfs/64k
> 
> [xfs-ext]
> FS_CONFIG_OPTION=xfs/4k
> USE_EXTERNAL=yes
> 
> [ext4]
> FS_CONFIG_OPTION=ext4/4k

How is that an improvement on the section setup we have right now?
Abstracting the config section options into a separate file is the
worst of both worlds - now I have to look up the section to find the
file and the section options, then lookup the file to see the
options that file contains.

It's like you've decided that the solution to centralised management
of configs must be "one config per file", and so every other way of
managing options needs to be reframed for that solution....

> > IOWs, all that is different from system to system is the device size
> > setup. The actual config sections under test (e.g. [xfs]) never need
> > to change from host to host, nor environment to environment. i.e.
> > "xfs-n64k" runs the same config filesystem test on every system,
> > everywhere...
> 
> Right. So it's also useful if those configs can stay in configs/<fs>/**
> as well.

Why is having hundreds of tiny single-config-only files
better than having all the configs in a single file that is
easily browsed and searched?

Honestly, I really don't see any advantage to re-implementing config
sections as a "file per config" object farm. Yes, you can store
information that way, but that doesn't make it an improvement over a
single file...

All that is needed is for the upstream repository to maintain a
config file with all the config sections defined that people need.
We don't need any new infrastructure to implement a "centralised
configs" feature - all we need is an agreement that upstream will
ship an update-to-date default config file instead of the ancient,
stale example.config/localhost.config files....

> > I don't really see a need for a new centralised config setup. With
> > the above, we can acheived a "zero-config" goal with the existing
> > config file formats and infrastructure. All that we need to do is
> > update the default config file in the repo to contain a section for
> > each of the "standard" test configs we want to define....
> 
> Could you please take look at the shared RFC [1] once? I believe it will
> be useful to have this central to xfstests for reasons I mentioned
> above. This also gets us to zero-config setup with almost no need to
> configure anything.

[1]: https://lore.kernel.org/fstests/cover.1736496620.git.nirjhar.roy.lists@gmail.com/

There's nothing in that which provides zero-config. It still
requires all the devices to be specified by the user...

> This helps other testers & subsystem maintainers to
> know what configs are being tested by maintainers, which they can use
> for their FS feature testing too.
> We can than directly issue -
> 
>            ./check -c <fs>/<config> -g quick

As I've already said: this functionality already exists - they are
called config sections!

> >> Additionally, we would like to thank Ted for listing several features he uses in
> >> his custom kvm-xfstests and gce-xfstests [3]. If there is an interest in further
> >> reducing the burden of maintaining custom test scripts and wrappers around
> >> xfstests, we can also discuss essential features that could be integrated
> >> directly into xfstests, whether from Ted's list or suggestions from others.
> >
> > On of my goals with check-parallel is to completely remove the need
> > for end users to configure fstests. i.e. all you need to do is point
> > it at a directory, tell it which filesystem to test, and it "just
> > runs" with all the defaults that come direct from the fstests
> > repository...
> >
> 
> Right. Centralizing fsconfigs & device configs is also doing the same.
> In fact once we have configs/devices/loop config file, then we don't
> need to even create local.config file (for most cases I believe).
> 
> ./check and ./check_parallel can be passed these config files and
> xfstests infra will create loop devices, run the tests and later do the
> cleanups.

Please, no.

check-parallel already provides the external zero-conf
infrastructure that check needs to run without config. It solves the
chicken/egg problems that check itself has (e.g. how do you specify
the location of the loop device image files it needs to create for
zero-conf), and it does it without needing check or it's internal
infrastructure to be modified in any way.

I've already outlined how we can use check-parallel to run check in
it's traditional serial form, so there is absolutely no need to try
to make check jump through hoops to do zero-conf internally.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

