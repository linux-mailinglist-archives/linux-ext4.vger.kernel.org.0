Return-Path: <linux-ext4+bounces-2021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2408A061E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 04:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6174BB213EC
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156913B28F;
	Thu, 11 Apr 2024 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="A8SD4sRL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA053E22
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803582; cv=none; b=tNP7JKHqCtuPUUMjGSmGhMkuwMP9G4LFanoTIRFjxITuVU3ooS8V3fc/O18wmmVm/tpM2X6HQjNyFJez8PR+17vk3L/rz3n8HDAkR6sbOHOM9d1seYlPkFbfOgLWj3uPny+4h+WyBMC7MCSd5e6SN6/sUTsd+WFfAo/L/tQ3Uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803582; c=relaxed/simple;
	bh=4+Q/C3utArZxcBHpUAXdASdnieGtJM3U035SNeNoRb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naSgtO0JALoDK7lRooE2SBp+LOPo0DQYE5mZO2XlC257Iuc8s4vmzN8W8AsnP5Z4MeUd9EAe5cK8Cdp0IegMEbATggIu0jfLW4Y1et7Z7CNotBzmWemO1rAgAyDGe4SdTIBoN5Jg1qPEX2kpFPesbf1EnZUGTlF7saFJh2IFLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=A8SD4sRL; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-60.bstnma.fios.verizon.net [173.48.113.60])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43B2k4wf005258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 22:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712803567; bh=zoXGVcPaXzEL7o6NI7ZmABoI+PnoXMtFy5z/+/B5ybI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=A8SD4sRLyv/OdKM/cp15dbNmzeITK3iR9zU3mi4YXLCdHtHwsaDYEDk67tQmuROT+
	 6+H5x2eADapWLTBJZnnZE2gr2i/1DZWDulJPyEji1DFzDg2Ad1sy3Q8A+fgYOx6j74
	 rCBom+N1Owl/dAjuqVEOUuFhV+EA5gPJa9/sGvJWohTSGUmxTBnn0Y6hE+dngaks28
	 vwcRgh6a8rOOvnhV7w86TIAL3aC9RDmxfjNyDGX3wumMYduYktg8u9A6ZL+OMzu9Ki
	 MV1I3QwoM4eYCQ2DGCTLwTIHpOuAh5goTm+6RQFTqNBlHP0y4JMKCP34UOEqehVnrr
	 rNADOPmhYDPWQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C1B1315C00DE; Wed, 10 Apr 2024 22:46:04 -0400 (EDT)
Date: Wed, 10 Apr 2024 22:46:04 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Bo Branten <bosse@accum.se>
Cc: linux-ext4@vger.kernel.org
Subject: Re: When is "casefold" enabled as default?
Message-ID: <20240411024604.GA187181@mit.edu>
References: <d53dd39-70f7-5422-5ddd-fdd96686e7fd@accum.se>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53dd39-70f7-5422-5ddd-fdd96686e7fd@accum.se>

On Thu, Apr 11, 2024 at 03:16:47AM +0200, Bo Branten wrote:
> 
> We have a compatibility problem with the ext4 feature "casefold" and now
> some users have reported that they have this feature enabled without asking
> so when formating the filesystem so I would like to as you if you know why
> this might happen? Does some distributions set it as default or is it some
> container system that has started using it?

I'm not aware of any distribution that has been enabling it; but there
are an awful lot of distributions out there.  I'd suggest that you ask
those users what distribution that they are using.

What compatibility problem are you seeing?

						- Ted

