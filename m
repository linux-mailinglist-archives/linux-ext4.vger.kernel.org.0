Return-Path: <linux-ext4+bounces-5413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583259D91C1
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 07:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7931B22BFE
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605714A617;
	Tue, 26 Nov 2024 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3GMJiE3n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CA14286;
	Tue, 26 Nov 2024 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602489; cv=none; b=O62JUJrS07FgulYBRUgDGVu+9fCUkWWauE/u3SpUXgVBB15YvhX7AwgpmDiMXhLVhjMxE4IL3kem2Sii3PRzWJMVHi3DNJDnUw/QrsU0P4MCPBAzaKFTQd44tUuIviSLClYxE4pKuA6AoEz3++KxE/PLy24INFweHMhZiyjoORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602489; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDtk/jL85q2pr1ZQUtFBwE02mZ7Um1eqJlwsl2bmjDucpLmUNS08rrYTEPTv0Drbeqoq+t1s7YTxgteLJPF9WPAlrtNeFz6XSyKxLVPoPh0tQxKmz2SCwj9k+VaEIkUXwYV2WcjQPM4mpTk2sLKIl2jS3XeCOCDZbo32qsmZnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3GMJiE3n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3GMJiE3nZDI/lpmM5NdTYfjmuo
	UM6nWM9uA8GnnsFGRCJXBFS7WEidNZ5zWiuxjZL457e/hMMvhg6ea0pTEqnUs/OdPKVEO400H/K6+
	MopN74SoZGoa2XFzafQKvby+uZn4fjbX1bZysoBTqPgNKFWUChJ2QucslZJ/qw/FXPzFsiHSroolN
	hWdF6ig5lz7B7ciW1RsYzmdhGRrAx94oitcZCQnqoOXpOj5HlaWBcPF+9h0WRR08LAcVXeRb/EzCj
	2jS5t7BLr42yJYvZ7WosgDOa8lY/G8AOVkbwtwSsH+e+iZnvB4AUhuEPClgVA8+n3pYToTtfruS6b
	weCl8cIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFp3Q-00000009kU7-0AUy;
	Tue, 26 Nov 2024 06:28:08 +0000
Date: Mon, 25 Nov 2024 22:28:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v4 3/3] generic: Addition of new tests for extsize hints
Message-ID: <Z0VqeLeYbLX-uCeK@infradead.org>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


