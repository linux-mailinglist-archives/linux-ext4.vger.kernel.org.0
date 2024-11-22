Return-Path: <linux-ext4+bounces-5381-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801599D61B5
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4583D282DDA
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827111DE3A2;
	Fri, 22 Nov 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf6wa3nx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F914C5B5;
	Fri, 22 Nov 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291472; cv=none; b=Fi6oznhXyB3j8sPzc1zENoenpXwyUzGjRpG8h+SikwIWsOT9xYmwlKTebS64PORmWhlUE6/5ZBbBad6bkEmbLrzA6z02yarIc6J4BEjtVBWo0V2O0b9o8t988ilDMs/trkVXTEDc+gZxvZzo5GaovEM3JtQWHtBiI5HjmJiKGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291472; c=relaxed/simple;
	bh=ZE7+eCaUAp20T0jRq65XXoxtolf05svo4xBEWjAS0/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMlLMdAP9yXmZA0xfijjBzR0xTOfp5OMYMXLw006Xn8vrYDj25BjAV74UiBlA7hodo/LIo7CNaZUX8Lfu6ukOazbp1i3eNu6i4LsGWZfPoWynyOqHHWnfLhro5aj83LKP5O2xBBX3xyzvrkEBvr2AJ6VqFvP9yy7gbD7cSzucEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf6wa3nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFA5C4CECE;
	Fri, 22 Nov 2024 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732291471;
	bh=ZE7+eCaUAp20T0jRq65XXoxtolf05svo4xBEWjAS0/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bf6wa3nxGSoJ47LcoznuhTF801muNRjyNyC5AeJa8dXhv7XA0AqboRba0GwlTmxNk
	 STaQnet7R5vfU41UuB0SJgzyGfiFi7WwrfpCVyrq6XQrpp481upplxlTzt3/Qrjowf
	 suMv1HARGINuP1PxlD+tdkawUpVP12orNmVmPepdpEhxmE0IBYWGYx8kBNbA6fjbkD
	 yfhKkXV3sivGz8Nhw8yOSlhE3i/85hzZ7UIn/vPcb2MtZf2gBp+DmVNVKqZNwk/BdG
	 Xqlprz8AWFC05ANC4ol2rpWzpS3PRgyRtGMavRwV5c4kg5Kiaiqvir8EhuC6mphnW7
	 GvIbZnKoST8Iw==
Date: Fri, 22 Nov 2024 08:04:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v3 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Message-ID: <20241122160430.GZ9425@frogsfrogsfrogs>
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <4412cece5c3f2175fa076a3b29fe6d0bb4c43a6e.1732126365.git.nirjhar@linux.ibm.com>
 <87plmp81km.fsf@gmail.com>
 <52dce21e-9b34-4a3d-9f2c-86634cd10750@linux.ibm.com>
 <871pz4xvuu.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pz4xvuu.fsf@gmail.com>

On Fri, Nov 22, 2024 at 12:22:41AM +0530, Ritesh Harjani wrote:
> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
> 
> > On 11/21/24 13:23, Ritesh Harjani (IBM) wrote:
> >> Nirjhar Roy <nirjhar@linux.ibm.com> writes:
> >>
> >>> _require_scratch_extsize helper function will be used in the
> >>> the next patch to make the test run only on filesystems with
> >>> extsize support.
> >>>
> >>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >>> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> >>> ---
> >>>   common/rc | 17 +++++++++++++++++
> >>>   1 file changed, 17 insertions(+)
> >>>
> >>> diff --git a/common/rc b/common/rc
> >>> index cccc98f5..995979e9 100644
> >>> --- a/common/rc
> >>> +++ b/common/rc
> >>> @@ -48,6 +48,23 @@ _test_fsxattr_xflag()
> >>>   	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
> >>>   }
> >>>   
> >>> +# This test requires extsize support on the  filesystem
> >>> +_require_scratch_extsize()
> >>> +{
> >>> +	_require_scratch
> >> _require_xfs_io_command "extsize"
> >>
> >> ^^^ Don't we need this too?
> > Yes, good point. I will add this in the next revision.
> >>
> >>> +	_scratch_mkfs > /dev/null
> >>> +	_scratch_mount
> >>> +	local filename=$SCRATCH_MNT/$RANDOM
> >>> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> >>> +	local extsz=$(( blksz*2 ))
> >>> +	local res=$($XFS_IO_PROG -c "open -f $filename" -c "extsize $extsz" \
> >>> +		-c "extsize")
> >>> +	_scratch_unmount
> >>> +	grep -q "\[$extsz\] $filename" <(echo $res) || \
> >>> +		_notrun "this test requires extsize support on the filesystem"
> >> Why grep when we can simply just check the return value of previous xfs_io command?
> > No, I don't think we can rely on the return value of xfs_io. For ex, 
> > let's look at the following set of commands which are ran on an ext4 system:
> >
> > root@AMARPC: /mnt1/test$ xfs_io -V
> > xfs_io version 5.13.0
> > root@AMARPC: /mnt1/test$ touch new
> > root@AMARPC: /mnt1/test$ xfs_io -c "extsize 8k"  new
> > foreign file active, extsize command is for XFS filesystems only
> > root@AMARPC: /mnt1/test$ echo "$?"
> > 0
> > This incorrect return value might have been fixed in some later versions 
> > of xfs_io but there are still versions where we can't solely rely on the 
> > return value.
> 
> Ok. That's bad, we then have to rely on grep.
> Sure, thanks for checking and confirming that.

You all should add CMD_FOREIGN_OK to the extsize command in xfs_io,
assuming that you've not already done that in your dev workspace.

--D

> -ritesh
> 

