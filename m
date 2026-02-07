Return-Path: <linux-ext4+bounces-13618-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDI7C+l8h2nsYgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13618-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 18:56:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805BE106C4B
	for <lists+linux-ext4@lfdr.de>; Sat, 07 Feb 2026 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12CD3019900
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Feb 2026 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B12D6E63;
	Sat,  7 Feb 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="X5CgY323"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10F22F01
	for <linux-ext4@vger.kernel.org>; Sat,  7 Feb 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770487010; cv=none; b=I42eeziBdHmdRIgBeTl9Xpvgbjhb0lmcBv1dK1i0iLi9p7Nt2Ybp8OLowBZIlN0IDd8u6x+R1sGTRO48bo7BHTtBrqPGbzUfGkfP7/+S8nKsUxbVK07MTKhul2D+ViAcRVI36RErfDs2r/qxxiXBJtkEQOrNmHYKAymehC9WrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770487010; c=relaxed/simple;
	bh=uEdOxGW0bNnwZtbkdSrDMnFZanh7Kxxpj6aLEq4gtjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rl9NV5Lkwn+PlqEv3tE/Chw7yezO+96er3tMUDYBoPjjS1V5UTH+59ydCe2vjsHirRU8OP1e+o9syQ+jckc+izWvhuEpXBDin0aivBNz/YQWvaZjYjINVx54bhnW5tUnzzDJd7ecKdIYMo+bdO4O4QBoxQQO4h/LJ9QCkPC+P7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=X5CgY323; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-57.bstnma.fios.verizon.net [173.48.115.57])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 617HuNuQ015840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 7 Feb 2026 12:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770486985; bh=X1L3TFzL4YKQgtTuSHVXHd/ijZMZp5BAusHsnCljvLg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=X5CgY323qnlbkxCqxooe9CwFGLPqqH1Rpkj5NPrUChhauteSDzn0E64C8PQK1Xw/s
	 7fcbQ2E/58CLX+K0WyAbVnKNSfWTOiyAZkDmQZr789uT8HxeKt16LWKiLzgXgqKcwz
	 J3rFwvFh/gQ41D1i9bLYXQ0sO+D+JtaQdzyiajUwKZVMacNhxaUVUFVKmBuV+RZ+7G
	 SnCsmZ6ei98tyCJIgymAu9v8vt36pOiFLWbanAp4l77A2FlXBLOm9TkQXDxnCCrwLP
	 xvYndQ/SEUU6xvo19SqnqAFDIMj1PUN8WeZsJYCud74wzEluli2EiDdPuESr3UD4Ob
	 zbRe3Jq+jITpA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BDB9D57A20B4; Sat,  7 Feb 2026 12:55:22 -0500 (EST)
Date: Sat, 7 Feb 2026 12:55:22 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Message-ID: <20260207175522.GB87551@macsyma.lan>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
 <20260207053106.GA87551@macsyma.lan>
 <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13618-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[williams.edu:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 805BE106C4B
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 01:45:06PM +0100, Mario Lohajner wrote:
> The pattern I keep referring to as “observable in practice” is about
> repeated free -> reallocate cycles, allocator restart points, and reuse
> bias - i.e., which regions of the address space are revisited most
> frequently over time.

But you haven't proved that this *matters*.  You need to justify
**why** we should care about portions of the address space are
revisted more frequently.  Why is it worth code complexity and
mainteance overhead?

"Because" is not an sufficient answer.

> The question I’m raising is much narrower: whether allocator
> policy choices can unintentionally reinforce reuse patterns under
> certain workloads - and whether offering an *alternative policy* is
> reasonable (I dare to say; in some cases more optimal).

Optimal WHY?  You have yet to show anything other than wear leveling
why reusing portions of the LBA space is problematic, and why avoiding
said reuse might be worthwhile.

In fact, there is an argument to be made that an SSD-specific
allocation algorithm which aggressively tries to reuse recently
deleted blocks would result in better performance.  Why?  Because it
is an implicit discard --- overwriting the LBA tells the Flash
Translation Layer that the previous contents of the flash associated
with the LBA is no longer needed, without the overhead of sending an
explicit discard request.  Discards are expensive for the FTL, and so
when they have a lot of I/O pressure, some FTL implementations will
just ignore the discard request in favor of serving immediate I/O
requests, even if this results in more garbage collection overhead
later.

However, we've never done this because it wasn't clear the complexity
was worth it --- and whenever you make changes to the block allocation
algorithm, it's important to make sure performance and file
fragmentation works well across a large number of workloads and a wide
variety of different flash storage devices --- and both when the file
system is freshly formatted, but also after the equivalent of years of
file system aging (that is, after long-term use).  For more
information, see [1][2][3].

[1] https://www.cs.williams.edu/~jannen/teaching/s21/cs333/meetings/aging.html
[2] https://www.usenix.org/conference/hotstorage19/presentation/conway
[3] https://dl.acm.org/doi/10.1145/258612.258689

So an SSD-specific allocation policy which encourages and embraces
reuse of LBA's (and NOT avoiding reuse) has a lot more theoretical and
principled support.  But despite that, the questions of "is this
really worth the extra complexity", and "can we make sure that it
works well across a wide variety of workloads and with both new and
aged file systems" haven't been answered satisfactorily yet.

The way to answer these questions would require running benchmarks and
file system aging tools, such as those described in [3], while
creating prototype changes.  Hand-waving is enough for the creation of
prototypes and proof-of-concept patches.  But it's not enough for
something that we would merge into the upstream kernel.

Cheers,

							- Ted

