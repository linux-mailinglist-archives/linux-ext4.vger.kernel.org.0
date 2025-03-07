Return-Path: <linux-ext4+bounces-6714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56728A56F5E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B69189A293
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1A242937;
	Fri,  7 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt1IBl0X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA9242910;
	Fri,  7 Mar 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369247; cv=none; b=DFIUelT+yN1AD/4G+XFMiqZ7od/DVhX8dGmfVMK1SUDiMfdlWXEa/Bo5QeDM1tqx4vO5nAGgYd//9tDV2sGB09uGcxkGxL9DCtJNBYEYZQ7eY4KO4CisLNCwrS10B6qh5ifqMLjz1xVGGBhT8rJrPq3OUKBkOPg3qAsJ+nDg6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369247; c=relaxed/simple;
	bh=+NmlaSsErqnbxtvOSwjLfNHWTnd/3qjiCEKhTCZHKo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wh02nY8p3QVRCGUduBG6nhAj+QkGroFMp8BhHQbdZlsspSZF2olqy+WXGqFk2gI1XzjbqArr9zbmeZJGKLBajrwi1po3D90KqeEjRirzwfEntn3DgNv2uElgcSstTeeb2DmWdHDqbxMwMeIP1ayfhXyj5UzW03tKgkFjC0RyKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt1IBl0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F82C4CED1;
	Fri,  7 Mar 2025 17:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741369246;
	bh=+NmlaSsErqnbxtvOSwjLfNHWTnd/3qjiCEKhTCZHKo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wt1IBl0Xqmib2Sv0t192/mKVbF0k0fTIjnY8pP/WfLxrYDa4iOuxfrhH2o43WtffJ
	 OpCn3l1Q0YJm9o+iRq3YBM0iPQD3qhaGAN0tUiUpW3utmHIgBiP9OAO2HIvABPtRV3
	 +RhqE4pGmREQ1+IxJgMuTmECI8AC2YfiohIHEeolLQzXuqCXCpBJgSEOXXrcH58Dsl
	 e2b17WWN20TWqPsgeW/0SJ5saH669kJ7gp2VujvTTHBFOmr1mq9Tj4zoe7fIFjgt4N
	 NprLjBDfqevN9ttFGy+JLrH5ZDGLhDLlMRDJB/13xJ7Y8ijQqcI7NMWI7ytwghvpvb
	 yBndMR+BChpMg==
Date: Fri, 7 Mar 2025 09:40:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <20250307174045.GR2803749@frogsfrogsfrogs>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
 <20250306174653.GP2803749@frogsfrogsfrogs>
 <716e0d26-7728-42bb-981d-aae89ef50d7f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <716e0d26-7728-42bb-981d-aae89ef50d7f@gmail.com>

On Fri, Mar 07, 2025 at 11:21:15AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 3/6/25 23:16, Darrick J. Wong wrote:
> > On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> > > Silently executing scripts during sourcing common/rc doesn't look good
> > > and also causes unnecessary script execution. Decouple init_rc() call
> > > and call init_rc() explicitly where required.
> > > 
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > ---
> > >   check           | 10 ++--------
> > >   common/preamble |  1 +
> > >   common/rc       |  2 --
> > >   soak            |  1 +
> > >   4 files changed, 4 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index ea92b0d6..d30af1ba 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -840,16 +840,8 @@ function run_section()
> > >   		_prepare_test_list
> > >   	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> > >   		_test_unmount 2> /dev/null
> > > -		if ! _test_mount
> > > -		then
> > > -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> > > -			status=1
> > > -			exit
> > > -		fi
> > Unrelated change?  I was expecting a mechanical ". ./common/rc" =>
> > ". ./common/rc ; init_rc" change in this patch.
> This patch adds an init_rc() call to _begin_fstests() in common/preamble and
> hence the above _test_mount() will be executed during that call. So this
> _test_mount isn't necessary here, right? _test_mount() will be executed (as
> a part of init_rc() call) before every test run. Please let me know if my
> understanding isn't correct.

It's true that in terms of getting the test filesystem mounted, the
_test_mount here and in init_rc are redundant.  But look at what happens
on error here -- we print "check: failed to mount..." to signal that the
new section's TEST_FS_MOUNT_OPTS are not valid, and exit the ./check
process.

By deferring the mount to the init_rc in _preamble, that means that
we'll run the whole section with bad mount options, most likely
resulting in every test spewing "common/rc: could not mount..." and
appearing to fail.

I think.  I'm not sure what "status=1; exit" does as compared to
"exit 1"; AFAICT the former actually results in an exit code of 0
because the (otherwise pointless) assignment succeeds.

Granted, the init_rc that you remove below would also catch that case
and exit ./check

> > >   	fi
> > > -	init_rc
> > Why remove init_rc here?
> Same reason as above.

But that's an additional change in behavior.  If there's no reason for
calling init_rc() from run_section() then that should be a separate
patch with a separate justification.

--D

> > 
> > > -
> > >   	seq="check.$$"
> > >   	check="$RESULT_BASE/check"
> > > @@ -870,6 +862,8 @@ function run_section()
> > >   	needwrap=true
> > >   	if [ ! -z "$SCRATCH_DEV" ]; then
> > > +		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
> > > +		[ $? -le 1 ] || exit 1
> > >   	  _scratch_unmount 2> /dev/null
> > >   	  # call the overridden mkfs - make sure the FS is built
> > >   	  # the same as we'll create it later.
> > > diff --git a/common/preamble b/common/preamble
> > > index 0c9ee2e0..c92e55bb 100644
> > > --- a/common/preamble
> > > +++ b/common/preamble
> > > @@ -50,6 +50,7 @@ _begin_fstest()
> > >   	_register_cleanup _cleanup
> > >   	. ./common/rc
> > > +	init_rc
> > >   	# remove previous $seqres.full before test
> > >   	rm -f $seqres.full $seqres.hints
> > > diff --git a/common/rc b/common/rc
> > > index d2de8588..f153ad81 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5754,8 +5754,6 @@ _require_program() {
> > >   	_have_program "$1" || _notrun "$tag required"
> > >   }
> > > -init_rc
> > > -
> > >   ################################################################################
> > >   # make sure this script returns success
> > >   /bin/true
> > > diff --git a/soak b/soak
> > > index d5c4229a..5734d854 100755
> > > --- a/soak
> > > +++ b/soak
> > > @@ -5,6 +5,7 @@
> > >   # get standard environment, filters and checks
> > >   . ./common/rc
> > > +# ToDo: Do we need an init_rc() here? How is soak used?
> > I have no idea what soak does and have never used it, but I think for
> > continuity's sake you should call init_rc here.
> 
> Okay. I think Dave has suggested removing this file[1]. This doesn't seem to
> used anymore.
> 
> [1] https://lore.kernel.org/all/Z8oT_tBYG-a79CjA@dread.disaster.area/
> 
> --NR
> 
> > 
> > --D
> > 
> > >   . ./common/filter
> > >   tmp=/tmp/$$
> > > -- 
> > > 2.34.1
> > > 
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 
> 

