Return-Path: <linux-ext4+bounces-334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2880853F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 11:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E9283F4F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Dec 2023 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481E358B5;
	Thu,  7 Dec 2023 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="um9XVhMk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143A1947A
	for <linux-ext4@vger.kernel.org>; Thu,  7 Dec 2023 10:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC34C433C8;
	Thu,  7 Dec 2023 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701943992;
	bh=jjIqC4iSn/VFDe+Xa9h9ciWtGqh8N3pSlXrWjTTjMaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=um9XVhMk6ydG46DAOeQvOYixYw3Lvl2SRRiPz7BFVe5hWSWwj/iBaUMibhPo8IHnp
	 imwk05eZz98/uY/w6+KOpBNw3Ptesy6eqokQGK4kO+UoE0kWa3EmiwxEm/LoC3aKlG
	 zxBuGQS1oGOU7Za1fr5e9R6SulbE6J6q0qaNPOzU=
Date: Thu, 7 Dec 2023 11:13:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yann Sionneau <ysionneau@kalrayinc.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: regression in 6.1.yy branch: LTP test preadv03 fails
Message-ID: <2023120747-domain-angled-d633@gregkh>
References: <c1f93c13-4865-b5a8-8969-4c2f5cb8f776@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f93c13-4865-b5a8-8969-4c2f5cb8f776@kalrayinc.com>

On Thu, Dec 07, 2023 at 11:05:15AM +0100, Yann Sionneau wrote:
> Hello,
> 
> I noticed yesterday that LTP test preadv03 now fails since 6.1.64 (it also
> fails on 6.1.65).
> 
> 6.6.4, 6.6.3, 6.5.0 and 6.2.0 seem to be unaffected.
> 
> I tested this on x86_64 and kvx arch (the latter is not upstream).
> 
> I can see some ext4 related commits on 6.1.64 and 6.1.65 changes, maybe it's
> related, therefore I add ext4 mailing list as CC.
> 
> I didn't run git bisect on this so far because I noticed building an x86_64
> ubuntu kernel on my laptop was taking ages. Maybe someone is more used to
> dealing with this and can bisect this way faster than me.

Should be fixed in the latest 6.1.y-rc release, right?  If not, please
let me know.

thanks,

greg k-h

