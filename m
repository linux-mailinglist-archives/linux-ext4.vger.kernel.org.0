Return-Path: <linux-ext4+bounces-9168-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C7B0F683
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF718842DB
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAD2F430B;
	Wed, 23 Jul 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9rY3M5H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9262F6F9D;
	Wed, 23 Jul 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282605; cv=none; b=DV/eTIK4BYd+Zf9RbliyxKDWjg7KYREKb+MzLRWMEqudnelsG6OfUQvXa/9GZQaGDCDnZKTSmV0Q/ZoC7ZU+DbpMt+U698bXja2qHAe+juXhpimqJBYA3+CTA/mozdiy8Un/QQ6sYE3m4IBwqewJlC7WcoOUlEDlJM4+pTLxG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282605; c=relaxed/simple;
	bh=RCGWcT8sG+CixnkMWkTnAWoF9wzChICSk12UfBIsilA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4bvoQBvll7LI02wMwpZJ8JuvXRTlxQhlFSgqLdsCMfn9A4cYkln5B2RnPHYcTkGDqRxe0JeLSzMu2dr3cOStGkVFE80DUN2G3Ih8pAr2+t8O/Ui01PC2AcLtaLBT68r3w/MXHoHNtZL4WrBwMLngzG68tMDsTE4niqrrK29UVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9rY3M5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FA5C4CEFA;
	Wed, 23 Jul 2025 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282604;
	bh=RCGWcT8sG+CixnkMWkTnAWoF9wzChICSk12UfBIsilA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9rY3M5H05rUTbZaTuSMHgNFjtEiXBCWkW2yXssy7aHeaZ1T9z6bNj4xe3MHCw8dW
	 bEYtUYQSlcqsXzFg88uAfg5aTY7X3ZW1tlagHwJ00a+swMJHjQEadW/AvKnO4AV5Sr
	 KZqlhu370CyGfpUYrctgZrURRa4YUs3YYuMQWGPucY8sjQ2vsvzmZwIUlEJAZGh7uG
	 6Ptoi+eztsLu0Ca6rsROWdGgaiUewZj44VvqL9t/V+tiOZ4TaVCbXUvCz1J5DruLV0
	 q4FHutlRICT14gUdgAt49zu6bLodmHQr8fZx6Gva/bgjvHVqid9ySmV9UEFZmlbi9+
	 /hA4h64HCsuww==
Date: Wed, 23 Jul 2025 07:56:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 08/13] generic/1229: Stress fsx with atomic writes
 enabled
Message-ID: <20250723145643.GO2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e1e7d552e91fab58037b7b35ffbf8b2e7070be5.1752329098.git.ojaswin@linux.ibm.com>
 <20250717162230.GH2672039@frogsfrogsfrogs>
 <aICBYrgdwZUcm2C7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aICBYrgdwZUcm2C7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Wed, Jul 23, 2025 at 12:00:48PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jul 17, 2025 at 09:22:30AM -0700, Darrick J. Wong wrote:
> > On Sat, Jul 12, 2025 at 07:42:50PM +0530, Ojaswin Mujoo wrote:
> > > Stress file with atomic writes to ensure we excercise codepaths
> > > where we are mixing different FS operations with atomic writes
> > > 
> > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > Hrm, doesn't generic/521 test this already if the fs happens to support
> > atomic writes?
> > 
> > --D
> 
> Hi Darrick,
> 
> Yes but I wanted one with _require_scratch_write_atomic and writes going
> to SCRATCH fs to explicitly test atomic writes as that can get missed in
> g/521. 
> 
> Would you instead prefer to have those changes in g/521?

Oh, I see.  You're setting the opsize to awu_max so that you're
guaranteed to get maximally sized atomic writes, which might not happen
with regular g521.

Ok I'm convinced,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Regards,
> Ojaswin
> 

