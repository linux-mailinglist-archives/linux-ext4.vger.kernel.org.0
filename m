Return-Path: <linux-ext4+bounces-8760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A8AF058C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 23:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F16716BEF9
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DD0266560;
	Tue,  1 Jul 2025 21:24:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B581C84C5
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405082; cv=none; b=hs3wr/R1Bbn3cla0VfMvFQQqN0GNXuBU3R06yj5iuo3DrxBWckwCbz5JguvHjg3s0ywt7VyWbMTy9Q4TRDUBzMwzAUg4bZw5a7l3li3MYvtbVTlrIY5ELs8c5WsgW4ZDjIQk2LEyotCUC+s5dDi/oRvlikLHFOS86ElXbmZJnEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405082; c=relaxed/simple;
	bh=dYTK5OAposMrwMJTrGnRMN9nlw5pDKEwSrvLOySNbQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N++TrzYp80wNvUidfhEgcQHM3fUnnj/RJULa68VoS2O5vCnbocm1ebf3rlWFH/AeKTQrOp/MEFcDah7wtD2diGBmo8/yNFb7L1vagg+Yg1TA3V7dhfDJS/B+gwZcTL3BGCA+nWUgdLVuumEX+81LsJzja8A154Pf28eXSJxJYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-121.bstnma.fios.verizon.net [108.26.156.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 561LOHm7009077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 17:24:19 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 85C1E2E00D5; Tue, 01 Jul 2025 17:24:17 -0400 (EDT)
Date: Tue, 1 Jul 2025 17:24:17 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
Message-ID: <20250701212417.GD495283@mit.edu>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
 <87y0t7rajm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0t7rajm.fsf@trenco.lwn.net>

On Tue, Jul 01, 2025 at 01:11:25PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > Hi Jon, hi Ted,
> >
> > While discussing on my previous ext4 docs reorganization attempt
> > by merging contents [1], Jon suggested that considering current docs
> > file structure, a proper toctree would be ideal [2]. So, here's
> > the patchset that does exactly that.
> >
> > Actual conversion to toctree structure is in [1/5], while the rest
> > is cleanups to make the resulting toctree nicer.
> >
> > This patchset is based on docs-next tree.
> 
> So to me this seems like an improvement.  I'm happy to take it, though
> would prefer an ack from ext4land if possible.

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

