Return-Path: <linux-ext4+bounces-8635-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35259AE8301
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 14:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3013C173199
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CED25FA2D;
	Wed, 25 Jun 2025 12:45:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEB2609E1
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855512; cv=none; b=OdC7+a07L0qfyMToEQhZz0izKoK4BJq/Alr06bogtONvd4LuIbOkXTtQT1o++Tgdm/y2PQrFPRbcO69BoPkWS6xNGhIBSyZIjSx/GnbopNCPbrIYj4+YyXTvapV03N7d2e6+rEucgCTT/oRrqL/gpw2EL42JdWg6KMhplEXq/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855512; c=relaxed/simple;
	bh=U6MI2PdJBFWRH5pUrWIaLIFI8PrLyw/SMKOxte+tblQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1cggoPNKcWKys/jO71K4gL3i5ti0NvXpoXGer6zYuoNmj11lx0a1o5VUqCsVeiII6LapooFHjwmZeXQ5Vx41yyWPcdcbXOjSVkZDGONiTgr5TNrc+m/QKoXqKr551CcHTJVE2CyDEPVPAwO65gNFibXlzMygJlheNaLd3GAajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55PCijuO005260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:44:46 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 067412E00D5; Wed, 25 Jun 2025 08:44:45 -0400 (EDT)
Date: Wed, 25 Jun 2025 08:44:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Simon Richter <Simon.Richter@hogyros.de>, linux-fscrypt@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] fscrypt: don't use hardware offload Crypto API drivers
Message-ID: <20250625124445.GC28249@mit.edu>
References: <20250611205859.80819-1-ebiggers@kernel.org>
 <7f63be76-289b-4a99-b802-afd72e0512b8@hogyros.de>
 <20250612005914.GA546455@google.com>
 <20250612062521.GA1838@sol>
 <20250625063252.GD8962@sol>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625063252.GD8962@sol>

On Tue, Jun 24, 2025 at 11:32:52PM -0700, Eric Biggers wrote:
> 
> That was the synchronous throughput.  However, submitting multiple requests
> asynchronously (which again, fscrypt doesn't actually do) barely helps.
> Apparently the STM32 crypto engine has only one hardware queue.
> 
> I already strongly suspected that these non-inline crypto engines
> aren't worth using.  But I didn't realize they are quite this bad.
> Even with AES on a Cortex-A7 CPU that lacks AES instructions, the
> CPU is much faster!

I wonder if the primary design goal of the STM32 crypto engine is that
it might reduce power consumption --- after all, one of the primary
benchmarketing metrics that vendors care about is "hours of You Tube
watch time" --- and decryptoing a video stream doesn't require high
performance.

Given that the typical benchmarketing number which handset vendors
tend to care about is SQLite transactions per second, maybe they
wouldn't be all that eager to use the crypto engine.  :-)

    	     	      	      	     	      - Ted

