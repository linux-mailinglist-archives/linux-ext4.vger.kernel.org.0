Return-Path: <linux-ext4+bounces-8341-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E06AD2C2B
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 05:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6DD1893083
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jun 2025 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE31259CBF;
	Tue, 10 Jun 2025 03:37:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C62110;
	Tue, 10 Jun 2025 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749526626; cv=none; b=eLqudNjlNK1ycCjfZlJyBu+jfkcWDsbv1idFiHmGD3R8OniTB9uyYkgoXpi6kPXL8+sF8osZCV5Pdki50tnv4owytH7PhFHQxaGHA6kJ/559tRrBndA1ZjmCJXjFZMtLtJPwnCd9zpD1sjY7mYg97sMQo4+CgJ1ldHpZ4LjMQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749526626; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bha8IBYh5tpTaprFF8bxuHLXTrUnqY0lHMMRCZdTyXmdGVf5b197IlP1JITXT11Znam5/8j/+y7nrVW7q9NbqwdBHEmMVKA0hsY2rDemmuqw3IVopKQFG8fc0FSn0KK69ug5rGW5x4PCdqXi6Cr0dWQUq7oGpE5vl1n6GJedmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 236C568C4E; Tue, 10 Jun 2025 05:37:01 +0200 (CEST)
Date: Tue, 10 Jun 2025 05:37:00 +0200
From: hch <hch@lst.de>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, hch <hch@lst.de>,
	"tytso@mit.edu" <tytso@mit.edu>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4/002: make generic to support xfs
Message-ID: <20250610033700.GB23813@lst.de>
References: <20250609110307.17455-1-hans.holmberg@wdc.com> <20250609110307.17455-3-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609110307.17455-3-hans.holmberg@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


