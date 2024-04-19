Return-Path: <linux-ext4+bounces-2150-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F4F8AA775
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Apr 2024 05:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2395A286362
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Apr 2024 03:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC77E591;
	Fri, 19 Apr 2024 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SgDW/Mxg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17367D09A
	for <linux-ext4@vger.kernel.org>; Fri, 19 Apr 2024 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498376; cv=none; b=lrVVRpEUo/eqMxz0HuXpzIiON4nU1q48e3rkOO1g5Sm2JCMNBIA/CWy/qKGarVf4X7WQryx9T+uuynI79d8KcblvzPoeqJolv6mCdMAdXj1D6FxF2aFXcMUlRB+oKRhv5TMcWzQV7pjhqVWEc30R/9pKZVarOX5MptGYbZ5P0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498376; c=relaxed/simple;
	bh=c+/gPco6T74bdTFn27KewBMzb9DuoS0GHSVLy2ogqJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH2QcLZMGg2gS+Yv6z9CLtylABqW8zhAFl2itWFvYzvDSYtEs4Me8TwXlzAPXI5aFaAk6YAlLss6Nc0f2ZmR2Ynb0i6p+h2n6JwDlSuQ1MtPa3PO0PckqNI8Tc1N+5M5n+85clswH2iKk/eyRfgge9wR27TwUYiIWPa2nPWKKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SgDW/Mxg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43J3k8m7008113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713498369; bh=OG99fuhJ3C63Vt4bVzVyCks1BEcUeZ9E1hEobP0lekc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SgDW/MxgP39rlwwdSj26zouSLMZxOBOaec4FwMFv4axq6MjBjGgyYZqBRGpERH6iE
	 jwF0EmvP8FTHkcOsV78c63KLJcZOl1lJGegD5HmuxTZmRFD+aSf8x2R/+KN6T1ZI+R
	 g97IHTaMkhik73WEJ7+flyiKOvqGQPVzUo944kkJY4u88T1mJWwLqx+IR8fs9HPFvq
	 XkYb+C9emMz76impi/lshbWKEJH3tKbayWVlvhR/AaHZN/WAJOMZdnEpU9QK7PhJpz
	 8FY0M30H0yQFGg+j4qGGqua2w1Mu2uL2AiJ3aDEKm6SvtVYuhxJnKbLej45MVnNFFg
	 lXEMCRFEmCCMA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 19D4115C0CBA; Thu, 18 Apr 2024 23:46:08 -0400 (EDT)
Date: Thu, 18 Apr 2024 23:46:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] misc: add 2038 timestamp support
Message-ID: <20240419034608.GC3374174@mit.edu>
References: <20230927054016.16645-1-adilger@dilger.ca>
 <20240418143611.GA3373668@mit.edu>
 <E44A9FB1-280E-4EB7-9092-856E200EE500@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E44A9FB1-280E-4EB7-9092-856E200EE500@dilger.ca>

On Thu, Apr 18, 2024 at 04:04:10PM -0600, Andreas Dilger wrote:
> 
> I've never used Github actions for this. If I fork tytso/e2fsprogs and
> push to adilger/e2fsprogs, are those actions automated already with a
> config file inside the repo, or do I need to set that up myself?

Github actions should be enabled by default (although enterprise
accounts can have the default changed or prohibited by the enterprise
administrator's policy).

The config file is checked into the repo at .github/workflows/ci.yml
so if you fork the repo, you should get it.

> PS: the kernel.org repo looks like it has not been updated in 4 months,
> despite emails that you have landed patches. I was pulling from there
> and didn't notice until now that you have been pushing only to github.

I don't update kernel.org as frequently as github, but I suspect the
issue is that you were probably looking at the master branch, and the
updates were going on the next branch.  When I'm processing a large
number of patches, sometimes I don't update master until I'm really
confident everything is in great shape to update the master branch to
point at next.

It's just that April has been super crazy busy me for me, so master
lagged next by a few weeks.

Cheers,

						- Ted

