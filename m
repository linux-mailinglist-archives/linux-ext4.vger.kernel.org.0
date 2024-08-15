Return-Path: <linux-ext4+bounces-3735-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FB953625
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4301C25355
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811371A00D2;
	Thu, 15 Aug 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnJX3Sip"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD41AC8B7;
	Thu, 15 Aug 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733347; cv=none; b=MJf16NacrOky+u4Bwu0P8ujsfAOxFJIBWuIk56tFu+MxiTIGlqRNYDYLIG5TlQHVJ/NlJFo3W9s4x+2/RwSvhJJZ/URZKv4l3t4MBE7dJBQzak2CZRxvgaMz6aYC5xU0a/7+4PgaX6BzMweLfI99EBEUqzV3utThQQWG+EVf8ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733347; c=relaxed/simple;
	bh=gWjvEPZtVEHi2sjoPgdRvTu2/HU8I/YPBbUL9JEYxOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggB9etz+GiHVi2cyi7nPtsr8fQLPdIKxEKslT2yVQXMjjwxjUBosVBw3e5mYWfkQ6N+Z1YUFYKpHbWaoxqgBuGz6ZpKfAqO+ZuHL6GnRLbNEXDFEbaD7F5dWLToXXCqe2XaOy2jA4xCQj0X/xUE0DQqHY7hhVCV71XHws2gAFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnJX3Sip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63912C32786;
	Thu, 15 Aug 2024 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733346;
	bh=gWjvEPZtVEHi2sjoPgdRvTu2/HU8I/YPBbUL9JEYxOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnJX3SipLxuFP4RGSlWnOfzpGk0ZiV+sXJNsAO4IQiEsxqLCTJaIFcBBwU25V3Abp
	 rVdNQ0jpiiDUc5/0A2ddWn7fI0fSQDZwLo1imj2PiVc2oKO6FW5cA1xTBR0g7kjxjE
	 DvDuYWCqdSH4lY8H57N6IMgUG7/ZzhvUZZznYUhLD1tR9UwSB9iU+Xj7P0G0UnTaAx
	 lUnUgqk80/G/iZ+ya473ddW7dligv7qTQJtGNB7qf7gGKa9hkBwRz/GrLp11aVLrm1
	 cy9r7o4fZvM2jUABT5teF02W5vzyC3G6A9A/RLwwJSpL0tUwd7mEzb4/wPRXGAqwR3
	 k53ia75xMFb0Q==
Date: Thu, 15 Aug 2024 07:49:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
Message-ID: <20240815144905.GA6039@frogsfrogsfrogs>
References: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
 <fec59d4d-898d-447c-b4fb-e9d055550f96@web.de>
 <5d75ab7f-0fad-07ef-bbcb-3fed16a5170e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d75ab7f-0fad-07ef-bbcb-3fed16a5170e@huaweicloud.com>

On Thu, Aug 15, 2024 at 09:17:10PM +0800, Kemeng Shi wrote:
> 
> 
> on 8/15/2024 5:55 PM, Markus Elfring wrote:
> >> Release inode_bitmap_bh from ext4_read_inode_bitmap in
> >> ext4_mark_inode_used to avoid buffer_head leak.
> >> By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
> >> is NULL.
> > 
> > 1. I suggest to split such changes into separate update steps.
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.11-rc3#n81
> It's acceptable to me, but I'm not sure if it worth separate patches
> to others. I will do separate in next version if no person is against
> this.

No, that suggestion is stupid.  There's no reason to generate even more
patches for a three line fix, it's very obvious that you're fixing a
missing resource release and rearranging the first error out
accordingly.

--D

> > 2. How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> > 
> > 3. Would you like to append parentheses to any function names?
> Thanks for remind me of these. I will improve the series in next
> version.
> 
> Thanks,
> Kemeng
> > 
> > Regards,
> > Markus
> > 
> 
> 

