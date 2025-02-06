Return-Path: <linux-ext4+bounces-6355-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B9A2AD10
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32901653B6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D81F4176;
	Thu,  6 Feb 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9XFf1zC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544E1F416D;
	Thu,  6 Feb 2025 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857172; cv=none; b=P+Fn3nsUhsItSbeqFBEV6rft68Wlqfs6ZLECMytdmiXffnw7DnHZq8nwZkc/hI8rGv+qZ3G/ghEXLm0QSV7i4nOin51WdCdz+3BTNbzZXtQpVobrufQ7cixYR3efqv2YEvWJibXyiykXIJsK4J7yBIVGpR5JT1iu1AkXiwb0en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857172; c=relaxed/simple;
	bh=VAG0wAGbBVNZNLNfRzf3eIVwshv0u3/X2PACi+RQzps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEnmlLqH8k56DtFBvAS6keZntYEDxpf9OMBVPL6ss8/c/+cE2yokztFEqosQ9xUanM1/UR9/6g/slk6+/xQD1ze/XJJ1Kf3Qi+A/Naym7rjoBOUvNGOeWofubw4n97Ihg0ajO9hP50UiZxPGffA/OOrmH+IgRifqgbqv2KslgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9XFf1zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203E5C4CEDD;
	Thu,  6 Feb 2025 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857172;
	bh=VAG0wAGbBVNZNLNfRzf3eIVwshv0u3/X2PACi+RQzps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9XFf1zCWzEw/2L1u1GqncU0X0wFQ7BSwhZuczZBakEjDQLgI6yvpht4FDhlU/Goi
	 Q0dR84rDqtShW56WR5EwzG/XAdub0nvXEtTJw+8z+NpceRNno0NGBMABxhnxdb4Pn7
	 25CuwvgIgRLMKk2y9LQC9j/KctU5nRq89lyGeZiBmjqBozgyLRNRUKv25WSpJ9aAPQ
	 mJyBvwvD1b0APdFwBQvCbxlEfMTJY6sN7yMbiOi4C9eQu0T5zodGIYzMxzh4wqrJHr
	 3jafkx4jiuJcIS+gavJbf+MRPqgqip/eYHkbBisJl8Q0PMJGoicNY7r3/Lu3sn68te
	 SHuMO6JxzqNPw==
Date: Thu, 6 Feb 2025 07:52:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2] check: Fix fs specfic imports when
 $FSTYPE!=$OLD_FSTYPE
Message-ID: <20250206155251.GA21787@frogsfrogsfrogs>
References: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
 <20250128180917.GA3561257@frogsfrogsfrogs>
 <f89b6b40-8dce-4378-ba56-cf7f29695bdb@gmail.com>
 <20250129160259.GT3557553@frogsfrogsfrogs>
 <dfbd2895-e29a-4e25-bbc6-a83826d14878@gmail.com>
 <20250131162457.GV1611770@frogsfrogsfrogs>
 <3599e504-8c2f-4196-9ce8-a4c458505888@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3599e504-8c2f-4196-9ce8-a4c458505888@gmail.com>

On Thu, Feb 06, 2025 at 11:05:42AM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 1/31/25 21:54, Darrick J. Wong wrote:
> > On Fri, Jan 31, 2025 at 06:49:50PM +0530, Nirjhar Roy (IBM) wrote:
> > > On 1/29/25 21:32, Darrick J. Wong wrote:
> > > > On Wed, Jan 29, 2025 at 04:48:10PM +0530, Nirjhar Roy (IBM) wrote:
> > > > > On 1/28/25 23:39, Darrick J. Wong wrote:
> > > > > > On Tue, Jan 28, 2025 at 05:00:22AM +0000, Nirjhar Roy (IBM) wrote:
> > > > > > > Bug Description:
> > > > > > > 
> > > > > > > _test_mount function is failing with the following error:
> > > > > > > ./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
> > > > > > > check: failed to mount /dev/loop0 on /mnt1/test
> > > > > > > 
> > > > > > > when the second section in local.config file is xfs and the first section
> > > > > > > is non-xfs.
> > > > > > > 
> > > > > > > It can be easily reproduced with the following local.config file
> > > > > > > 
> > > > > > > [s2]
> > > > > > > export FSTYP=ext4
> > > > > > > export TEST_DEV=/dev/loop0
> > > > > > > export TEST_DIR=/mnt1/test
> > > > > > > export SCRATCH_DEV=/dev/loop1
> > > > > > > export SCRATCH_MNT=/mnt1/scratch
> > > > > > > 
> > > > > > > [s1]
> > > > > > > export FSTYP=xfs
> > > > > > > export TEST_DEV=/dev/loop0
> > > > > > > export TEST_DIR=/mnt1/test
> > > > > > > export SCRATCH_DEV=/dev/loop1
> > > > > > > export SCRATCH_MNT=/mnt1/scratch
> > > > > > > 
> > > > > > > ./check selftest/001
> > > > > > > 
> > > > > > > Root cause:
> > > > > > > When _test_mount() is executed for the second section, the FSTYPE has
> > > > > > > already changed but the new fs specific common/$FSTYP has not yet
> > > > > > > been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
> > > > > > > the test run fails.
> > > > > > > 
> > > > > > > Fix:
> > > > > > > Remove the additional _test_mount in check file just before ". commom/rc"
> > > > > > > since ". commom/rc" is already sourcing fs specific imports and doing a
> > > > > > > _test_mount.
> > > > > > > 
> > > > > > > Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
> > > > > > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > > > > > ---
> > > > > > >     check | 12 +++---------
> > > > > > >     1 file changed, 3 insertions(+), 9 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/check b/check
> > > > > > > index 607d2456..5cb4e7eb 100755
> > > > > > > --- a/check
> > > > > > > +++ b/check
> > > > > > > @@ -784,15 +784,9 @@ function run_section()
> > > > > > >     			status=1
> > > > > > >     			exit
> > > > > > >     		fi
> > > > > > > -		if ! _test_mount
> > > > > > Don't we want to _test_mount the newly created filesystem still?  But
> > > > > > perhaps after sourcing common/rc ?
> > > > > > 
> > > > > > --D
> > > > > common/rc calls init_rc() in the end and init_rc() already does a
> > > > > _test_mount. _test_mount after sourcing common/rc will fail, won't it? Does
> > > > > that make sense?
> > > > > 
> > > > > init_rc()
> > > > > {
> > > > >       # make some further configuration checks here
> > > > >       if [ "$TEST_DEV" = ""  ]
> > > > >       then
> > > > >           echo "common/rc: Error: \$TEST_DEV is not set"
> > > > >           exit 1
> > > > >       fi
> > > > > 
> > > > >       # if $TEST_DEV is not mounted, mount it now as XFS
> > > > >       if [ -z "`_fs_type $TEST_DEV`" ]
> > > > >       then
> > > > >           # $TEST_DEV is not mounted
> > > > >           if ! _test_mount
> > > > >           then
> > > > >               echo "common/rc: retrying test device mount with external set"
> > > > >               [ "$USE_EXTERNAL" != "yes" ] && export USE_EXTERNAL=yes
> > > > >               if ! _test_mount
> > > > >               then
> > > > >                   echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
> > > > >                   exit 1
> > > > >               fi
> > > > >           fi
> > > > >       fi
> > > > > ...
> > > > ahahahaha yes it does.
> > > > 
> > > > /commit message reading comprehension fail, sorry about that.
> > > > 
> > > > Though now that you point it out, should check elide the init_rc call
> > > > about 12 lines down if it re-sourced common/rc ?
> > > Yes, it should. init_rc() is getting called twice when common/rc is getting
> > > re-sourced. Maybe I can do like
> > > 
> > > 
> > > if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
> > > 
> > >      <...>
> > > 
> > >      . common/rc # changes in this patch
> > > 
> > >      <...>
> > > 
> > > elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> > > 
> > >      ...
> > > 
> > >      init_rc() # explicitly adding an init_rc() for this condition
> > > 
> > > else
> > > 
> > >      init_rc() # # explicitly adding an init_rc() for all other conditions.
> > > This will prevent init_rc() from getting called twice during re-sourcing
> > > common/rc
> > > 
> > > fi
> > > 
> > > What do you think?
> > Sounds fine as a mechanical change, but I wonder, should calling init_rc
> > be explicit?  There are not so many places that source common/rc:
> > 
> > $ git grep 'common/rc'
> > check:362:if ! . ./common/rc; then
> > check:836:              . common/rc
> > common/preamble:52:     . ./common/rc
> > soak:7:. ./common/rc
> > tests/generic/749:18:. ./common/rc
> > 
> > (I filtered out the non-executable matches)
> > 
> > I think the call in generic/749 is unnecessary and I don't know what
> > soak does.  But that means that one could insert an explicit call to
> > init_rc at line 366 and 837 in check and at line 53 in common/preamble,
> > and we can clean up one more of those places where sourcing a common/
> > file actually /does/ something quietly under the covers.
> 
> Okay just to clear my understanding, do you mean that the call to init_rc()
> be removed from common/rc file and the places which actually need the call
> to init_rc, explicitly calls init_rc() instead of sourcing ". common/rc" and
> making common/rc do something under the cover?

Yes.  Callsites like this:

. ./common
<horrid bash code>

become this:

. ./common/rc
init_rc
<horrid bash code>

--D

> --NR
> 
> > 
> > (Unless the maintainer is ok with the status quo...?)
> > 
> > --D
> > 
> > > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > 
> > > > --D
> > > > 
> > > > > ...
> > > > > 
> > > > > --NR
> > > > > 
> > > > > 
> > > > > 
> > > > > > > -		then
> > > > > > > -			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
> > > > > > > -			status=1
> > > > > > > -			exit
> > > > > > > -		fi
> > > > > > > -		# TEST_DEV has been recreated, previous FSTYP derived from
> > > > > > > -		# TEST_DEV could be changed, source common/rc again with
> > > > > > > -		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
> > > > > > > +		# Previous FSTYP derived from TEST_DEV could be changed, source
> > > > > > > +		# common/rc again with correct FSTYP to get FSTYP specific configs,
> > > > > > > +		# e.g. common/xfs
> > > > > > >     		. common/rc
> > > > > > >     		_prepare_test_list
> > > > > > >     	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
> > > > > > > -- 
> > > > > > > 2.34.1
> > > > > > > 
> > > > > > > 
> > > > > -- 
> > > > > Nirjhar Roy
> > > > > Linux Kernel Developer
> > > > > IBM, Bangalore
> > > > > 
> > > -- 
> > > Nirjhar Roy
> > > Linux Kernel Developer
> > > IBM, Bangalore
> > > 
> > > 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 
> 

