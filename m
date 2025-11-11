Return-Path: <linux-ext4+bounces-11756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49887C4CAA8
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F6B420696
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D12F0C6F;
	Tue, 11 Nov 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x+zsPyO6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63B228CA9;
	Tue, 11 Nov 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853355; cv=none; b=AihxMIPPkAoTV9NUFz4r77qKhHvwgIt7NEx+QkKJqYQApMrMwG7AbJtwkXR3Yt03Rll8UP8IpV8ngyCwwhdK1qC9NZDuXkMVd+9NNwWKLJTCVLwK9EO45YWeBwPqd/aHZfgTjlzbooN/MAx/gefYBbFAd+FpJk4RKE5WQ8bd05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853355; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJXf/Bd9sDxVphlhFjreAJxLyRyx8x+ES0It/AdedDmPpAIVKnnKyhuwyBmeDYTyby+8Xkx+m8kXrJaorBAB4pvkm/94oRf6uH/00i7xxEYDftqoyXHWLeorO+RDTS4iAKzlmspQu64xNesmdhK22OkQC8/Br+yerl1h0jsub+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x+zsPyO6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=x+zsPyO6YjeeU62NlqCZBLxTD/
	mzu71SlTlESBFXbK06M/L/ubV0hFE32bpz54gWVuJ9yLRkzT00eqbUX3jJqzBFYmzs9ycknYy5IzJ
	rUWehJYB8sWnU2esY0tu6RiDme7gahMwBF7aKY9qJXj+wTojxeMaV3bmYM1anqsg52NIcmTsyFYKJ
	HzWxsWLTOtYV7IwJAAh6JVD13QN9d/g5fZKBcrNUtIydJ520p08TganXRILQJ80qHw9vnW0MRbo4/
	Cs8rHmZlT2p7wnSi6IzFmb3jii7h9cqT7H1IgAaunEjfl4b9ogiIMqOL0lWpZQGGXE3e5Psjcxe/x
	+wrM+VxA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkgb-00000006qSF-0yVO;
	Tue, 11 Nov 2025 09:29:13 +0000
Date: Tue, 11 Nov 2025 01:29:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/7] xfs/837: fix test to work with pre-metadir quota
 mount options
Message-ID: <aRMB6aXXfcIaY2Bc@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909097.605950.5129078568168785441.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909097.605950.5129078568168785441.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


