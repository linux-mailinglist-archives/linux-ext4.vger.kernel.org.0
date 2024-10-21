Return-Path: <linux-ext4+bounces-4681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EE9A90E9
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3783B21BAE
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7C1E1A08;
	Mon, 21 Oct 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hq3vKwUn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E81991AE;
	Mon, 21 Oct 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541995; cv=none; b=gVyEJ/WpiZ0qcKxKxfo9Z5mHRPj309VVAeXM/4hMGAcHFsor6sdRLhmtH6MHxRsqtCDWlYq94lFp4AY+qIUtsNVWL2ZxZQO8biPVg2HZSheLF42uHFrHaKk2GYUNa2k7yQjXEyDVkZRi/QZBZb8yMb8BHfLoeyJq/YT74rJzfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541995; c=relaxed/simple;
	bh=4RoLzcglFgkIf2Mh0l88MUQzG+gTX5O5Hqxe5YMG/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTgSmSkhWxq2uPEbnH4K4LEPEzJL5oJAqZwbXyCISu5eawBtw2XZWd89H0AGTNqyRdKDtlKX1VRcoZdCaMM7SQ8U3AKL4RFSvBVsDlS33zLlIIQhQtkOZdpeOGdIRdoUU3nTvkynb8hFIS+hFYzje84JjRZt2whV8CxLfR/4KuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hq3vKwUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDB7C4CEC3;
	Mon, 21 Oct 2024 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729541994;
	bh=4RoLzcglFgkIf2Mh0l88MUQzG+gTX5O5Hqxe5YMG/iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq3vKwUncJA/Cp71vu0dPT3Xg1z0TF0zzFIIoFajb45vGA+hoGxva18alxHsiTXUW
	 1V/P/Zthll3pxk8WULQ2qZBeCOPwT26P5by9i7ALrpCGALwWKin6MB/Elfot/ZE2K6
	 3OEh1CfhovZT96STMsAsK3+0/qwXvPXo+NwnqNos=
Date: Mon, 21 Oct 2024 22:19:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: jack@suse.cz, hch@lst.de, sashal@kernel.org, tytso@mit.edu,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [5.10.y] Regression in EXT3/4 with v5.10.227, LTP preadv03 is
 failing
Message-ID: <2024102122-sustained-camcorder-32fa@gregkh>
References: <lrkyqy12hpikl.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
 <2024102130-thieving-parchment-7885@gregkh>
 <lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lrkyqldyhpeb5.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>

On Mon, Oct 21, 2024 at 07:15:58PM +0200, Mahmoud Adam wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Oct 21, 2024 at 05:43:54PM +0200, Mahmoud Adam wrote:
> >> 
> >> Hello,
> >> 
> >>   In the latest 5.10.227 we see LTP preadv03 failing on EXT3/4, when
> >> bisected it was found that the commit dde4c1e1663b6 ("ext4: properly
> >> sync file size update after O_SYNC direct IO") is causing it
> >> 
> >> This seems similar to what occurred before[1] and if I understand
> >> correctly it was because of missing dependency backport 936e114a245b6
> >> ("iomap: update ki_pos a little later in iomap_dio_complete") which was
> >> then backported to 5.15 & 6.1 but not to 5.10.
> >> 
> >> *This is not failing on 5.15 nor 6.1, and it does fail consistently in x86-64 & ARM
> >> 
> >> [1]: https://lore.kernel.org/all/20231205122122.dfhhoaswsfscuhc3@quack3/
> >> 
> >
> >
> > What do you suggest be done?
> >
> 
> I think as an urgent fix I would suggest reverting the mentioned commit
> and commits that depend on it from 5.10.y..
> 
> 4911610c7a1fe ("ext4: fix warning in ext4_dio_write_end_io()")
> f8a7c342326f6 ("ext4: dax: fix overflowing extents beyond inode size when partially writing")
> dde4c1e1663b6 ("ext4: properly sync file size update after O_SYNC direct
> IO")

Great, can you submit a series of these reverted that you have tested to
fix the issue?

thanks,

greg k-h

