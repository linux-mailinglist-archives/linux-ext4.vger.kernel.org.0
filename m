Return-Path: <linux-ext4+bounces-14647-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O7+bG/buqGkwzAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14647-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 03:48:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6620A4EC
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 03:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1A6A3022444
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 02:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EF225788;
	Thu,  5 Mar 2026 02:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Y8O/TdxX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE420ED
	for <linux-ext4@vger.kernel.org>; Thu,  5 Mar 2026 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678893; cv=none; b=iGWKq6gkZQJvT1V2k+LO/jdwiSxXNHUBcdxKflrjUoaCIvavBHs2RzSxebjtUQ043fDXhyuUV/4/rL1CeAuhnvF2czNWbRw2rrbSs/yWtoN1f+HT1zufuOoa+l8trLz0Owcm4ftcpSJK0+E42CJ7WpNBeHOwVcQYFZ0dhyPJmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678893; c=relaxed/simple;
	bh=QmasTkVXWRunJx2spfadq6ddDSa18yF+5K1YlbU9KlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6KIeb0NiZoby8SiwCB49n3huPuRZx12alDC6e/dnAAPd+A8HjJ5Aotil7FyUEGrXgEdKeEevfkV33aQmQ3Yplred16nOnKM/N1p4mtdNAYD0KuhsMDMfJJvEg2gi323Zcig+RvXpZvhClC+jMlTaoPoyRQcsM91788Pmgfauhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Y8O/TdxX; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.148.192.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6252lZSC015160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Mar 2026 21:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772678858; bh=0RlI02kvYjGT3WiYSDErGrwZiWjHXV+9b0LZ4y8xZMA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Y8O/TdxXC1TX63spC4UrtOnG8/MhO7KYPOtxjDoTOEkS6oZr0QgMpz0AaqnjZfHXT
	 KgQeQmv4gcDzO4VX/GsFIpGfBd7odmCMv3bbireA0HnNIkLAt2McVie5GAmi/AfvKx
	 XDU3LjBhiPYqzYvszCV0P3r5MlzKsCgO8RBbG4XFTgPOw7dW3EoCMj9EbD1hjKWtwo
	 jt8CvTmwDs0Gs732oQZxKT+n7ZuuHoCTim7jB6ETyT0NekEggow2r8cAHzartfIm0U
	 Sl+6WEx2z4C+npxud1bMIrdVz/WvgoqsMtp3zqcWgpy8G48BvO2Em8ijQMEPjcJpWI
	 2pwx2zGaXNVdA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id DA2FF5B9B709; Wed,  4 Mar 2026 21:47:34 -0500 (EST)
Date: Wed, 4 Mar 2026 21:47:34 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Mario Lohajner <mario_lohajner@rocketmail.com>
Cc: Andreas Dilger <adilger@dilger.ca>, libaokun1@huawei.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangerkun@huawei.com,
        libaokun9@gmail.com
Subject: Re: [PATCH] ext4: rralloc - (former rotalloc) improved round-robin
 allocation policy
Message-ID: <20260305024734.GC8243@macsyma-wired.lan>
References: <20260225201520.220071-1-mario_lohajner@rocketmail.com>
 <D135BB30-388D-4B4F-9E09-211F6DA74FCA@dilger.ca>
 <20260226024819.GA39209@macsyma-wired.lan>
 <04dfeda0-8c13-4233-b631-d8912d4fe6f0@rocketmail.com>
 <20260227011200.GA68551@macsyma-wired.lan>
 <2af6328d-5a72-476d-9768-9398a9417ea6@rocketmail.com>
 <20260227164319.GB93969@macsyma-wired.lan>
 <c156caec-e2c8-4b85-a135-0adecb56a859@rocketmail.com>
 <20260303013309.GB6520@macsyma-wired.lan>
 <cba02030-752e-43e1-9f65-8b726c4d42fb@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba02030-752e-43e1-9f65-8b726c4d42fb@rocketmail.com>
X-Rspamd-Queue-Id: 5FC6620A4EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,huawei.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14647-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rocketmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:28:47PM +0100, Mario Lohajner wrote:
> RRALLOC targets sustained parallel overwrite-heavy workloads such as
> scratch disks, rendering outputs, database storage and VM image storage.
> ....
> It is not intended to improve write-once/read-many workloads and remains
> disabled by default.

First of all, databases and VM images are use cases which are almost
the definition of write-once / read-many workloads.

As far as your first two examples, I've been part of teams that have
built storage systems for scratch disks and rendering outputs at an
extremely large scale, at *extremely* large scale.  (A public estimate
from 2013[1], for which I make no comments about how accurate it was
back then, but it's fair to say that there have been at least a few more
data centers built since then; also, disks and SSD have gotten
somewhat more efficient from storage density since them.  :-)

[1] https://what-if.xkcd.com/63/

Having built and supported systems for these first two use cases, I
can quite confidentially tell you that the problem that you are
trying to solve for weren't even *close* to real world issues that we
had to overcome.

Now, it may be that you are doing some very different (or perhaps very
dumb; I can't say given how few details you've given).  But what
you've described is so vague and scatter-shot that it could have come
from the output of a very Large Language Model given a very sloppily
written prompt.  (In other words, what is commonlly called "AI Slop".)

If you want to be convincing, you'll need to give a lot more specific
detail about the nature of the workloads.  How many Petabytes (or
whatever the appropriate unit in your case) per hour of data is being
written?  What kind of storage devices are you using?  How many are
you using?  Attached to how many servers?  How many files are being
written in parallel?  At what throughput rate?

When you use stock ext4 for this workload, what are you seeing?  What
sort of benchmarking did you use to convince yourself that the
bottleneck is indeed block allocation algorithm.  What kind of
percentage increase did your replacement algorithm have for this
specific workload.

If you want to see examples of well-written papers of various
performance improvements, I will refer you to papers from Usenix's
File System and Storage Technologies conference[2] for examples of how
to write a convincing paper when you're not free to share *all* of the
details of the workload, or the specific storage devices that you are
using.  The problem is right now, you've shared nothing about your
specific workload.

[2] https://www.usenix.org/conferences/byname/146

Cheers,

						- Ted

