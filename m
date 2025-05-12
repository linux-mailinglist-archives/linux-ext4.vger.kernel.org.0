Return-Path: <linux-ext4+bounces-7809-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FCAB3C47
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A0817EC6D
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CA23C4EB;
	Mon, 12 May 2025 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtBKZ0f5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C54215773;
	Mon, 12 May 2025 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064175; cv=none; b=Ur0gzu9TCPEF1WMXcKGdsT0FC1FJSZLBs8hfFEokUMdfFXrNHrGCSKyHKK6yTZHOzFLzRIT/02g/isR9IH8h2zOCLub21b1bHeojnN0sz0MbY2yaeIMvZ9KUlqU5oxm1Mhx4t/Zh8RAOjpQUmh3cmQpAyTGlJqfP2RixiAFhnnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064175; c=relaxed/simple;
	bh=VWlZafYkwTJ7RgaVLj2rFeRQfhLZHXw22mIQW5lxMtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8vRc9eOYM9nt9zWyLq/VygU7qj3lol9v6BeHkNDg2Qn3HG06OKOpWpugCXDyH0fkYnvAYs6TPbQ5w7TTYH5b9iOA5+t+HNzrkl9LcL6hgfb9Z4VWtn8pQ8bLU0zflEOdcZN5ibq13LwMsxdt2sB3gfBoi7VJLeYz2HzISRAG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FtBKZ0f5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y8t09wJh55EFUqSBhk7z4cb0yNRoTNBcrg7IuPA7JOU=; b=FtBKZ0f5B9lrpWSNFCsyy58a/t
	WEVERk3VXM85VDfCO3snvk9xCAqABAJv4L+XW+3lWA1lMLqJGrujIDhda3DLORurellbms2yQZ79+
	uUb2VuUI+Qoduu7A76HCVcs3Kv1GKqfmOSoez7covn7zqbcGMbegnmGkH2WVLL9bl8kYmP6rh2KTM
	cuJmsS3JIFlc0ew60410PXRKRUy54rQSsFXXvOIsT9wLIRKogc0/hanvC6gJJ8HBn72R5dIwiBHKu
	WcG7kkKmjGWDphXLs6J5RfXl4YU8bp0iz0RVw2ZgUXT+FzdINXcUYc0B4oYMMrSDRL5PrBPfenBrD
	iqHuCzSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEVCQ-00000009tn2-0pVM;
	Mon, 12 May 2025 15:36:14 +0000
Date: Mon, 12 May 2025 08:36:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com, hch@infradead.org, cem@kernel.org
Subject: Re: [PATCH v5 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Message-ID: <aCIVbuot62pZu9xk@infradead.org>
References: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
 <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html


This still looks good.

One nit:

> +	/*
> +	 * Now that mp has been modified according to the remount options,
> +	 * we do a final option validation with xfs_finish_flags()
> +	 * just like it is done during mount. We cannot use
> +	 * xfs_finish_flags()on new_mp as it contains only the user
> +	 * given options.

This could use slightly better formatting:

	/*
	 * Now that mp has been modified according to the remount options, we
	 * do a final option validation with xfs_finish_flags() just like it is
	 * done during mount. We cannot use xfs_finish_flags() on new_mp as it
	 * contains only the user given options.
	 */

