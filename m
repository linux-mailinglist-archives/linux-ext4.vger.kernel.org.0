Return-Path: <linux-ext4+bounces-6352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A2A2AC27
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A744167C73
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A251E5B7A;
	Thu,  6 Feb 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MPwAOB9i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747F236420
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854574; cv=none; b=jQKtESCDS+i1JdNVYH+jU6WzjF+e5VyDzzb79mdczmU4y8gvu+Mv6ckmLqU8KPIPqDV8vMgXG5RJtsa3Zukx8GR5Vydd5A8/IHCTTEVaPgoilUlC0vk2J9hptfmVT+dL8N5MCWAnn9xUey2RdgMZoklpS4NuPQw9tzDGkJvUixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854574; c=relaxed/simple;
	bh=3gf3ncnpJyQin6tZPGsoVBf27U7XjOWhbI+3lOKNlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgiwbnUwHG2X8Qe7+qAdkGyXN/zT3gQmIk4eWGApjI3QhuVzPZkjAX6F6cSdXQjPHMM4kWNenPGu6x3IUO0VyhIIn8AwMa2Y76ArmzupwlizTzEeF3m7CD9TLPcEZF9/oEm6olXL8Cv0dScP835NuqJm82JRYyPdkWJiL3isrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MPwAOB9i; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-148.bstnma.fios.verizon.net [173.48.111.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 516F9A6E013927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 10:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738854552; bh=xKH0aXUcLZvt/5vtGRGxbkWwlAPwPjYybm/CGsJUlUY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MPwAOB9i0vVWRnNT6bPXnH8Ymu5rLLeEMhYMwAVvGg+Q6ZTyAgvHShBm8jaUK4El6
	 BoCOvgu3Vlv9keNEKyMyKvBg9RjUFSEn6AGagU+LgFZ67Tqyiy3UFb6SrWP/jDamdP
	 cvG3YVR1niHDhSP7HbmffkeVQoh+QmDSylQ4Xz7BCIBPFtvQzpu06C6rE4KvXQHw0i
	 aGGztwEOZ40Ign3iUdYX5KxAlxHUF8Pw74phBuHd81gO5i8bWWAI5qDGgadW0wa+Fw
	 LBbGbU5qSn4EBgvVwHVcEcwQ7cnWciuFjnE1oVUdN5nO0/mmG7K1Eghg1NCyIeanED
	 1O9t4chVSAt2Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 5C4B315C013F; Thu, 06 Feb 2025 10:09:10 -0500 (EST)
Date: Thu, 6 Feb 2025 10:09:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ext4: avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250206150910.GA1130956@mit.edu>
References: <Zz0TEX3GycUEmISN@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz0TEX3GycUEmISN@kspp>

On Tue, Nov 19, 2024 at 04:37:05PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we
> are getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure (`struct shash_desc`) where the size of the
> flexible-array member (`__ctx`) is known at compile-time, and
> refactor the rest of the code, accordingly.
> 
> So, with these changes, fix 38 of the following warnings:
> 
> fs/ext4/ext4.h:2471:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, for this patch!  It appears that this patch has since been
obviated by Eric Bigger's commit f2b4fa19647e (" ext4: switch to using
the crc32c library"), which landed during this merge window, so this
patch should not be needed.

						- Ted

