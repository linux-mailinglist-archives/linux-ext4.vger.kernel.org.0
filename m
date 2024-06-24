Return-Path: <linux-ext4+bounces-2933-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3591523C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D12A1F2404B
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 15:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A919D073;
	Mon, 24 Jun 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eom2YbTY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AECD19D069
	for <linux-ext4@vger.kernel.org>; Mon, 24 Jun 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242834; cv=none; b=DJo++wSd5IIOqRKZqQI5kggckz7ngINjEySKxvL312buu/AyB5iMEKhRIwCxSfBtAyj8tK/Y+Q7kE69zHhEUr4sA4vMOE6exMcosdC0UE4QbPKaDnY2rC/seBDP3wLI1a2+d61hw93Q8FfPrWgu09r6xPumAL/m/ZsrOgdSvR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242834; c=relaxed/simple;
	bh=aiGzNulTYl0LtlPBBXZTwmZd3N8hpOkdeUGhSQNwerU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnSwD7NAfKRCkFBzPwQ4r+mqdY6s69igjjZAXf4AFF/bB568xDJYNNRhOet9WXmoi1VG7aP8GD3vO0/jZR3fhLgkHM27s3SVI1HyFWHUIoWCx7Gb7bva+fQpO6iH4GxIwmlsI1zdpxNdME50eTr7xWZUz/WQjNcwfhAWZN+1tzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eom2YbTY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-193.bstnma.fios.verizon.net [108.26.156.193])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45OFQweR029175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719242819; bh=iKR+OzHKf8u/BfsACZ32+X6MX96Prwz7afTODz95XBA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=eom2YbTYusIC36znG7VxrMfpDcRL3iNiTIsG37+Ae+FcNCH5WwV1v3bSjvlwtyO+4
	 8G3U/pcJCo8LrWLkl8yiGcK44GSFWIk/ksBb15SLajtOvSyGeWPm4f3z4m9ZKzqNDd
	 vAOO//JbRqFLRPQfL1IysR7+n0thteOGBmPh+ZQ3trRrfDBSowAAuXA9CB7oqWgWmy
	 zgZ1aDYPafob049GK8vn5E06Uj8/wGwvGtk4SWv8vnD/4MhLCilUO3JNLpSGuzPByx
	 QiBHjNG38Eh2nmBcQgKpdoLbNkEkOSvF+PF1eOGnoAeZK+CBLosQMv/DtQz4wmTRA9
	 NCu0XxgLj6FVQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0496A15C00DC; Mon, 24 Jun 2024 11:26:58 -0400 (EDT)
Date: Mon, 24 Jun 2024 11:26:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexander Coffin <alex.coffin@maticrobots.com>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ext4 resize2fs on-line resizing panic
Message-ID: <20240624152658.GC280025@mit.edu>
References: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>

On Sun, Jun 23, 2024 at 06:57:13PM -0700, Alexander Coffin wrote:
> [1.] One line summary of the problem:
> Using resize2fs on-line resizing on a specific ext4 partition is
> causing an Oops.
> 
> 
> [6.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/admin-guide/bug-hunting.rst)
> 
> ```
> [  445.552287] ------------[ cut here ]------------
> [  445.552300] kernel BUG at fs/jbd2/journal.c:846!

Thanks for the bug report.  The BUG_ON is from the following assert in
jbd2_journal_next_log_block:

	J_ASSERT(journal->j_free > 1);

and it indicates that we ran out of space in the journal.  There are
mechanisms to make sure that this should never happen, and if the
journal is too small and the transaction couldn't be broken up, then
the operation (whether it is a resize or a file truncate or some other
operation) should have errored out, and not triggered a BUG.

We'll need to investigate further how to address this, but a
short-term workaround is to simply to make the journal size larger.
It looks like this is a very small file system, and so mke2fs will by
default use a smaller journal so that the overhead of the journal
doesn't overwhelm the usuable space for that small file system.  This
can result in a performance degredation, but that was considered an
acceptable tradeoff rather than users getting annoyed that there very
small file system had an unaccepted file system overhead of say, 75%
of the usable space.  Very often these small file systems was on
crapola devices such as USB thumb drives, where performance was going
to be a diaster anyway.  :-)

In practice, people have generally not tried to resize small file
systems like this, which is why we hadn't run into this situation
earlier.

Cheers,

					- Ted

