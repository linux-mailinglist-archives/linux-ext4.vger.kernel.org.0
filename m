Return-Path: <linux-ext4+bounces-2662-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BA8D14B1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 08:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BD1B2113E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 06:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DF6A33B;
	Tue, 28 May 2024 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TUMVKsep"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED11BDD3
	for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879019; cv=none; b=p7YZpIJfhcPtYbUrc21Ql80QGJPzTwsrTVU4xn1sKPvWif5DrvAXvAZDf4cGBaMG1y1+rdff5hJ3Qi18wdpl+QlXwibvUX7NBnnGrlY8gbyIokDlI0yugZ5ZttJ/l5IrNHHXjnFVvWMSVfUXI/VJY5BLrSVmElpoPi3AwmhSFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879019; c=relaxed/simple;
	bh=BzLi6SqoaN39rJEH0tlO461xNVeBEq0ZehRyOfFXA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeBV3a5RmGZRoPtRAfYgzeJlDC4zI93mIOD12SXgl4xBRcEgPp3z+eqblsXjPKyGaasu0GCh4BIVz9j36dU6v5ZZtMSBtLmTNhnqe+5BI+h8NoxsFzQTp3oIj1b3ED7DjnKU1g3512HSWoNZcKB3tFEIn+/+qHamc/OwJaP8LcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TUMVKsep; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (static180.cust.as2116.net [213.239.88.180] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44S6o068017233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 02:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716879004; bh=WeUczJhw9i2RJskJRQFxOhdJfww+ndeMWSit3yDf1yk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TUMVKsepSUj2u2sswf6Nxxkg9WP/pULTi4ov02DVou6rU9vSvuAOrz9sMpmwa0f4v
	 FhO39hL/N+BcWh+F2L96uqKLb/hTPjc3mRcIlpCsNPG9M30LyDSDS/YP7ls+jjQvhI
	 vvpSyGxdlWi5ocAgZrq4Wjh005ELP8jCPPMi65qRsxSDWmBfF75F04BJNb1VC0q/OP
	 1YRaVJBYoCHCN2wpXnz1APeI1oq4VT4nooThFzWsBVPHvxuNoLBdm5N0IVvXy9lZ3A
	 zMMOtgrsA7HDj1q39HzF2sUv1S/ed/VfrsP7ahtO6OFC0ixomKh9+XTxQvuVxv14e4
	 QnDLFVz2tdD3w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 7EAF13411C8; Tue, 28 May 2024 02:49:58 -0400 (EDT)
Date: Tue, 28 May 2024 08:49:58 +0200
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libext2fs: fix unused parameter warnings/errors
Message-ID: <20240528064958.GB1294551@mit.edu>
References: <20240527091542.4121237-2-hi@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527091542.4121237-2-hi@alyssa.is>

On Mon, May 27, 2024 at 11:15:43AM +0200, Alyssa Ross wrote:
> This fixes building dependent packages that use -Werror.
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
> I'm assuming here that it is actually intentional that these variables 
> are unused!  I don't understand the code enough to know for sure — 
> I'm just trying to fix some build regressions after updating e2fsprogs. :)

Well, note that you only get the warning at all if you use
-Wunused-parameter, "-Wunused -Wextra", or "-Wall -Wextra".  The
unused-parameter warning is not enabled unless you **really** go out
of your way to enable it, because it has so many false positives.  The
gcc maintainers do not enable this insanity even with -Wall, so
someone really went out of their way to make your life miserable.  :-)

I generally think it's a really bad idea to turn on warnings as if
they are overdone Christmas tree lights.  However, to accomodate this,
the normal way to suppress this is via __attribute__(unused).  To do
this in a portable way to avoid breaking compilers which don't
understand said attribute:

/* this is usually predfined in some header file like compiler.h */
#ifdef __GNUC__
#define EXT2FS_ATTR(x) __attribute__(x)
#else
#define EXT2FS_ATTR(x)
#endif

...
_INLINE_ errcode_t ext2fs_resize_mem(unsigned long EXT2FS_ATTR((unused)) old_size,
				     unsigned long size, void *ptr)
...

You can also play this game if you really have a huge number of stupid
gcc warnings that you want to suppress:

/* this is usually predfined in some header file like compiler.h */
#ifndef __GNUC_PREREQ
#if defined(__GNUC__) && defined(__GNUC_MINOR__)
#define __GNUC_PREREQ(maj, min) \
	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
#else
#define __GNUC_PREREQ(maj, min) 0
#endif
#endif

#if __GNUC_PREREQ (4, 6)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif

...

#if __GNUC_PREREQ (4, 6)
#pragma GCC diagnostic pop
#endif

I do this when I'm defining a lot of inline functions in a header
file, and some stupid person thinks that -Wunused -Wextra is actually
a good idea (hint: it's not), and I just want to shut up the
completely unnecessary warnings.

Cheers,

					- Ted

