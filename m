Return-Path: <linux-ext4+bounces-11753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B22C4CA72
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDF818849FB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763432ED15D;
	Tue, 11 Nov 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBdR25O0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409E1E7C23;
	Tue, 11 Nov 2025 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853264; cv=none; b=pnzOjU3QoqwGBJDbEyHhF4W0+co8SEce62niLJk4fuJf8iK28YgUQIxMEh00sdcHqXIinl6o7qHQU4r85ews0VN5jnj5kmkGBBFSCmduYMZx2oGwFTXRyG3EOBpySpRt/YwOy4fZ8sNNoOnBL3znUs9EVClhCeukxSkH0eBwybQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853264; c=relaxed/simple;
	bh=ki5echalEcfcG0sjm5XuXfkeZbuncrPBeaE4qiW9NrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvxNXIwdMaO5l+DOviO8r6W9Co0DbRO78b0fAD2peBaB44Pet9J7TyAiiMcmmgLpPzviELgiq6pZG3gqbrj2rCufHAf2D5t9/uZ8d0P/wia55ocuC5Ef+0wtY7iXzl6c81HWHMM4ooobqp63JKAJqmVcHo88CV3tmz4RPfLBJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBdR25O0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mMIxYYoS64JSwaR6/1hzjqgragssIENI9jTR/caiJ6A=; b=rBdR25O0K2x3GFOrKkMo0m1zJL
	gRK9Jcf6Z6TLz5l1ffHebI7YxlZLFXUFBZSsC07eI1HzEGHJGAY8DfLaN5DYlZoeCIq2fKqKSzPJn
	ELR4m17YR8eXa6ylDnULn6bNj8MdnYXU9HN2QzlU8t1sdea0tpTl6l8vPsCB03DsTD9YZdqri33qw
	0wIAt412yadwdoDsbh7TYaviNT8Ew/cMvRmM8D9v8o90zVzhsFHEc6FXhRqSLdqM0FdfeHQJuDBk3
	NYdbWa97xjiutOWcfSFks1hKuKpvYKkGSXx/jBbZ45Fm6PTQPAbghe/N5QqigmldHYhY9jvZEHZB5
	8VlsOipg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkf8-00000006qNX-0NXV;
	Tue, 11 Nov 2025 09:27:42 +0000
Date: Tue, 11 Nov 2025 01:27:42 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] generic/778: fix severe performance problems
Message-ID: <aRMBjm0RGA4Cgrpq@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 10, 2025 at 10:26:32AM -0800, Darrick J. Wong wrote:
> Finally, replace the 20x loop with a _soak_loop_running 5x loop because
> 5 seems like enough.  Anyone who wants more can set TIME_FACTOR or
> SOAK_DURATION to get more intensive testing.  On my system this cuts the
> runtime to 75 seconds.

Phew!

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

