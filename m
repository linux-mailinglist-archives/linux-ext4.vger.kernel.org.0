Return-Path: <linux-ext4+bounces-11885-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A73C66264
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 21:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5D361297E6
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5F34B438;
	Mon, 17 Nov 2025 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="k5JggWYP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D74319875
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412695; cv=none; b=JKonWeBDrau5lVa0KUDVTXEGhnsGgNrzhlbmZ44K0MW4t8q3G6YsT1Gq9XYNiGEtGz5oK6aH937MsEN2oHj43jUynAmN1Tee6ir5Zx/ic6rTDh1NFEUGnigqdVYs3hpgHUKxXCYn86UTi9lM5oFyn4e99HeyrSlwI1A5kScMO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412695; c=relaxed/simple;
	bh=MhRuGKREKjnDv5Rvs5Tcu3ha4BQBYTByx2vMFukybAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk9xddWqTJuUAGdtpSVufVWmETDSP/VhYjbrGWLDA60mkQsiY0lH1TNsYpMuuvoJ1WToaszeMkgunxNTi2Z1jdXjOn7Gu8kxXlNlt+2cFafUa0/xYUitYjptEn2NC15PIEopmQdMJeYjvI/wofEWQfPN1al/00makfqlGHZkgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=k5JggWYP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso2521813b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763412692; x=1764017492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzhSFtd1TJYR/cIblKSU+QrS3cy0V4ly+fmhKB6r+qY=;
        b=k5JggWYPoO+BSCmkWvSENgLSY7VpDkFZpUobtUkiLdyHcfvOVjG/7umvPtVzdDJ6Yt
         GqYhtxescCO4qPkHW7t/atI3oVslTbgyQArfVL/V7yi9eZGXTmbeKh75jxVkFp6jBKBR
         uM+mK9A3DAbsRNzaCcTKHa446Br/tBeN8ClPiof63iq6kknLAJeWihVvNt+Z5Oc39ug+
         sNgufYbP+LieOvVfDnyStlUF9vXgTftwlGOFxEOdALx4yAAJ5wmDahs+nuZqgpRg5HyZ
         t/XpcIh2k0btXfL358zNgpsPEg9goAYsNZYIoVookT2hpP1/R+cR+G34z2lPDccrh8XN
         1Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763412692; x=1764017492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzhSFtd1TJYR/cIblKSU+QrS3cy0V4ly+fmhKB6r+qY=;
        b=mWgJiMqUO9SP4Fe6TX/pWqIpxo+888oZRJqkXe4C+Hr1CVWkSVARvAAHX74by/xM+8
         pxl+VoPXST65jeKL6hhhoq27AxnJVHVtB4+PgJz2rmh/IgeSnLXIZ+UV4XN2rIpMNREt
         gJ043F95Ant0aSQkgCR2G2yYhpIvPGbJXzH/zeiwNdisOSn0va/Zo+SiOVxUoghJHCV+
         Qr/wyrOXXITcMQo93v5IZ2PDz/aNDDSwjf3kbSvmfdPdtkNhfdXicWOBtDPkwtJd4yUv
         cscdp9WToElorzBtdt7CzlOfWV5HbMKJUnX5HoCY5nmPOhgn3IoEHOIqthCeHiXBDE0x
         uGAw==
X-Forwarded-Encrypted: i=1; AJvYcCU2cmNsc9etdvi9807l0oybP/eGRHyVcT5peGOSWvFrMFnqMuy2R0PNhsnPj/JriuBEf+GETXH6ZYa/@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQ3gSoEVo64+iXPf0ZQNzVIr/GLDxA/8rZfmIgMMhAmCQurqY
	47d+h2S7LpIPZrTTaq7y/mDuIWofQFYlPISj27O8GdfQ6y9T9Bax56FZJD4TLXmVI70=
X-Gm-Gg: ASbGncs0Zj4ckngbWfxu2Q7y3JC0hfLSQrTrdhlgtJTD97/lH077aA5D6G3TdLFnkYT
	sJRtn3GcjFfYjULPfnnuu6JnPGde+iVRDTHkAV9ZVPV8+SvY6Pou9H6OkYvwDSGIzWeuB9PteX2
	vAcyonK1B4JKUJk9VDLEtwhSjPdcFttPE3bl3BcEg4FIqS40G16YLi9NG3cQcNPe1krySDMygII
	IBoH6KnFPyxoSP7Mj1qKnCWxo65mdReFNw0aI+cdi9ZfGcEvVmJwsHK+UbDKlX7UWSKAUXHocVL
	OGX14g31DStHMI8/Kzpe+BrM38yqjcTaFlARrdA9lsd57OreXAwjPVsfSeuU7LCYm7/Sdbdqc9G
	U/Ez0nZmgl+qr0m9Wwhl4N5DfN1TCOj/+UaEgrvz9EGQkBFjHORHOrXl/YVSfBM0r60DtTNASHv
	z1gkc1GtoqgdodCC3IWrdKZm2WyS8+NDV77gnb39A/slpyUiCtZbs0JxCUKtiNaA==
X-Google-Smtp-Source: AGHT+IFmWemPBugDags9Dp2aFdnpOuTH5HosoXLiUasMcQMlSkctA94mD5u3ieiUdMxFP9/1+M2F7w==
X-Received: by 2002:a05:6a00:982:b0:7b2:2d85:ae59 with SMTP id d2e1a72fcca58-7ba39ecfa9dmr13503855b3a.11.1763412692398;
        Mon, 17 Nov 2025 12:51:32 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714df0esm14242994b3a.37.2025.11.17.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:51:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vL6C7-0000000CADH-2ixk;
	Tue, 18 Nov 2025 07:51:27 +1100
Date: Tue, 18 Nov 2025 07:51:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	tytso@mit.edu, willy@infradead.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
	martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRuKz4F3xATf8IUp@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aRmHRk7FGD4nCT0s@dread.disaster.area>
 <8d645cb5-7589-4544-a547-19729610d44d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d645cb5-7589-4544-a547-19729610d44d@oracle.com>

On Mon, Nov 17, 2025 at 10:59:55AM +0000, John Garry wrote:
> On 16/11/2025 08:11, Dave Chinner wrote:
> > > This patch set focuses on HW accelerated single block atomic writes with
> > > buffered IO, to get some early reviews on the core design.
> > What hardware acceleration? Hardware atomic writes are do not make
> > IO faster; they only change IO failure semantics in certain corner
> > cases.
> 
> I think that he references using REQ_ATOMIC-based bio vs xfs software-based
> atomic writes (which reuse the CoW infrastructure). And the former is
> considerably faster from my testing (for DIO, obvs). But the latter has not
> been optimized.

For DIO, REQ_ATOMIC IO will generally be faster than the software
fallback because no page cache interactions or data copy is required
by the DIO REQ_ATOMIC fast path.

But we are considering buffered writes, which *must* do a data copy,
and so the behaviour and performance differential of doing a COW vs
trying to force writeback to do REQ_ATOMIC IO is going to be much
different.

Consider that the way atomic buffered writes have been implemented
in writeback - turning off all folio and IO merging.  This means
writeback efficiency of atomic writes is going to be horrendous
compared to COW writes that don't use REQ_ATOMIC.

Further, REQ_ATOMIC buffered writes need to turn off delayed
allocation because if you can't allocate aligned extents then the
atomic write can *never* be performed. Hence we have to allocate up
front where we can return errors to userspace immediately, rather
than just reserve space and punt allocation to writeback. i.e. we
have to avoid the situation where we have dirty "atomic" data in the
page cache that cannot be written because physical allocation fails.

The likely outcome of turning off delalloc is that it further
degrades buffered atomic write writeback efficiency because it
removes the ability for the filesystem to optimise physical locality
of writeback IO. e.g. adjacent allocation across multiple small
files or packing of random writes in a single file to allow them to
merge at the block layer into one big IO...

REQ_ATOMIC is a natural fit for DIO because DIO is largely a "one
write syscall, one physical IO" style interface. Buffered writes,
OTOH, completely decouples application IO from physical IO, and so
there is no real "atomic" connection between the data being written
into the page caceh and the physical IO that is performed at some
time later.

This decoupling of physical IO is what brings all the problems and
inefficiencies. The filesystem being able to mark the RWF_ATOMIC
write range as a COW range at submission time creates a natural
"atomic IO" behaviour without requiring the page cache or writeback
to even care that the data needs to be written atomically.

From there, we optimise the COW IO path to record that
the new COW extent was created for the purpose of an atomic write.
Then when we go to write back data over that extent, the filesystem
can chose to do a REQ_ATOMIC write to do an atomic overwrite instead
of allocating a new extent and swapping the BMBT extent pointers at
IO completion time.

We really don't care if 4x16kB adjacent RWF_ATOMIC writes are
submitted as 1x64kB REQ_ATOMIC IO or 4 individual 16kB REQ_ATOMIC
IOs. The former is much more efficient from an IO perspective, and
the COW path can actually optimise for this because it can track the
atomic write ranges in cache exactly. If the range is larger (or
unaligned) than what REQ_ATOMIC can handle, we use COW writeback to
optimise for maximum writeback bandwidth, otherwise we use
REQ_ATOMIC to optimise for minimum writeback submission and
completion overhead...

IOWs, I think that for XFS (and other COW-capable filesystems) we
should be looking at optimising the COW IO path to use REQ_ATOMIC
where appropriate to create a direct overwrite fast path for
RWF_ATOMIC buffered writes. This seems a more natural and a lot less
intrusive than trying to blast through the page caceh abstractions
to directly couple userspace IO boundaries to physical writeback IO
boundaries...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

