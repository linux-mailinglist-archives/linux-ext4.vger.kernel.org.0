Return-Path: <linux-ext4+bounces-13566-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGzLBzdHhWkN/QMAu9opvQ
	(envelope-from <linux-ext4+bounces-13566-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 02:43:19 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AEF8FF4
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 02:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD4F3017786
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DB123F422;
	Fri,  6 Feb 2026 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CSeOBOCN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D023ED5B
	for <linux-ext4@vger.kernel.org>; Fri,  6 Feb 2026 01:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342195; cv=none; b=DcEsp7pcVlhyzTcAf282RKHY/7i1/d75XlNYgQow2rsGDtPU4GKtSH09PB3t0ibuOPigtrOBV/vn7dfQiCxjXxro9Di1q3ddc0p+XzeT7NijgoxXrQCxqqbhgfmIOOH82gOU2MCnCiMrcynKcfHYzFlEF9+rTHsJyhzaWppaWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342195; c=relaxed/simple;
	bh=xwpOqzULNFaxUq8fMFm+Xlb5ctlbpZpshxhVbpcTpHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ6XnS5qvS7SQkBWguTahV8DtSaNknVw1YwX+pjdTFbA/thDnSPcvDL4g1wzIGmk1FbHDWBCoagthsIdjX/MUH84d17DrHl6a76f5ILJ+p11KQj3RA5LcF6bUaVy0A0tklPZ0VdK7Yk9wvkD8E474XPGq9cKM0ZuZDCFMH0BEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CSeOBOCN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-115-175.bstnma.fios.verizon.net [173.48.115.175])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6161gnkV008050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Feb 2026 20:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1770342171; bh=AvMWEpZg4iHn8Z0xWBGlU70PiNkutClixV8HTgR+xTE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CSeOBOCNzj+skziXWUMwTn3r+9G3e/C/PXZcJRteIbtOLoK2/ZKveVx9UzS1mSsUU
	 BW76NVOvASq/0yYpWB6lOhiWhR7/v+ptBXfTv/E9lJ2+iVHrNSgOQsJkNDGTMPC36X
	 SuBWWGdGW4f3XwtuKu9CDYi7i2JOg/gAi3G/pgUn1ymkpEYhfxQpKJFw74H8bPKFNo
	 FmGdSxoam1V6S9kqpTdLwqoBtCgIWdnKwWe/20Cq6K/4mAZCgyVATw5GcYcamzZk4q
	 aJ6Cr8wZ/uCb4wmXKdLrBHwdKhUB5mdeT3WLSsQZlY8je6ACq1wHNi2zCgPPBfMOqS
	 0ExqKBTKy4ahA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 521A157674A6; Thu,  5 Feb 2026 20:42:49 -0500 (EST)
Date: Thu, 5 Feb 2026 20:42:49 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
Message-ID: <20260206014249.GH31420@macsyma.lan>
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-13566-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[macsyma.lan:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 762AEF8FF4
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:23:18PM +0100, Mario Lohajner wrote:
> Let me briefly restate the intent, focusing on the fundamentals.
> 
> Rotalloc is not wear leveling (and is intentionally not named as such).
> It is a allocation policy whose goal is to reduce allocation hotspots by
> enforcing mount-wide sequential allocation. Wear leveling, if any,
> remains a device/firmware concern and is explicitly out of scope.
> While WL motivated part of this work,

Yes, but *why* are you trying to reduce allocation hotspots?  What
problem are you trying to solve?  And actually, you are making
allocation hotspots *worse* since with global cursor, by definition
there is a single, super-hotspot.  This will cause scalability issues
on a system with multiple CPU's trying to write in parallel.

> the main added value of this patch is allocator separation.
> The policy indirection (aka vectored allocator) allows allocation
> strategies that are orthogonal to the regular allocator to operate
> outside the hot path, preserving existing heuristics and improving
> maintainability.

Allocator separation is not necessarily that an unalloyed good thing.
By having duplicated code, it means that if we need to make a change
in infrastructure code, we might now need to make it in multiple code
paths.  It is also one more code path that we have to test and
maintain.  So there is a real cost from the perspctive of the upstream
maintenance perspective.

Also, because having a single global allocation point (your "cursor")
is going to absolutely *trash* performance, especially for high speed
NVMe devices connected to high count CPU's, it's not clear to me why
performance is necessary for rotalloc.

> The rotating allocator itself is a working prototype.
> It was written with minimal diff and clarity in mind to make the policy
> reviewable. Refinements and simplifications are expected and welcome.

OK, so this sounds like it's not ready for prime time....

> Regarding discard/trim: while discard prepares blocks for reuse and
> signals that a block is free, it does not implement wear leveling by
> itself. Rotalloc operates at a higher layer; by promoting sequentiality,
> it reduces block/group allocation hotspots regardless of underlying
> device behavior.
> Since it is not in line with the current allocator goals, it is
> implemented as an optional policy.

Again, what is the high level goal of rotalloc?  What specific
hardware and workload are you trying to optimize for?  If you want to
impose a maintaince overhead on upstream, you need to justify why the
mainteance overhead is worth it.  And so that means you need to be a
bit more explicit about what specific real-world solution you are
trying to solve....

						- Ted

