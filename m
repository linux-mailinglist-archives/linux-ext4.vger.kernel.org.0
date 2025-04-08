Return-Path: <linux-ext4+bounces-7140-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F30A81277
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8854C17ED
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D922E40E;
	Tue,  8 Apr 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbNAGFBo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E31DE3A9;
	Tue,  8 Apr 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129966; cv=none; b=FGPqe2q46vtF3h2N/1c+JXqtpToUJ2AaduJfs6PrcvWDNMkzyAcuGI2Yj8sTbQkwKmZpUZFJQ28X14P0CazpkUjP4NZ+4rOS5/puoLL3VXt9GwMSV7B1KAuLnqD+BD48Cg0/+59gcHvY29E4s1twkFnf+WdS5rpbsF/PA+BzB8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129966; c=relaxed/simple;
	bh=/11XW1FCK7k61FPOSSR5PIk9C1BVk1Kjg+fmIxK0Y6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOR4qniH3/z6ERjL77I1mR2jeWds7QHrsY6EDslc7eIlKrfD+wxMes29cXQKz9rwqJ+4f7kOGo4x3N7XKV3kX5lcRdNY+EdPvOaPI4kt33kJnU0/P8nzGKzCq1s77v5F04VW9kW5mmODHfz6P2DZugXsXBYW9hYpvZIf/p3bQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbNAGFBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ED4C4CEE5;
	Tue,  8 Apr 2025 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744129965;
	bh=/11XW1FCK7k61FPOSSR5PIk9C1BVk1Kjg+fmIxK0Y6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbNAGFBof3jNedBWhPcad6j2eufQxzOoEHnPygdy0zJ5B2hU4csFt57uGJsN6jRsH
	 j7yIV7Vjm47jKF2eFK8QAae9jjdOGfPV2qwlR9E9GwGxkS6TjV0pUvSiRF1fe722Yu
	 RjsP40tFWu5lCttKG7H/APUn6QFYiUsEfvdXWLbxUZ14JhxRuPWRA8vYcVJOuKXrrY
	 h3+8vsr++tPfTe0uu8D1sfkf+kHfperR/MHEb67fYM65fwFh5x7Spstc0WjnF7rw6W
	 glrizGeJZ0L/UrPkBbhiVBGQlp/T9abMhVkJ6IeSmKCH50BtVyzv3V1KsVUJMquJV/
	 Cc3VUcmq9Tf/A==
Date: Tue, 8 Apr 2025 09:32:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v3 5/6] common/config: Introduce _exit wrapper around
 exit command
Message-ID: <20250408163244.GH6307@frogsfrogsfrogs>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
 <87y0wbj9ru.fsf@gmail.com>
 <0e4817b5-bd20-4ea6-93f4-ec0bee9bf833@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e4817b5-bd20-4ea6-93f4-ec0bee9bf833@gmail.com>

On Tue, Apr 08, 2025 at 09:45:53PM +0530, Nirjhar Roy (IBM) wrote:
> 
> On 4/8/25 14:43, Ritesh Harjani (IBM) wrote:
> > "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:
> > 
> > > We should always set the value of status correctly when we are exiting.
> > > Else, "$?" might not give us the correct value.
> > > If we see the following trap
> > > handler registration in the check script:
> > > 
> > > if $OPTIONS_HAVE_SECTIONS; then
> > >       trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
> > > else
> > >       trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
> > > fi
> > > 
> > > So, "exit 1" will exit the check script without setting the correct
> > > return value. I ran with the following local.config file:
> > > 
> > > [xfs_4k_valid]
> > > FSTYP=xfs
> > > TEST_DEV=/dev/loop0
> > > TEST_DIR=/mnt1/test
> > > SCRATCH_DEV=/dev/loop1
> > > SCRATCH_MNT=/mnt1/scratch
> > > 
> > > [xfs_4k_invalid]
> > > FSTYP=xfs
> > > TEST_DEV=/dev/loop0
> > > TEST_DIR=/mnt1/invalid_dir
> > > SCRATCH_DEV=/dev/loop1
> > > SCRATCH_MNT=/mnt1/scratch
> > > 
> > > This caused the init_rc() to catch the case of invalid _test_mount
> > > options. Although the check script correctly failed during the execution
> > > of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
> > > returned 0. This is because init_rc exits with "exit 1" without
> > > correctly setting the value of "status". IMO, the correct behavior
> > > should have been that "$?" should have been non-zero.
> > > 
> > > The next patch will replace exit with _exit.
> > > 
> > > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > ---
> > >   common/config | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/common/config b/common/config
> > > index 79bec87f..eb6af35a 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> > >   export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
> > > +# This functions sets the exit code to status and then exits. Don't use
> > > +# exit directly, as it might not set the value of "status" correctly.
> > ...as it might not set the value of "$status" correctly, which is used
> > as an exit code in the trap handler routine set up by the check script.
> > 
> > > +_exit()
> > > +{
> > > +	status="$1"
> > > +	exit "$status"
> > > +}
> > > +
> > I agree with Darrick’s suggestion here. It’s safer to update status only
> > when an argument is passed - otherwise, it’s easy to trip over this.
> > 
> > Let’s also avoid defaulting status to 0 inside _exit(). That way, if the
> > caller forgets to pass an argument but has explicitly set status
> > earlier, we preserve the intended value.
> > 
> > We should update _exit() with...
> > 
> > test -n "$1" && status="$1"
> 
> Okay, so in that case if someone does "status=<value>;_exit", we should end
> up with the "<value>" instead of something else, right?

Right.  I think.  AFAICT the following simple program actually does
return 5 despite the cleanup:

trap 'echo cleanup' INT QUIT TERM EXIT
exit 5

But since fstests set a variable named "status" and then "exit $status"
from cleanup, I think it doesn't matter how status gets set as long as
it /does/ get set somewhere.

--D

> --NR
> 
> > 
> > -ritesh
> > 
> > 
> > >   # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
> > >   set_mkfs_prog_path_with_opts()
> > >   {
> > > -- 
> > > 2.34.1
> 
> -- 
> Nirjhar Roy
> Linux Kernel Developer
> IBM, Bangalore
> 

