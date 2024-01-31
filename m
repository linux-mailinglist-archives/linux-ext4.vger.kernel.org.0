Return-Path: <linux-ext4+bounces-1038-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E18434E8
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jan 2024 05:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1331F22CC2
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jan 2024 04:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956163D0B3;
	Wed, 31 Jan 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="VaH2cke0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9ED3D0A8
	for <linux-ext4@vger.kernel.org>; Wed, 31 Jan 2024 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677123; cv=none; b=S3XfzbtoWo1CCwJidCA8vMUrJrvcROceoWrbp2ZuM0oZbYq4+XgqQp7yLeumavUTTs4u9CteWSzT7A0AmZhwnQqY+2SSi+WDsMeWwYbLibnEtijdwq/GaTkXFVAZJUiuitNOgmUm1c/vcRHp7EaMqTgScdM91z8meCgfhXIzsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677123; c=relaxed/simple;
	bh=AbCGXp5Zx/URHiZT1nmu8rSeqyC0cbZsrnC8I1K/zGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+CrSz0rD7bMW9e8ehm/gtz5ak7m76kVslZ3Q2Izg9P/wewN0oZhy7N+M5XKdo9lcbE0MQHkK/Jm3mP/OlLDmPfScBuR6qOuynKB29x2ARg7h2rAQJwWHYLY3AcsreBd2BcA1jNbH1lRK2cqVRLpi/97b8Y28ZSKu+c8oWvgo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=VaH2cke0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40V4wNUQ013006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 23:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706677105; bh=FTAZSbSldqW8oyYhGCCedIW1l15RMakCY0zmdX7B1ck=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=VaH2cke0joKHX/XvZt0Z5ZUj/GOXaCrsYxsSJfXkQJrjEA/OKrLrmZ5a5EwhmTSTT
	 m3ijT/kYcPLpkyYIKAKewne+xDC04C2RPct8X47C5F2jDkDOJwelPq2ljartmRfMdI
	 Bk9+9k8B5Mq80pO2pCxMFbKY7ehIu0Myi56ukpUHZZnmsICMXBdu9ZVPlsrX2D+fyF
	 cTYK66CeK/ENviTgAiyWKHanMY2pIXM3g/1d4sc2v8U9dhh7Dw3i0xgV4fmn/E2e74
	 DXD/FEI4Zii5cFtl0T4ihBXiMnZmh5odtKjGnpzACAkmla2viJx4laK2ZshYUCI1Yz
	 +iPKbzfyzQpEA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D94E715C0667; Tue, 30 Jan 2024 23:58:22 -0500 (EST)
Date: Tue, 30 Jan 2024 23:58:22 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <20240131045822.GA2356784@mit.edu>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbmILkfdGks57J4a@dread.disaster.area>

On Wed, Jan 31, 2024 at 10:37:18AM +1100, Dave Chinner wrote:
> It should be obvious what has happened now -
> current->journal_info is not null, so ext4 thinks it owns the
> structure attached there and panics when it finds that it isn't an
> ext4 journal handle being held there.
> 
> I don't think there are any clear rules as to how filesystems can
> and can't use current->journal_info. In general, a task can't jump
> from one filesystem to another inside a transaction context like
> this, so there's never been a serious concern about nested
> current->journal_info assignments like this in the past.
> 
> XFS is doing nothing wrong - we're allowed to define transaction
> contexts however we want and use current->journal_info in this way.
> However, we have to acknowledge that ext4 has also done nothing
> wrong by assuming current->journal_info should below to it if it is
> not null. Indeed, XFS does the same thing.

Nice analysis.  Fundamentally the current usage of
current->journal_info assumes that a process would only be calling
into one file system at a time.  But obviously that's not going to be
true in the case of one file system writing to memory which then
triggers a page fault.

As far as other potential avenues that could cause this kind of
nesting, the other one which comes to mind might be sendfile(2) --
although in general the reader side won't trigger a transaction since
the atime update tends to be done lazily.

> The question here is what to do about this? The obvious solution is
> to have save/restore semantics in the filesystem code that
> sets/clears current->journal_info, and then filesystems can also do
> the necessary "recursion into same filesystem" checks they need to
> ensure that they aren't nesting transactions in a way that can
> deadlock.
> 
> Maybe there are other options - should filesystems even be allowed to
> trigger page faults when they have set current->journal_info?

Hmm, could XFS pre-fault target memory buffer for the bulkstat output
before starting its transaction?  Alternatively, ext4 could do a save
of current->journal_info before starting to process the page fault,
and restore it when it is done.  Both of these seem a bit hacky, and
the question is indeed, are there other avenues that might cause the
transaction context nesting, such that a more general solution is
called for?

						- Ted

