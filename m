Return-Path: <linux-ext4+bounces-6762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F5A5B812
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 05:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80493B00F6
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 04:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC81EA7FC;
	Tue, 11 Mar 2025 04:49:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBC1E832E
	for <linux-ext4@vger.kernel.org>; Tue, 11 Mar 2025 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741668586; cv=none; b=hywSGSQxJTvOTtsYl8YtQqTBXrnj+M2WXPtBr+WxTKPI8u0G+KjQbL0wqOjlgfW++xY79pOgkP7+gXEKv1CvpDUiGQylobteSr9PQyWJeS1Wj+JP3XAc/DnOEy0Hdrg6m0cXubrLcAsN4wfQL+V/72FhsOtcKbjly7BRi84sBQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741668586; c=relaxed/simple;
	bh=eDMFEDfXMpdk5FoJ5a9RrjL/o3Ylg8uTSZQg+3TKPqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj4dbwumJweq+BAVFpwtBnvVKGtHaLalIjbGvZN0Lzx2g5xv/7Zc+AMU9HhvXITfE5o0AMTNHbCJp61NzibQFAZex4+PLPnxGfCtkt1/lGkeEfHGLJOeg/pfvF8YVmeId6n6x5126sMqfSjZcFP8ZT0ntepI1B4Cj7Hf+uzv3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52B4nZCp019327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 00:49:36 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 16DD62E010B; Tue, 11 Mar 2025 00:49:35 -0400 (EDT)
Date: Tue, 11 Mar 2025 00:49:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311044935.GD69932@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <20250310221243.0d5db7b3@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310221243.0d5db7b3@pumpkin>

On Mon, Mar 10, 2025 at 10:12:43PM +0000, David Laight wrote:
> 
> I'm sure that hadn't used to be the case.
> But as some point the 'ctime' changed from something that was usually
> the file create time (for some definition of create) to a pretty useless
> time that is almost a waste of disk space.

ctime was "inode change time" in BSD 4.2, released in 1983.  So it's
been "change time" and not "creation time" for at least 42 years.

It might have been "creation time" back in the V7 Unix days, but I'd
gently suggest that after over four decades, arguing that we get to
change the semantics of an inode timestamp because we think know
better.... is not really justification for breaking backwards
compatibility.


I'd also note that trying to add "creation time" has all sorts of
interesting questions.  The way all pretty much all text editors work
when you save some file, at least if they are compotently implemented,
is to *NOT* truncate the existing file, and then rewrite it with the
new contents, but rather, to write the contents to "foo.c.new", then
rename "foo.c" to "foo.c.old", and then rename "foo.c.new" to "foo.c".

So pretty much all text editors that exist in Unix today will result
in the "creation time" to be pretty much the same "last moification
time" (within a few milliseconds; however long it takes to write the
file).

So without changing pretty much all userspace tools which rewrite
files, adding a "creation time" to Linux would be pretty much useless.
For example, what should git do when you run "git checkout"?  Should
itfigure out which git commit a file was first tracked in git, and use
that time stamp for the file's "creation time".  That would take a
fairly large effort for git, especially if it needs to be performant
--- and is it *really* all that useful to know when a file was first
created in the git history and to make it available as a file system
timestamp?

This really goes to my question of exactly how useful the file
creation time concept really is.  Perhaps that's why the developers at
the UC Berkley made ctime be "inode change time", I suspect when they
authored the BSD Fast File System 42 years ago.  Personally, while I
don't find "change time" to be all that useful --- I find "creation
time" an order of magnitude *more* useless.  :-)

					- Ted

