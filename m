Return-Path: <linux-ext4+bounces-3259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1A930D71
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148921F213A1
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 05:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F131836C5;
	Mon, 15 Jul 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IJufC1hE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pT3pfWb5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1D13AA39;
	Mon, 15 Jul 2024 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020542; cv=none; b=jxnIqugBc/+Iz6e6qa+4Mh0UjWhRGcvxPfhEGxSzbRd18slvtSXh6faeQ2+kPn/NnLpWwtphgm+zV1989MyUz6Z5vSsb7SrIJncKXl3EF1oBxoK22+cd+4pH6FqU10leCbvGbJm5ruc0RO7Y8mDvgeSlSS0sxV0OReNAwr5H7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020542; c=relaxed/simple;
	bh=XBsZbKGiVtTrKlyP1R6GYcTiqxjh19bGVWk3vIktpF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq2ZRIjlIPRKZNZp1P098D6Ojp0gM3qK6yLdal2DQNwqcxi+dYMdwRzIm02/xTmjqgsHtBWoxc6t7W4mW5ii240yvp24IXn3Z3mjRcrp3FtTts5tHjZfm4J22QQIvAyKELRTpIvAl2CN0NAJPS6MTefai7OMnzJVFEQnbmcyMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=IJufC1hE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pT3pfWb5; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.nyi.internal (Postfix) with ESMTP id 0AC5620054E;
	Mon, 15 Jul 2024 01:15:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Jul 2024 01:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721020539; x=1721027739; bh=1ACFvhP62g
	scbHqyYeARu0YHLy0C0ta9v4Ydldd1YuU=; b=IJufC1hEunLX8ShlvfQOj3gHeZ
	tuMhkLLiuonq83SQrIF7ocSp5I/XfR4t5AK74YQMcasmzenZxy2vn07UYZGwlbBp
	5XrDmdrJ9tOHHVzR1IAFcV4nNe0AOpST5V0I1N9u9sdJ1EsHeGqdDLvSkYB20JPS
	uElbGdqdcJlKyp3kMaw/BCKPX5LS87KK+zjHXCmRG/JcMnGTx9d/H1ois9+fsOgo
	x4ieMhf0wv+UKthJ4/yBtMelhIxmM8DMdIDipHoA7IJF2Y1AfQYULW/BzFM3ttL6
	mBIeKVb+QA0TkVEJhg9ubHsgUZDX+XE0ruoC3O216horTNs8O4rhrxsUBWuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721020539; x=1721027739; bh=1ACFvhP62gscbHqyYeARu0YHLy0C
	0ta9v4Ydldd1YuU=; b=pT3pfWb5lhsvBc8ig/lReN6EuBpyTD1rNcNe/NzywA9D
	yawjrBoUcciq8rkL8OxRTRpFyqhrVD29c+lf09n/k3eaWu4ls2pMkweyk1A9xser
	KMWpESlhTJhGAFriiRKML1MSyQ7+dTnTdw8ZKMWS8ejvZPDR/NdkGvTepDgB9lW3
	UQwRsOCNQhwytpMy+wIL4wr/wx52By0Q76qMfaGFR0IHDdmD2ROCREmPMBfCD2c+
	DKkHh14CBnwp1MQKQ3/7ESotzUombvXa7etBzE1R3sW9YXB9qQxAz8kus1XVy8Rg
	LX+JvZ2z8AtI76ncd6BItzdupvQEcWz6lNtrHkHW4w==
X-ME-Sender: <xms:ebCUZt-D3rte0sCxnqARy97iKOLUloqvW3f5OBOvgg8jU2T6wlqY5g>
    <xme:ebCUZhucwiOaq8xm2Gc6rJl8nJOu2JOlyWDIHGLmsKgne9cAfrwhb8GiG5iRk6o5l
    TqnU6fBYsP7Ew>
X-ME-Received: <xmr:ebCUZrARYVzvRpECQ7CxQ5fJV5VXC-09THSqIrnJAL7T4-_gGO8356d0dBlHmput4TfzC-w3efnzNel_Pel8Fc05pCz8Jk9f5PcJHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedugdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:ebCUZhcUXL5iJ2IWw0WVuf_06XNPLWQTwYVu-_o_jNoHRtBosdYQ_Q>
    <xmx:ebCUZiP8uHq0tA0-Pp2gGhumc43M4oi7ezbmMzxUlHV6InnFrdJI0w>
    <xmx:ebCUZjlpdb41GrQU-mJnPzZEsO5V462CluKCQKOgKgzgvbmYye0grw>
    <xmx:ebCUZsuUsHXNnnWFstQk9UcG5D7rUp4LYxGzEomfcGarQlnxCW5hdQ>
    <xmx:erCUZrz7kLiuR7vYXy6YusCZveJodqhFSp9ZR7LUIASnPv7fRsWlVtvD>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jul 2024 01:15:36 -0400 (EDT)
Date: Mon, 15 Jul 2024 07:15:34 +0200
From: Greg KH <greg@kroah.com>
To: botta633 <bottaawesome633@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-ext4@vger.kernel.org, syzkaller@googlegroups.com,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] locking/lockdep: Forcing subclasses to have same
 name pointer as their parent class
Message-ID: <2024071514-gift-bride-a420@gregkh>
References: <20240715063447.391668-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715063447.391668-1-bottaawesome633@gmail.com>

On Mon, Jul 15, 2024 at 09:34:46AM +0300, botta633 wrote:
> From: Ahmed Ehab <bottaawesome633@gmail.com>
> 
> Preventing lockdep_set_subclass from creating a new instance of the
> string literal. Hence, we will always have the same class->name among
> parent and subclasses. This prevents kernel panics when looking up a
> lock class while comparing class locks and class names.
> 
> Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
> Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
> ---
>  include/linux/lockdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

