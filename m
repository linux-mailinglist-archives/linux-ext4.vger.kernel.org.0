Return-Path: <linux-ext4+bounces-3460-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8995593C214
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A06C282C5B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D519A283;
	Thu, 25 Jul 2024 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RSVQQr0E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A8199E9F;
	Thu, 25 Jul 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910603; cv=none; b=DSM/ncXfm1XskmFf0JtCdirGwfjqHmDBpytLnFnf67oqUI06BSr+vFbgZwpOWsM3sshQTygttzShodX4GuaHjt0v4U4CtbzM7EATyjJf0PWZep+3ZKGguKPrAAuAvyeVBaAFdyXd78yu8jqM3gARxbNg0Eq/d2uDu89u4s+Xeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910603; c=relaxed/simple;
	bh=iuvdXQESVDwggfrmmB5RRpqk5UDB9WTd0f30EJVQv0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQHUDr1hpI9eovY2BaHA/OhM3vl4QEuakCwzNedbBxnOqIYHjdpXwhuHJFpYaTllmlu1NesXD13XdOosrn3U0bym44x5mxG0PKHYpNTjkQ3H2mAwPhSlgB1qUmQFtE+3erGcs7ZVd2KEYuDwfDhrbFxo6mLiwHOaQY19wkoq5RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RSVQQr0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC19BC116B1;
	Thu, 25 Jul 2024 12:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721910602;
	bh=iuvdXQESVDwggfrmmB5RRpqk5UDB9WTd0f30EJVQv0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSVQQr0ENGKfHPuQQ1ZHdN/Y4k6yYo/C70YCHJLQ61nEivirsfi7oP9uRg5gdmg+t
	 3jIPLdMODNxD03JoY7f9Q26eIPAD0V76XYj6Gbhytt78CDpsNdhL3kkWG3DMnuyQX+
	 RK0x3KsK2OKxMHXZNmot8iwCwJoYg/Sc0cdZzBDk=
Date: Thu, 25 Jul 2024 14:29:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: amir73il@gmail.com, krisman@collabora.com, jack@suse.cz,
	sashal@kernel.org, stable@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5.15.y 0/4] Apply fanotify-related documentation changes
Message-ID: <2024072553-placate-snowplow-e7a3@gregkh>
References: <20240724190623.8948-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190623.8948-1-cel@kernel.org>

On Wed, Jul 24, 2024 at 03:06:19PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> These extra commits were requested by Amir Goldstein
> <amir73il@gmail.com>. Note that c0baf9ac0b05 ("docs: Document the
> FAN_FS_ERROR event") is already applied to v5.15.y.
> 
> Gabriel Krisman Bertazi (3):
>   samples: Add fs error monitoring example
>   samples: Make fs-monitor depend on libc and headers
>   docs: Fix formatting of literal sections in fanotify docs
> 
> Linus Torvalds (1):
>   Add gitignore file for samples/fanotify/ subdirectory
> 
>  .../admin-guide/filesystem-monitoring.rst     |  20 ++-
>  samples/Kconfig                               |   9 ++
>  samples/Makefile                              |   1 +
>  samples/fanotify/.gitignore                   |   1 +
>  samples/fanotify/Makefile                     |   5 +
>  samples/fanotify/fs-monitor.c                 | 142 ++++++++++++++++++
>  6 files changed, 170 insertions(+), 8 deletions(-)
>  create mode 100644 samples/fanotify/.gitignore
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
> 
> -- 
> 2.45.2
> 
> 

All now queued up, thanks.

greg k-h

