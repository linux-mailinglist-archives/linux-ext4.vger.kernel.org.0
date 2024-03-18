Return-Path: <linux-ext4+bounces-1676-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46887E525
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 09:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B91F22383
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8928DBC;
	Mon, 18 Mar 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fChAnfyd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305126AD8;
	Mon, 18 Mar 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751498; cv=none; b=P/stX7nJ9E5CvUqnrit9CrPPucH1tSaXr1XUfH4wT6shddw4mzKQwODnp7IHuIxwdzfj8rfir9aIfpjg00hJuEKIm4YdjAATXHXa6dE60sgJCcv3WsDuZ7qZDVn3cMClfTMV5rSUMq/IT8UkjtbTuSq8pe99Ji0Wz7wKItnEXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751498; c=relaxed/simple;
	bh=1TmE/xqIyypclwlllLbD4j8U75v6abiKzNmNwMS0poU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q91rc4kFn1XZxR68W3b68c6hlXI6rTcvNtn1eeKpnAgVC1oky82eYYPtTjhrdD1aRig0EPAW4E/5jeGHOlGDjCo3VlFje26fVR73jH2rMEbdHCAlkglTNkGnLd6DN1KmGwt9jZKtgMR27s7m7duDz8ybphg5x6q8vNvsb5ZGaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fChAnfyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EEBC433F1;
	Mon, 18 Mar 2024 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710751498;
	bh=1TmE/xqIyypclwlllLbD4j8U75v6abiKzNmNwMS0poU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fChAnfydv2Sa+/WKTFpa5ogjlTfuna7SuStKu7bp2GJ3JC8mbntUUN5vKZXoXF6zq
	 zjAz/WW9W5515GbqdQF6OA2CcDVKGdrH0/3ado6f7B9Hby3o0KV9BXna5qSn7O8a8l
	 B2BI1WK83nJWQjGE2hXsv7QRGi3Te4cJTCEu9DuZuCctSuQt9f89VvPOYm/TG6NFih
	 IeOOfPE66rxG22aAgERjOLFtoi6B33rFYaBF7B9l+I8NF2DClm6DHa41xarMwQ83IQ
	 XoEqHxQpTI/LaAgRe6QLV7wXPvgBeeBSqn5nsI0jauqmqq0SdHZ9R7vqkTtmvxHbwA
	 UpBFDsyRLDsTw==
Date: Mon, 18 Mar 2024 09:44:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mforney@mforney.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ext4: apply umask if ACL support is disabled"
Message-ID: <20240318-auswies-poppig-6ad4f7d0665f@brauner>
References: <20240315142956.2420360-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315142956.2420360-1-max.kellermann@ionos.com>

On Fri, Mar 15, 2024 at 03:29:56PM +0100, Max Kellermann wrote:
> This reverts commit 484fd6c1de13b336806a967908a927cc0356e312.  The
> commit caused a regression because now the umask was applied to
> symlinks and the fix is unnecessary because the umask/O_TMPFILE bug
> has been fixed somewhere else already.
> 
> Fixes: https://lore.kernel.org/lkml/28DSITL9912E1.2LSZUVTGTO52Q@mforney.org/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

