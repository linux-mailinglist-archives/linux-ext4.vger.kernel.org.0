Return-Path: <linux-ext4+bounces-9211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C1B14586
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 03:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19553BC456
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD518DF89;
	Tue, 29 Jul 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NS3UWwS3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3E26AC3;
	Tue, 29 Jul 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751041; cv=none; b=ERfxZL8/58YPx/pD4J9tu8Ssi427mbob6N7bzVZn/SD0jZiU7rmhgi6K6U8HUj7FWopy38RVBZLOCVws/ez8jvR2drQW5PMB9hZmKKk/N6ztTTEYPUV1sRjdzkUSi+mDz/Ia3ovKADAhPpgDFq+G/NCF85McMQ+RFCTArXYA/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751041; c=relaxed/simple;
	bh=xvL5Snk9AkC2TzpByv0i3/kjTLO4XcHtgHVQhzVmSfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHLvJAXJ3Fop6YQ4zz9n6ywqtmKyU+v4010pqiSFu9rd8QpwUqK2m4GdviIfZ2CMEQQuAWd2wEC9PVUESe5fNnphyQ56xBmsAPhpYG7RIlDJFzCyv8Rf7Kj5fnIczCcnLYsw3jpo2dcaAtFYoYEggiYJV05qCpyd0g9XFkYyH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NS3UWwS3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=45IU08JIJqJgViVt6DYreAvaMpc8wW/LjPAgfw8p8cw=; b=NS3UWwS3L1wkNp4hrrqpO0/pX8
	6DcSm7CVRywsT8mNyns+lY4OvTqH2j8OBlUaSaNBco5Q4i2QYbVbBF920B8WQBcThhVuxCZ2fpvHe
	eNN7uHxNOfBxXetPdVAQNyh/vmFiFwZGYleoIMmlWm7XFgaTyGjRhh4TFjY7/xndySdk2pI+AR781
	8Sg0jh6ibvOqzIR2vAN1bzX/ssEJK8rsCYSGm+spaOsfvMmFakVdyG8WZmTx6E4m2+ZVP2nmuDmPi
	/r2cICOCSDUkzcZywNGw/zQFei9QsyiWyzBnCrtKq23AOYLhU3IJYWhXULWk7tCKUkmE7Vgvu+HhJ
	J7kmm3Qg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugYl5-0000000Ffs2-1IUK;
	Tue, 29 Jul 2025 01:03:59 +0000
Message-ID: <0b5d7ca5-cc85-4f6b-b417-0d237d9d45a4@infradead.org>
Date: Mon, 28 Jul 2025 18:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ext4: fix duplicate Sphinx labels in
 atomic_writes.rst
To: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>, tytso@mit.edu
Cc: adilger.kernel@dilger.ca, corbet@lwn.net, linux-ext4@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729005628.68795-1-andreluizrodriguescastro@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250729005628.68795-1-andreluizrodriguescastro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

It seems that the patch and the $Subject do not agree.


On 7/28/25 5:56 PM, Andre Luiz da Nobrega wrote:
> Fixes Sphinx warnings about duplicate reference labels in
> Documentation/filesystems/ext4/atomic_writes.rst.
> 
> Specifically, the label '.. _atomic_write_bdev_support:' was renamed to
> '.. _atomic_write_bdev_support_section:' to ensure label uniqueness
> within the document.
> 
> Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
> ---
>  Documentation/arch/powerpc/index.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
> index 0560cbae5fa1..ce39b54b5a7d 100644
> --- a/Documentation/arch/powerpc/index.rst
> +++ b/Documentation/arch/powerpc/index.rst
> @@ -6,7 +6,7 @@ powerpc
>  
>  .. toctree::
>      :maxdepth: 1
> -
> +    
>      associativity
>      booting
>      bootwrapper
> @@ -20,6 +20,7 @@ powerpc
>      elfnote
>      firmware-assisted-dump
>      hvcs
> +    htm 
>      imc
>      isa-versions
>      kaslr-booke32

-- 
~Randy


