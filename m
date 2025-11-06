Return-Path: <linux-ext4+bounces-11519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A856AC39A73
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 09:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98CF04F574B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B3308F35;
	Thu,  6 Nov 2025 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RsN0jivS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XocpdLt/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7D3093B2;
	Thu,  6 Nov 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419043; cv=none; b=Qx7rmhOHDaMCSR1xhEebS200iBfe/nd4EyCt2a7wewhdRjS5eBp7KLZBqx09QNnMd/FsExyDNGhpPOxhrC92NLZRPOIm2YAXYn5xxfRQxhHCtev4JlklIiUjW/QZx9DNypuX2o2B8yTmDxAmO4zbCQK/f+k2nxL2xV4cLjmSUyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419043; c=relaxed/simple;
	bh=abpNyxgQ9KkNVSqckerDOI+qEs4P+IlXGuU6qfpqD64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBJ/aPVEql5LLxw8aGRCR640ctyAAAeIGt+z9R2yf77FKNM9uZqcIABES038fV1/B5IL84dX8HgbtK7/C+0qH035Am3eCprZ6mUd1PRG53A0OWUE/z9t3JwLNLfWV/Tj7A+VT7YYZCyP782+DF9ES8Wyp4m81oTjMvfHfKryUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RsN0jivS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XocpdLt/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D8697A0189;
	Thu,  6 Nov 2025 03:50:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 06 Nov 2025 03:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762419040;
	 x=1762505440; bh=BhZNIoa9fUJAqHwJYe381aYj+y1Pb8jxqZVXoI8Hijs=; b=
	RsN0jivSrh6aL2juVaGk9DIZNt7yko8n58IVG9GViIQhQABXUPeQjz+ecxBEbFmc
	ZHZ2TOqQnohfbClNaLDnQCKrVIjnhHIAgvYUlQOl6FYdFVsVgdPWa8SIyhiX2EnV
	WT8g69QHl4tc0pwdBWMsiuEJG8EmdihK1pXCG5cliDLjvxma57whONH7Di9Vm+tD
	ishBoSgn/Z64xAv9l88zvkB7P+WOgLa8L6kMt/3SzT4SWQz2NzEmSYncFFfJ6mED
	dTj6eDtx3O7qwWBh9kwPDFWWqIZ0vW5hskh5x8AwnHkW97w+PgWMbGfXWkbtQlm0
	fzALvtzlWsBxr07qyl3lng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762419040; x=
	1762505440; bh=BhZNIoa9fUJAqHwJYe381aYj+y1Pb8jxqZVXoI8Hijs=; b=X
	ocpdLt/MFhJLtFpU2rFc1lAePPVvUBJ/IBBtWrKl9BY0Ju17UNA41yN9JpzQcvjo
	hNWEqmAjaZyS7rSYFIKQJBiymkt0tv2p29DyAwZY7CVjrbtis/DEVLsMS5FRzHJx
	9gfBkxZxgYw4xZuvxukLpdIBEDFcqvuP5qDKqOL9U16fzdGBZaLXaWMNq4M00j55
	0mRXZhxNiQuxXU+TqqqbBFJaU5bmmwZRGCZ+JmsKi8ap5tuu37/nr7KDrKKJOkdf
	Fb5ViqyXn7kpKgTvBQmR4L23+wFRTScfcrRTG1IyAPYxyb4PrjqNDfoHgX8ugX8A
	DsOC46+Zg/SoXl2N9pzDw==
X-ME-Sender: <xms:X2EMaWhrSg0Ds-BdkIxxnZx0U8rN89Xy750ql2fGdmp1eMJ44dkr4A>
    <xme:X2EMaYknFoLb1SVJAQ-cxKGvQwnlbGUDoOu5AFBfgqgeqVXYY39WWbu5hm9c6WL22
    Uiy0o9d1N419tNXEK_AnQd3kAUdzqKUqm0mBMVfKLaBRj-GBw>
X-ME-Received: <xmr:X2EMaUbSCwNHVh4M0KZ7SSE1PCWVL8ui2dqW20vhUw2QIHm1slor0u_UKrCG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgfekffeifeeiveekleetjedvtedvtdeludfgvdfhteejje
    eiudeltdefffefvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeduvdegvdduvdehvdesiihjuhdrvgguuhdr
    tghnpdhrtghpthhtohepshgvtghurhhithihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X2EMabGkIevA0e8hYnzocggpSNHU3bsBUKCLfqL47_Oqn38jyGymEw>
    <xmx:X2EMabYm69hP7QiDmDgQT2PYOL_UpxgjUzoVowL3jh4A-_KCLu0abw>
    <xmx:X2EMaXzXzIBWpRjG04RjLqBNqrTMc3TogrSooEOG3HvgQnPYYnHrzQ>
    <xmx:X2EMaVSfI-gWoLH24Hb_ZTmn6BYeY6LH-0M1988y51CikGgDUD0r5Q>
    <xmx:YGEMaaw8MtGbp98fLur23m5iv_yf1ql981orDtCSqyIn1InQCpnpTxqY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 03:50:39 -0500 (EST)
Date: Thu, 6 Nov 2025 17:50:35 +0900
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?56ug5oC/6LS6?= <12421252@zju.edu.cn>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [SECURITY] ext4: KASAN use-after-free and Oops in
 ext4_xattr_set_entry with crafted ext4 image
Message-ID: <2025110602-display-remodeler-80f0@gregkh>
References: <dd5c923.1fc4a.19a5475534a.Coremail.l1zao@zju.edu.cn>
 <2025110632-fondue-chewer-2e20@gregkh>
 <58255d5d.20a1f.19a585765c9.Coremail.12421252@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58255d5d.20a1f.19a585765c9.Coremail.12421252@zju.edu.cn>

On Thu, Nov 06, 2025 at 04:45:14PM +0800, 章怿贺 wrote:
> Hi Greg,
> 
> Thank you for your explanation and suggestions.  

Please always cc: everyone on the emails, direct emails don't scale :)

> I ran e2fsck -fn on the extracted image and it does report errors
> (including “padding at end of block bitmap is not set”), so it seems
> fsck already detects the corruption. Next time I will evaluate the
> impact more carefully before contacting the Linux community again.

That's great to hear, but I'm sure the ext4 developers would still
appreciate a kernel patch for this if you have one :)

thanks,

greg k-h

