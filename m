Return-Path: <linux-ext4+bounces-6087-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C16A10802
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 14:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E7B1888E58
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2025 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FC1FA82C;
	Tue, 14 Jan 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q/kFJvnp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4923244B
	for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861919; cv=none; b=WoA1jPUqx1NikH9flKoe+b0NGqoJzsfX4u2ueDUqWB6hUPjvvh5S8COB5CZnhrZoW2d05k+oy+Xy1cbSr8q/1fP3gS+e0wfzKdJH1efBCtq9uMb2hFiAHf1XzTY0QPRxSGFXzwLVd6GfWCQ1Mg0gNLihgf6EI513+hsrdJnXZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861919; c=relaxed/simple;
	bh=G24kzgrgKTFebE0tbtdYbld6tVlXPldb1h2RYR9wXJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye8WwsH82ptu95AI8I0Iu1Hn9HhdGgLKZExOjN2UlebjFPejmm1S0yBSZ8zZ3a2xpZTDqUwtM5W2vi36rnygmGpEnG7qfHo8cxa8OUclzcCuNtv9tmnk6uoKDaCoDrPOkFNOW+bLW08y4Fuu7TVsn4+KiLuMGYygkpYrLinIgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q/kFJvnp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-113.bstnma.fios.verizon.net [108.26.156.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50EDcFd0024270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 08:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736861898; bh=xUWWjMzNxXbmXZgfFqAL2gYu/gtUd50YzuutRWwynCs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q/kFJvnpSrSqUCUz2VtOBQ/1WNKVObqZ9u3tqNoxCPIkr4UH1H6jKDZHc9GxLBJX2
	 eazA6Z2UayLHQR3G2hsuGks19r1n7HUaP23gQBHBJ8IsPHqRYdGHy3PCeDpSvgKHTv
	 31wn/pf6z8UFWsb1tmDJ6EcsZ4vtt4Fndjgdtb43UV5hTakc6uU7Lz1iKs5iUcm2xs
	 nLK316SVoRI9NQkAXTj8CiHkbJyCrMvIdwFlv3lSL//qnafHPRcwBf5ebTEqakt1t+
	 JOks0IhkK0RFW43yqDo1TJTQ2Usptngr3tpl+S0yiLlMhv1KF7+BQ8yxDESjGrys4b
	 OiZ5KDOZp6iNw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 545DA15C0175; Tue, 14 Jan 2025 08:38:15 -0500 (EST)
Date: Tue, 14 Jan 2025 08:38:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Liebes Wang <wanghaichi0403@gmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
Message-ID: <20250114133815.GA1997324@mit.edu>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>

On Tue, Jan 14, 2025 at 02:25:21PM +0800, Heming Zhao wrote:
> 
> The root cause appears to be that the jbd2 bypass recovery logic
> is incorrect.

Heming, thanks for taking a look.

I'm not convinced the root cause is what you've stated.  When
jbd2_journal_wipe() calls jbd2_mark_journal_empty(), s_start gets set
to zero:

	sb->s_start    = cpu_to_be32(0);

This then gets checked in jbd2_journal_recovery:

	if (!sb->s_start) {
		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
		journal->j_head = be32_to_cpu(sb->s_head);
		return 0;
	}

I suspect that there is something else wrong with jbd2's superblock,
since this normally works in the absence of malicious fs image
fuzzing, such that when jbd2_journal_load() calls reset_journal()
after jbd2_journal_recover() correctly bypasses recovery, the WARN_ON
gets triggered.

I'd suggest that you enable jbd2 debugging so we can see all of the
jbd2_debug() message to understand what might be going on.

By the way, given that this is only a WARN_ON, and it involves
malicious image fuzzing, this is probably a valid jbd2 bug, but it's
not actually a security bug.  Sure, someone silly enough to pick up a
maliciously corrupted USB thumb drive dropped in a parking lot and
insert it into their desktop, and the distribution is silly enoough to
allow automount, the worse that can happen is that the system to
reboot if the system is configured to panic on a WARNING.  So feel
free to prioritize your investigation appropriately.  :-)

Cheers,

						- Ted

