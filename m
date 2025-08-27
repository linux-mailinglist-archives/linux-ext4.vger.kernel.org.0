Return-Path: <linux-ext4+bounces-9692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D479B381E0
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C1F1BA35A2
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D772F83C1;
	Wed, 27 Aug 2025 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Su1nJqDs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4131285066
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296169; cv=none; b=t89g06AdPkSmK7Jd0S0DIDxyUmGrKLKUBgV1z8GSutNnbg+A6pAajyjNmRSlPMkLVvmPip+OgH9EOsmoTcYwKzKWgVBJGfIZATq0BcrXNJ4WEs7HzMTCSMVFdneouYSnTKTg1o7MnP+c0lW8MeBdgLPIatloWSMNRkh3MGMox6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296169; c=relaxed/simple;
	bh=ICrqE13s49dbDB4Gwp1lTRNh0ah26W1Bmg4IF5kHnFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbjy2ygvaOJrIUgDFlHu90OT/RhySElbtzU5mJ+SFWT92Uy+UEZ9JaC9OsPkZJB1B1cUaWEzCNw6A+xPxqiYSXgLNxKRQx6o7DSWyx0J+QZ0IZi5Yw7NLA82FlTQP+r0y7z05bIJcpCzR2s68pKDE3X/RP5ODMRVGPZm7+JT8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Su1nJqDs; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-253.bstnma.fios.verizon.net [173.48.119.253])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57RC2b1K018279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 08:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756296159; bh=g0OAUx2qHR+X+MEnyeHrNi4vGsQ/st8jB1elnzvliz4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Su1nJqDsA4r/voWMPA1qp9a4VJm7PHTFRcU98J3b61uQUGzmbBA19Wmln2WIorOMk
	 gj2cpkDg3yg///wGy+pOyoVko9/xVz6RAj0EEo/T8JPUQA81J5GgEaTJPxv10OUcTI
	 2OQ+CWbeaIxxB4ZdxfbjLZ29ExaN+1Ds9Wh8Ea071eaB1JwgsG9z/bWqwt1WSha07Z
	 xCokw0upDqhIrGyeAfdSiBLkHZyTBoPRgj5mwQ7kgWbT34TRIvAWjTKjPo9mptDvQA
	 k2ChWOz0wep5Y/l1rDWr6VK4p2vvSKzMLaOR0HRU6L09oGXrlNGO2CzuLNVn5XgJKi
	 Ip8vPZZtYzUPg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 557D52E00D6; Wed, 27 Aug 2025 08:02:37 -0400 (EDT)
Date: Wed, 27 Aug 2025 08:02:37 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] ext4: remove obsolete EXT3 config options
Message-ID: <20250827120237.GE1603531@mit.edu>
References: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827090808.80287-1-lukas.bulwahn@redhat.com>

On Wed, Aug 27, 2025 at 11:08:08AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> In June 2015, commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")
> removed the historic ext3 filesystem support as ext3 partitions are fully
> supported with the ext4 filesystem support. To simplify updating the kernel
> build configuration, which had only EXT3 support but not EXT4 support
> enabled, the three config options EXT3_{FS,FS_POSIX_ACL,FS_SECURITY} were
> kept, instead of immediately removing them. The three options just enable
> the corresponding EXT4 counterparts when configs from older kernel versions
> are used to build on later kernel versions. This ensures that the kernels
> from those kernel build configurations would then continue to have EXT4
> enabled for supporting booting from ext3 and ext4 file systems, to avoid
> potential unexpected surprises.
> 
> Given that the kernel build configuration has no backwards-compatibility
> guarantee and this transition phase for such build configurations has been
> in place for a decade, we can reasonably expect all such users to have
> transitioned to use the EXT4 config options in their config files at this
> point in time. With that in mind, the three EXT3 config options are
> obsolete by now.

Do we need to worry about what happens if someone uses an oldconfig
from an RHEL 7/8/9 kernel (or equivalent SuSE kernel) to try to build
the latest upstream kernel?

I don't really care because I don't use enterprise distros, and I
haven't worked for a company that supports enterprise customers for
over a decade, but I thought I should just check.

Cheers,

					- Ted

