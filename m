Return-Path: <linux-ext4+bounces-7625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8886AA6B2F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 09:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEBA986682
	for <lists+linux-ext4@lfdr.de>; Fri,  2 May 2025 07:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBF266B7E;
	Fri,  2 May 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3qPibeow"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5A1F12F8;
	Fri,  2 May 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169307; cv=none; b=g7+uM5FLtOWoYV5QlW3BHGCFH+kBpoiL1eCeGCaeYjwgWogdqP2ZT/zKE+XymTpAsbYB1Nyj0I1jC7nu3En29Uwauu7TVS1Ckfv4/SFxv1aq5dbWc1txxUg9WlCQtdY9rY7pR2CqIQ2pi6T0mX7KgSDzEBOBccU/NeOo4cAB7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169307; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J38SRHp+TN67lmT9WCkqFUQZ0bEM2BNIkXxUtpOLGOyugI9Q+PXLqXyOXw3L5Pjz0c/OJjSmOfvFMaFqr+bx4/KzI/Uwky7j/CIijsXcPpdr9JdASlaVXFvJYn0mc9fRUoPd0ZSa2Hb9Maqga0D49VLmJv1EhipnGOWUkQtAOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3qPibeow; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3qPibeow0UVZbbecYMI1oXjmR0
	0TSBgfNwYcBf4exWzgqTqMyXh2mwwr7FMG9WlEZmjC64ZqH2szWauNJiMDBiMMEYWH/U0/JTUjivf
	3bAjzWQJ9oZg/kWAyPlpkskoASpg/B5sXBS3kMLujUJ0XPXEDnD4mVxBt3wFQ9FRAIFz4v/gcjii6
	SLtMdg/meXLbBeHjYuKHKwQS3n3aevX6YhnwVWv2dC8VKR+8AeZYpdI5FK05yXrZ/Kf5O2cFDfwE1
	Nm3e6tmzhmyH1AsVhx2pEWv/RB8LTvjNqQU2pfZ6ZD/G/vriZ72GEmja0xp2LnTYvB/gxAhgdqQ+t
	sCsVEgQg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAkP3-0000000131E-10Nh;
	Fri, 02 May 2025 07:01:45 +0000
Date: Fri, 2 May 2025 00:01:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com, hch@infradead.org
Subject: Re: [PATCH v3 1/1] xfs: Fail remount with noattr2 on a v5 with v4
 enabled
Message-ID: <aBRt2SNUxb6WuMO-@infradead.org>
References: <cover.1745937794.git.nirjhar.roy.lists@gmail.com>
 <a56bb4685df5f8f45308f6a3195390ad73b75709.1745937794.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56bb4685df5f8f45308f6a3195390ad73b75709.1745937794.git.nirjhar.roy.lists@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


