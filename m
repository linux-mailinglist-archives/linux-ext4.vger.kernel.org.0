Return-Path: <linux-ext4+bounces-9577-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4138B31820
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 14:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813CE1D04641
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 12:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52942FC001;
	Fri, 22 Aug 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8hreah1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8652E8B74;
	Fri, 22 Aug 2025 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866504; cv=none; b=rQ7mHG7VNkuYvMAyo25AVDTuZsnlMxFr4OLCXLBpFYOEhCZE3f4JCNuHn737IgAIiTWuGN/+6N06NkRWr5bzbSyYpv7uLWvBbdRVUOLa88LdaOs6MkXAUGcjlfwf9rZmnYlIjy1oVEueWWvkI6OGfI3vPGYSEVrXXKUSz7qovvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866504; c=relaxed/simple;
	bh=NDGevwGXrFEFnsGuH0jC2kHyh2ATY5gReQLcWgkCWaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXuy/y9NCf+mu9/gGgpylSUhHk0vygkiftcQDyjstr5mjRLfwocRXxpX9y9WrYWm9IIXWlHmg+Rc4s5rCNRTUshPXjSV6Ln2lNSmVY7Sk2qUlgZU5A2URzeFQYFP+3984Efqv3+FwV8R02pf4Fh8hbnimyPnuEoWElpbzrUFDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8hreah1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9E6C4CEED;
	Fri, 22 Aug 2025 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755866503;
	bh=NDGevwGXrFEFnsGuH0jC2kHyh2ATY5gReQLcWgkCWaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8hreah116dFx2QJ7LWqjRzRUBwRbKSk0BkWPXjUXMNFsNo8RmVH1TnSFBkUXX4ZM
	 /tIrBt3hgFiVxWZzDXOgPgY8bNrr11rTebd86My+GASrfOC0AaweI3raoqLECYxdq5
	 0MsfAdrKj4Y3Tz7JYvWZhOs+qGN4y1J8+lnYOgoA=
Date: Fri, 22 Aug 2025 14:41:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Luca Boccassi <bluca@debian.org>
Cc: Christian Heusel <christian@heusel.eu>, Zhang Yi <yi.zhang@huawei.com>,
	Sasha Levin <sashal@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	heftig@archlinux.org
Subject: Re: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
Message-ID: <2025082214-oink-kindling-11cf@gregkh>
References: <3d7f77d2-b1f8-4d49-b36a-927a943efc2f@heusel.eu>
 <CAMw=ZnRtmhi8aaO+xsT=kgXYhB8u3sgBdtevrxDWctTLteWYoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRtmhi8aaO+xsT=kgXYhB8u3sgBdtevrxDWctTLteWYoA@mail.gmail.com>

On Tue, Aug 19, 2025 at 11:38:11PM +0100, Luca Boccassi wrote:
> On Tue, 19 Aug 2025 at 21:53, Christian Heusel <christian@heusel.eu> wrote:
> >
> > Hello everyone,
> >
> > the systemd CI has [recently noticed][0] an issue within the ext4 file
> > system after the Arch Linux kernel was upgraded to 6.16.1. The issue is
> > exclusive to the stable tree and does not occur on 6.16 and not on
> > 6.17-rc2. I have also tested 6.16.2-rc1 and it still contains the bug.
> >
> > I was able to bisect the issue between 6.16 and 6.16.1 to the following
> > commit:
> >
> >     b9c561f3f29c2 ("ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()")
> >
> > The issue can be reproduced by running the tests from
> > [TEST-58-REPART.sh][1] by running the [systemd integration tests][2].
> > But if there are any suggestions I can also test myself as the initial
> > setup for the integration tests is a bit involved.
> >
> > It is not yet clear to me whether this has real-world impact besides the
> > test, but the systemd devs said that it's not a particularily demanding
> > workflow, so I guess it is expected to work and could cause issues on
> > other systems too.
> >
> > Also does anybody have an idea which backport could be missing?
> >
> > Cheers,
> > Chris
> >
> > [0]: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233
> > [1]: https://github.com/systemd/systemd/blob/main/test/units/TEST-58-REPART.sh
> > [2]: https://github.com/systemd/systemd/blob/main/test/integration-tests/README.md
> >
> > ---
> >
> > #regzbot introduced: b9c561f3f29c2
> > #regzbot title: [STABLE] ext4: too many credits wanted / file system issue in v6.16.1
> > #regzbot link: https://github.com/systemd/systemd/actions/runs/17053272497/job/48345703316#step:14:233
> >
> > ---
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
> > git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [3e0969c9a8c57ff3c6139c084673ebedfc1cf14f] Linux 6.16.1
> > git bisect bad 3e0969c9a8c57ff3c6139c084673ebedfc1cf14f
> > # good: [288f1562e3f6af6d9b461eba49e75c84afa1b92c] media: v4l2-ctrls: Fix H264 SEPARATE_COLOUR_PLANE check
> > git bisect good 288f1562e3f6af6d9b461eba49e75c84afa1b92c
> > # bad: [f427460a1586c2e0865f9326b71ed6e5a0f404f2] f2fs: turn off one_time when forcibly set to foreground GC
> > git bisect bad f427460a1586c2e0865f9326b71ed6e5a0f404f2
> > # bad: [5f57327f41a5bbb85ea382bc389126dd7b8f2d7b] scsi: elx: efct: Fix dma_unmap_sg() nents value
> > git bisect bad 5f57327f41a5bbb85ea382bc389126dd7b8f2d7b
> > # good: [9143c604415328d5dcd4d37b8adab8417afcdd21] leds: pca955x: Avoid potential overflow when filling default_label (take 2)
> > git bisect good 9143c604415328d5dcd4d37b8adab8417afcdd21
> > # good: [9c4f20b7ac700e4b4377f85e36165a4f6ca85995] RDMA/hns: Fix accessing uninitialized resources
> > git bisect good 9c4f20b7ac700e4b4377f85e36165a4f6ca85995
> > # good: [0b21d1962bec2e660c22c4c4231430f97163dcf8] perf tests bp_account: Fix leaked file descriptor
> > git bisect good 0b21d1962bec2e660c22c4c4231430f97163dcf8
> > # good: [3dbe96d5481acd40d6090f174d2be8433d88716d] clk: thead: th1520-ap: Correctly refer the parent of osc_12m
> > git bisect good 3dbe96d5481acd40d6090f174d2be8433d88716d
> > # bad: [c6714f30ef88096a8da9fcafb6034dc4e9aa467d] clk: sunxi-ng: v3s: Fix de clock definition
> > git bisect bad c6714f30ef88096a8da9fcafb6034dc4e9aa467d
> > # bad: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
> > git bisect bad b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8
> > # first bad commit: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
> 
> The full kernel warning (immediately after the ext4 fs stops working):

I've pushed out a 6.16.3-rc1 that should hopefully resolve this.

thanks,

greg k-h

