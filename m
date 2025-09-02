Return-Path: <linux-ext4+bounces-9780-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4119DB3F474
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0634E274D
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Sep 2025 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070512E11B0;
	Tue,  2 Sep 2025 05:23:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8A54652;
	Tue,  2 Sep 2025 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756790610; cv=none; b=a/xLe6WnbPUbIZ784V0A+wiqDd2oRAk2hcBCjOIXJQlKtO6c164x7UqNcDuh0aQps0vZvjzw/VdQOU8jWOLJXKOR+Uf1TXgWvjNIqN6QNrcDksuRE/ilZdh5+T+raBxDbAPojCQy6kaaL3ycjOx6ZGyZbEx62Yd5SNymu2EGv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756790610; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GntKq3EPWkZPAGwohPtYPVBT61wR7LncAnVnOR7YWdCrqRU5N8RQ0++fYk24pY5BilEhM9nJbhl4u4SoWUFu+ocsJzJ+m6eLSB4h33jRxYVWq9eCUnkFWVHYAbWV+UxQnvlKeUTnRiKxKCqguG6BCMtJ3hEcrz1YuGbwI4aGaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B613E68AA6; Tue,  2 Sep 2025 07:23:16 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:23:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 3/8] block: align the bio after building it
Message-ID: <20250902052316.GA11086@lst.de>
References: <20250827141258.63501-1-kbusch@meta.com> <20250827141258.63501-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827141258.63501-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


