Return-Path: <linux-ext4+bounces-5411-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164D9D91BA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7B28610F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7F18FC7E;
	Tue, 26 Nov 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJMfOLfg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810FB17E473;
	Tue, 26 Nov 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602452; cv=none; b=buVe9yPa1JIUbnI6DNz2vwRHOQOlPAFKlHmD+qNpkTkHWFcX4PNP/a7ickPGAwvDcpR2oukVjbydFzsQ04mJMZFZIJ8yLAVcVmIPaXcykNzEHAfME8qZhL7FP1btk4Iv766kf3YibgqcHO2vnxsY1BIqeNvUGRAbEcGsFuBDPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602452; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIbg2OYJYjVgXwZuygpwpc6CBV04Fymv6+AygNETto2EauRPTY0tG312QW4nm4DNzC4cueVeKQHeeZOqyV+iBwmphnheMnDqoFa0zyWyf2cmA16wzmQfh4B40bMAnogLVR0FIbM2bBHZztlqFNv6NUDHzcfVMHQj4lqhOKn4ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UJMfOLfg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=UJMfOLfg+0FfUM+6QbcYt0OXEC
	7ssUDI0g/tFfDYZdJUXO/fkXZMA5tp6aEwDJjAKmsncyZbaUbc+82hakDiCZNNW0nB5ZRYoUsCH95
	HJj8qr89Luhe7kvY3EQkRKZTPaibl5Lj2v4h6r01Nhc7b2hxyTO0kKii0q92GDnndjLQqv80lFyJ2
	SaG6tYpE4+sd/Mf3byRrN/I2jqCsFtAi4WJLsLBb6Ke0lr2V93HwjuMSL83dKaTxr/MgLNhNKqvwL
	fG1Hem1tq7gslk6hWbFvknOjX2GzjXQkM5RmfYMZ2zJFgPDzIacTrxk5szVVkXbocSiOe2b0lbPWz
	6MKL284w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFp2n-00000009kKi-3jfh;
	Tue, 26 Nov 2024 06:27:29 +0000
Date: Mon, 25 Nov 2024 22:27:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v4 1/3] common/rc,xfs/207: Add a common helper function
 to check xflag bits
Message-ID: <Z0VqUcxr0O30RgWU@infradead.org>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <31b0c72649ec4308aa4e8981ac416addae4e1fdb.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b0c72649ec4308aa4e8981ac416addae4e1fdb.1732599868.git.nirjhar@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


