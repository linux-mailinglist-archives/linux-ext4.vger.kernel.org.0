Return-Path: <linux-ext4+bounces-5412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9F9D91BF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 07:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF30164F71
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0F1684A4;
	Tue, 26 Nov 2024 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b7dDh3YP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5C13AA5D;
	Tue, 26 Nov 2024 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602469; cv=none; b=PyilcJkV8sGnElXZzefXJjuVCq9P9mos7rMDwVZo9QN2QdfQxi3NNYtkZrkFU/gb2ua0V8ybP7l4IQob/kF2SgQ0LO+J5gOYldY+vrCJQWrxJt7kqzBguAnapeLewULTQ9HXN6E3Gon9NnWajqYZGa+SrylpZwmEWRbZYVe8NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602469; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL2m1jBF3Y4YzbYcFcVIK4ByTDUhO7Gt2RtYU/kHkSeb+qWrNowXGzgJ9iw5SUiWVBs7ZgoDjkSJMocujuhLrtmlj5qsFzjzf/+fYFHwOCaw1QW+jvrJN1VD/0kSs3QmXN6jMgX5IAwxTJ/8MueBTpq5e/wd2MMdKa/fLAEHHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b7dDh3YP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=b7dDh3YPDOZz4m7GcswKVYyMlY
	0z+NIGEBlVhL4LorAPwTx36DCyydTfnz/Q4TasoJInl1RSWaXvBKMsip8QNjPH5bAjt/uwY6MoqC5
	Hy5Bqst7lL0/6+ld7t4+YtmR6/otT6I2t/E3gdQHrR41b2bcmYABXL5DkAcOWCPKydbE25jtQ1YWz
	4itZfLbJHqaV+qmbG8AhdGx3hVp4zMHcP1tj15gLEDfJ+GShADO7VjgMzb5RqGHIXXVuw1OXedGbm
	cY6zS3WZj7NjtAXV8xXsoGdwUdinumKdyhf5PkgaPaHikHqBeC0SCpVS5QU41YhfmmsVyPn+YLQ4C
	m2bC8lgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFp36-00000009kP9-0xuJ;
	Tue, 26 Nov 2024 06:27:48 +0000
Date: Mon, 25 Nov 2024 22:27:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v4 2/3] common/rc: Add a new _require_scratch_extsize
 helper function
Message-ID: <Z0VqZP7dIVVbBPNc@infradead.org>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e0f7be0799a990e2f6856f884e527a92585bf56.1732599868.git.nirjhar@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


