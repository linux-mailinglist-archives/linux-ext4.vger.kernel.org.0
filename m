Return-Path: <linux-ext4+bounces-9177-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F9BB10AB7
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812D518821CD
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587C2D4B5A;
	Thu, 24 Jul 2025 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZvOJr/Hw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFF2D0C9F
	for <linux-ext4@vger.kernel.org>; Thu, 24 Jul 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361613; cv=none; b=aLlrtjdstgulM+HA2drEodPgcsxmZ/cdx+VZWRsHmxKKv/kOZq1exz8Y796brVMcXBWVlDCgKmz8A09L/lmYSVh/s+AX55Nsaif+bxO1iZu+cKQdYOtD6L5jd9bv4SDV3JTT9M/CSShoRNNGawy3jSQD/WZuyZpLOLxLDxnsCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361613; c=relaxed/simple;
	bh=OaFsBnCGLhAUEu/4Gk8H5YIk7gsTABDxKZp6SKQnO+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJHcPsApUgjh82N/oCOE143llj8EEDrBZSglfNhEr7HblDHhJvub87Mhr+q7HhtvgUjuYsbN0PG96mNgeTlDOXTf+6MU6iQTnpuLWX9fn6btREa6o/XrgubMlBCCcxpErNMDh+rPEDMt0MB+PAX+4ZuDI68wblWqMy0uIpmCM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZvOJr/Hw; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56OCrPHN022023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 08:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753361606; bh=osJUOSGZcMTgUMTZmidAPA5aolYHPS6rMlNDBT6fJnM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZvOJr/HwPZjUQjQrd/QucIsL+HE1SyKzXQYtNVd4AK4TuqJ7MfWYzkCKZL0sqGh/Y
	 G9+PsSCJIHKfqCS2JtHYqgozhSnpSudjaHcbtD0huwC0pTjnfb5aycA/PZbuSDhTI9
	 /J/NcsaACV/RGdQXWxO1RNsAsfV4iSMWWsqV9kd06s7UOLjHZFrU1s/mSNyzUKRqLZ
	 yEPcWB12uDVURAXyisuDX8JXw75rKdH4wGDK247lJZCd+PkHR/tpOrPijkSae4JRn2
	 bgpAOkP2heGrNvn/eBPIQ0K/rbqsm6n9Oqqqw9/X2Dx5MioWGZAVJJrn2o4IFP2UJK
	 0gvkGu2tsB+QQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BFEB52E00D5; Thu, 24 Jul 2025 08:53:24 -0400 (EDT)
Date: Thu, 24 Jul 2025 08:53:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Sergio Abreu <dosergio@gmail.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: I have one idea to improve ext4 filesystem efficientcy
Message-ID: <20250724125324.GB80823@mit.edu>
References: <de1f4f53-49b5-4d0e-a20d-f797b72b29be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1f4f53-49b5-4d0e-a20d-f797b72b29be@gmail.com>

On Thu, Jul 24, 2025 at 08:56:49AM -0300, Sergio Abreu wrote:
> 
> I have studied it deeply and now I want to contribute with an idea that
> could be used for next versions from ext4 and ahead
> 
> It's a simple thing that is fully compatible with current Ext4 version and
> will improve space efficiency.
> 
> I don't really want to write code, just transfer my vision to an already
> envolved and competent programmer that is working on ext4 development.
> 
> Now I just wanted to share a tech insight that would improve ext4 efficiency
> even more.

Why don't you just send the idea to the list, instead of just sayting
that you would like to contribute an idea?  

I will note that in general, ideas are generally not the bottleneck.
The bottleneck is software engineering time / bandwidth.  Either it
needs to come with a volunteer who is passionate enough to pursue the
implementation effort, or it needs to align with some company's
business goals, and so will allow their software engineer to dedicate
their work time towards the project.  Because file system engineering
is so demanding, and reiability is critical, most few features tend to
fall into that second category.

This is especially true for space efficiency, because storage per
terabyte has never been cheaper.  For example, adding support for
compression is an obvious way of improving space efficiency.  However,
the estimated cost per gigabyte in mid-2025 is roughly a penny (US
Dollars) using hard drives.  The cost per gigabyte stored on NVMe
flash is about 8 cents USD.  When you factor into that the cost of a
software engineer, whether in Brazil, US, China, India, etc., it's
hard for a company to justify such an investment.  And this does't
take into account that there are other performance tradeoffs involved
in using compression.  As the saying goes, there's no such thing as a
free lunch.

Cheers,

					- Ted

