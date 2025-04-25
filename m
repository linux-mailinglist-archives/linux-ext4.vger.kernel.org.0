Return-Path: <linux-ext4+bounces-7494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D4A9C9CB
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 15:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C69C017A
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Apr 2025 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D424E00D;
	Fri, 25 Apr 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BumJuWcG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDB2472A0;
	Fri, 25 Apr 2025 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586345; cv=none; b=jdOtNnHMV1PdkwWj8WicOfE2AWzd6SvVX5Lz0d0frzZyzZiOU/BEY+4Q5Eb4HNO816D6zRd9OCLv//uXEh9c5FI7OwNZfd8MEDgc8NH0AmKULTNzk/8CyJj6du5ydmcstgRbSSNM9b4Uv8A+jVA9Pzq9j52nCLsj2SB+JTz2LEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586345; c=relaxed/simple;
	bh=TyzotYciN0AZi4CO4pcbbh3+zX37cPvSh3prueKykcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR4kvT/f05ECo05OyX+IIlOZ07/6lKo6DboSdBybbl9qZwm+1XiLbOasontAQgBtlpzlrQ9k1EQ2iGjBmmRZAU7+k1cYm/voebAn5TzThxV5Ri7GPiR12fuoObYNtXU4g8OAbW9l0VVxdeDNXfNTo+tMdv7JErTZBEAJHUwb+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BumJuWcG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DkNHRT43l20SpRIMdfmlhGHSEiHBLM3uv2G+SmeKR7Y=; b=BumJuWcGDZ+6gXwfMsTG+FRbDE
	2+YJ5MjxGzUumk3Vc6edKOjO2xHR/dNSlWWYux0CME0T2gQlPpoXQ0m2lSnc5TQFbPtQ9kMvov5Lj
	Mm0EURKPGNfrigMUH1RC8Yw32GAAXjMrRThsBIKbeiajAnmaruWnZK+IZVHewqrcZhv0ornaxTH5m
	ITlsAyCo7fpi7H7Im8edLWRwPy4GHz9TWTqa9ejr5s2TVbKlbtRzuHfSrI32s/6A3C1BMB3sf7Q0k
	tPUpvU7aSL7WaHQxFXUdNiXDqCB0+XuCbyD6Q4jOIpMBjPHz0cDQ1ZIElH9NSi/VUnr/5kTInhYIL
	1K688sEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8IkJ-0000000HDVe-1ih8;
	Fri, 25 Apr 2025 13:05:35 +0000
Date: Fri, 25 Apr 2025 06:05:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
	zlang@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with
 CONFIG_XFS_SUPPORT_V4=y
Message-ID: <aAuIn7zbSNRzQ3WH@infradead.org>
References: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
 <Z_yhpwBQz7Xs4WLI@infradead.org>
 <0d1d7e6f-d2b9-4c38-9c8e-a25671b6380c@gmail.com>
 <Z_9JmaXJJVJFJ2Yl@infradead.org>
 <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <757190c8-f7e4-404b-88cd-772e0b62dea5@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Nirjhar,

sorry for the delay, I dropped the ball while on vacation.

On Wed, Apr 16, 2025 at 01:05:46PM +0530, Nirjhar Roy (IBM) wrote:
> 
> Yes, we need a second pass and I think that is already being done by
> xfs_finish_flags() in xfs_fs_fill_super(). However, in xfs_fs_reconfigure(),
> we still need a check to make a transition from /* attr2 -> noattr2 */ and
> /* noattr2 -> attr2 */ (only if it is permitted to) and update
> mp->m_features accordingly, just like it is being done for inode32 <->
> inode64, right?

Yes.

> Also, in your previous reply[1], you did suggest moving the
> crc+noattr2 check to xfs_fs_validate_params() - Are you suggesting to add
> another optional (NULLable) parameter "new_mp" to xfs_fs_validate_params()
> and then moving the check to xfs_fs_validate_params()?

No, let's skip that.

But we really should share the code for the validation.  So while a lot
of the checks in xfs_finish_flags are uselss in remount, it might still
be a good idea to just use that for the option validation so that we
don't miss checks in remount.


