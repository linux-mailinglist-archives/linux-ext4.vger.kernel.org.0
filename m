Return-Path: <linux-ext4+bounces-11751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E9C4C971
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B00A14E21D9
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32626E71E;
	Tue, 11 Nov 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djTxuhKw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F143262FC7;
	Tue, 11 Nov 2025 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852397; cv=none; b=lkQGr4tEiJj91cm8XUCvItfgefZHjIgvYbqpfCE68wUcem2rkSipOxDYZw4k+3/QLMDT791O3j9FQRKLWovlOopV9jgI8xqgY7L36arlmwG9o72hK8GXpUDASDqAjE3C5OspzJgY6Ps8JgvyRCCNAfDMPHlUkVhOc6vOv7PEIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852397; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQq/mjy9t/4iCcX1gB+Ng0JiP9zDN+qRwlhS3+Kwb6TJHVq7HvOepUTTe0/uBwX4MoXdGdyx77Xpxj9dDgx6xyORi4nIEQ9wFzrpU+Uhx5IjIfbrGJPQr8TxzsVjpgjbsEvgkWgbm/E5WU5ZgC4tpi5XImn6lv+xYbPtQLAeNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=djTxuhKw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=djTxuhKwZkfKHqIpZYLInYPaUu
	pFFi37P+7zISoi4yhrpTDGvrx5eQtMYjsfv8TElQv90mNuz3TPysf2Tu/iEzaBmUTKliUl6+C/UcE
	j6IY4qZ7iELb5sced9pdIN3BTAvQ/Euw2x8lQoA0pe5obanFaxylUWvVGnS0IYN8sxVFDonOw+yDp
	gi14aXgatslmcGDz8gvmzIoEG/WF27AJB50VOSNU/zuKfafHvUamAn106xIY7FrXmhK1AGFzYkZ3r
	0Zehci+/hwz2F6O2LfdCfAYrr1Fnum/yth9uMgSoFrencVQE8kf6mECm1wBoq3fASKvUxyjMrKU+D
	1uSISqNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkR9-00000006pKu-29VS;
	Tue, 11 Nov 2025 09:13:15 +0000
Date: Tue, 11 Nov 2025 01:13:15 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/7] common: leave any breadcrumbs when
 _link_out_file_named can't find the output file
Message-ID: <aRL-KyYw6TbwPB06@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909022.605950.903689908646225008.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909022.605950.903689908646225008.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


