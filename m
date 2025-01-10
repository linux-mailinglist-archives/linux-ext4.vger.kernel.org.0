Return-Path: <linux-ext4+bounces-6035-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB8A096C9
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 17:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112D93A7F76
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC09212B13;
	Fri, 10 Jan 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SRlPa7Nm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B5211A05
	for <linux-ext4@vger.kernel.org>; Fri, 10 Jan 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525352; cv=none; b=d2QexgdXC7bdHMczhd8SXdhjlCbJL1bHHr7xJ/5qHssi5Au1eEV/YsIZyEeF6VpS2OocaMeYNsavwZmSBnQJpyh4nZhbC4CqyTuQ3jzwiLi24Zn81x/su77sfqbukBrxOoPx5LqHqkJsUsQCCpurqp8KcBoqYTD+BLYi+BGPvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525352; c=relaxed/simple;
	bh=R9xFIHau6/pxD9E307enmKQymDEKY/ZfWxksUVwTk/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W12UzoQoKe5fhP2QRMcSwAfu5MiYGs+PCTfgASLdH2uEvrhElzFfhTkxOoUk7YKdcGoHls/HJMEYkERAF3Tep6bnAd79KiU/2/zXQ+sk6LkuiO/mA7kg2c7yu4E5X2pC3fqWP7/uZJCKLoAE19t6jssxNvz/981ywZqa6NbimBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SRlPa7Nm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-114-113.bstnma.fios.verizon.net [173.48.114.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50AG8j7h024893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736525328; bh=1SDU15fXSbgUypzM3fr3xdeDdwISve0qJKAh/ouUwyY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SRlPa7NmktrXbvxeTZEDtqQZDCSDJi4KjES0+KbE9L3Nt5FVPtUZFkwuQoleVHCNf
	 8B4d5BrBttLjxKZmBMBPbKOQdrnrjGoWRv1Izb4arQzQM4rVzf8vhnY5jqDFNtRxiM
	 sqmHiDr0wjDitFX0dXTADX8ys6anouYYvn+XdS/kbb1AoF/cREB/h/36FmFuCJRTDE
	 36wBJxcQvV1s/gQlT+8/7wNIVayLa/rjI9nQEwwYZNzKnh7a1KaDFHWLjA2DHPg6G3
	 NrYqF1NqFNye7+W9dFh0NrKCiZhQBKfNgCS+SwkiHQFCMjLWAqIuW1hG4h6xC2VSId
	 JH+RgAcZE3bug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7F57A15C0147; Fri, 10 Jan 2025 11:08:45 -0500 (EST)
Date: Fri, 10 Jan 2025 11:08:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [RFC 2/5] check: Add -q <n> option to support unconditional
 looping.
Message-ID: <20250110160845.GA1514771@mit.edu>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
 <1826e6084fd71e3e9755b1d2750876eb5f0e1161.1736496620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1826e6084fd71e3e9755b1d2750876eb5f0e1161.1736496620.git.nirjhar.roy.lists@gmail.com>

On Fri, Jan 10, 2025 at 09:10:26AM +0000, Nirjhar Roy (IBM) wrote:
> This patch adds -q <n> option through which one can run a given test <n>
> times unconditionally. It also prints pass/fail metrics at the end.
> 
> The advantage of this over -L <n> and -i/-I <n> is that:
>     a. -L <n> will not re-run a flakey test if the test passes for the first time.
>     b. -I/-i <n> sets up devices during each iteration and hence slower.
> Note -q <n> will override -L <n>.

This is great!  It's something that I've wanted for a while, since at
the moment I implement {gce,kvm}-xfstests -C 10 is to run check ten
times, and doing something which does the looping inside check instead
of outside will be much more efficient.

One other thing that has been on my todo list to update, but which
perhaps you might be willing to do while you are doing work in this
area (nudge, nudge :-), is an optional mode which interates but which
stops once a test fails.  This is essentially the reverse of -L, and
the reason why it's useful is when trying to bisect a flakey test,
which sometimes might only be failing 2-5% of the time, require
running a test 30-50 times.  But the moment the test fails, we don't
need to run the test any more, so this would speed up bisection tests
which today I do via:

   gce-xfstests ltm --repo linux.git --bisect-good v6.12 --bisect-bad \
	v6.13-rc1 -C 50 -c ext4/inline_data generic/273

Because of this, I wonder if we should have one option to specify the
number of interations, and then a different option which specifies the
iteration mode, which might be "unconditional", "until first failure",
"only if the test initially fails", etc, instead of separate options
for -q, -L, etc.

Thanks,

					- Ted

