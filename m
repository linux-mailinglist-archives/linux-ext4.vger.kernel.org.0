Return-Path: <linux-ext4+bounces-7327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF559A92C52
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 22:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663391B651B9
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 20:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886F2063DD;
	Thu, 17 Apr 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awksi0wX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA261FF1CE;
	Thu, 17 Apr 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922129; cv=none; b=Q2ia9LW0qL02WTdyjlEWI1RrvQH+9aVwuBpvSe3rRC3HHUsyFKkrqF+9TDVrCBOpV3VKKZK+pciyQXeKycV2yX05gOyjBph+dYqoWaiAMja7FCv/4Y2hhw4727hMT+troDYMiJJCLozWtz41qhlB1FagXYDHid7XcHrNSZ+Mvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922129; c=relaxed/simple;
	bh=9g7VSe4GPs0t1aTM8Y3REKtX5xNSUrZEZQxXyCyrB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0n/iwk6N9n+aQxnJbgiEi8e4a7RyAsW3FBaxiueGHS5/UThZ01S9N1t5AvdiFoKsQSgbMlAI54PdXP7ZNWQfcud+3wO3jdz1fW6PaWWRXMU2pWXT/TCuWuIO5sfRzoO1FqVjB0uilSMM6dXAgGmS+duxPU1zZPuBfcecAfTp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awksi0wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C80C4CEE4;
	Thu, 17 Apr 2025 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744922128;
	bh=9g7VSe4GPs0t1aTM8Y3REKtX5xNSUrZEZQxXyCyrB0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awksi0wXsBL8vTc4IQKDCTTHjwJ9hxcfyAQUxC12iAA3COzg8a71GxuvoP1LQncfQ
	 uFn95Hb8OOje3Q7Mo1fmtkUs/h470YFno6/2qNb9QHInRbl7+syAcqEML9cj74m9P3
	 vZY2xEv4uzcKZKsHcBq6esoCdDTl1vh4YTSEQAQ85ld/S99erssEkZ8Eb1c9889ax5
	 bEnBAgN+wdqgX8SLr0IyOa7MMzpI63HrP+WRYVUJRij5WG9o5Ri/1p65AlYhSTMM67
	 XJDZd6jXnPBValTesj1f+v+RhlddNsNfix6/n0wTL2DJyfCu+xWtyaQYY5Biyz26cz
	 9weQMNsC4+o0A==
Date: Thu, 17 Apr 2025 13:35:26 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <aAFmDjDtZBzxiN66@bombadil.infradead.org>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417164907.GA6008@mit.edu>

On Thu, Apr 17, 2025 at 11:49:07AM -0500, Theodore Ts'o wrote:
> On Wed, Apr 16, 2025 at 06:34:15PM -0500, Theodore Ts'o wrote:
> 
> > >  - Is this useful information?
> > 
> > Maybe; the question is why are your results so different from my results.
> 
> It looks like the problem is that your kernel config doesn't enable
> CONFIG_QFMT_V2.  As a result, the quota feature is not supported in
> the kernel under test.   From ext4/033.full file:
> 
> mount: /media/scratch: wrong fs type, bad option, bad superblock on /dev/loop5, missing codepage or helper program, or other error.
>        dmesg(1) may have more information after failed mount system call.
> mount -o acl,user_xattr -o dioread_nolock,nodelalloc /dev/loop5 /media/scratch failed
> 
> And from the ext4/034.dmesg file:
> 
> [  297.969763] EXT4-fs (loop5): The kernel was not built with CONFIG_QUOTA and CONFIG_QFMT_V2

Let' see what happens when I enable quotas, pushed.

  Luis

