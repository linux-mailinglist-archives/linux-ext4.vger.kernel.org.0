Return-Path: <linux-ext4+bounces-4829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC1A9B23C3
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 05:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771321F216E3
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Oct 2024 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2965189BA2;
	Mon, 28 Oct 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bCVZQE7Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5DA47
	for <linux-ext4@vger.kernel.org>; Mon, 28 Oct 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730088000; cv=none; b=XxGlJU7LotyWDN0oTOnt3FWMbE3A0Z8SVjoDDlFRDuFaQNyfPu4xIQGhZaMCbcbs1/T8NaZPzrrsUY4zfoyswIEfUu3yFO6v/YeyvXl3pObJLDmhBo4CwXJnLKUkXceWp1tiGTedffeJsQQDXdK3t1vjiUfUfaMy6hYXvNxEMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730088000; c=relaxed/simple;
	bh=WPE0VEX30Ec+ynGBgQfu7MGIIVtZd9QzNuytFslHEAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipA8B991bdFhKCGIYX+ME9Z6VI52/y85fy5d6/68bdoZhnrs/LS4Es6HYE4WrXcoieHGOd6rKz4OG52uUEQx5Q88jaNLmqa5zDfiV6BQ9mWe+ErOjxdruIRNG2kaNRRVBRg+UsDyasyuIetjeYPfsqw8QldDLvILMtnvaXHI23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bCVZQE7Z; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49S3xNFC022816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 23:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730087965; bh=6cC20PV8MpH2FJQ3aj7bu+cI/YUu81WJiMpqJU8Rl3s=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bCVZQE7ZoaGgeTa8Tt829kJDzngUj/AcaD1W1ARMBl3X9eRE03SQTZ/JEJVsXQLpX
	 3ueHSVxYJQIHCMc6Ri69/naNnCx7nqr0itnZegbbWoLXobrf+PCQEChQBk6etxGG6z
	 O/DW+2pRSJQTH1InoinaXHlcK5uFKZiWuOFohFRB3E5H5sQs6xFchjxb2Mu3M3s0fR
	 yRZclqIH9gLqJyXkKnkT0PsyYV+1vAgyR85Bj2vFXtGuxLeTVnNvCeHAK/iRvl9tL+
	 sWvcmzK3J170BxdYWfUOF/zqTZJagMUPbVDuV3YstFl/dVJX0NR5RRv05PpYRAYgV7
	 x3hesjHvnp/Uw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EAFFE340C2E; Sun, 27 Oct 2024 22:59:22 -0500 (CDT)
Date: Sun, 27 Oct 2024 20:59:22 -0700
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
Message-ID: <20241028035922.GC3842351@mit.edu>
References: <20241023135949.3745142-1-tytso@mit.edu>
 <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>
 <20241025154213.GD3307207@mit.edu>
 <6bb74ccc-25e2-45c1-8a88-cfd093a194c7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb74ccc-25e2-45c1-8a88-cfd093a194c7@huawei.com>

On Mon, Oct 28, 2024 at 09:47:46AM +0800, Zhang Yi wrote:
> 
> IIRC, at the moment, fixed metadata does not appear in the middle of
> the block group.

The mke2fs from e2fsprogs will not create a file system like that
normally, no.  *However* it is possible for fixed metadata to be in
the middle of the block group:

   * If resize2fs does an off-line file system growth without a resize inode
     or the reserved blocks in the resize inode has been exhausted
   * If e2fsck needs to reallocate some fixed metadata blocks as part of
     repairing a (very badly) corrupted file system.
   * If there are blocks reported to mke2fs when the file system is created
   * If a non-standard mkfs.ext4 is used by some other operating system which
     reimplemented mke2fs for some reason (for example, because they wanted
     to avoid using GPL'ed code).

So while these cases are quite uncommon, they *can* happen in the
wild, and we want GETFSMAP to be able to handle these file systems
correctly.

Cheers,

					- Ted

