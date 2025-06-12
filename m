Return-Path: <linux-ext4+bounces-8400-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61DAD7DBF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 23:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E931895417
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EEA2D542F;
	Thu, 12 Jun 2025 21:50:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B31AAE17
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765018; cv=none; b=nT2HkpDWnwgR6SVpsIhmBGwMsxmoJ1HexLA1b5PRQgVnGjqOvxg14S4R9oAIU22/3Dd3N2om3jRvXCfGVrGur81FUfMIIdPy68qhH3Z7ZNvOa8p+Na5GKr/+YA1zJd+NEvqqZFLPgJ/kJ8tT26iiM3y3McOQvAprjYYaxo6XOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765018; c=relaxed/simple;
	bh=2yFBbVBYK7V9aWE5QwogkzNypCnReo5hVOvB+oOq/uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvJ0rUyJZyKfOsTJmt1gpH3vzcPr32/70vWxLE2Z59qrZ0crc77+6llDP6UOPcQF9ghqXS06t0qq81lYO6cQZ9+lvq8ArR1+LHsDkKybgiNPpd0FMpL9JeCynXSxDUfgfxnv+Kn9PFntiSQSJ4JXsJZrVjmPMnAO1ZLqzqdHgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (customer.nwyynyx1.pop.starlinkisp.net [129.222.234.49] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55CLo3sP017133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 17:50:05 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 12EFF346B55; Thu, 12 Jun 2025 17:50:03 -0400 (EDT)
Date: Thu, 12 Jun 2025 19:20:03 -0230
From: "Theodore Ts'o" <tytso@mit.edu>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Discrepancy between mkfs.ext4 man page and code on
 lazy_journal_init default
Message-ID: <20250612215003.GR784455@mit.edu>
References: <CAHB1NahGodp3=NovantwmhM2=faVWuuusfRPUiUZaXZt58K7Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NahGodp3=NovantwmhM2=faVWuuusfRPUiUZaXZt58K7Qg@mail.gmail.com>

On Thu, Jun 12, 2025 at 08:54:59PM +0800, Julian Sun wrote:
> Hi,
> 
> Recently, I observed a significant difference in the number of
> blk_mq_get_tag() calls when executing mkfs.ext4 -F -q /dev/$nvme
> versus mkfs.ext4 -F -q -E lazy_itable_init=1,lazy_journal_init=1
> /dev/$nvme. The former has over 2,000 more calls than the latter,
> which is confusing because the mkfs.ext4 man page states both features
> should be enabled by default. This implies the commands should be
> equivalent, with no I/O difference.
> 
>        lazy_journal_init[= <0 to disable, 1 to enable>]
>              If  enabled, the journal inode will not be
> fully zeroed out by mke2fs.  This speeds up file system initialization
> noticeably, but carries some small risk if the system crashes before
> the journal has been overwritten entirely one time.  If the option
> value is omitted, it defaults to 1 to enable lazy journal inode
>                               ^^^^^^^^^^^
> zeroing.

I agree that this might be a bit misleading, but what was meant was
that:

	mke2fs -E lazy_journal_init

and

	mke2fs -E lazy_journal_init=1

are identical.  The key words here is "If the option value is
omitted".


Note that there is a distinct difference between the extended option
using -E command-line option and specifying the default in
mke2fs.conf.  That is documented in the mke2fs.conf(5) man page.

So the bottom line is that it is possible to change the default of
lazy_journal_init (and lazy_itable_init, etc.) in /etc/mke2fs.conf.
So specifying exactly what the default should be is tricky, because
the system administrator could have changed what is in
/etc/mke2fs.conf.

So there is the default if there is no mention of the option in
/etc/mke2fs.conf; the default that is used if the extended option -E
lazy_itable_init=N is not specified (which is the value in
/etc/mke2fs.conf, or the default if it is not mentioned in
/etc/mke2fs.conf); and then there is the default value if "=N" is not
specified.

'm not sure what's the best way of making this more explicit, short
of doubling or tripling the paragraphs in man pages for mke2fs(8) and
mke2fs.conf(5).  Which would not be ideal....  I'm happy to receive
any suggestions for how to make things a bit more clear but hopefully
in a succint way.

Fortunately, it's super rare that users would ever need to change the
default, and most of the time, it's best not to mess with these knobs
at all....

Cheers,

						- Ted

