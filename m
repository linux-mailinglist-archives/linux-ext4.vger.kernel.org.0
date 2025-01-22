Return-Path: <linux-ext4+bounces-6194-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE1A18CD2
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 08:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE513AC378
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E371C1F0D;
	Wed, 22 Jan 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3rZ4qLal"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9C18A6DB
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531461; cv=none; b=RSxBx0nedMWKNcFz+r9z4grDjNUhbpY0QVtUwku7kcK4IKWynsA+YI/2p9j55kiFD2LopNJA5sk9ihRwKYb7YezgPEZ7U+ap4Z+SAI3xry/ULBjaKJISsZ6rISpv1iKNbfMPOYUryBREbKPreQVxWloj4vQUlnCMhArQChKMXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531461; c=relaxed/simple;
	bh=VMatHh+dZNa9EN6xiV8VNTX48LNysiTR7osEuaSDqZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU9PnahvRvgnjGKwjevCAKO7EWn/WWEtMIHf+VzWI0pKa2tdImBxMJhKkhUMGUBuVPZVUm62X2+3iWnkPTykEYeozS1nN1Ia8ab5CIxlV5wyK3YHPMIkxt1x46uNlh+R5KuBAhLWVCCq8sd/RzjFMra/kvbRgSNxziuYjyBXG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3rZ4qLal; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WRBW9g7osOhBN86koWamWVCWvBItcnFJBMhYw4GC8bo=; b=3rZ4qLal1XWG03XEgg832qzWtk
	XO2TXf3q9knYeWjZRyAQUqlaCE1xaPLElOngdiH2HD9YyrdXpN0tSUcyjTkDJMD+i/sH6g6EJwjLy
	Tz0zZURgDbbuz4r6KcWvVlkyx4KSxeGrdwr/dP9ksxdXwQ8EnirS7XkOLWa3nxNMcw2REzyZaG3jk
	+T2k16CL4NO2KnCA1iUWvYekXFqVTS+MRHbs4lXUqYCZFQHnFoWa9akhw64FjbRtur6nvv5ziCk0V
	WWLBX9iLLSy/NfZcuerP/LrV3TjDx8UgTj/NUQ4nHDKu39/qLYaLZuO3DHLY9mrpsJN606AW9rmgf
	WRoq2MMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1taVIw-00000009bm7-1zYl;
	Wed, 22 Jan 2025 07:37:38 +0000
Date: Tue, 21 Jan 2025 23:37:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <Z5CgQosGsbxbbEIL@infradead.org>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
 <b8663f69-cdaf-4c05-b99f-cd4105023264@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8663f69-cdaf-4c05-b99f-cd4105023264@wiesinger.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 22, 2025 at 08:29:09AM +0100, Gerhard Wiesinger wrote:
> BTW: Why does it break the ACID properties?

It doesn't if implemented properly, which of course means out of place
writes.

The only sane way to implement compression in XFS would be using out
of place writes, which we support for reflinks and which is heavily
used by the new zoned mode.  For the latter retrofitting compression
would be relatively easy, but it first needs to get merged, then
stabilize and mature, and then we'll need to see if we have enough
use cases.  So don't plan for it.


