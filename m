Return-Path: <linux-ext4+bounces-2051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC318A23B7
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 04:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FEDB220A1
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Apr 2024 02:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE11DDAA;
	Fri, 12 Apr 2024 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="peEPYlCf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57D6AB8
	for <linux-ext4@vger.kernel.org>; Fri, 12 Apr 2024 02:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712888198; cv=none; b=cvtIHqBxzN00hEhUvL3/dZ8r2t7fX5ybZU55nBmkn3o7t1bDuE7kBh7+nGcDR82N7sWfWvxyJ21Kyqry3Oz6vRpDTGuteVi0krLHAAJXVxi+73E4mcN1lUDYZQ/geJ1T20Avl8uZTNE9BEifRfBv4V9R5Tl7XmDbocLPLYmtIcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712888198; c=relaxed/simple;
	bh=LdZvbIlw5MRsSAR+EZDfhnDss46ddfS0ppAR9+RcgGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfFTFYlGBEDI8YQLNx3CC5z+2bdyFZgyvalkZBGRCUKpc7RYLOiYbZ4TD9gnv/ggBEHwWtwujTAjUMGH+SrXGvlInHCcjJkqidS98wrqP6Iog8IwD0wtKAxDZmV9fU3CkgBFNArYvPd4Bs/df84MGah8YexORySHenWqFYnbyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=peEPYlCf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43C2GKwI031233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 22:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712888188; bh=ksG9y6pkzHtdIInkxHKyFhaaHLh7ng8phA0myE0db3M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=peEPYlCfc3adqXxI4tgJ2P3r5gNtGBRA8D8YgDfoQ10RyiokKDRivfKp0wjkpR4LC
	 z8aWocZNjfsQS8rxt4Z8RK40nD1+UHMjioBghLqqKX7oTPYhaQR0cJ7MkuPdUxTktU
	 u64/CWhe949ku9nYUgI6Z9Nbasa+Fqsq15z3nlqsPHFtMbhs9gTQ/yVZOslbTxeef5
	 vBn0qwnIgOpPYLq6x8NmB3dlApHbOu058nUIZfl7/DrAk2S0/o/agoRDOL++tW6/nN
	 EkQkFTmpWR7XDy2ivuCRkuv5cI6SjkHdESJouFt2ELw+a4+gjGfwxD8lyv+hUbcczK
	 RIC5vG+UNcL3Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8455615C00DE; Thu, 11 Apr 2024 22:16:20 -0400 (EDT)
Date: Thu, 11 Apr 2024 22:16:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] kvm-xfstests: Add 1k config for ext2
Message-ID: <20240412021620.GC187181@mit.edu>
References: <c5dea04b0e955402258835f2c880ceaf3b1f0ab5.1709721921.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5dea04b0e955402258835f2c880ceaf3b1f0ab5.1709721921.git.ritesh.list@gmail.com>

On Wed, Mar 06, 2024 at 04:29:05PM +0530, Ritesh Harjani (IBM) wrote:
> This adds 1k config option in test-appliance for ext2.
> This will come in handy for testing bs < ps path for ext2
> for e.g. it's useful in testing iomap bufferd-io work going 
> on for ext2.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks, applied.

					- Ted

