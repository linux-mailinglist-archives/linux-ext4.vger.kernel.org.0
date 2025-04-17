Return-Path: <linux-ext4+bounces-7325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B889A92302
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2452319E6678
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07D2505C7;
	Thu, 17 Apr 2025 16:49:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FA1D61B9
	for <linux-ext4@vger.kernel.org>; Thu, 17 Apr 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908564; cv=none; b=uOValdq14zUnOiuw6xpmoSyUglRrFjL+TofcBkT/kJQvznWnBnjV2ceYoqREeOXWOfTmpoUBVHiD9afftWTjJzYRnHA9eWz0C4WJRemt7YHBIqAnYI5rzPQaFSQp7jzY5QAsBvC2q50MKs3cG7JZWNBJoA5GL8D5dW0ISPHvDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908564; c=relaxed/simple;
	bh=ez1n9wbJ+pTVSW+bHCJ1bM6eZEmIUzkT5k5LzHB+920=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwQbvAhxbpZiWq6Rq5YcXqp6wKgkAkBbbJz07VgapVzIlEV2j6hkU9NKZWtdAzztUYQP68A9E3TYzLSyeYyR2EVsg8GPnI2scMrvhjz5bJ0Sa0EIJoL/aYHSynZwy8rey2lD/q10VtUklzT9nUbeUdwmQvnHbE1YMg8/nyClQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53HGn8wx014622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 12:49:09 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 74CF1340A24; Thu, 17 Apr 2025 11:49:07 -0500 (CDT)
Date: Thu, 17 Apr 2025 11:49:07 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        kdevops@lists.linux.dev, dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250417164907.GA6008@mit.edu>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416233415.GA3779528@mit.edu>

On Wed, Apr 16, 2025 at 06:34:15PM -0500, Theodore Ts'o wrote:

> >  - Is this useful information?
> 
> Maybe; the question is why are your results so different from my results.

It looks like the problem is that your kernel config doesn't enable
CONFIG_QFMT_V2.  As a result, the quota feature is not supported in
the kernel under test.   From ext4/033.full file:

mount: /media/scratch: wrong fs type, bad option, bad superblock on /dev/loop5, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.
mount -o acl,user_xattr -o dioread_nolock,nodelalloc /dev/loop5 /media/scratch failed

And from the ext4/034.dmesg file:

[  297.969763] EXT4-fs (loop5): The kernel was not built with CONFIG_QUOTA and CONFIG_QFMT_V2

Cheers,

						- Ted

