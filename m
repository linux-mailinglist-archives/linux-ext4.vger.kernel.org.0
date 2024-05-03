Return-Path: <linux-ext4+bounces-2276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F65C8BA5E2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 06:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D61D1C21C62
	for <lists+linux-ext4@lfdr.de>; Fri,  3 May 2024 04:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CCF208D0;
	Fri,  3 May 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dm7AtSLp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2361C6BD
	for <linux-ext4@vger.kernel.org>; Fri,  3 May 2024 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708981; cv=none; b=Oo7Wei6/FkoCPvilYZLCH896pwB42KzEAubI0UX4ir3pOJW4WrLCn30PpaSiUtcT8iVPTmZ+HTVZ6E+bXittLYzucOOx7Ew6KxRVSj+2LxJqhHR+ZLAhd5+BdzdCdMthD9HoVmxpDuvlSAZO9SW5E5j/5j4Nn1tChOpUt0+L8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708981; c=relaxed/simple;
	bh=L5DtjBmIpFTp3rEu3Gp44IImrrcYPEobAIJbCe8WHD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHOPLqp8U4TMWzzxYmbaF21UvWX9j/5avOmLyoThscs+6Yz1cMWf0nXexh0i5PiZKv1uD0Z6e/4MaibOXW+8bD1NEG9HCxq+mDYdEs2lx+L0VjXGH1nh5BPZtTMO+Ji2Xzyc/qjxTcE4WWyQfA95EvPGsUKQwDcqnhqMdO/hjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dm7AtSLp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44342qUK020600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 00:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714708973; bh=tiMzt5+6GWz5RJ2vKwbqe3bhyNBkYDR5wgXScolmrW0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dm7AtSLpz1TrgI6uPod89OchPX97NB7rKXjC3tl4LOvFrYs8QS0AxPMBOqGzaIrr9
	 TV9c1JDRrCQFVHY3wlUFAd9/bpRtzAJfcK8aiXPZ/VWYakq4Vq63h3cUv4IEDBAGJR
	 T1fn83/z2XsfmvHiOR/FpZwRlXtc1oliR6GZyW3gVFFj0ziWB2izapxgoDQxtQPKm0
	 jU0cAy+iUquyotDF7UJCf9lh17lRWU1arV79BbzVwaH56Jw1MsF1+/UVuxzBWqzZ8d
	 mkSi48ApjMeYxgUiNRLFhpZmwa8NCKW4h2Bi6kmGkdW6A3csjFocmowCkzkFSBw7tk
	 v7ZG8sM8VWH9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4825015C02BB; Fri,  3 May 2024 00:02:52 -0400 (EDT)
Date: Fri, 3 May 2024 00:02:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "ext4: drop duplicate ea_inode handling in
 ext4_xattr_block_set()"
Message-ID: <20240503040252.GG1743554@mit.edu>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240321162657.27420-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321162657.27420-1-jack@suse.cz>

On Thu, Mar 21, 2024 at 05:26:49PM +0100, Jan Kara wrote:
> This reverts commit 7f48212678e91a057259b3e281701f7feb1ee397. We will
> need the special cleanup handling once we move allocation of EA inode
> outside of the buffer lock in the following patch.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted

