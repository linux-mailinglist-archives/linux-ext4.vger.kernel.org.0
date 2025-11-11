Return-Path: <linux-ext4+bounces-11759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F4C4CAC6
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C296A34EEC0
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Nov 2025 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82A42F12DD;
	Tue, 11 Nov 2025 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KD2iCn+S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA623D7D8;
	Tue, 11 Nov 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853526; cv=none; b=kmfeEEQyUTaivH1lZZ356Y3ToQRAB609w7W3W0WfpipuJLZ5KKNlC/Xs73sxg4kyu/4erwVwa30og3VsUNp97OaWh9TvgrNmO3L7+12PIvz8FSIG1h7PuiTNg4KbY/XIYVE7QngxSo0Ww/7hC/nh7gbs48lXdoQgRNOQHd4yj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853526; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX6JZ3bdMQcxoH7rZX0Tz5vFc+KPxlxnoNLtBy6frKI8NfOUMQXwEiK8Y3n1k1ly612vd0KgXIaMCtcaF8NX8OYgHcKVLeZ6zJWwOM1Mhcex9hDH1gId6bEDHiZoH5xdGF6gki91Ex2EVYgvMwefstmTVyG1f/ajumhYM+DUVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KD2iCn+S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KD2iCn+SgbF0ZdME/bpDwSCrel
	BQskLcVvhzm9/IqmkV7HpxyACRsr7AYl4Q4Jl8M430u6smnFydWQJjSVivyphyVv/SkcATESteuCX
	4ars2BWCTZASUZuRxqyWvig8O0CokVcRE6r3R2FChUSCJf4aoza7NILgmMExsjQ0US8vQMH8ndoFx
	uc91Z7BGn6p8TxbB0A7FnoEIiE2aIL607yZlyffLq0tjKUcZXwNOreLak+Qiz2lirqahf5ZZVNjU+
	MgHdaB+YMd+1d8ZX8qZY7+SpWA/wO3W27XQjv3Ap63qGor3zWjoq0PzVihR8FBZgHbIfn3toDkPFm
	2SSATm9A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkjM-00000006qwS-3kF7;
	Tue, 11 Nov 2025 09:32:04 +0000
Date: Tue, 11 Nov 2025 01:32:04 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] generic/774: turn off lfsr
Message-ID: <aRMClFX2zZHM59uo@infradead.org>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

