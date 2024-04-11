Return-Path: <linux-ext4+bounces-2036-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6778A17F5
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F24B1C22264
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0953DF71;
	Thu, 11 Apr 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cz1Wd0gE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA9DDD2
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847385; cv=none; b=h4oVtXB1Q5Z33cKKuDabYdB+G/7maWFuO5RvgdhGNyRU5MAO8usckJFBqC5VUiIGSyYFNl/vqkY4F5MLJrNFpa2p9gyDIrS9UuFAjq239NjYvufTtp6ZDM6TMSbpW/wzu7wgaI6PEFTjidpDc6gmrCHggL04N8Q7XZHrfWhJJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847385; c=relaxed/simple;
	bh=qyl8cvRewrne2R76ugWWGaunbDv0YkyI9BrchJYhyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhm6f8HEatEmyA9e1EGXX4hT30XyDo580rFMR84RNlx1ifmDTmbmrjzq2IpyUgU2/bqikUwCk7cdiHBFJdnU5mLpHBhme81L984/0cXBQ9qXmYKgVbdYn3+t0VPwB5QiAvHz0mufgpIpsLly7CZsLHU8hQwI5r2SVHFLah10Je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cz1Wd0gE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43BEtxaE031330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 10:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712847361; bh=ytHBX5f5+0rUA2br7x5TCIaneua6UncdS4wP1oiAmxk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cz1Wd0gE2hLPFxdVhKZyHStFedsiAL8zjb/C0wSx34mEjzPD9CREQUZhricLwJ7+H
	 kWdc3F93XJdY/MWraB98EQgVPnt6lvj7uThiaIggphLRkcSmJfOhfeXLLsgLFDuXhJ
	 NG/auxm9ih5EV5QDC1axtjY43NYrowCDf56wVU6O4+pk0u1kcn0wGFcHx4d0oHwCMy
	 zqqMvTXQ3WbW8EAGmHrE8TgkL8j2Qtj56ClYehLNdD3YNxb9Z8d7fcW0fwlFUMJubR
	 cdGbOdPbAFf3EHbHxh1skd5Fo/rvLQtwEpXT83MsVu/ZW68uY2e0W1J7d2ALFG5v39
	 WKEcbEa/lhvBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7B57A15C00DE; Thu, 11 Apr 2024 10:55:59 -0400 (EDT)
Date: Thu, 11 Apr 2024 10:55:59 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "yebin (H)" <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240411145559.GB187181@mit.edu>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
 <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3>
 <6611F8D5.3030403@huawei.com>
 <20240411133718.tq74yorf6odpla4r@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411133718.tq74yorf6odpla4r@quack3>

On Thu, Apr 11, 2024 at 03:37:18PM +0200, Jan Kara wrote:
> > The vendor
> > has confirmed that only 512-byte atomicity can be ensured in the firmware.
> > Although the valid data is only 60 bytes, the entire commit block is used
> > for calculating
> > the checksum.
> > jbd2_commit_block_csum_verify:
> > ...
> > calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
> > ...
> 
> Ah, indeed. This is the bit I've missed. Thanks for explanation! Still I
> think trying to somehow automatically deal with wrong commit block checksum
> is too dangerous because it can result in fs corruption in some (unlikely)
> cases. OTOH I understand journal replay failure after a power fail isn't
> great either so we need to think how to fix this...

Unfortunately, the only fix I can think of would require changing how
we do the checksum to only include the portion of the jbd2 block which
contains valid data, per the header field.  This would be a format
change which means that if a new kernel writes the new jbd2 format
(using a journal incompat flag, or a new checksum type), older kernels
and older versions of e2fsprogs wouldn't be able to validate the
journal.  So rollout of the fix would have to be carefully managed.

					- Ted

