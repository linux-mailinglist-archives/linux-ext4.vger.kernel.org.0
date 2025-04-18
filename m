Return-Path: <linux-ext4+bounces-7329-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4BA92F6F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 03:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CB27AE546
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Apr 2025 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C18207A11;
	Fri, 18 Apr 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NztAGl1w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274A20458A;
	Fri, 18 Apr 2025 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940547; cv=none; b=PRq3e+yWUAMzoNDmzE+aO4H4+m/PoGk2mjrX6RYLjcIrTGXpxAaEbGqv4ktpLagiVBvg3UOnBVSZLKEBzGSNOK199GMFAaXjRTbFiaj8JrJCMT50HE6TjswgZ5lNswkjiO6wxO0YfU8j/fs6LkIQDipQ+OUh2dZl6TRR8Faxy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940547; c=relaxed/simple;
	bh=gG+1/T/riWKqGr/DmbNVZcKxEKPWNmg6qfUUOFoYwCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5p0/ifx9RRBQylY2epdQRlxkgk4NDQSXIqhGCxJuXFMAH+mR64P1o1Sd+sy79LE1bepobPOWYquFmuprvd38C5lDVIXoLv6xrMmGkd/aq1KMW31H3+r/y3kT6Uoyh/d3Poj94RTLgkzJtWRX1gMuyBfhngNSMls6V3PaQefKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NztAGl1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB3CC4CEE4;
	Fri, 18 Apr 2025 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744940547;
	bh=gG+1/T/riWKqGr/DmbNVZcKxEKPWNmg6qfUUOFoYwCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NztAGl1wqpL1VyvqGzG1zFzTcSpkTaZeaDddneuL9GwG2flGrMjjW6KoZxmkKTicM
	 LteHDepL1snbG7/klW++hQJmDI8hxFemrZktr9gWmJPoRtPYillUNYCWP9z+Xc7pDi
	 jxcmlkloxDOn3crXj9/Gt6GG/eOJqDCG7K6hAVeTKgMSACGVHlvXOsu5/Ex3XZZCL+
	 hruL4epoBgh5kmk4gAU9mDkEabQ/FRpcoTdNWog1LrBuW++IdNKSxMX5Nmy3HcAKYm
	 fG34XxnCJ/f1NyOs2coAkChTJNY8VJfEX/nr8mf2ZiNc0L+lfGCUH85fQxOZjP3W6q
	 9fboFN2WHXTKw==
Date: Thu, 17 Apr 2025 18:42:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <aAGuAYGZfpUSabSf@bombadil.infradead.org>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417164907.GA6008@mit.edu>
 <aAFmDjDtZBzxiN66@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAFmDjDtZBzxiN66@bombadil.infradead.org>

On Thu, Apr 17, 2025 at 01:35:28PM -0700, Luis Chamberlain wrote:
> On Thu, Apr 17, 2025 at 11:49:07AM -0500, Theodore Ts'o wrote:
> > On Wed, Apr 16, 2025 at 06:34:15PM -0500, Theodore Ts'o wrote:
> > 
> > > >  - Is this useful information?
> > > 
> > > Maybe; the question is why are your results so different from my results.
> > 
> > It looks like the problem is that your kernel config doesn't enable
> > CONFIG_QFMT_V2.  As a result, the quota feature is not supported in
> > the kernel under test.   From ext4/033.full file:
> > 
> > mount: /media/scratch: wrong fs type, bad option, bad superblock on /dev/loop5, missing codepage or helper program, or other error.
> >        dmesg(1) may have more information after failed mount system call.
> > mount -o acl,user_xattr -o dioread_nolock,nodelalloc /dev/loop5 /media/scratch failed
> > 
> > And from the ext4/034.dmesg file:
> > 
> > [  297.969763] EXT4-fs (loop5): The kernel was not built with CONFIG_QUOTA and CONFIG_QFMT_V2
> 
> Let' see what happens when I enable quotas, pushed.

That helped, it brought down the test failures from 261 to 170 with a
success rate improvement from 55.4% to 57.9%.

Dashboards for both results, the old one:

https://kdevops.org/ext4/v6.15-rc2-a74831cc.html

The latest one:

https://kdevops.org/ext4/v6.15-rc2.html

Detailed test results:

https://github.com/linux-kdevops/kdevops-results-archive/commit/a051dea3db9fcc7e164c1d027264e181b68833e0

And so the new file name for results is

fstests/gh/linux-ext4-kpd/20250417/0001/linux-6-15-rc2/8ffd015db85f.xz

Detailed test results below:

KERNEL:    6.15.0-rc2-g8ffd015db85f
CPUS:      8

ext4_defaults: 793 tests, 2 failures, 259 skipped, 10521 seconds
  Failures: generic/223 generic/741
ext4_4k: 793 tests, 2 failures, 308 skipped, 9837 seconds
  Failures: generic/223 generic/741
ext4_2k: 793 tests, 2 failures, 311 skipped, 10017 seconds
  Failures: generic/223 generic/741
ext4_advanced_features: 793 tests, 3 failures, 267 skipped, 10416 seconds
  Failures: generic/223 generic/477 generic/741
ext4_1k: 793 tests, 2 failures, 314 skipped, 10813 seconds
  Failures: generic/223 generic/741
ext4_bigalloc16k_4k: 793 tests, 26 failures, 341 skipped, 8856 seconds
  Failures: ext4/033 generic/075 generic/082 generic/091 generic/112
    generic/127 generic/219 generic/223 generic/230 generic/231
    generic/232 generic/233 generic/234 generic/235 generic/263
    generic/280 generic/381 generic/382 generic/566 generic/587
    generic/600 generic/601 generic/681 generic/682 generic/691
    generic/741
ext4_bigalloc32k_4k: 793 tests, 26 failures, 341 skipped, 8678 seconds
  Failures: ext4/033 generic/075 generic/082 generic/091 generic/112
    generic/127 generic/219 generic/223 generic/230 generic/231
    generic/232 generic/233 generic/234 generic/235 generic/263
    generic/280 generic/381 generic/382 generic/566 generic/587
    generic/600 generic/601 generic/681 generic/682 generic/691
    generic/741
ext4_bigalloc64k_4k: 793 tests, 26 failures, 341 skipped, 8554 seconds
  Failures: ext4/033 generic/075 generic/082 generic/091 generic/112
    generic/127 generic/219 generic/223 generic/230 generic/231
    generic/232 generic/233 generic/234 generic/235 generic/263
    generic/280 generic/381 generic/382 generic/566 generic/587
    generic/600 generic/601 generic/681 generic/682 generic/691
    generic/741
ext4_bigalloc1024k_4k: 793 tests, 38 failures, 341 skipped, 8019 seconds
  Failures: ext4/033 ext4/045 generic/075 generic/082 generic/091
    generic/112 generic/127 generic/219 generic/230 generic/231
    generic/232 generic/233 generic/234 generic/235 generic/251
    generic/263 generic/280 generic/365 generic/381 generic/382
    generic/435 generic/566 generic/587 generic/600 generic/601
    generic/614 generic/629 generic/634 generic/635 generic/643
    generic/681 generic/682 generic/691 generic/698 generic/732
    generic/738 generic/741 generic/754
ext4_bigalloc2048k_4k: 793 tests, 43 failures, 348 skipped, 7961 seconds
  Failures: ext4/033 ext4/045 generic/075 generic/082 generic/091
    generic/112 generic/127 generic/219 generic/230 generic/231
    generic/232 generic/233 generic/234 generic/235 generic/251
    generic/263 generic/280 generic/365 generic/381 generic/382
    generic/435 generic/471 generic/566 generic/587 generic/600
    generic/601 generic/603 generic/614 generic/629 generic/634
    generic/635 generic/643 generic/645 generic/676 generic/681
    generic/682 generic/691 generic/698 generic/732 generic/736
    generic/738 generic/741 generic/754
Totals: 7930 tests, 3171 skipped, 170 failures, 0 errors, 83862s

  Luis

