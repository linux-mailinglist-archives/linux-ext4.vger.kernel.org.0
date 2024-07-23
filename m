Return-Path: <linux-ext4+bounces-3389-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E193A52B
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 19:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C5FB21548
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C615885A;
	Tue, 23 Jul 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bRPP7v3G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35A158203;
	Tue, 23 Jul 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757413; cv=none; b=X4CfmmEKaSBgmuOM4b1Bsl9MV5ThqhtXUXn5rSPiOMDD2WL2QRF+iitoxtOrOTfW3NuSHd6wZtKtA6Mu8A5E4IPIchCeQsouV1UAcnT2fxxyALq8Ueqgc0KhY0PJg4RuAbXz/vKIsw/Sdqv1i2uu0Z2Tznc/YFUcYLC9Kuczne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757413; c=relaxed/simple;
	bh=8KHrMM7tUfw/84uOBUst7fOhws3TvhmkqeU9juK5RBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmMzeo+GRapZqcbjny2MP+qlSwFbnN5qJE3SxKfPtZa7jMG3t8DYvZmjxcBMPVzZtKTKxG2iPDXfyXIwcp3beiV6m2s9KKk7XeTMjKJ5Bh4iEhVwD/9ErxQmNSVW3k3iTNDJU7knC0ZcQAUYXdC54NBdz1JWLM9FUaSDiqgc+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bRPP7v3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5EBC4AF09;
	Tue, 23 Jul 2024 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721757413;
	bh=8KHrMM7tUfw/84uOBUst7fOhws3TvhmkqeU9juK5RBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRPP7v3GCrNH59DIoBLWcUxEoyuv6pzKIeDkz81CMroBIe6+Fq9cxS9BiNOHyRfNi
	 nf3fd4QnCKCyVpNfJcjRh2UJRvzgpSNY8/GJsBRtdHowoE+wSsuQ8OUa/1+XG3qNU7
	 TSxvDiOGx4WyGxKolMenWoAQj2raC0q2tJqLgQWM=
Date: Tue, 23 Jul 2024 19:56:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, yi.zhang@huawei.com,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, niecheng1@uniontech.com,
	zhangdandan@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH v2 4.19 1/4] ext4: check and update i_disksize properly
Message-ID: <2024072308-hanky-oat-838d@gregkh>
References: <20240720160420.578940-1-wangyuli@uniontech.com>
 <CBA4773FBA840F79+20240720160420.578940-2-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBA4773FBA840F79+20240720160420.578940-2-wangyuli@uniontech.com>

On Sun, Jul 21, 2024 at 12:04:07AM +0800, WangYuli wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> commit 4df031ff5876d94b48dd9ee486ba5522382a06b2 upstream

As this commit is not in 5.4.y, we can't take it for 4.19.y as that
would cause a regression when you upgrade.

Please fix this up and submit a 5.4.y set of patches and then submit
this series again so that we can consider them.

thanks,
greg k-h

