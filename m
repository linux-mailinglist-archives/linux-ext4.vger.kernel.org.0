Return-Path: <linux-ext4+bounces-6756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83855A59A23
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A91718910C5
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Mar 2025 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078C22DFAE;
	Mon, 10 Mar 2025 15:37:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889471C68B6
	for <linux-ext4@vger.kernel.org>; Mon, 10 Mar 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621075; cv=none; b=eZRxC3kSSDRcUpVJmbz3CTZSexJATq3spr5gix8vWb3vX8AGgdv3eFJ+wvsiF+oJbJltDftcNdAZ9eJAt+hrZDGKoxsIY7Quv7f8898/UQ9nU1oUCNF3NEIAQw0uvszCJ2ZJ4mVMMuE4Sv3D0t2pvmutpnozj9DItaCOM2DKBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621075; c=relaxed/simple;
	bh=OQQn5b6TgE+Vkztwfk+wMzQZVPlzWI8LM20KRhtjSJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIhp+QU6XwWLkcu08+DvhSFydh5hZghay5tH/ILjcW9fdMY9fotN9VPvqZYp2a+a47BgVF6VIbpyhMSantvTw8pFTpEznmFC/ScSLi/0pulOQV61quRovoZgTzHF0u3Bbo4cWZ9gtvaKAj27HPGo2qsV5KB35EQoainHhqYLDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52AFbjVv023312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 11:37:45 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EB66E2E010B; Mon, 10 Mar 2025 11:37:44 -0400 (EDT)
Date: Mon, 10 Mar 2025 11:37:44 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250310153744.GD8837@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <69d8b100-f65d-470f-a957-2819795e82a4@gmx.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d8b100-f65d-470f-a957-2819795e82a4@gmx.com>

On Mon, Mar 10, 2025 at 02:11:13PM +0000, Artem S. Tashkinov wrote:
> 
> I'm not going to argue with your reasoning but being able to set btime
> could be beneficial for backup and restore purposes/utilities.

I think the fundmental question is should we change the current
defined semantics of btime, versus adding some new "crtime" field for
those people who care about Windows compatibility.

Granted, it's only been relatively recently that userspace could even
*access* btime for a file in the a mounted file system via the
statx(2) system call.  So there might not be that many users of btime
today, so changing the semantics might not break userspace (much).

Again, the choices are:

* Change semantics of "birth time" for everyone as of some new kernel version

* Make the semantics of "birth time" be subject to chagge via a mount option

* Add the ability to optionally store a new "creation time" which as
  Windows semantics in addition to btime.  This could either be via an
  xattr, or by adding a new on-disk inode field for some file systems
  that care about Windows compatibility.

> Secondly, I really like having separate modification and creation times
> for all my files.

Personally, I don't find it all that useful, since "creation time" is
really (with apologies to Lewis Carroll):

   “When I use a timestamp,’ Humpty Dumpty said in rather a scornful tone, ‘it
    means just what I choose it to mean — neither more nor less.’

    ’The question is,’ said Alice, ‘whether you can make timestamps mean so
    many different things.’

    ’The question is,’ said Humpty Dumpty, ‘which is to be master — that’s all.”

.... combined with the fact that most file systems don't support
creation time today.

Hence I find it more useful to find some other way to do version
stamping --- and something more reliable, like a SHA1 hash like git
uses.  Or as a nother example, using an external database, such as a
rpm or dpkg installed package database, with a crypto hash to verify
whether the file has actually changed, no matter what the package
manager thinks.

But that's just my personal opinion.  I am sure that other people
might find "creation time" to be useful.

> Finally, as for POSIX not offering this feature - doesn't Linux already
> have a lot of syscalls that are not found in POSIX?

What I was trying to point out that there is precedent in POSIX not
allowing certain timestamps to be changed, because that would violate
the semantics of ctime --- and the same would apply for btime's
current semantics.

Can we forcibly change btime's semantics?  Perhaps.  But let's do so
consciously, and not blindly follow Windows' way of doing things.

Cheers,

	     	     	     	    	     	 - Ted

