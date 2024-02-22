Return-Path: <linux-ext4+bounces-1371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92852860388
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 21:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395C51F26CDB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D296AFBF;
	Thu, 22 Feb 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PTN+0C6U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A946AFB8
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632796; cv=none; b=jbp7V9FL0g4rj+9ZxuoXhYfoNaJyUxfspsHmomzGOO23cQ8BMnbgeysm4fhHaLqtD4XJ9xlGytpE9n85Zqbz88lb1VvJOsyD3g86yoCmLkNvWE7aokt6pvZ11QTfpALxrbbgU+VjFlmCuzPOdJJOSs97oxoGddhvikwebHARBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632796; c=relaxed/simple;
	bh=BlP4CrGie+FCVnlreK/dTzBKUU8RRQ8JdT6HVWh9izk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0C8yiy7Lwq3Vp4/khVsJ+V6P3Ig+HkFs7+preqIMe1oaqdxwcbMqbpvJQSC9674vFUbQ7WBTRF9Xjl1qNDSiTHp9Hk08cJdxKJo6Laj+rsLQ2ITCimWD0hEtkrFZSuJFoV7HF0MGZn7L8E8HbBkEmXjUO6G5J6OaBDKvQZwLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PTN+0C6U; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MKCqWR026969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 15:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708632774; bh=3pPMlbI1D92DjeU+ZhSA8cIvG1XyeqTC8x8rwR9QuhI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PTN+0C6Ul4EFhJ1ce2jafld/WogVZupprPC7rRAGZ6aOz412xTtaCHkER1wAVSaZQ
	 4ERRiranfYWZhgrJazTSnC5oa4YBi0mED4Bsv970uXBApZ44EGCl5aFwZd5B3SJoav
	 517LM4EtADWMn7Hdtbe28JpNehMuLrfUHSMrh9j4+LwV17+GSeRobAgYvAbCHhhlcf
	 TpQCm9qPCKu6B/YVslMXXB4WtvtzFyhy4Ax5WDzKyadzSgy1YKAcORdJoIvakYVapl
	 XysFfjDEVMQvPmWiq01njtmtNiwA4bq5Rr8IF63fLkk1Bxx+iZ1khsNW4O7TB1GMux
	 ydBatwU50ho4A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 6314B15C0336; Thu, 22 Feb 2024 15:12:52 -0500 (EST)
Date: Thu, 22 Feb 2024 15:12:52 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Reindl Harald <h.reindl@thelounge.net>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Message-ID: <20240222201252.GA744192@mit.edu>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
 <4b40056d-9b55-48b2-86f0-b91207e9abb7@thelounge.net>
 <20240221154858.GA594407@mit.edu>
 <26213f05-2727-45de-8917-da54430d2d19@thelounge.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26213f05-2727-45de-8917-da54430d2d19@thelounge.net>

On Wed, Feb 21, 2024 at 11:57:22PM +0100, Reindl Harald wrote:
> 
> Fedora for sure didn't invent the nonsense in "mke2fs.conf" falling back to
> such pervert settings for very small martitions

So first lf all, "very small" means "smaller that 512 megs".  The
rationale was to reduce the overhead for small thumb drives, where
maximizing space for data files was considered most important.

In practice, most root file systems tend to be larger than 512 megs.
For example, the absolute minimum EBS size in Amazon's cloud is 1GiB
for General Purpose SSD backed EBS, and 5GiB for HDD backed EBS.
Google Compute Engine's minimum Persistent Disk size is 10 GiB.

In any case, starting in e2fsprogs 1.46.4 (released August 2021, first
shipped in Fedora 36), we changed the default so that 256 byte inodes
is used everywhere, including these small file systems.

If you didn't like the old default, well, for these really small file
systems, the good news is that it's pretty simple to backup, reformat,
and restore the file system.  (And of course, when the root file
system is that small, in general reinstalling it is no big deal.)

Cheers,

					- Ted

