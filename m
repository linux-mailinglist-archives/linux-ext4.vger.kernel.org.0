Return-Path: <linux-ext4+bounces-5384-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 881519D6447
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B284B161B88
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 18:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697B1E008C;
	Fri, 22 Nov 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUB9fKUh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DE1DFE2A;
	Fri, 22 Nov 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301068; cv=none; b=bg9+3nPLkgYcl0j/sCFa1+C8LNVaHS+ma7C+MloXjoSWu3A4Xu+AZk7opc0Bzta1OvJQ8oG4tSSwH/E5kH0049J63STzvBZnWwtaQJOKFCU8DdAPYf3XBL757L66eudYkeENEYePRK/0QUQaI90F7ImRgFNlzBJxBVe9WEUlq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301068; c=relaxed/simple;
	bh=e/XIHDpe59oE1/S/+5cCI+kVL3qGPSRE3Y8/WaS0BSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWA8u/wjvJ9LI9EJPSw36Q0MLGO7VXcRqi0D8ZXU1pMRADciLtfiZlDAOmIasna3SyI2BHWANz6PHd+9oRICQcn71tmYyngav9WFth7PmXZN/f69AaVlVALuUgTDvBMV27WUrBhWTU6+Kw1IIAnsdKHlFailW6b2TuMhAbfHzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUB9fKUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF622C4CED0;
	Fri, 22 Nov 2024 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732301067;
	bh=e/XIHDpe59oE1/S/+5cCI+kVL3qGPSRE3Y8/WaS0BSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUB9fKUhPiC4OaoOBGQsLMY/03iMaW1j3vQLDRqa8NQ2YO4uW4m1TYTA1ZSww937v
	 Arhe5trKeIXQemr4go6a6letxSmleA4ZmkgkkG3syW/iOO8ina/xvo0Ic1X0xd0ro7
	 eGiJY5MmpE6soDkpeZCO0QhFpHTFhqJ8F6JcaSTqvPXUf1YkYX34AX5oAaOan5AnDC
	 XOJQWqbVwMwqKbRx/Z0mw0TSAky+JduaIxgUyinBBATQe1kONNhNK8bmvqDFnwFYIo
	 gECq44V1eAppv04Tl665KXqGwCKaKtwacF8b5UVsetepRXaICrAgG8VnaEupa0410y
	 s7OfKhElzdEnw==
Date: Fri, 22 Nov 2024 10:44:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Message-ID: <20241122184426.GK1926309@frogsfrogsfrogs>
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
 <87plmp81km.fsf@gmail.com>
 <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
 <871pz4xvuu.fsf@gmail.com>
 <20241122160430.GZ9425@frogsfrogsfrogs>
 <7bf1c177-1213-4c35-80bc-620d02a441c2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf1c177-1213-4c35-80bc-620d02a441c2@linux.ibm.com>

On Fri, Nov 22, 2024 at 11:37:17PM +0530, Nirjhar Roy wrote:
> 
> On 11/22/24 21:34, Darrick J. Wong wrote:
> > On Fri, Nov 22, 2024 at 12:22:41AM +0530, Ritesh Harjani wrote:
> > > Nirjhar Roy <nirjhar@linux.ibm.com> writes:
> > > 
> > > > On 11/21/24 13:23, Ritesh Harjani (IBM) wrote:
> > > > > Nirjhar Roy <nirjhar@linux.ibm.com> writes:
> > > > > 
> > > > > > _require_scratch_extsize helper function will be used in the
> > > > > > the next patch to make the test run only on filesystems with
> > > > > > extsize support.
> > > > > > 
> > > > > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > > Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> > > > > > ---
> > > > > >    common/rc | 17 +++++++++++++++++
> > > > > >    1 file changed, 17 insertions(+)
> > > > > > 
> > > > > > diff --git a/common/rc b/common/rc
> > > > > > index cccc98f5..995979e9 100644
> > > > > > --- a/common/rc
> > > > > > +++ b/common/rc
> > > > > > @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
> > > > > >    	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
> > > > > >    }
> > > > > > +# This test requires extsize support on the  filesystem
> > > > > > +_require_scratch_extsize()
> > > > > > +{
> > > > > > +	_require_scratch
> > > > > _require_xfs_io_command "extsize"
> > > > > 
> > > > > ^^^ Don't we need this too?
> > > > Yes, good point. I will add this in the next revision.
> > > > > > +	_scratch_mkfs > /dev/null
> > > > > > +	_scratch_mount
> > > > > > +	local filename=$SCRATCH_MNT/$RANDOM
> > > > > > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > > > > > +	local extsz=$(( blksz*2 ))
> > > > > > +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
> > > > > > +		-c "extsize")
> > > > > > +	_scratch_unmount
> > > > > > +	grep -q "\[$extsz\] $filename" <(echo $res) || \
> > > > > > +		_notrun "this test requires extsize support on the filesystem"
> > > > > Why grep when we can simply just check the return value of previous xfs_io command?
> > > > No, I don't think we can rely on the return value of xfs_io. For ex,
> > > > let's look at the following set of commands which are ran on an ext4 system:
> > > > 
> > > > root@AMARPC: /mnt1/test$ xfs_io -V
> > > > xfs_io version 5.13.0
> > > > root@AMARPC: /mnt1/test$ touch new
> > > > root@AMARPC: /mnt1/test$ xfs_io -c "extsize 8k"  new
> > > > foreign file active, extsize command is for XFS filesystems only
> > > > root@AMARPC: /mnt1/test$ echo "$?"
> > > > 0
> > > > This incorrect return value might have been fixed in some later versions
> > > > of xfs_io but there are still versions where we can't solely rely on the
> > > > return value.
> > > Ok. That's bad, we then have to rely on grep.
> > > Sure, thanks for checking and confirming that.
> > You all should add CMD_FOREIGN_OK to the extsize command in xfs_io,
> > assuming that you've not already done that in your dev workspace.
> > 
> > --D
> 
> Yes, I have tested with that as well. I have applied the following patch to
> xfsprogs and tested with the modified xfs_io.
> 
> diff --git a/io/open.c b/io/open.c
> index 15850b55..6407b7e8 100644
> --- a/io/open.c
> +++ b/io/open.c
> @@ -980,7 +980,7 @@ open_init(void)
>         extsize_cmd.args = _("[-D | -R] [extsize]");
>         extsize_cmd.argmin = 0;
>         extsize_cmd.argmax = -1;
> -       extsize_cmd.flags = CMD_NOMAP_OK;
> +       extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
>         extsize_cmd.oneline =
>                 _("get/set preferred extent size (in bytes) for the open
> file");
>         extsize_cmd.help = extsize_help;
> 
> The return values are similar.
> 
> root@AMARPC: /mnt1/scratch$ touch new
> root@AMARPC: /mnt1/scratch$ /home/ubuntu/xfsprogs-dev/io/xfs_io -c "extsize
> 8k" new
> root@AMARPC: /mnt1/scratch$ echo "$?"
> 0
> root@AMARPC: /mnt1/scratch$ /home/ubuntu/xfsprogs-dev/io/xfs_io -c "extsize"
> new
> [0] new
> 
> This is the reason I am not relying on the return value, instead I am
> checking if only the extsize gets changed, we will assume that the extsize
> support is there, else the test will _notrun.
> 
> Also,
> 
> root@AMARPC: /mnt1/scratch$ strace -f /mnt1/scratch$
> /home/ubuntu/xfsprogs-dev/io/xfs_io -c "extsize 16k" new
> 
> ...
> 
> ...
> 
> ioctl(3, FS_IOC_FSGETXATTR, {fsx_xflags=0, fsx_extsize=0, fsx_nextents=0,
> fsx_projid=0, fsx_cowextsize=0}) = 0
> ioctl(3, FS_IOC_FSSETXATTR, {fsx_xflags=FS_XFLAG_EXTSIZE, fsx_extsize=16384,
> fsx_projid=0, fsx_cowextsize=0}) = 0
> exit_group(0)
> 
> Looking at the existing code for ext4_fileattr_set(), We validate the flags
> but I think we silently don't validate(and ignore) the xflags. Like, we have
> 
> int err = -EOPNOTSUPP;
> if (flags & ~EXT4_FL_USER_VISIBLE)
>         goto out;
> 
> BUT we do NOT have something like
> 
> int err = -EOPNOTSUPP;
> if (fa->fsx_flags & ~EXT4_VALID_XFLAGS) // where EXT4_VALID_XFLAGS should be
> an || of all the supported xflags in ext4.
>         goto out;
> 
> I am not sure what other filesystems do, but if we check whether the extsize
> got changed, then we can correctly determine extsize support.
> 
> Does that make sense?

You don't have to check fsx_flags if you don't use fileattr_fill_xflags.
ext4 doesn't use that.

--D

> --NR
> 
> 
> 
> > 
> > > -ritesh
> > > 
> -- 
> ---
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

