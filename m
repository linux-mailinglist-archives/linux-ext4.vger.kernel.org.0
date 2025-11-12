Return-Path: <linux-ext4+bounces-11801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B6C509B2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 06:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF6C94E3A8C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C541B2D77F6;
	Wed, 12 Nov 2025 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBmFw60v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A115D1;
	Wed, 12 Nov 2025 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762925008; cv=none; b=VEKqkTOOFDXZzUDnagJ5df3dU7fwMHlCUgYJqpx4An/kj4Lx6II8rlW81rw5qNA5y1NnvrDNIdgqmLausZxuxTPobGU4sWqFm3glkSc4TqIQfnVvihRYehQaKHB7/Onu8i5Zy5DFxxrAJV+Q3n1b1fC/3Bv8QcAFnjVVUfUC9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762925008; c=relaxed/simple;
	bh=G4AswcjweoTcMDRqGcf3nc+qhS391EN2XY6+IwKLitI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/lCoTZn2lhzRVbM3BF6li+ajvcs6Qc71aqlf9F8wcOajcFoPveRLuGvH25wk4CK4u/WXsTyCGDVPD2ABVMsNoCVzcZ1y6sw6XHpDnFaejeyYmAsIc+qx6iLTzWVnVDz3QOQTcCshwhPQraC0mQhXO8s3+Qemwb7IdyQnEpBpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBmFw60v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F82C16AAE;
	Wed, 12 Nov 2025 05:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762925008;
	bh=G4AswcjweoTcMDRqGcf3nc+qhS391EN2XY6+IwKLitI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBmFw60vUaCLqWP2sTvALWy7G8kst4qhmOQauC2I1tKyzlIoeqW21T1UAy7EGmpoH
	 r3HLaN7uvoIRgR47dFW218NULHfky8r5h/zx5WfVFsFpo/VhK1F9ehBZuqZVA+0EYV
	 j+oRnWySQOM52G884nOArkjF7MbjMOajE8fie7vR1M0ZfCW53ofdwt7tTQKPa8b1X4
	 fLXJlwrxSXFHxtJztCjcME5sM0zFPDQT4DEgl0I08sYhrbqTe/jSVf533O4DRC4rG3
	 fQ1Pxu28T9fjtWQE0GfT1rcRGeCGQKgA7DMcMy2UADH8Ure5gBDot7Njh9T4LzuogI
	 6wR2ZWohozbNg==
Date: Tue, 11 Nov 2025 21:23:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca, jack@suse.cz,
	linux-kernel@vger.kernel.org, kernel@pankajraghav.com,
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	Baokun Li <libaokun@huaweicloud.com>
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251112052327.GL196358@frogsfrogsfrogs>
References: <cd2201c9-ff7f-4cfd-acfc-2bba265b3a29@huawei.com>
 <44d3fbd7-1c53-4f94-a4c8-586873a47146@huawei.com>
 <20251112040220.GO2988753@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112040220.GO2988753@mit.edu>

On Tue, Nov 11, 2025 at 11:02:20PM -0500, Theodore Ts'o wrote:
> On Wed, Nov 12, 2025 at 10:19:06AM +0800, Baokun Li wrote:
> > I am using a slightly older version of xfstests, and when running the
> > 64k tests I also encountered similar failures. The cover letter stated
> > "no Oops" for the 64k tests rather than "no new failures," meaning that
> > some cases did fail, but no severe issues such as BUG_ON or softlock
> > were observed.
> 
> Sorry, I misread your cover letter.  It's good you are seeing similar
> failures.
> 
> 
> On Wed, Nov 12, 2025 at 10:49:19AM +0800, Baokun Li wrote:
> > I checked the code of the swapon syscall in mm/swapfile.c, and currently
> > the swapfile does not support LBS. Therefore, some failing test cases can
> > be filtered out based on this.
> 
> Ah, OK. What's happening is with XFS the swap tests are being skipped
> automatically if the swapon fails.  From _require_scratch_swapfils:
> 
> 	*)
> 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> 			_scratch_unmount
> 			_notrun "swapfiles are not supported"
> 		fi
> 		;;
> 
> 
> But ext4 has different logic:
> 
> 	# ext* has supported all variants of swap files since their
> 	# introduction, so swapon should not fail.
> 
> << famous last words >>
> 
> 	case "$FSTYP" in
> 	ext2|ext3|ext4)
> 		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> 			if _check_s_dax "$SCRATCH_MNT/swap" 1 >/dev/null; then
> 				_scratch_unmount
> 				_notrun "swapfiles are not supported"
> 			else
> 				_scratch_unmount
> 				_fail "swapon failed for $FSTYP"
> 			fi
> 		fi
> 		;;
> 
> 
> I guess we could add logic to _require_scratch_swapfile in common/rc
> to also _notrun if swapon fails and block size is greater that page
> size.  Or I might just add an exclusion in my test appliance runner
> for now for all tests in group swap.

https://lore.kernel.org/fstests/176169820051.1433624.4158113392739761085.stgit@frogsfrogsfrogs/T/#u

Hm?

--D

> 
> 						- Ted
> 

