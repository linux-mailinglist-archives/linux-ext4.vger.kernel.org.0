Return-Path: <linux-ext4+bounces-3406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DD93AC37
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 07:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F921F22B24
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 05:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B725481AA;
	Wed, 24 Jul 2024 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flYDGCor"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4221208D7;
	Wed, 24 Jul 2024 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798603; cv=none; b=PQLU9ylJWRTGszLdXbTgMWATvK9GUbYEXlTbqaSmRswgGD63vA1flbGr3Opu9H6F3b1eeTl6ml7zg4piKPv66bLE71BjNH6NwYyaObhEwIj7uDkyD3huiu+bRH+Q1JyohqJrqp4xT0R9gjfwEhkPh+Biw3Vj8Bb3sWe286CmyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798603; c=relaxed/simple;
	bh=3wV2E0ms8osbGVrmUy0Brt3tv3Cz24uYw20q/7UoYC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXD4nQio9L35oKR6npiy3CTlWGVsIfBBtEiEBN1SL/TB/DLAqBmfDxFa8o5OfPat4qoZ9bd7807ue5Mi2DMtjp/GiymgVyYZTomDKui7dpxhQ+Y74G7cseFPxnH9OHm2bhgpB9tGE8t2sa0tOxHQvhPJCFWXBky5AxMvg+fs3wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flYDGCor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C842C32782;
	Wed, 24 Jul 2024 05:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721798603;
	bh=3wV2E0ms8osbGVrmUy0Brt3tv3Cz24uYw20q/7UoYC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flYDGCorY3DfjswUyJ7VkLQqocbFjGWk04Z9iiP5A6UMBwOz79ypi0iMuQ/qF9s3T
	 jJJeslhHF98t/EM9/rYLaDXT7pmNf1oKhmRUTXlV9pkeube9/35zb7liLMe8kUOaQg
	 s+GxlCwxIgzp5zW0N339ii8UtvsJOP4IT8Nb6hlg=
Date: Wed, 24 Jul 2024 07:23:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, yi.zhang@huawei.com,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, niecheng1@uniontech.com,
	zhangdandan@uniontech.com, guanwentao@uniontech.com,
	chenyichong@uniontech.com, wentao@uniontech.com
Subject: Re: [PATCH v2 4.19 0/4] ext4: improve delalloc buffer write
 performance
Message-ID: <2024072434-clunky-ninja-89fa@gregkh>
References: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>
 <2024072316-thirty-cytoplasm-2b81@gregkh>
 <206F8E88DD4C4DD9+5197bc65-d440-4ad5-8b19-e1f83f4a1c7a@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <206F8E88DD4C4DD9+5197bc65-d440-4ad5-8b19-e1f83f4a1c7a@uniontech.com>

On Wed, Jul 24, 2024 at 12:55:52PM +0800, WangYuli wrote:
> Hi greg k-h,
> 
> As a commercial Linux distribution maintainer, we understand that
> even though upstream support for linux-4.19.y is ending, our users'
> reliance on this kernel version will not cease immediately.

Good luck to them, given that almost immediately after it goes out of
support it will become insecure :(

> They often lack the time or resources to promptly migrate all their
> devices to a newer kernel, due to considerations such as stability,
> operational costs, and other factors.

They have had 6 years to plan for this, how much time do they need?

> Therefore, to provide a more graceful conclusion to the linux-4.19.y
> lifecycle, we propose backporting these performance optimizations
> to extend its useful life  and ensure a smooth transition for commercial
> users by the way.

Performance optimizations for old kernels like this are not a good idea,
please just have them move to a more modern, and actually supported,
kernel instead if they wish to have performance improvements.  Otherwise
you are ensuring they will never move.

good luck!

greg k-h

