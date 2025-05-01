Return-Path: <linux-ext4+bounces-7591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C96AA5A2E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 06:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D0F1C003CC
	for <lists+linux-ext4@lfdr.de>; Thu,  1 May 2025 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A322F773;
	Thu,  1 May 2025 04:14:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDD1EE7DC
	for <linux-ext4@vger.kernel.org>; Thu,  1 May 2025 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072853; cv=none; b=RTTHefKngS4z9qbWx70lhd9J9Zm0/DdxFn9SdlVM6ATxKafx7ineVBuOeG7YZaN7U5aji4CDxxil2ywVmiFM6Th7bMb53usKMCOlHsotcyHTcnQ54d7aNtJBW8SgDI9H3tx2tC/IY7rm/+ZaehpDEB7L4k3wVtrLcSyN8DM57Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072853; c=relaxed/simple;
	bh=gRxrcTmexcUwmDFtYdzrgnX6og4L+CvWmh7RjgSMJqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otfxG+JtKyl2Wk9RVFx1nOvGZbXNx6aPLICZVM0+CktGnxR1FKcpMLLyiLDtA0hUASnmkkzW1Sj7yhNoG/QcfiFkJwLr0TmJK4ReZRM0i1LDI6pDjX+2FR130vpRzYqqYUpz65v+QhDByoocqpDNF0fBPudFCke7Gs6TY8jjrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-201.bstnma.fios.verizon.net [173.48.112.201])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5414E4dj023418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 May 2025 00:14:05 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7C1242E00E9; Thu, 01 May 2025 00:14:04 -0400 (EDT)
Date: Thu, 1 May 2025 00:14:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, jack@suse.cz, harshads@google.com
Subject: Re: [PATCH v8 0/9] Ext4 Fast Commit Performance Patchset
Message-ID: <20250501041404.GA205188@mit.edu>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
 <20250424145911.GC765145@mit.edu>
 <CAD+ocbzqihJidUkanZLwUfHFNyEs0SO_Tbx4ABr_9W3dRVbArg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzqihJidUkanZLwUfHFNyEs0SO_Tbx4ABr_9W3dRVbArg@mail.gmail.com>

On Wed, Apr 30, 2025 at 11:55:48AM -0700, harshad shirwadkar wrote:
> 
> I tried to run this on my end, and I didn't see the errors that you
> pointed out. Here's my run:
> 
> -------------------- Summary report
> KERNEL:    kernel 6.14.0-rc2-xfstests-perf-gff9ebf4dde0d #31 SMP
> PREEMPT_DYNAMIC Sat Apr 12 19:35:39 UTC 2025 x86_64
> CMDLINE:   -c fast_commit -g auto

I was applying your patches on 6.15-rc3 and this evening I tried
applying them against 6.15-rc2, which has been failing as well.

There's nothing else on the ext4 dev branch yet, but there were a
large number of ext4 patches which landed between 6.14-rc2 and
6.15-rc2.

							- Ted

