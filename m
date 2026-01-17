Return-Path: <linux-ext4+bounces-12950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34FD38BF6
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 04:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264043030928
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 03:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347202D1931;
	Sat, 17 Jan 2026 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LHVQuWT9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27129D273
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768621688; cv=none; b=MWqZalnR2KmqmUl3KluX9ZtlqjVKBK6BjXm2BBXACVEBcVMni34UMNVTuEN1jnnxx8ChP7sMb7yUeiqDyZJ3GjQSnJFy9vY60Tvtdxt0RyPWIzI3pWmnBka//2NJjxVtgdfTYYAhAH9pQ2KjB7PrfJukMc1T3VEDLeteTAIudrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768621688; c=relaxed/simple;
	bh=9i/c3MjuJIbjkJppkl2fDkaFi84meZQzoApT3vS4/fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkXjKoXspt7jQoPdM9/onGlygc3rlMkQotfN7wojtx9npZDYj/I3kBRtvFhii1eY+90YfrJZqvr40kSng/T8bAIP2A7qWb4Fv8NlmsexO9dq4RRcd90WLypOFFJbYZJxkW4iZdOMttapNQt7ZV6wQ62p6i5RClmIEBdwKVp8D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LHVQuWT9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([193.36.225.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60H3lmMD020028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 22:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768621675; bh=8GeFjy9eaYPSi3dvtDKSLLs1dZY4Vmhi4XIZX7FjOTw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LHVQuWT9CcYCMj8r/q4S0o5csnXHJLymG9r+wAYCuvxSN4jmc58jjKfHZann69bYJ
	 OHIob9/ndTn6RgjIaVfhBtZjPR4+WU2It5cmSgcv4QdByYcq3YCYruupb5/IOFjeWj
	 M+o3szmju3tjDxx94yh7yXuoMrV+wJb/+SOo7FXM5CnvQRahayiwU5AzouUcZ+7jwB
	 IasHOSB2Vacc/CDBQn8An9DKEb+lSiDzOAxZKIQoEHLTQk9kJ/VWGysgChRA2NbQRJ
	 Jidj8+lCG9o6R6mf3ta61HHDgMffp9hV3YKtpGQjdhz2DB/fxUKV58vsjfHcqJU0jB
	 JcN7FJm9ZsKSA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 69BFE5503F24; Fri, 16 Jan 2026 17:47:47 -1000 (HST)
Date: Fri, 16 Jan 2026 17:47:47 -1000
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] e4defrag inline data segfault fix
Message-ID: <20260117034747.GA19954@macsyma.local>
References: <4378305.GUtdWV9SEq@daniel-desktop3>
 <20260116172139.GB15522@frogsfrogsfrogs>
 <20260116234405.GG19200@macsyma.local>
 <20260117023559.GC15522@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117023559.GC15522@frogsfrogsfrogs>

On Fri, Jan 16, 2026 at 06:35:59PM -0800, Darrick J. Wong wrote:
> > -	/* Has no blocks */
> > -	if (buf->st_blocks == 0) {
> > +	/* Has 0 or 1 blocks, no point to defragment */
> > +	if (buf->st_blocks <= buf->st_blksize / 512) {
> 
> ...because can't you call FS_IOC_GETFLAGS and look for
> EXT4_INLINE_DATA_FL?

I could have checked for EXT4_INLINE_DATA_FL, but we need to call
stat(2) to check for the st_blocks == 0 case, and while it is harmless
to defrag a file with a single data block, it's also pointless and a
waste of system calls.  So it's best that we skip defragging the file
in these cases:

  A) A zero-length file with st_blocks == 0
  B) A file with a single data block (st_blocks == st_blksize / 512)
  C) A file with inline data (st_blocks == 1)

... and we can do that only by checking the values returned by
stat(2).

Yes, (B) and (C) relies on Linux's behavior, since Posix is silent on
the semantics of st_blocks, but e4defrag works only by using a
Linux-specific ioctl, and using FS_IOC_GETFLAGS would also be
Linux-only.

    	       	       	       		- Ted

