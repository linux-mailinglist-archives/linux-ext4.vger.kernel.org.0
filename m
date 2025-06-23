Return-Path: <linux-ext4+bounces-8610-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3F0AE4688
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF48B18872C4
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Jun 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360EF255F53;
	Mon, 23 Jun 2025 14:19:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BE23AE7C
	for <linux-ext4@vger.kernel.org>; Mon, 23 Jun 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688355; cv=none; b=Fez3ckqFhecCU2tnCCoi4KyhMcQ4IzRBnEAMR+F69mJdRl04V0hk/LM/YDl5hjFlZZ19jIgnO9o7BuMYaGVdBQJgWR/wuySg/ii6tguYmgAzJa6F+OnmUUh6dA1ZMXjm1Xt66LsHnXzADpA8FdTaTi1hTpVgSmXCtOEAign9pYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688355; c=relaxed/simple;
	bh=9gk6HbiV5Z2t2EqbQqZC/85wphjwP8QBXXr+eIuNZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owAsnRdS7g/sa0VPr75ErVhh+g6nQa6NdH78hcQ4qH8vwRC46D72cZtybtT3O5SzQ3r+ndUCGVI0stj5Wdg2hwS2haam2h+onB1DfV3dzxprn8CM+UbSdJHz8pOHxjA4EYLMHVIvZKijXpYYpNzQDF8RByHXV/cyxqYyl4LPJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55NEHrEi003746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 10:17:53 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 150182E00D5; Mon, 23 Jun 2025 10:17:53 -0400 (EDT)
Date: Mon, 23 Jun 2025 10:17:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huaweicloud.com>, Baokun Li <libaokun1@huawei.com>
Subject: Re: LBS support for EXT4
Message-ID: <20250623141753.GA33354@mit.edu>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>

If you want to review and test the ext4/iomap changes, that would be
great.  Be aware, though, that there are some features of ext4
(example: data journalling, fscrypt, fsverity, etc.) that the current
iomap buffered I/O code may not support today.  The alternatives are
to keep the existing ext4 code paths for those file system features,
or to try to add that functionality into iomap.  There are of course
tradeoffs to both alternatives; one might result in more code that we
have to maintain; the other might require a lot more work.

It _might_ be less effort to add LBS support to native ext4 code.  I
think the main thing is to make sure that we always we use a large
folio and not fall back to a sub-blocksize set of pages.  So again,
it's all about tradeoffs and what you consider to be the highest
priority.

For myself, my primary concern is to keep the code maintainable and to
not result in any test regressions.  If your goal is to get more file
systems to use iomap for buffered I/O, that might be different than
those who are aiming to get performance or improved hardware support
ASAP as your higher priority.  I will say that in the ideal world, we
would eventually migrate to use the iomap code for buffered I/O for at
least the most common case.  But if we end up having an intermediate
way station where we have large folio support for LBS before we get to
that desired end state, I'm open to that, so long as the code stays
maintainable and bug-free(tm).   :-)

Cheers,

						- Ted

