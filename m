Return-Path: <linux-ext4+bounces-8368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5054EAD5CD3
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 19:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE09C3A70DA
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531920C463;
	Wed, 11 Jun 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mbDVAX+V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E81A317A;
	Wed, 11 Jun 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661520; cv=none; b=iJ2sKwKzCPK3zVI+uv+MX5XIvuujGbHf4FwxMnkS65P8fXnbVuGrFzGGySgtW9wZHIXJrLgyzJjSV+fKfBwbOqPvtjWkXXLGFfsCL+AmE6XzPZyo2ybEQFTZPTCS9K0MnI7rmrsem7YKZf3nApZPuOmH7yuKyQ8Ex0PJqcNCz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661520; c=relaxed/simple;
	bh=wE17FUWoXTtsVVyfUweavOVY7qJotag8pGhX4VoqGAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A3YgMz3AXRNikL0LEmCGXSc86ty1wMLkoZw1uhoo06KAK5gBezmwlvRrvuL+7YPaypHb4qs4Ge5SHQ3bIF5nXaCK2+ujjyBuZUclLC1nAcKcpnSulZ6I6N46/UDElEn/9y8r8Qi7S2WcH7dFg7GKYy6/j4wYl8kFepgR8r2+a/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mbDVAX+V; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 026F941ECE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749661518; bh=+VWSQ4ODTAC6Kk4O/+fTY+FOsVbZtqm+QbfgKKPfzmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mbDVAX+V3HgxcvBRNIwMTEiudyZD2XhYKkRzl4Zb0feO5gDYLrwd4nbmifxH2Cxyx
	 OASYX578aLc6TRsEQHci8ctwHo1ErIrloLBzzTbE30uVtcoPrFaTsovFs+RFvMUpGA
	 zcrhDkA589fuXR55SGMC62Fb9huohqfhmc8NLhu2Ctol6+wJ8wCec3kNBzicRjWa5S
	 lKOdW4lzQTzf5YfjV7MmUgII/5RbSiWeY13kA2fryrdyIc7wp3GigEOCsNujhYa9J6
	 qcPdQuq4sl6Wah0/qi1LdJc+H3mPMSmwTBlOkN3iC3a6mJsp4bCno1Eox9vyGl17/Q
	 Smc9Pl+MBn6Fw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 026F941ECE;
	Wed, 11 Jun 2025 17:05:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Darrick J. Wong" <djwong@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux ext4
 <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
In-Reply-To: <20250611164800.GC6134@frogsfrogsfrogs>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs>
Date: Wed, 11 Jun 2025 11:05:17 -0600
Message-ID: <87ikl21a5u.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Jun 10, 2025 at 04:11:59PM +0700, Bagas Sanjaya wrote:
>> Sphinx reports htmldocs warnings on ext4 atomic block writes docs:
>> 
>> Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in Documentation/filesystems/ext4/atomic_writes.rst
>> Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in Documentation/filesystems/ext4/atomic_writes.rst
>> 
>> These warnings reference duplicated cross-reference labels to themselves in
>> the same doc, which are because atomic_writes.rst is transcluded in
>> overview.rst via include:: directive, thus the culprit docs get processed
>> twice.
>
> <confused> How is that possible?  atomic_writes.rst is only "include::"d
> once in overview.rst.  Is the file implicitly included through some
> other means?

Sphinx wants to snarf up every .rst file it sees, regardless of whether
it is explicitly made part of the document tree.  So it will pick up
atomic_writes.rst separately from the include.

This could be "fixed" by removing the .rst extension from the included
file.  But, since there is no use of the atomic_writes label to begin
with, it's better to just take it out.  The other fix, removing a cross
reference, is not entirely ideal, but there is little text between the
label and the reference.

jon

