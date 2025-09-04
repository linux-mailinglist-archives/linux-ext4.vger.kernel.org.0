Return-Path: <linux-ext4+bounces-9816-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE3B43BFC
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 14:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A8B3BDF16
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E832749CB;
	Thu,  4 Sep 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WYmCXvI3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F745464D
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989950; cv=none; b=c8UUHEVcPNjoGTpQ8ZO/qH3Ei3l0CXtbeanV+UHfzv8+7TVSh41dkD442inPcmewLZUYCmTFGxdt1yfq1g31S0nWUVDww56DOiM5Qq84WMSV5NImOipADPrMHa++Jom/VZXRPQ9XjyHLydchWemyPgQ42rKUnY8Z8vV3KbVq8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989950; c=relaxed/simple;
	bh=IizBvpQst483ETzUWS1Ne3Bx7hsq5UQ5RIrh4cYoH6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki5xzcOvm9ZoPk/JR1z+bdYGXhF8IVu7Ghn6Vburuwhp/80okok0KTDF/Ywc8vspEeSGjVzFCtCTvTnVrDDk5iS/ThTLlUNHKyQNPNTj0D8/XRVf5ZU+ViZ41ma2hoQveC7O6KmUUHLFC/kqR/NM2DnroDEWHSKB4YfACk7ShRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WYmCXvI3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-200.bstnma.fios.verizon.net [173.48.82.200])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 584CjaT1010597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 08:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756989938; bh=y5BvKcp8yJ+qDUiBR6PAcIeiCDo/QoOFnzeDxh9f61g=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WYmCXvI3dF3+9ANB6hKmb32SEJmZI8so1jBzq475cUj4imhmswvGOMN9fGZ2BajQe
	 NpR1cDP5l4F0b8tAvTL7+emgtQG1LJNiiy25NyHaxsobudH/5z47PJR2bLVN3CQOl/
	 Sc/Qdcjv1SvBpeiqQcfAjNmvenTIsepjl92C0JDDfe6oEhIkc7TGdWPWx0fDDcmVAa
	 LqWR8KsfV+PDhd2Ff0gNLpG31eb5kykfufPguUNh0sql6qR21DUDSe9KrwencnWvJX
	 x+nxos0QT5c3bvVG44SeU8ckKA0zfpq4Fn8UujOZjyyZKxKYPLjApYi+R1vmUYCmug
	 FwgGIms9bDI8g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DCAD02E00D6; Thu, 04 Sep 2025 08:45:35 -0400 (EDT)
Date: Thu, 4 Sep 2025 08:45:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] ext4: clear extent index structure after file
 delete
Message-ID: <20250904124535.GA3267668@mit.edu>
References: <20250903113027.261912-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903113027.261912-1-bretznic@gmail.com>

On Wed, Sep 03, 2025 at 04:30:27AM -0700, Nicolas Bretz wrote:
> The extent index structure in the top inode is not being cleared after a file
> is deleted, which leaves the path to the data blocks intact. This patch clears
> this extent index structure.
> 
> Extent structures are already being cleared, so this also makes the
> behavior consistent between extent and extent _index_ structures.

Actually, if we are going to make things consistent, we would be *not*
be clearing the extent leaf blocks if we are deleting the file ---
when possible.

Clearing the extent structures was never for security concerns.  The
reality is that removing the pointers to the data blocks is security
theater (e.g., like the TSA in US airports).  It makes people feel
good, but programs like photorec can be used to find the data blocks.
If they really want to securly delete a file, they should use shred or
wipe to overwrite the datablocks before deleting the file.

[1] https://www.cgsecurity.org/wiki/photoRec

The reason why we wipe the extent structures is because when
journalling is enabled, a file truncation or deletion might not fit in
a single journal transaction, and might need to span two transactions.
For that reason, we put the inode on the orphan list, and then if the
operation doesn't fit in a single transaction, we need to keep the
file system in a consistent state at each transaction boundary.  So
that's why we zero out the extent structures as we go; so if we need
to pause the truncation so we can do a journal commit, the data block
pointers to the blocks that have been released are properly zeroed.

Now, if we know that all of the blocks in an extent leaf block can be
released in the current transaction, we could omit zeroing the leaf
block --- so long as we can drop the pointer to the leaf block in the
parent index block.  This also has the benefit that if we don't need
to modify the extent leaf block, we save two 4k writes to the disk ---
one in the journal and one in the extent leaf block, which would
improve the performance of an "rm -rf" workload.

The reason why we haven't done this is that the benefits aren't that
big, and so we haven't gotten around toit.  But if you are interested
in looking into it, if we can keep the code complexity down and avoid
impacting the maintainability of the code base feel free to take a
look at it.

					- Ted

P.S.  A related project would be adding support for the "secure
deletion" flag (see the chattr man page), which is currently
unimplemented.  The tricky bit is (a) we can't zero the blocks until
the transaction releasing the blockshas been commited, and (b) we need
to avoid a race where a block being zero gets reallocated since we
don't want to zero out data belonging to a newly realocated data block
that has been associated with an in-use inode.  The marginal utility
is a bit small, since userspace tools like shred and wipe already
exist, which is why no one has actually implemented to date.  But if
you're looking for an fun/interesting project, it's a possibility.


