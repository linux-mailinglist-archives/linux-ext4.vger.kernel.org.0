Return-Path: <linux-ext4+bounces-4980-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599329BFD52
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 05:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3D283064
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 04:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32413AA2A;
	Thu,  7 Nov 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="C3F4NzdW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F2DF59
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953027; cv=none; b=ko2NeCvaukxZ7DRd5Lc3ITgSSTc7ZbcBGQPwflXnHWLNRLjbuILSPBy/oBt59AXp29SSM7q7FADTsmSIsSSgdWBO+JYnruv+c3UYvEUwYy0GYu0LMkJlyn9sWYry8fMolX3LY1t9UEwOs/CVu99/txujbTTibbx1f2OPRmj/7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953027; c=relaxed/simple;
	bh=VnVyfp1RGxsxRJbCr7tMWbtY/M1dipjJWwcEwiTGWLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRlpoCpoCQfRNUG8Ji4p4HE9LT1VYKwGeFfPiXjYod29VPPsOKyKmBLSDd9NNniSO6xsAUuNX7JSbkkb2lcFoaYsdXvdOFJbTRLLiod4AcHfO1n5ifsgBSrgYcKanbThfqvO1H9L7hglb56QHk764LBvEzxk2QvVC7HK8HcFX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=C3F4NzdW; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A74GiTd029620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 23:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730953006; bh=gh+kbXGdzpiF2v72qQUByKLVUWEwHA7/3i8u2N0Gce0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=C3F4NzdWdaDZgpdnFoC8yq6nbx6R4ItZdxCpZGNU/7TQ4An+yYZiTIljxQZTrHSid
	 3TwJe7IXlge7No5fgJpRiYPPUOeMBpeganm0afSP18NvbL7yt11hJ+LIAkKOYyqm12
	 qwCeIaXA7hjHaYK/8rPA/+M/Ga+wTVKcZ3pGsAARTQLB4gMGlCpWPYeK+Z03rbnu27
	 anRfT7tYf0uziVa3pOtyqGyE6iu9C8G0OJCAreGHVloka4eIeJEU+HDbETU44m098Y
	 l3RoIfYdRH1zMYO00QAMulExCv/6iqslQfp5corBvKFrKQvwc0/khNiGFmvK3bPrzC
	 S0+7BbzjGSJgw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 52A8B15C02FA; Wed, 06 Nov 2024 23:16:44 -0500 (EST)
Date: Wed, 6 Nov 2024 23:16:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Li Zetao <lizetao1@huawei.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next 0/3] ext4: Using scope-based resource management
 function
Message-ID: <20241107041644.GE172001@mit.edu>
References: <20240823061824.3323522-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823061824.3323522-1-lizetao1@huawei.com>

On Fri, Aug 23, 2024 at 02:18:21PM +0800, Li Zetao wrote:
> Hi all,
> 
> This patch set is dedicated to using scope-based resource management
> functions to replace the direct use of lock/unlock methods, so that
> developers can focus more on using resources in a certain scope and
> avoid overly focusing on resource leakage issues.
> 
> At the same time, some functions can remove the controversial goto
> label(eg: patch 3), which usually only releases resources and then
> exits the function. After replacement, these functions can exit
> directly without worrying about resources not being released.
> 
> This patch set has been tested by fsstress for a long time and no
> problems were found.

Hmm, I'm torn.  I do like the simplification that these patches can
offer.

The potential downsides/problems that are worrying me:

1) The zero day test bot has flagged a number of warnings[1]

[1] https://lore.kernel.org/r/202408290407.XQuWf1oH-lkp@intel.com

2) The documentation for guard() and scoped_guard() is pretty sparse,
    and the comments in include/linux/cleanup.h are positively
    confusing.  There is a real need for a tutorial which explains how
    they should be used in the Documentation directory, or maybe a
    LWN.net article.  Still, after staring that the implementation, I
    was able to figure it out, but I'm bit worried that people who
    aren't familiar with this construt which appears to have laned in
    August 2023, might find the code less readable.

3)  Once this this lands, I could see potential problems when bug fixes
    are backported to stable kernels older than 6.6, since this changes
    how lock and unlock calls in the ext4 code.  So unless
    include/linux/cleanup.h is backported to all of the LTS kernels, as
    well as these ext4 patches, there is a ris that a future (possibly
    security) bug fix will result in a missing unlock leading to
    hilarity and/or sadness.

    I'm reminded of the story of XFS changing the error return
    semantics from errno to -errno, and resulting bugs when patches
    were automatically backported to the stable kernels leading to
    real problems, which is why XFS opted out of LTS backports.  This
    patch series could have the same problem.... and I haven't been
    able to recruit someone to be the ext4 stable kernel maintainers
    who could monitor xfstests resullts with lockdep enabled to catch
    potential problems.

That being said, I do see the value of the change

What do other ext4 developers think?

						- Ted

