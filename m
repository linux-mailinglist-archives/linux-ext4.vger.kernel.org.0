Return-Path: <linux-ext4+bounces-11028-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3FEC02CEB
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D062D3ACBB9
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Oct 2025 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289FB34B1AB;
	Thu, 23 Oct 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBte238+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC81E25E3;
	Thu, 23 Oct 2025 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242157; cv=none; b=UwkNIGXjddYLXJ80ixQbVVxp08RqF8hfFZbzl4YScV6Y6cDLXURgS5H9PCpEvJHEBDfdVjYPAV+YirnyT7gkeN0eZBDolJCl80VPgo1eP1PPsqjZyfeHRPSuoojUSxKHkZ+VC8qjz9rMxlwN5LEtwnz8hJX9v2mBN3h5zR0ALJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242157; c=relaxed/simple;
	bh=W9hOllCYjZkW3SsDFZQQTRthlKx0vsY0rDZ8rrKvmQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFMjYPPxHHIRq+AMXIsjVjljQo5eV/lWM/KbWnBUKnisLxNHddOgDn+K3jG4QJnDUmNdHuAVnvfweo81sVCz46tHt02xkilpTdM/8Rx2J3oyexN6J1b3eNHtkPyPuBtJkBVPlyLvRri6TL/CAlkfvYcxh+PlU6Ulj6hulYOQQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBte238+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1529AC4CEE7;
	Thu, 23 Oct 2025 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761242157;
	bh=W9hOllCYjZkW3SsDFZQQTRthlKx0vsY0rDZ8rrKvmQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBte238+k1/axF3N8c26hoGmfeKKV8DJiZQ5kJWfF/qv3ZHSXBHdGOE4pikrwyUp+
	 51kFOgwjCYBAm5XZ2L+W1gQffNcVQha2RwUya6xOfyHg6hW/W7YuULfmGUK/j111AL
	 3A3GUSSQcFOcoIsc0YiLdBFZs8tIyW0Ruf8+0Y2cNvLkA6n2pepqznFa9apxJYVaKn
	 x47tCaE+2utlW4E5Dwfv3xRN3pCWQBBu7ymWeTMFxgk9mZqMUctxkZo/GNCxBY6vJ8
	 EvC9ZwbK0NfgQfsMfSgipj15G4J+zocmuiR+dAEkk1NPF3rIjFm8PCJm9hQaHMWcBc
	 yt2mxzePn8hFw==
Date: Thu, 23 Oct 2025 10:55:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Brian Foster <bfoster@redhat.com>, Zorro Lang <zlang@redhat.com>,
	fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20251023175556.GS6178@frogsfrogsfrogs>
References: <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
 <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aPdu2DtLSNrI7gfp@bfoster>
 <aPd1aKVFImgXpULn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251021174406.GR6178@frogsfrogsfrogs>
 <aPiKYvb2C-VECybc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3b201807-439f-4dc9-af20-7e2cdad112f3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b201807-439f-4dc9-af20-7e2cdad112f3@oracle.com>

On Thu, Oct 23, 2025 at 04:44:36PM +0100, John Garry wrote:
> On 22/10/2025 08:40, Ojaswin Mujoo wrote:
> > > FWIW I see a somewhat different failure -- not data corruption, but
> > > pwrite returning failure:
> > > --- /run/fstests/bin/tests/generic/521.out      2025-07-15 14:45:15.100315255 -0700
> > > +++ /var/tmp/fstests/generic/521.out.bad        2025-10-21 10:33:39.032263811 -0700
> > > @@ -1,2 +1,668 @@
> > >   QA output created by 521
> > > +dowrite: write: Input/output error
> > Hmm that's strange. Can you try running the above command with
> > prep.fsxops that I've shared. You'll need to pull the fsx atomic write
> > changes in this patch for it to work. I've been running on non atomic
> > write device btw.
> 
> JFYI, I can see this issue with v6.18-rc2 and generic/760
> 
> I'll investigate...

I figured out why I'm seeing EIO from the ftrace output.  Apparently
xfs_atomic_write_cow_iomap_begin isn't detecting delalloc extents in the
cow fork and converting them to unwritten:

fsx-35984 [003]  1996.389571: xfs_file_direct_write: dev 8:0 ino 0x127 disize 0x88000 pos 0x20000 bytecount 0x10000
fsx-35984 [003]  1996.389572: iomap_dio_rw_begin:   dev 8:0 ino 0x127 size 0x88000 offset 0x20000 length 0x10000 done_before 0x0 flags ATOMIC|DIRECT dio_flags  aio 0
fsx-35984 [003]  1996.389583: iomap_iter:           dev 8:0 ino 0x127 pos 0x20000 length 0x10000 status 0 flags WRITE|DIRECT|ATOMIC (0x211) ops xfs_atomic_write_cow_iomap_ops caller __iomap_dio_rw+0x1cb
fsx-35984 [003]  1996.389583: xfs_iomap_atomic_write_cow: dev 8:0 ino 0x127 pos 0x20000 bytecount 0x10000
fsx-35984 [003]  1996.389584: xfs_iomap_found:      dev 8:0 ino 0x127 disize 0x88000 pos 0x20000 bytecount 0x10000 fork cow startoff 0x20 startblock 0xffffffffe0007 fsbcount 0x10
fsx-35984 [003]  1996.389584: iomap_iter_dstmap:    dev 8:0 ino 0x127 bdev 8:0 addr 0xffffffffffffffff offset 0x20000 length 0x10000 type DELALLOC (0x1) flags DIRTY|SHARED (0x6)
fsx-35984 [003]  1996.389595: console:              Direct I/O collision with buffered writes! File: /junk Comm: fsx
fsx-35984 [003]  1996.391183: iomap_iter:           dev 8:0 ino 0x127 pos 0x20000 length 0x10000 status -5 flags WRITE|DIRECT|ATOMIC (0x211) ops xfs_atomic_write_cow_iomap_ops caller __iomap_dio_rw+0x1cb
fsx-35984 [003]  1996.391184: iomap_dio_complete:   dev 8:0 ino 0x127 size 0x88000 offset 0x20000 flags ATOMIC|DIRECT aio 0 error -5 ret -5

I suspect this needs a xfs_bmapi_convert_delalloc call somewhere around
the end of that function.

--D

