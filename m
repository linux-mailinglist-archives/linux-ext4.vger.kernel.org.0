Return-Path: <linux-ext4+bounces-664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B8823B97
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 05:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6FF1C24629
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907A125B9;
	Thu,  4 Jan 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta9Pu8Lj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1F1D68A
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 04:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F95C433C7;
	Thu,  4 Jan 2024 04:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704344141;
	bh=gdCtb7p5/FMsr3W0D5Vf+boic8g9KjCvs1CjiHtWKjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ta9Pu8Lj3T7FaWXIHuaFcTw2r3aMKnNyzPM8Rtc9vRq8UKsuU7Qra94A2YZ3UjIml
	 ia6jLdUyZ1GjN5O25Q/S4GV02uCHEffOLRcDLpTzKPimCEgiCOyVpBRX/OFRllRtTB
	 op9A12mM16e5095FBVIQ3tUpeiHbANLHUCf9vEfUur5Bx32ycYoPgTkmCDmkn5DxSf
	 dYEdpzxw+QpFnqL26dHS1gBnD9bC+qZki5Ud0wvdnHug5wCdowz53X5Flgqbv5JRTD
	 esLoMn1zBv2yiGgeKytg286AGmVDNfXgYh/1aAwLb4zjU5Q1UNbckvH6See1yEh/g9
	 kKxlgSRTJuXDg==
Date: Wed, 3 Jan 2024 20:55:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: e2scrub finds corruption immediately after mounting
Message-ID: <20240104045540.GD36164@frogsfrogsfrogs>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>

On Wed, Jan 03, 2024 at 04:14:36PM -0500, Brian J. Murrell wrote:
> I am trying to migrate from lvcheck
> (https://github.com/BryanKadzban/lvcheck) to using the officially
> supported e2scrub[_all] kit.
> 
> I am finding that e2scrub very often (much more than lvcheck even)
> finds corruption and wants me to do an offline e2fsck.  Not only does
> it do this immediately after booting a system that includes filesystem
> checks (that were caused by e2scrub previously setting a filesystem to
> be checked on next boot), but it happens immediately after I run an
> e2fsck and then mount the filesystem, even without any activity on it.
> Observe:
> 
> # umount /opt
> # e2fsck -y /dev/rootvol_tmp/almalinux8_opt 
> e2fsck 1.45.6 (20-Mar-2020)
> /dev/mapper/rootvol_tmp-almalinux8_opt: clean, 1698/178816 files,
> 482404/716800 blocks
> # e2scrub /dev/rootvol_tmp/almalinux8_opt 
>   Logical volume "almalinux8_opt.e2scrub" created.
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/rootvol_tmp/almalinux8_opt.e2scrub: 1698/178816 files (86.9% non-
> contiguous), 482404/716800 blocks
> /dev/rootvol_tmp/almalinux8_opt: Scrub succeeded.
> tune2fs 1.45.6 (20-Mar-2020)
> Setting current mount count to 0
> Setting time filesystem last checked to Wed Jan  3 11:37:04 2024
> 
>   Logical volume "almalinux8_opt.e2scrub" successfully removed.
> # mount /opt
> # e2scrub /dev/rootvol_tmp/almalinux8_opt 
>   Logical volume "almalinux8_opt.e2scrub" created.
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/rootvol_tmp/almalinux8_opt.e2scrub: 1698/178816 files (86.9% non-
> contiguous), 482404/716800 blocks
> /dev/rootvol_tmp/almalinux8_opt: Scrub FAILED due to corruption! 

Curious.  Normally e2scrub will run e2fsck twice: Once in journal-only
preen mode to replay the journal, then again with -fy to perform the
full filesystem (snapshot) check.

I wonder if you would paste the output of
"bash -x e2scrub /dev/rootvol_tmp/almalinux8_opt" here?  I'd be curious
to see what the command flow is.

Assuming that 1.47.0 doesn't magically fix it. :)

> Unmount and run e2fsck -y.
> tune2fs 1.45.6 (20-Mar-2020)
> Setting filesystem error flag to force fsck.
>   Logical volume "almalinux8_opt.e2scrub" successfully removed.
> 
> So as you can see, I unmount /opt, run an e2fsck -y on it to clean it
> and then before mounting run e2scrub and it finds the filesystem clean.
> Good so far.
> 
> I then mount it and then immediately run another e2scrub on it and that
> finds it dirty and wants me to unmount and run another e2fsck -y on it.
> But how can that be?  Surely an e2scrub on a freshly cleaned and
> mounted filesystem (with no activity on it in between) should be clean,
> yes?

Right.  Unless something's broken in e2fsck. :/

--D

> 
> Cheers,
> b.
> 



