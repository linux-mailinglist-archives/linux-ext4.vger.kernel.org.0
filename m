Return-Path: <linux-ext4+bounces-3697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD494EC62
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2024 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA16D1C218CD
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2024 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2E179972;
	Mon, 12 Aug 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNBNMX1Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4608178375
	for <linux-ext4@vger.kernel.org>; Mon, 12 Aug 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464494; cv=none; b=U4JPJf3FSvisCLQkG9IHtdZXC3uq7tI8ZMEvgIQjsq2b1MXPl0i6veyyEiKDz+KIb7JJpB2eBuieEFOUpUD7ePiMDezh8+PQVc6UQwmV1RCr7ZcpNMK2d4ExkP7boAM/fDL0rKddsIi0tJP/wniZqFrv1/ZSfWVi8aSGCZ5mwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464494; c=relaxed/simple;
	bh=3xehZGWOpTHjqenbVPZ/01V9UzEM6YxjlopDzRp0pSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEL/kHI9Of0WqG0r2qHVSZ2R+M/F6gmwrAdt54ZIcBG6ZfrQeQWJX1tkK/0MnsWCNZ9z/uDeZwtcIvZuwj89P7F+YMJc3W/2fsm/ZMTfXAuNi1GJxvrADtsKs8i3I1IPNLvnJ1ZBmMuG7BUAUP7D64CTgI3C1oZAUFQvN6Ue1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TNBNMX1Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Ja3MRqMKX9YNlwVLnaKWoZvlZ4zw/CZ6sjwXtiE1dQ=; b=TNBNMX1YkcI05SSX6Vn5eK3ZXs
	X8J9I90ogABgQJd67U3P2eFdGhvsuehxtHk/X2hoUIUeVhn5lBXQGbDE626DczjR80VI851w3pwUF
	UKFqBQfIooTl2z+mqs2pjWP1ClTumWHaapU0PIv2gbKwDOl/j8Ozx66F053mmCCbQd/klCJiZGjMZ
	4Z0YyYzvXoGbNnXNU4hT3g2HSk/lZBGW2F0Ue/0mcqMLU7bBsN6qSS0sjSK4I6l4SJc8yk1i2PZEN
	IrvVL+oqg5YOSiMIw/4lCZSyaGvALE79I6E6YCG62eGVt2jt2y6x2iCosilLnRJOkDNWoI/P28OsW
	65Sbfq1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTqO-00000000D7v-3fDP;
	Mon, 12 Aug 2024 12:08:12 +0000
Date: Mon, 12 Aug 2024 05:08:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Johannes Bauer <canjzymsaxyt@spornkuller.de>,
	linux-ext4@vger.kernel.org
Subject: Re: Modification of block device by R/O mount
Message-ID: <Zrn7LBE8ek1dXIAn@infradead.org>
References: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
 <Zqrqo1lIrsxdm7AP@dread.disaster.area>
 <bdf2626f-580a-4af2-9fb0-5e3ebe944f95@spornkuller.de>
 <1cd11635-4015-43e6-8c8c-db5e2f029536@spornkuller.de>
 <ZrV15hAK0Lawyl+8@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrV15hAK0Lawyl+8@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 09, 2024 at 11:50:30AM +1000, Dave Chinner wrote:
> You'll need someone who actually knows what metadata ext4 needs to
> modify directly on read-only mounts to tell you exactly what the
> mount is modifying and whether or not it should actually be doing
> that or not. However, I personally wouldn't consider this behaviour
> a bug if it necessary to allow read-only mounts on read-only block
> devices to work reliably...

Modifying page cache without dirtying is in general a bug.  On a
block device we'll mostly get away with it, but it still is asking
for trouble later.  So this probably still warrants fixing, but as
Dave said it isn't exactly a grave bug.


