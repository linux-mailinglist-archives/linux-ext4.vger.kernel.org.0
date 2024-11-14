Return-Path: <linux-ext4+bounces-5185-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B39C95B8
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 00:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3485F28168E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 23:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FE41B21B6;
	Thu, 14 Nov 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Au6fWA35"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F01B21A8
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625321; cv=none; b=u9FGITtizAeeEw7pjKQ6dP0e/JoUeW0h4Fh/b0cDgCAaurOxuw/plZ54f38EISxiWhaTvRDTefAeqxCEe7BCp1MhvQExS50lq4Q7HuxisvSrb2oBixjMTuGmJGMnmfzPC0uLBdcZhJDJrFfUpQ34VVekENR7rs2ehKAo/aNH+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625321; c=relaxed/simple;
	bh=MK2DhBLnwbG5e5ZmBE1yNvN+Cf6QzUUoBav5TZVEAPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YLhyP1KrZVgcxOVxYBywUZX+8vh8rbfEcQzQr/edZoHQEnWeLPkjTgFL9Go1vIrwyNDgGhYulo8nTt4V0eIYi/jZVdTCb1ice9PDk+DTE1Ay/Xw8WG+WS7mVHfFMQiaL8+z5Od0eHmL3nKe76nznwigphvftB1soecY/sI3ZbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Au6fWA35; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731625313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CO7x25wgzcGlKTf0gfOze2m5krBMIGAGOp6OTv9hDaA=;
	b=Au6fWA35pD3FvvLpQaWGqq+FNgVJUAHQR4c3DtYegOTqI+CHx2z7Bvew4lFNAk7gi5lWMG
	pQ+ZUrj4Fd+q8oEElPClgU3XFEn26rq5LqaaC0hNeGCXnM8Y9roKguQS0F8rooRvLvRfnL
	oo9U/x5FeeuyCqSR++/CzIzrhbRiq5Y=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] ext4: Annotate struct fname with __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <173159220757.521904.13348650494002839092.b4-ty@mit.edu>
Date: Fri, 15 Nov 2024 00:01:39 +0100
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <67B144E1-F6E4-402F-B6E7-95159815542C@linux.dev>
References: <20241105101813.10864-2-thorsten.blum@linux.dev>
 <173159220757.521904.13348650494002839092.b4-ty@mit.edu>
To: Theodore Ts'o <tytso@mit.edu>
X-Migadu-Flow: FLOW_OUT

On 14. Nov 2024, at 14:53, Theodore Ts'o wrote:
> By the way, in general, you don't need to resend patches unless you
> need to rebase them to fix patch conflicts; I track requested patches
> using patchwork, and I tend to process and review patches in batches.
> 
> If you are concerned that I might have missed a patch, feel free to
> reply to the original patch with a ping.  I'll see it in my inbox, and
> even if it had gotten lost in my inbox, I can find the original patch
> using lore.kernel.org or patchwork.

Thanks for letting me know.

Best regards,
Thorsten


