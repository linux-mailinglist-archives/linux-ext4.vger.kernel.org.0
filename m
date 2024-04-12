Return-Path: <linux-ext4+bounces-2052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E9C8A248B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 05:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531D9283FBB
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 03:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D017BCE;
	Fri, 12 Apr 2024 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dOfhEEQ9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7628FC
	for <linux-ext4@vger.kernel.org>; Fri, 12 Apr 2024 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894162; cv=none; b=VVvm0EbWK3la6cIBdSnOHDnv6p3d0ebXs+PqqaFtG+Yeg1GK2bPHgFHEzeoX1CqF5MsKQcyEjiqUYZLtSLSLFVv6b5xO6oUuhPrD4rHoju66c6t/mUwbIhanMQklF5NeqE/6zcmZJl5p6W9RIeyMmoP14cqW0I3dtpyKL0dKpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894162; c=relaxed/simple;
	bh=jgsySEBfBr2yKswNUwikz+FITKjJFHnZo959lH69wCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3iQGp93tQp+891wLiX0v2BFV1GQ0RDeufnTJknW3xmdyITCYIBHgNHhcyz0DY8531tws0XMkf8eBtJkR5NvxVOQueZyVlKkpG5bLsCi7bzMsDhjtd1KMLJ3wf74Sl47QGbZ3ovPqyTTk5P+LE6/v/DDQYXsvjvwP4wvasqcG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dOfhEEQ9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43C3taCf022568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 23:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712894139; bh=3y/worbB/UJgc5iThuhYF+NXbVCCGkZo3/cJ22BJobY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dOfhEEQ9qq2eBitbPxPjKxnkbJWSMYIq1Rs9v8s7FZrm/N+xrL/FeLtG4Xhco4aa+
	 9KjnG+3c+QEho2i8qjlsc0/V877gOB3E8JgjYiqA57Y2vbPvf49slCx5MILUZxHBmx
	 M/uyW4qTo6mLzYZ6Rbl+m/tuv6ctdgKrStE5y97R99R2NZ4FMnpyVdqs+OENXLL/Xs
	 2upBA/iKiGG6BwvhxfYFaA9uZbibTNfkoMhR55UJhrrzdpJGr5FIqVbuICSZAgZaXd
	 4K5o0QgrJuXwth+ijJ0iMDwdxYa/OUnBU04kgq6AtFtWJDfbwpyKwI4SCxTPujQcUW
	 5Gk1v01opiBUw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7761F15C00DE; Thu, 11 Apr 2024 23:55:36 -0400 (EDT)
Date: Thu, 11 Apr 2024 23:55:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240412035536.GD187181@mit.edu>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
 <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3>
 <6611F8D5.3030403@huawei.com>
 <20240411133718.tq74yorf6odpla4r@quack3>
 <20240411145559.GB187181@mit.edu>
 <66188E1B.6070209@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66188E1B.6070209@huawei.com>

On Fri, Apr 12, 2024 at 09:27:55AM +0800, yebin (H) wrote:
> I thought of a solution that when the commit block checksum is
> incorrect, retain the first 512 bytes of data, clear the subsequent
> data, and then calculate the checksum to see if it is correct. This
> solution can distinguish whether the commit is complete for
> components that can ensure the atomicity of 512 bytes or more. But
> for HDD, it may not be able to distinguish, but it should be
> alleviated to some extent.

Yeah, we discussed something similar at the weekly ext4 call; the idea
was to change the kernel to zero out the jbd2 block before we fill in
any jbd2 tags (including in the commit block) when writing the
journal.  Then in the journal replay path, if the checksum doesn't
match, we can try zeroing out everything beyond the size in the header
struct, and then retry the the checksum and see if it matches.

This also has the benefit of making sure that we aren't leaking stale
(uninitialized) kernel memory to disk, which could be considered a
security vulnerability in some cases --- although the likelihood that
something truly sensitive could be leaked is quite low; the attack
requires raw access to the storate device; and exposure similar to
what gets written to the swap device.  Still there are people who do
worry about such things.

						- Ted

