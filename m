Return-Path: <linux-ext4+bounces-1424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CFC86C327
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 09:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0991F239D3
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 08:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D66481CE;
	Thu, 29 Feb 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RVC5HiSq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A046556
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194163; cv=none; b=Zks2jbsmMbBylmp6BflMhmMAgv7m3ZAMZ04ODLJeqkSxOWLRIjA96Kao1vrSvEg6SZxiSNAAvy98npGopaNw8XyIC0dcSpZBt/pJTbF6KlghhGzO3nNvGqSYHlkUiYXV30COTFOzYd2Pga1RMc0JnIF6vjaAw2F3/bncPOoPsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194163; c=relaxed/simple;
	bh=Nf2BX4WBdYo+WUvwb7etgTe/KIm3yi1SETywrZlcWrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRFBBRob3X95UXMLzNC/v9dzDwCyXbuu9vyivpyrFqDbrtPr8isQ9HHV3EAwQZRR884/JZZMThOfnbbNI57a67EKvbGh//QxpRUFiPKKmsI+FckJi1jPpD7QOkjy4RQ6dpgFwYbhHCwu3kYoz4njDSqbyjpxaknB4HZ70qch6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RVC5HiSq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41T899wV016987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 03:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709194151; bh=QqIRc0mPpcip4J3TaeIY6KvwuBzqghkm+QuNDcPFQow=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RVC5HiSqldEmd6bzJC3Mzc731NtThWMFxSMVM5ZlqDWWNmiF390siOFXswAy8vCrl
	 n1t0ZhY8Z5bd90gYGtj8v4UdCatevdG56E7GCHkxgqQHyqhmDB8OTGrjTandyE89aO
	 HOuifQD4saaP9Bdtpx/i12VhuIITVftxnNyUg+qDSVKbOI703Eu1r6BdzKGaAxOnrK
	 4cuMvMWlfw6islBTLlx9L6YQ3L/Nvia+p1WCj+oHAFCVFpvxHXMwgLr7SId26e803A
	 mPeIYuA7lf3Y22+bdNw52NE0oRUV3YZdKU5rg1D0Ey4kKn9b5cINFS7rwzN8GUoFtS
	 vV3eZ+++h7QsA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D3572340440; Thu, 29 Feb 2024 02:09:08 -0600 (CST)
Date: Thu, 29 Feb 2024 02:07:59 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] [RFC] Fix jbd2 to stop waking up sleeping disks on sync
Message-ID: <20240229080759.GB57093@macsyma.local>
References: <20240227212546.110340-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227212546.110340-1-phill@thesusis.net>

On Tue, Feb 27, 2024 at 04:25:46PM -0500, Phillip Susi wrote:
> I noticed that every time I sync ( which happens automatically when
> you suspend to ram ), ext4 issues a flush to the block device, even
> though there have been no writes to flush.  This appears to be because
> jbd2_trans_will_send_data_barrier() returns a 0 when no transaction
> has been started.  The intent appears to be that a transaction that
> has completed should return 0, and that when there is NO transaction,
> it should return a 1, but the tests were in the wrong order, leading
> to the 0 to be returned before checking for the absense of a
> transaction at all.  Reversing the order allows my disk to remain in
> runtime_pm when syncing.
> 
> I *think* this is correct, but I'm not very familliar with jbd2, so it
> may have unintended consequences.  What do you think?

Yeah, this change is going to problems.  The basic idea here is if
when we request that a transaction to commit, will it issue a a
commit?  If so, then fsync(2) doesn't need to issue a barrier (i.e., a
cache flush command).

So for example, if a database does an overwriting write to a file
block which is already allocated, and then follows it up with a
fdatasync(2), there won't be any need to make any metadata changes as
part of writing out the changed block.  Hence, we won't need to start
a new jbd2 transaction, and in that case, current transaction has
already commited, so the jbd2 layer won't need to do anything, and so
it won't have issued a commit.  In that case,
jbd2_trans_will_send_data_barrier() needs to return false, so that
fdatasync(2) will actually issue a cache flush command.

The patch you've proposed will cause fdatasync(2) to not issue a
barrier, which could lead to the write to the database file getting
lost after a power fail event, which would make the database
adminisrtator very sad.

Cheers,

					- Ted

