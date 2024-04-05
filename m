Return-Path: <linux-ext4+bounces-1881-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE089940D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 06:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3831D28B2D5
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D961C68F;
	Fri,  5 Apr 2024 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aOJAXNTH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C320B04
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 04:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712290822; cv=none; b=oq94ZVmnxuMB6FPtQVAyIIve9xrimlrh7prF5llRSQ3c6gBhbGg+mfIOE8ox2NmXXv2TXrp93uRR+ZSDVjlztX8ZpF/BoDFgJ1lPdDNGmJzfoo8WZ6vAgLbKmqsH+oPhkIT+WstEHNkLKCoJb2l93BuCc1NYE8QRwsxZ+hR7eWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712290822; c=relaxed/simple;
	bh=pjWL2Sl0ZlPZPQb/pt6HLy4t4cYrAtTPUobP8y7xqog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY6qp33b+ZPXUSbzwMBpjUACEuQXbf24rKDKUqgPeKMor967S9jkUQnnVEs1QkZXdHw4GwSgzashucjvwxhRG64WX27pG/ew/YqCcQlzXp9E33UHkXGSr4wSvtlM1xoLvZNIbGMfvScwG7BQLT9CcE2TQnvcSIEGDOVXl1ysw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aOJAXNTH; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4354KE7W008371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 00:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712290815; bh=hF06hqLddGVvV0QAL2R3xAPVV1zZViSUo/gjM2KqIJw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=aOJAXNTHspi7flK8pgL1mOp1NrxLpAOFZpON5VXT78YwSnO31zy67+FhC0q4kzbVu
	 mPyqf4I1papwwucXDVNoDfiAvNErLu46eiGPj2ZcGofo8sRArV1FVywFWLQH+waep0
	 X+W9jhjvGR01toTjMmvobJLEucP6nlOMeMDFTBVxmqtXTuChkyl34VX/BHtA0Du0e/
	 CWQt901Ww2Pa/JWAfwhZVoFtugzTyv9KTZ0ludTAYt3gCII2xV4fveyk+CGWRzXwgW
	 KiZ2QBBkM6CRW64YNcf+/DFXyap2s2ui6PXb28DDoRbXuIbvUNUCJPAQdu0NQ3gNt+
	 /UXI+zaHHJQ6Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 343A115C00DE; Fri,  5 Apr 2024 00:20:14 -0400 (EDT)
Date: Fri, 5 Apr 2024 00:20:14 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hanasaki Jiji <hanasaki@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: ext4 e2fsck error interpretation and howto fix? expecting
 249045418 actual extent phys 249045427 log 1 len 2
Message-ID: <20240405042014.GD13376@mit.edu>
References: <CAMr-kF3yY6zYi2ZBXG7g77zaG2qzA9B294cqL=B7HOtkXYhOeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-kF3yY6zYi2ZBXG7g77zaG2qzA9B294cqL=B7HOtkXYhOeA@mail.gmail.com>

On Thu, Apr 04, 2024 at 06:23:44PM -0400, Hanasaki Jiji wrote:
> Hello all,
> 
> I have an ext4 filesystem with e2fsck reporting many of the below
> lines.  Neither e2fsck nor fsck fix the issue.
> Repeated runs result in the same errors.
> 
> kernel version = linux-image-6.1.0-18-amd64 / Debian Bookworm
> 
> Your help understanding the output and help fixing are very much appreciated.
> 
> Thank you,
> 
> ==== e2fsck output ====
> 62264184(d): expecting 249045418 actual extent phys 249045427 log 1 len 2
> 62264185(d): expecting 249045419 actual extent phys 249045429 log 1 len 2
> 62266954(d): expecting 249045453 actual extent phys 249045486 log 1 len 3

These aren't problems.  You enabled a debugging feature, via "-E
fragcheck".  Quoting from the man page:

       fragcheck
              During  pass 1, print a detailed report of any discontiguous
	      blocks for files in the file system.


This is intended for use by developers who are trying to assess
various different block allocation algorithms' fragmentation
resistance.

The (d) means directory, and due to how files tend to get added to
directories, directories are almost certainly going to be
discontiguous, and with hashed tree indexes, this isn't a performance
issue.  So arguably fragcheck should really skip printing messages
about directories.  That being said, given pretty much any workload,
and utilization approaching 100%, a certain amount of file
fragmentation is inevitable, so using fragcheck to assess the
fragmentation resistance of a particular change in a block allocation
algorithm can only be done using a fixed workload to avoid comparing
apples versus oranges.

In any case, unless you are an ext4 developer actively doing block
allocation work, you really shouldn't be using -E fragcheck.

Cheers,

					- Ted

