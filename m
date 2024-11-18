Return-Path: <linux-ext4+bounces-5241-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA39D1565
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD26B27939
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A01BD508;
	Mon, 18 Nov 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GO13WLin"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74E22F19;
	Mon, 18 Nov 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947291; cv=none; b=VDK4B12Cj/aM9zYMsJm/aBhh8IzLUA4Aepgz9EUCOeQEPnlXWZauzKpC7J0zbV7KAorGJviBeP8ww+mtlanCmIhrbtqgsiLUCvpYc8DVAFu6fssvEvGBLA+QTjpImQJCMccSy9wRNimlnLX5ARuvn2+ytEyfdRfq8bHdmPn3PG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947291; c=relaxed/simple;
	bh=QIkt9aUigRD9s0MX1UNB0Twm/MbJSOljK+xUuakHIMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIcIbLUQQBNXhbLAzCIP1umiUSNtBh8Yzl6pggg1L4ESPpo+IQlK8CKoLtnNKBVF+uRfA3vgx5fWGlkQbtd7oUhmTX2/7YZtT9XBPo+mv7zqsjaFP4sdXDKbxArgrpKh4ifPCCT6fumIKBkSgofa9uoFfS8iHtpDUmvX93w2AWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GO13WLin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73E9C4CECC;
	Mon, 18 Nov 2024 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731947290;
	bh=QIkt9aUigRD9s0MX1UNB0Twm/MbJSOljK+xUuakHIMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GO13WLinV5aCfgE1wJTtNqKlFW0aZcMeMjpfgA69yuvvNyV+15g5OkBy8MLJMbBLJ
	 mjSt4CnHKeTdM5liyUqPJyKJkaZHqG021gvscTzLd82Ruu2Uh/l8RISDqVMzncoO9e
	 CI8f9uCgztmFPjzMqDGS9M/lQ7ZeLgTxMADcm5Jgvel28MOIZS0MeQTDWy7Ie5NQ1R
	 vLLjVrQ/2uS4FHJOapHVl0sBYsk98I/46XakEVMdngctI7duKs21YAzPW9EzcZW5GS
	 qLuLPtInRKHtLZdZvYaWgQExfm/oRXeBSUrdBfJD4o2bAEC0+xKVI42OGsDGSmaJDk
	 1CLx+PTETj1VA==
Date: Mon, 18 Nov 2024 08:28:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v2 1/2] common/rc,xfs/207: Adding a common helper
 function to check xflag bits on a given file
Message-ID: <20241118162810.GI9425@frogsfrogsfrogs>
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
 <9a955f34cab443d3ed0fc07c17886d5e8a11ad80.1731597226.git.nirjhar@linux.ibm.com>
 <20241115164548.GE9425@frogsfrogsfrogs>
 <87r07cco5p.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r07cco5p.fsf@gmail.com>

On Sat, Nov 16, 2024 at 12:36:26AM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Fri, Nov 15, 2024 at 09:45:58AM +0530, Nirjhar Roy wrote:
> >> This patch defines a common helper function to test whether any of
> >> fsxattr xflags field is set or not. We will use this helper in the next
> >> patch for checking extsize (e) flag.
> >> 
> >> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> >> ---
> >>  common/rc     |  7 +++++++
> >>  tests/xfs/207 | 13 ++-----------
> >>  2 files changed, 9 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/common/rc b/common/rc
> >> index 2af26f23..fc18fc94 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -41,6 +41,13 @@ _md5_checksum()
> >>  	md5sum $1 | cut -d ' ' -f1
> >>  }
> >>  
> >> +# Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
> >> +# e.g, fsxattr.xflags =  0x80000800 [----------e-----X]
> >> +_test_fsx_xflags_field()
> >
> > How about we call this "_test_fsxattr_xflag" instead?
> >
> > fsx is already something else in fstests.
> >
> >> +{
> >> +    grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
> >> +}
> >
> > Not sure why this lost the xfs_io | grep -q structure.  The return value
> > of the whole expression will always be the return value of the last
> > command in the pipeline.
> >
> 
> I guess it was suggested here [1]
> 
> [1]: https://lore.kernel.org/all/20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

Ah.

> root-> grep -q "hello" <(echo "hello world"); echo $?
> 0
> 
> The cmd is not using the unnamed pipes ("|") any more. It's spawning the
> process () which does echo "hello world" and creating a named pipe or
> say temporary FD <() which is being read by grep now. So we still will
> have the correct return value. Slightly inefficitent compared to unnamed
> pipes though I agree. 

Well... it's subtle, being bash, right? :)

bash creates a pipe and a subprocess for the "echo hello world", then
hooks its stdout to the pipe, just like a regular "|" pipe.

But for "grep -q hello" things are different -- for the grep process,
the pipe is added as a new fd (e.g. /dev/fd/63), and then that path is
provided on the command line.  So what bash is doing is:

	grep -q "hello" /dev/fd/63

AFAICT for grep this makes no difference unless you want it to tell you
filenames:

$ grep -l hello <(echo hello world)
/dev/fd/63
$ echo hello world | grep -l hello
(standard input)

and I'm sure there's other weird implications that I'm not remembering.

> > (Correct?  I hate bash...)
> >
> 
> root-> ls -la <(echo "hello world");
> lr-x------ 1 root root 64 Nov 16 00:42 /dev/fd/63 -> 'pipe:[74211850]'
> 
> Did I make you hate it more? ;) 

Yep!

--D

> 
> -ritesh
> 
> > --D
> >
> >> +
> >>  # Write a byte into a range of a file
> >>  _pwrite_byte() {
> >>  	local pattern="$1"
> >> diff --git a/tests/xfs/207 b/tests/xfs/207
> >> index bbe21307..4f6826f3 100755
> >> --- a/tests/xfs/207
> >> +++ b/tests/xfs/207
> >> @@ -21,15 +21,6 @@ _require_cp_reflink
> >>  _require_xfs_io_command "fiemap"
> >>  _require_xfs_io_command "cowextsize"
> >>  
> >> -# Takes the fsxattr.xflags line,
> >> -# i.e. fsxattr.xflags = 0x0 [--------------C-]
> >> -# and tests whether a flag character is set
> >> -test_xflag()
> >> -{
> >> -    local flg=$1
> >> -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> >> -}
> >> -
> >>  echo "Format and mount"
> >>  _scratch_mkfs > $seqres.full 2>&1
> >>  _scratch_mount >> $seqres.full 2>&1
> >> @@ -65,14 +56,14 @@ echo "Set cowextsize and check flag"
> >>  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
> >>  _scratch_cycle_mount
> >>  
> >> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> >> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> >>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> >>  
> >>  echo "Unset cowextsize and check flag"
> >>  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
> >>  _scratch_cycle_mount
> >>  
> >> -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> >> +_test_fsx_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> >>  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> >>  
> >>  status=0
> >> -- 
> >> 2.43.5
> >> 
> >> 
> 

