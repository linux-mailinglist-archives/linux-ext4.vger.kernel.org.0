Return-Path: <linux-ext4+bounces-4981-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078FF9BFD7F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 06:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D5B1C218B0
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 05:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3E618858E;
	Thu,  7 Nov 2024 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mGXs5M4/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAA366
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730955795; cv=none; b=Izeg7dMFghqHJRBFA65tzrpSOeXZ1uwmcQJO2nNNXxWY7X/2AWvyONcjCM8cjjzHEhnaGnO8K+4bb6ADtIWLWGRRtAimKJoYKgvcTo7OXTTxhcpm4yWUxwOftbO55g01+huY6LvLBqcbYMC3Ya7wpiowzr8tg7GmRUX2Pbe9lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730955795; c=relaxed/simple;
	bh=A1xk1Y1Drb+SMlVSpAyyuW5xhbCD2d87NukgzEgyXYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxVqzq2PiGYHiNFwEd5VCIJ4Q014mRtxuqWbPXoJCy5QqWToCmmLRSsnwxreul64evaF+JiGZjF6jV4xt80fx0IL4lOmYfh5Q/EBdMcsTollDUnV3B+25jJxLC7VA9ILtTyz2fuU/XgGm2VZbaCOaD2aHZWC/zwhdydi/KtBIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mGXs5M4/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7537Eo018766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 00:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730955789; bh=7ejduhyzE6qyO0NJEbymQI49G12/Ii3pJbPfJ+tahC0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mGXs5M4/Vi39aRBT5MYWfRMCJdeB7GzqOYlLNM5tP5Ulv4WpJT5aFzs6c+PG8HQ8B
	 0ng5icQMEO1NhyvC+IvnkYMy0TvhpcVMrKwt7MLcopx6NeuKJk/Zs/+wGwwlxJwHzN
	 GlXyQtixl1AsTBGPLIFd9o2nLxsztLHCgL9XnWfxOribFXLTbBJgjPiW+ZN1peh19h
	 3c2R8fdbFnHokK3x/84R9ljh+KqzhsALoWhF4YKh9j6jqimbILLTANYDAv/MFvckYx
	 8eXqP6BDsV8OF6OtdtNMIoX9V2Xf0qLJpr5GHD7RWIy66sL/ZzdSCTrrxGtahQEZsJ
	 n8m6vsqE1Wr3g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9361B15C02FA; Thu, 07 Nov 2024 00:03:07 -0500 (EST)
Date: Thu, 7 Nov 2024 00:03:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Max Brener <linmaxi@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND v2] ext4: Optimization of no-op ext4_truncate triggers
Message-ID: <20241107050307.GA287288@mit.edu>
References: <20241016111624.5229-1-linmaxi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016111624.5229-1-linmaxi@gmail.com>

On Wed, Oct 16, 2024 at 02:16:24PM +0300, Max Brener wrote:
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
> v1: https://lore.kernel.org/lkml/20240926221103.24423-1-linmaxi@gmail.com/T/
> 
> Changes from last version: Moved vfs-level changes to be ext4-level,
> and improved the description of the patch.
> 
> This patch enables skipping no-op 'ext4_truncate' calls. Analyzing the kernel
> with ftrace shows ext4_truncate is being sometimes called without making any
> impact, and sometimes userspace programs might call ext4_truncate in vein. By 
> detecting these calls and skipping them, cpu time is saved.
> 
> I'll fix this by skipping ext4_truncate call in 'ext4_setattr' when the file's size
> hasn't changed AND it hasn't been truncated since the last disk space preallocation.
> It is meant to consider the case when ext4_truncate is being called to truncate
> preallocated blocks too. Notice that so far, the condition to triggering 
> ext4_truncate by the user was: if (attr->ia_size <= oldsize) which means it is
> being triggered when attr->ia_size == oldsize regardless of whether there are
> preallocated blocks or not - if there are none, then the call is redundant.
> 
> Steps:
> 1.Add a new inode state flag: EXT4_STATE_TRUNCATED
> 2.Clear the flag when ext4_fallocate is being called with FALLOC_FL_KEEP_SIZE flag
> to enable using ext4_truncate again, to remove preallocated disk space that may
> have resulted from this call.
> 3.Set EXT4_STATE_TRUNCATED when ext4_truncated is called successfully.
> 4.Don't skip ext4_truncate in ext4_setattr when the size of the file has either been
> reduced OR stayed the same, but hasn't been truncated yet. This is in order to allow
> truncating of preallocated blocks.

This patch is still not quite right.  See Jan's comment from [1]:

   Agreed as well. I'll also note that keeping such flag uptodate is not as
   simple as it seems because there are various places that may be allocating
   blocks beyond EOF (for example extending writes) and that rely on
   ext4_truncate() removing them so one needs to be careful to capture all the
   places where the "truncated" state needs to be cleared.

[1] https://lore.kernel.org/all/20240930095601.x66iqw74bxffytgq@quack3/

						- Ted

