Return-Path: <linux-ext4+bounces-11755-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFD8C4CA81
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AC34EBFB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A22DAFD2;
	Tue, 11 Nov 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zen1bXF+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9D35950;
	Tue, 11 Nov 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853329; cv=none; b=Yo01jTv020L97rMni+1grzBxtITUefRak3uvjvpjz9nfO0lNDxp+b9W8rWLDmbjBRt8jXmzoacoAMZXcDuQuMLymladOeFTZLjUUTFtaxJbiNXAjtwF1iEz8UEm0pZLemU4B283sc5hvLwYcoqoXxCVdj9dwRTrg4VtTgkOOOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853329; c=relaxed/simple;
	bh=eBdLKmpqaF7drxBsX0T/YGGlwdADNv4VBLed3H0H8Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhUueSU0lk0d65v/JJlJD6CqnyEKPBBKjKhn18XHRcJZie8cj2GItAhWJPhIR5zJa1sMQF5MfBsEHd1b0QnMf2DLIahSrh0mS0g2vbGTHyttgB4q4wQTAz0w1By6FlsL+nL+nO5q8F7IYSKuSeTpMvcwrJ39UtB7oXoPHFuXSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zen1bXF+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oRZIEUCag3oBcCjMEjZvh/kERTMCTYkK8QTmNJk85B4=; b=zen1bXF+Q6CaCCKCqfxWWPgvL6
	HcX2EWAedQQvEFuBWEsa8i585CZjTl9f7JKEbaaDurL4Pm9PVM4AM7FvMXM2gjJiQKIFpzODsmUuh
	YEIYxtISJMyN/FLvO3yxFBGxJqGg9MGNp7tAMA9zxqvjwfQgRyqhAhw5tpWhdH/thK0EAfPgO6/hh
	AesoZRNLuryO9fMiQuQlCHa6UkzvBepPntB0q1MCbjnVk3eX7J+FOlPUymnw+V/eT6pxkrgHAWqGL
	9APICDh1ZLNQ9FuZL/wVcSwWJ0NAeuytyOSrzCpn4No/5QGt9zOFTpRLJIezph1rJ6sj+Ormi7DMu
	h/ZMepJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkgC-00000006qQz-0OSM;
	Tue, 11 Nov 2025 09:28:48 +0000
Date: Tue, 11 Nov 2025 01:28:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/7] generic/019: skip test when there is no journal
Message-ID: <aRMB0JlJvduJCxF_@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909079.605950.17890053232268440120.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909079.605950.17890053232268440120.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 10, 2025 at 10:27:04AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test checks a filesystem's ability to recover from a noncritical
> disk failure (e.g. journal replay) without becoming inconsistent.  This
> isn't true for any filesystem that doesn't have a journal, so we should
> skip the test on those platforms.

This is triggered by your fuse ext4 I guess?

Either way, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> 
---end quoted text---

