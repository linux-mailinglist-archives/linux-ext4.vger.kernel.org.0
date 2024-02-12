Return-Path: <linux-ext4+bounces-1193-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1AA850D6F
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Feb 2024 07:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9D41F23460
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Feb 2024 06:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A57462;
	Mon, 12 Feb 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kePfteA4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82C6FAD;
	Mon, 12 Feb 2024 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707717755; cv=none; b=WYfZkGDOM/lAl84M8v3fO6txltruFrFGq4fkRifNCKSCLhXajPztiR8kIKWkLzSbr/NNDCrxLPtR9vQ8MEnb29AzApBY9AkDVyTeNXgywNsfcsLmnNoEFzIVHTH4H8JchBN6hNSXbipu2p4+JLnVBPW33erp7sLl3MEmBiZd8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707717755; c=relaxed/simple;
	bh=r3ujuO0COn4/CEoshVZMVfrelu9cvXTDs8XEyBmSehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3EeHKa+VVD3tDINz+cZEAuwdvJJBUM6RYCfqrUUJA3Py1rAelK4rTJHItP/qzqHqK673YmM2wtUyWWN+jthURMrUD80B/FOwVG4Fhy7Js8h53v5Qrrbhii3gknxtXrNaM2cIO5dLjdhmvZ+epAyj40ouLPO9RdiziRgs6r+A/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kePfteA4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r3ujuO0COn4/CEoshVZMVfrelu9cvXTDs8XEyBmSehc=; b=kePfteA4/7o2gcIXYog6poOr3S
	0tmBFcKXTWgy4TVcMkJclzXQOn4QaOwg3CZw471H/pmqhJWuHjm0TslkfDBg8z2Nngn1Ueaj2cKwG
	OBep0doQKEKjr/Ylus4Whg2547R6xFVEvss7s+qxGcijQcBgAd1JQ6g2JrYA99tduET/bbkEFkFNi
	pJ7nM1AImpwhGN8me5OZ57BoIjStSGZCv9KFJXzFQSc7Nuc1LMYth6Y8fNFl2gFlQaxMWYxdUqkVu
	kSwGJ3xlP65zYhoF3AoIL6596ty3N105npaBY78uVbxhnL4AHAdexHfox9AoaP1ViGipDnG2pO4dx
	dzRMzbEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZPOd-00000004NKX-2W3E;
	Mon, 12 Feb 2024 06:02:27 +0000
Date: Sun, 11 Feb 2024 22:02:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, willy@infradead.org,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v3 08/26] iomap: add pos and dirty_len into
 trace_iomap_writepage_map
Message-ID: <Zcm0c7aMoWp7mPST@infradead.org>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127015825.1608160-9-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you submit this for inclusion in the vfs tree?

