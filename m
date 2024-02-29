Return-Path: <linux-ext4+bounces-1435-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99E86CC3A
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 15:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FE1C21B43
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED6C13776C;
	Thu, 29 Feb 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BNhdhJi8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F31353F8
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218747; cv=none; b=nyhoqFAYSXBcTBLXUyTckKubSrlVOzwsLBr/d7Y9OWwLuKSXHIJh31BqAebLiIGbDjX/nkZtFXUn9Roty81axGlmhu2KBaVr8bgOJaRitl2tuZfR4WZvojUNUo3gvBh/x6xCTEzNSKmjMwr+OgGU0KWNb2XEGoBU8gH2ps7ecBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218747; c=relaxed/simple;
	bh=fUhGmymEnNMd8TSoZFvGxM6z7oeCwJ0VUkP/UcsNPbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyhZSsV0f7ACuTaQiAvBkt2A6qJYMXJr2uj1H80QSdhBgJz4qCcnzZsdcoiQP3sryiERnMxgAzyLC4bMhVXdkvzeoqkYYTCtbz1N2ArQnhtV8zPibb/6lHWAdkgaVLCpDVgzMMZCQfGNOYEjM+ZGQaKylZ994n919NN7cUUJJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BNhdhJi8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41TEwwVU015346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709218740; bh=3i9paN40gIhtoETY9uKVsJa9keq/SuW3nEoIh2ZpCgs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BNhdhJi8m3NQo85ACLu0h2RAycfLRj0/5wMxaXm52yvgHYlQgntv6EtYp4cY4A4JL
	 PUoIEBow5yE6vsG5lVtVOxhKsrq3jolmhT9moPMy7/8RYi4w+Yrb7Hfr/vtJ7U2Lbl
	 +jU8+n6SF6dt4CjbCEV2OkHX62LALsgXcw3Uk8zgvfXfgIyV2B0L44TU2nh2q27p8S
	 3YhRQxwA0/yqlI76o/e6byYQVX9nObweb2Q34gopwRbbxsxmETaDOmbJ0EBNr9BDB5
	 AtaHNDiWBHDxcpNc3VzYiUJe1Tlrpz/fSW4mJ/+5O5ASqgHN5AmgBIBGBLb3EY8gPj
	 /K9qfcGwN/dVQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 314AA3403F5; Thu, 29 Feb 2024 08:58:58 -0600 (CST)
Date: Thu, 29 Feb 2024 08:58:58 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] [RFC] Fix jbd2 to stop waking up sleeping disks on sync
Message-ID: <20240229145858.GE272762@mit.edu>
References: <20240227212546.110340-1-phill@thesusis.net>
 <20240229080759.GB57093@macsyma.local>
 <87edcv1h94.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edcv1h94.fsf@vps.thesusis.net>

On Thu, Feb 29, 2024 at 09:23:35AM -0500, Phillip Susi wrote:
> 
> So because no metadata changed, jbd2 will not issue a barrier to end the
> transaction?  How can we fix this then?  Is there some way that jbd2 can
> know whether file data has been written, and thus, issue the barrier to
> close the transaction?

Because no metadata changed, jbd2 will not even *start* a (jbd2)
transaction as a result of that write (overwrite) to an already
allocated data block..  Since it didn't start a jbd2 transaction for
this file system operation, there's no reason to force a jbd2
transaction to close.

(Note: this could because there *is* no currently existing open
transaction, or there might be a currently open transaction, but it's
not relevent to the activity associated with the file descriptor being
fsync'ed.)

This is a critical performance optimization, because for many database
workloads, which are overwriting existing blocks and using
fdatasync(2), there is no reason to force a jbd2 transaction commit
for every single fdatasync(2) issued by the database.  However, we
still need to send a cache flush operation so that the data block is
safely persistend onto stable storage.

Cheers,

						- Ted


