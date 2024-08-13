Return-Path: <linux-ext4+bounces-3700-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C502A95027C
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE68B221F5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99B318CBEB;
	Tue, 13 Aug 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oA9v2HJg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2862C42AB9;
	Tue, 13 Aug 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545030; cv=none; b=W80SF4LaxtbEBkvmnUSPHkdFlVqjeWe/0lLQhOlr4Npj5TfYlSbHXlWQCKlOrWEjQNrJyIghTGbJdQWquimeDkaJvk0bFDZELUNOkxssoEfsJfp1+9/8fCY9nIdtEuU6DzLL4P8E1LCWQ4J+Chef71nZZCtSzjT/uLlAztiUA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545030; c=relaxed/simple;
	bh=+t7C/2rh1InitL4i9dbhLiuiWL7fjqkvIlgMRG+19yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEDUyxVP1o5j0Mg9x7BYhAUu+RZ2+QZaxaypfYe2orR+bl7nwKbI+aLuP78xZjURORxVjQWUBDdzIHJUixJ5/MaCjdvKi41eXTQkWkGMs2koIzSepZCpgwHc5QYXhAmLuKL9SOYVG/IoNHyr+JVIMaof0l1vKkLjGW2v//eOtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oA9v2HJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D6EC4AF09;
	Tue, 13 Aug 2024 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723545029;
	bh=+t7C/2rh1InitL4i9dbhLiuiWL7fjqkvIlgMRG+19yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oA9v2HJgp6O7zYH7GN5Ku19yyRqjCBlsLOaWGxZu1k7o9g9ag1MEAB5XWxXPNRPNX
	 sCh4Cctlm9iP5whvOxIeYHMB4pGGEPxgnGtZKEw9Tf3V09Y/N2tokuA3JVwOt8xKA1
	 2wzUtYO15zX57S6o97k3ISelL7JelmngiGxEesjg=
Date: Tue, 13 Aug 2024 12:30:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Cc: amir73il@gmail.com, krisman@collabora.com, jack@suse.cz,
	sashal@kernel.org, stable@vger.kernel.org, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5.10.y 0/3] Apply fanotify-related documentation changes
Message-ID: <2024081313-shallot-nursing-6023@gregkh>
References: <20240725153229.13407-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725153229.13407-1-cel@kernel.org>

On Thu, Jul 25, 2024 at 11:32:26AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> These extra commits were requested by Amir Goldstein
> <amir73il@gmail.com>. Note that c0baf9ac0b05 ("docs: Document the
> FAN_FS_ERROR event") is already applied to v5.10.y.
> 
> Gabriel Krisman Bertazi (2):
>   samples: Add fs error monitoring example
>   samples: Make fs-monitor depend on libc and headers
> 
> Linus Torvalds (1):
>   Add gitignore file for samples/fanotify/ subdirectory
> 
>  samples/Kconfig               |   8 ++
>  samples/Makefile              |   1 +
>  samples/fanotify/.gitignore   |   1 +
>  samples/fanotify/Makefile     |   5 ++
>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
>  5 files changed, 157 insertions(+)
>  create mode 100644 samples/fanotify/.gitignore
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
> 
> -- 
> 2.45.2
> 
> 

Now queued up, thanks.

greg k-h

