Return-Path: <linux-ext4+bounces-1113-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14D849F87
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 17:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF241F22677
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188D2E636;
	Mon,  5 Feb 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nE3v+/WT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7B3CF4B
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150799; cv=none; b=JtbpJaFCtKm2bVirSKc65NIDb0GJNIsGKj9tUzFfytGqVFmi/CAsd3ClUgcBrO2PPe2r/0QYQEBNaBpRouWCTAlysN4G7P5WRSQGzq8gA57qeJaGhVVjCxcFzoEllPq2qHZyo3HAW9PvzP4APSIzcs5aPBtrxnz8Ldzo4vMIZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150799; c=relaxed/simple;
	bh=2cQXhUPiMEW3Ok85h1EHeLAdBpbDxsZrxdUiLgoGxIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvU4jXq/+2uC2KMScs9YuFX6kxxCiYwKaeqjMImRsPv0oCdgQ1dE/JTI+kflI6qOkZivumCx92H3hotwAUzF05+yXJZOdRVE/rpjUAv/lYaVGkvXu1YBNkulm2nliBRWZOO5Vskut5tDxM/ttB8eZcX4bUjqaLaawXVj9BK+jAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nE3v+/WT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 415GWnNj014106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 11:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707150772; bh=a9P4gllJIaKyhZehWwj32p0bctAew6koUJX5fapQ3pQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nE3v+/WT01Gk5V/Z68qPKmJcM7hU6ejzRJNb5gfCRDRr0HScBgSzNJukgqr/k+WWD
	 rRoJJmzmB3fH1Krx1choGfJD9GfDXIG0u+d4aloWquXQuYOj67M5jEEX7/KDOOM2U8
	 srGpfV2gk3U51xYuSpkrLmlDojg2+2aHrxoV60sWXTekEc2DjptjmjkkkzbrmjBHO6
	 YA155/K7Ggk38BKkPTOmRzkfmDAidILGgFd1KOxJCou/DoMyL3vK8/EYWbYvrwVHsK
	 H9RqCdUnL3r/a16CoFcJdL7zQ+AJVeERboPxKV0QgpLH3ukrC1POhSkKpZCxbtNK++
	 2LnW75jaVcM6g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B733815C02FD; Mon,  5 Feb 2024 11:32:49 -0500 (EST)
Date: Mon, 5 Feb 2024 11:32:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, jack@suse.cz,
        ritesh.list@gmail.com, john.g.garry@oracle.com, djwong@kernel.org
Subject: Re: Running out of inode flags in ext4
Message-ID: <20240205163249.GE119530@mit.edu>
References: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcCztkt8KtMrsvPp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>

On Mon, Feb 05, 2024 at 03:38:54PM +0530, Ojaswin Mujoo wrote:
> Hi folks,
> 
> I'm trying to rework the ext4 atomic write patchset so we have similar
> semantics as discussed here [1], which would look something like:
> 
> 1. we call FS_IOC_FSSETXATTR to enable atomic write on inode
> 
> 2. In the setxattr path, we need to mark the inode with
> atomic_write_enabled. XFS does it via an on disk inode flag which is
> straightforward enough 
> 
> However, on ext4 we are almost out of 32 bits of inode flags and I don't
> think it's possible to add any flags2 field or something (iiuc, ondisk
> indoe doesn't have scope for expansion).

We still have some unused flags.  For example,
0x01000000. 0x04000000. and 0x08000000 are still unused.  We are
starting to get close to full, so we need to be a bit careful since it
is very much a limited resource.  But we're not yet at the point where
we need to worry about trying to reuse flags like EXT4_EOFBLOCKS_FL.

Cheers,

							- Ted

