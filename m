Return-Path: <linux-ext4+bounces-1022-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0D841D4C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jan 2024 09:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ADE1F2392B
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jan 2024 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F854F92;
	Tue, 30 Jan 2024 08:13:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C254730;
	Tue, 30 Jan 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602411; cv=none; b=qHxlMfGL08jQ/3HCHehQ4algUjfl6TDNMg/Dv6lQ+8cRXfyarRG52UB/2axgYeohewDirNsCtClUPM5igJdy18Woj9zS6j+oKHlnfkpB/9jl8OVtvhNvoTInZKp+NO5C4i1rq8ltClMqRq8i1DVQtOxrJtEbNZudX7sh7E4dkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602411; c=relaxed/simple;
	bh=H9Uzgoak4i6LUsljZliictwGDjYmDADI3JxrR/uu71w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCFordJfAbkxKvPQhCnr4cZA51bl1bWkwbzQnNnHMMv4lkIWDJX1krawbEml5uBmnSwU2c8pRjdJJkc9ForVk9Gdt2sk5ECCRR/Z0Hh7ctkmXaClvSdLNX6VAyj8Urgcc4DlPiGnOzeIreruX2UMKF7Sri1meI5xhPQXxwtqEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3FF368C4E; Tue, 30 Jan 2024 09:13:26 +0100 (CET)
Date: Tue, 30 Jan 2024 09:13:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Convert to buffered_write_operations
Message-ID: <20240130081325.GD22621@lst.de>
References: <20240130055414.2143959-1-willy@infradead.org> <20240130055414.2143959-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130055414.2143959-4-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Given that an ext4 conversion to iomap is pending on the list I wonder
if this is the best example.  But the conversion itself looks sensible
to me with the fixup.

