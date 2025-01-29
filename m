Return-Path: <linux-ext4+bounces-6273-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34803A22121
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 17:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583AC3A2D16
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2025 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB145023;
	Wed, 29 Jan 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1RGNuc7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF72853A7;
	Wed, 29 Jan 2025 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166581; cv=none; b=lrJcl0TXR3ckWLyrZxNPMerTXvPteEz3ByRN2vmshyXz88jS1K92//9Z6lNGlQTr1rOMVAUHoj/O+BKQSP+fPqzP6RZ2o1s+DJ8psAvFkgLMkjBhFIRuWJvHXBb0cMz2LjInYtzVfq0B9PcKRNqZnbqks0xiQ4fhaYonhl/afng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166581; c=relaxed/simple;
	bh=n7RRE34Y/nYRpXOp/8WNy/heEVTd+pE5XQIcq2Nwvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUc+WK0Qr75KlMn78e+a/M29ZJa2hT7WfCBYwA5FYBRjOKrVgZHHdghcqWZMOEr/1Hd2mJY5BUJ6N9IzGxEJSjApjcbt7Dc4jQgMQQxnkP8gfSt9v4e7SEdGXrXxYwV/c1542tWTeuaOz7Nvi5mL/h1cpDptVIUMTWTzDJAoQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1RGNuc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D76C4CED1;
	Wed, 29 Jan 2025 16:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738166580;
	bh=n7RRE34Y/nYRpXOp/8WNy/heEVTd+pE5XQIcq2Nwvgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1RGNuc70KgInSzahi5fOD+gEUrXSvVSPPI2lHmHb7Y7mKQHDmLF0gYvdQdxbwvA2
	 VfJemOUG1SIUK/Td9UCImOMvyzjWc7czLhK8Sd2FD9gNd5tV8KrHFSeiaUHOo1d+Da
	 Y8bjeVeiWmF+4xZgvgKBcq1gkoPXoxTbwae40NKkkEAA7NYyaKdiDm/BZdepO5rAFD
	 OSAjhE2SKGNecb79fYY64smZSyjUHWv9UCM692CQ95tmmEy17LgOyInIlqxpFlL9y5
	 NNg4dmQmSemqg9GZQORLag7jSkr6awuIi3TLMsX1Iuul2YE/Iw93gSTswNdrVU/Xr8
	 xUab2EJpD6TtA==
Date: Wed, 29 Jan 2025 08:02:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250129160259.GT3557553@frogsfrogsfrogs>
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
 <20250128180917.GA3561257@frogsfrogsfrogs>
 <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>

On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 1/28/25 23:39, Darrick J. Wong wrote:
> > On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
> > > Bug Description:
> > > 
> > > _test_mount function is failing with the following error:
> > > ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> > > check: failed to mount /dev/loop0 on /mnt1/test
> > > 
> > > when the second section in local.config file is xfs and the first section
> > > is non-xfs.
> > > 
> > > It can be easily reproduced with the following local.config file
> > > 
> > > [s2]
> > > export FSTYP=ext4
> > > export TEST_DEV=/dev/loop0
> > > export TEST_DIR=/mnt1/test
> > > export SCRATCH_DEV=/dev/loop1
> > > export SCRATCH_MNT=/mnt1/scratch
> > > 
> > > [s1]
> > > export FSTYP=xfs
> > > export TEST_DEV=/dev/loop0
> > > export TEST_DIR=/mnt1/test
> > > export SCRATCH_DEV=/dev/loop1
> > > export SCRATCH_MNT=/mnt1/scratch
> > > 
> > > ./check selftest/001
> > > 
> > > Root cause:
> > > When _test_mount() is executed for the second section, the FSTYPE has
> > > already changed but the new fs specific common/$FSTYP has not yet
> > > been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
> > > the test run fails.
> > > 
> > > Fix:
> > > Remove the additional _test_mount in check file just before ". commom/rc"
> > > since ". commom/rc" is already sourcing fs specific imports and doing a
> > > _test_mount.
> > > 
> > > Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   check | 12 +++---------
> > >   1 file changed, 3 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index 607d2456..5cb4e7eb 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -784,15 +784,9 @@ function run_section()
> > >   			status=1
> > >   			exit
> > >   		fi
> > > -		if ! _test_mount
> > Don't we want to _test_mount the newly created filesystem still?  But
> > perhaps after sourcing common/rc ?
> > 
> > --D
> 
> common/rc calls init_rc() in the end and init_rc() already does a
> _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
> that make sense?
> 
> init_rc()
> {
>     # make some further configuration checks here
>     if [ "$TEST_DEV" = ""  ]
>     then
>         echo "common/rc: Error: \$TEST_DEV is not set"
>         exit 1
>     fi
> 
>     # if $TEST_DEV is not mounted, mount it now as XFS
>     if [ -z "`_fs_type $TEST_DEV`" ]
>     then
>         # $TEST_DEV is not mounted
>         if ! _test_mount
>         then
>             echo "common/rc: retrying test device mount with external set"
>             [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
>             if ! _test_mount
>             then
>                 echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
>                 exit 1
>             fi
>         fi
>     fi
> ...

ahahahaha yes it does.

/commit message reading comprehension fail, sorry about that.

Though now that you point it out, should check elide the init_rc call
about 12 lines down if it re-sourced common/rc ?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ...
> 
> --NR
> 
> 
> 
> > 
> > > -		then
> > > -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> > > -			status=1
> > > -			exit
> > > -		fi
> > > -		# TEST_DEV has been recreated, previous FSTYP derived from
> > > -		# TEST_DEV could be changed, source common/rc again with
> > > -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
> > > +		# Previous FSTYP derived from TEST_DEV could be changed, source
> > > +		# common/rc again with correct FSTYP to get FSTYP specific configs,
> > > +		# e.g. common/xfs
> > >   		. common/rc
> > >   		_prepare_test_list
> > >   	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> > > -- 
> > > 2.34.1
> > > 
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

