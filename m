Return-Path: <linux-ext4+bounces-4777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA809B08A4
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 17:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9391C213D3
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E02158219;
	Fri, 25 Oct 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TZWbkSZJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEB870837
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870952; cv=none; b=stlrfUmxUT2rG67BTFqJCDNYfBB9OzgULoLg9HuCF2od1OtPjfoP5OLYNF8LDvXhemY/5ImbGI4ViYse4/aToJ3RLDkP3uSQ943+R5HgquXSHUK0SG1ays1/vJZBsFdVZdaZe+LLQuVlAIoS4/DfdexceP4QrsWB1UThNW1HZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870952; c=relaxed/simple;
	bh=+sCssaHINs+ysoEc2ooYjhvlNKnq3puozmRb9ffzhDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXlYOQYbk5imUvvGvA2RxYkfWYIRYuLvT2Nmf5BqaY09px9O3K/vB0E9PlzeQcgLKSSdC8B6lpZT3NH1+GwF649YkX0N8Y4dXsMvsMznwyQ0raUnPV0d/T8d06BFZCtBl1s7sK2mIyT/CCo8dR4w00xUNGM8YEAVHkD5DFiqo/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TZWbkSZJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49PFgDR5007509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 11:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729870935; bh=xt8IO7DsdC3djmxqTbTl7vgzOuWKGbG2thSqfNRpIX4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TZWbkSZJNmJ49DAR2KJvfmE/YB+RVkaXI64UK34BDvciOx4gfGaZkE3sZaa+wi8sr
	 QGXtNWW4P93KTUG1zyAnQzgTILLmZ6RSwwd+iaLBNmHWX+1ofvIE41Fku5TOfjvqw3
	 k6kWsEnO+vAf6NdPAOryBeR9haTjkEluwJKsnd1r9cbFW7qociEmWb5StqRBOZzomi
	 /nVWC2dwOPMz17cC2fPMPzGGs9m1T33vIJviC37YXAkOMSbhHJ2iN3bB0bs40vuwQ3
	 t4TPRoTDfBRfvdHz6c538Ssc/pMkYbcjiP/Mz6pt4J64b0QqXqnPpMaWH/n5B/sFAv
	 2UdjVAbIf9SZA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A5BD515C0329; Fri, 25 Oct 2024 11:42:13 -0400 (EDT)
Date: Fri, 25 Oct 2024 11:42:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
Message-ID: <20241025154213.GD3307207@mit.edu>
References: <20241023135949.3745142-1-tytso@mit.edu>
 <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>

On Fri, Oct 25, 2024 at 03:06:07PM +0800, Zhang Yi wrote:
> 
> Now it seems to be able to handle all the necessary metadata in the
> query range here, can we remove the processing of info->gfi_meta_list
> in ext4_getfsmap_datadev_helper() as well?

Not without further code refactoring; we still need it if there are
metadata blocks in the middle of the block group.  My main emphasis
was keeping the code changes as simple so it would be easy to
backport, and so I didn't do further optimizations.

As a related observation, I'm not entirely sure the current set of
abstractions, where we pass exactly one set of helper/callback
functions down through multiple functions is the best match for ext4.
It should be possible to significantly simplify the call stack by
reworking the GETFSMAP support.

On the other hand, the current, more complicated design might be
useful if at some point in the future, we were to add support for
reverse mapping for online fsck and/or if we add reflink support.
(See how Darrick implemented GETFSMAP for xfs.)

     	 	 	     	      	  - Ted

