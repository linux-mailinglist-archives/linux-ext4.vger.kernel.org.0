Return-Path: <linux-ext4+bounces-6990-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B9A72DD7
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 11:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D2E3B09EF
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE68B20B818;
	Thu, 27 Mar 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IkxfCnGG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D311CAA85
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071564; cv=none; b=RyhQm/ZSq7AWXHDIUOz36LCB4naC73guiYxHnMozc8Mst6up7pshajdn/2AX+IFy3MYFGz6Uy7G/AcR3SIfM2jJ02cHxAI//Zu2J6i+KkI9TOv2P2Fx8lXjCusioPFGUtOb4pD+q6EuBo7ENP8X36JGoMH57Wgp7vL5lmtc9IlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071564; c=relaxed/simple;
	bh=DBj2B2tN7D3AYapCT51ZV6bW0DNSCbHF2QdskpOMfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJdeTsV3jho32oRRCUkBGjfDdAK/VBTlbSLscL5cP9Q4iPCjaQc4H6AVZ/DocodjPUnQACX55wV2+rbvO7Ouab4F3MPbpqlIRZ6PcYMMwfHdHoq0eX9b5eblNGY8g2tiKhmBY6dhW7JUm8XwcWa60dFnAe4E3Gku/i7AYpn522Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IkxfCnGG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fQiXHj+wNtKiEX9FqAZQMgreHp7onDEdJWNXtMuGREk=; b=IkxfCnGGHwA9/t/oOiQZ3kOkAI
	+5SgWwGVzynxLIWGcZD9MZ7FGUVAdQCBq87bisN2RfhH+GitjGiRHvMWYmfc+IZc82kpBNBZUxBWR
	FBluDvHOrZ76/cECVbOUbGLR6klmMFTjwEF+858KKICHKdM69Se1iE7xGI/lW08kq9Q2xvE3wGZRh
	PXba2OS/joNaPZwUEnRa/mNjWunkjJZ7o0YijVHtvnsdXo4jUq6aCRFXHzoosrnpt84u/v4L0Rk9C
	CaEm/wf8SS6svnGxQKazee5cXbtWbzz9RJ5rWcaKdY4NmTSqkYOQurJRxKvJP6m3uzEMKDpq8Q9sb
	OK+blwaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkXS-0000000AiDo-0UZf;
	Thu, 27 Mar 2025 10:32:42 +0000
Date: Thu, 27 Mar 2025 03:32:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org, djwong@kernel.org
Subject: Re: [RFC PATCH v2 0/4] remove buffer heads from ext2
Message-ID: <Z-UpSq8jLIUXMf-Z@infradead.org>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326014928.61507-1-catherine.hoang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 25, 2025 at 06:49:24PM -0700, Catherine Hoang wrote:
> Hi all,
> 
> This series is an effort to begin removing buffer heads from ext2. 

Why is that desirable?


