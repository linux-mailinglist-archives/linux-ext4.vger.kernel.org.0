Return-Path: <linux-ext4+bounces-2080-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9128A3FE3
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Apr 2024 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D4C1F21552
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Apr 2024 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF54012B93;
	Sun, 14 Apr 2024 02:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gm3P5WlG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7218E1D
	for <linux-ext4@vger.kernel.org>; Sun, 14 Apr 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713060343; cv=none; b=OF8a/q3EhB1wypN3KCQyYfX//v1hvXAkg8dVSqFL2Tl4XEof0mWArFy+4xhDAH4MhqhkgI12wegm7bnbO5NvxBDF7fg0Qjad8QCchMU5Dg2MW0pB+xM97mAZ9uzwZdt0cbvV9y3G/HUu2+7DAxaa3xzzLWnSTqwHYXzDq7WGaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713060343; c=relaxed/simple;
	bh=MGA7H4Ak7JA9w5IRIFq0xzZptOoFSfbXSg3Cr7bmVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPQJqjxZ60YXY1m0iGXKqDTGD8gXTsNdNXTjELewTRTXFex4osa1cFlipaxY7m+QC+nKeMTl7gsCfIwsDoKAycyEMJo3S1sz2wsx1okUcfuaWKiqqDgoXijR4wvGGEgPtRyMwcNQB2KFXEjVU5CxcQhIAn0MQ13yNVi2wwth228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gm3P5WlG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43E24vOI017915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 22:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713060302; bh=FXSMfOuJHvgzP8fvH4L0dhdvcbQaONOy8jw0JVIAXwY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gm3P5WlGyVoxRXP+9V0+YSIDP2kbuJVkylgPM0ppChEX+mShuq2ApJQwm4LJi6JiM
	 XAJeqmaIk2fkUcSKpL5sWI34RcX4YiBVnM2qqJzYkvx1p01d140S7MzfDGW7YQLv4u
	 b/xa4LsfcgXuHrl0IBj0V429c2XtwgobI2g5ZaW/RhJnQX/Xv9HtIJPA+ufw+oCj61
	 +DWfJqm/U35Fiq3YmCB0hMqHTg4BhpKBzLGjUVLkAG8c3iX1XTNM7TTSSfs1NqvRlN
	 QtwqUZmHuek5X6bCtWIveyFW45QyozNCugTcV7FKP8v9Z5Sw93aWz3tm0ooVa1xX5U
	 z8YFtBqJbxLAw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8F3FD15C0CB5; Sat, 13 Apr 2024 22:04:57 -0400 (EDT)
Date: Sat, 13 Apr 2024 22:04:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Nam Cao <namcao@linutronix.de>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240414020457.GI187181@mit.edu>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>

On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
> This looks like a straight-forward mathematical substitution of "dlimit"
> with "search_buf + buf_size" and rearranging of the terms to make the
> while loop offset "zero based" rather than "address based" and would
> avoid overflow if "search_buf" was within one 4kB block of overflow:
> 
>    dlimit = search_buf + buf_size = 0xfffff000 + 0x1000 = 0x00000000

Umm... maybe, but does riscv32 actually have a memory map where a
kernel page would actually have an address in high memory like that?
That seems.... unusual.

If we have a reliable reproduction, can someone actually printk the
address or test to see if this theory is correct?

	   	       	       - Ted

