Return-Path: <linux-ext4+bounces-8631-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633ADAE80AF
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40A3BFF3E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 11:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D072BE7A6;
	Wed, 25 Jun 2025 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="CUuXs4L5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70102820D5
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850003; cv=none; b=ZCfgi2jVhP4GLF/lESdkNJCud1SZ/1idPKIb2cZvSr5Qm4e4HDVBiAr74mRhYAQG0LrqAK/0qZ7KtJp2XfjVQQ2zCUyRr6jXfg78OHvYc7uMaPHU5lm2XeCzRn1UYfb9hz3+6futk4FAmwBau52rcFhweQcdeH3JyaHe8ICVsOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850003; c=relaxed/simple;
	bh=bC8PR2TME4UFCi+5Hc59bcgjdsjRclxq+G/yx4wOW+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgCb6ZygAouomXncgBkudeGnei7daZJphkI8YBo4lOUVYrGW1apc4TACJFsSYv3gdmIEg8s3uP/owqQe2sffwvjO1m0Pl8Uvd4iebAKbpY34sXAp10EYm5S3dQootY5Mcqriabc7q2wk8oV3SZuAKp+ngKejz7g9AgRJ1wXOu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=CUuXs4L5; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bRzhC6lGYz9sd6;
	Wed, 25 Jun 2025 13:13:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750849996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7oe2pIJC+38vJh1O1Q1OLLWTyKPP/SymJuoX1qC+pk=;
	b=CUuXs4L5mUJVSQPquyF9jhJ5H8ElV4H2vwva/vVgNV8vO9G2mATA0jby3+2NVTBRfFCi9q
	1gLmZgxbOezMsFrosqF+99NQWkAKj9XOMubQGfCM0excYZgbWpPPFw3ijGYhyZZfZd1b5e
	jd451+j4fbnkPiuONgOSCZTtuurz82ddPY/X/l0kNMxabyvMOWv/3x6hafoWTdoql4wgAZ
	Uwe8maxneTZE6PnZvh20YIL+idbS8ZDV2AKFeeyuONris9ChsjUw+mfMejBL/2zis/+Rqu
	W4TBr/69BbMmdwOQ+zYPb6kGDrCtjDn/RHBdirJJrjVGw8pCf8KezRQtnjYUXQ==
Date: Wed, 25 Jun 2025 13:13:11 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>, 
	Baokun Li <libaokun1@huawei.com>
Subject: Re: LBS support for EXT4
Message-ID: <c3ywjnnpfefledcl27qoqvwi4ew7fkrpmneddbxtquazraocrv@5e6l3t5oqap4>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
 <20250623141753.GA33354@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141753.GA33354@mit.edu>
X-Rspamd-Queue-Id: 4bRzhC6lGYz9sd6

Thanks for the reply, Ted.

On Mon, Jun 23, 2025 at 10:17:53AM -0400, Theodore Ts'o wrote:
> If you want to review and test the ext4/iomap changes, that would be
> great.  Be aware, though, that there are some features of ext4
> (example: data journalling, fscrypt, fsverity, etc.) that the current
> iomap buffered I/O code may not support today.  The alternatives are
> to keep the existing ext4 code paths for those file system features,
> or to try to add that functionality into iomap.  There are of course
> tradeoffs to both alternatives; one might result in more code that we
> have to maintain; the other might require a lot more work.
> 
> It _might_ be less effort to add LBS support to native ext4 code.  I
> think the main thing is to make sure that we always we use a large
> folio and not fall back to a sub-blocksize set of pages.  So again,
> it's all about tradeoffs and what you consider to be the highest
> priority.

@Baokun are your LBS patches based on the native ext4 code or on top of
Zhang's iomap patches.

> 
> For myself, my primary concern is to keep the code maintainable and to
> not result in any test regressions.  If your goal is to get more file
> systems to use iomap for buffered I/O, that might be different than
> those who are aiming to get performance or improved hardware support
> ASAP as your higher priority.  I will say that in the ideal world, we
> would eventually migrate to use the iomap code for buffered I/O for at
> least the most common case.  But if we end up having an intermediate
> way station where we have large folio support for LBS before we get to
> that desired end state, I'm open to that, so long as the code stays
> maintainable and bug-free(tm).   :-)
> 

This makes sense. Thanks, Ted.

-- 
Pankaj Raghav

