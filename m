Return-Path: <linux-ext4+bounces-5540-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A559EB1B1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 14:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F80188879D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED94E1AA1C2;
	Tue, 10 Dec 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjQpTGYa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A41A9B35
	for <linux-ext4@vger.kernel.org>; Tue, 10 Dec 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836412; cv=none; b=Yki/Dsw/RjqshmCU5hgZsqLXJb6dCNRYfhMlR8sT9ZRVcT9APPO+axb6eWxX+8WhofILRW833IgWIqEdv4dvkc6X49iso4XhPGeScFyLSVQ61LHMeb+mtODqnD6wWnS1Y+zzB3+GDADmxoc3OqQ4JycrfHFk/DiWF8ufPzAjhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836412; c=relaxed/simple;
	bh=eNudwZIOhp5UTkp15VtjWBMJ32YbnaqZEMTYObFNEpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSwn83JkBiRFT4Ivsvjry9yTioOHwGivTmzmDB7cCnX6SwRrtRJVd05AaQHKM/OOKBX9yDFfMWWqxmxPYsfw0UGS0Y626IOwr/kPyIbQevqluoPXoi1d2VJUZ5IuR5iqfJAcoRyqo/ZggjlJm6kdDBmbs3m3xKbnrrfS5+HLKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjQpTGYa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733836409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WD/Ab3dOG4KyeeZcYiAMWWJNGYnEmp5W/qh/uoSkm1E=;
	b=MjQpTGYapKPjOOX2feQ0YMzqmiMo7P+iJ0CNDuIAabZW7gpv/Tm0sO+m86BMeeVlLW5Ux+
	1+q9xTSKqyWgX4RdK2evqYSAehVkpVH5ZuusVXQTMXC9QadAKzu6NJD29OqgbBrgZCXdqb
	UmwjtIl6NLHtG+uRuwZmprSfxxMEDRQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-qvToNrIjPBOM8KeZ9kk-hg-1; Tue,
 10 Dec 2024 08:13:26 -0500
X-MC-Unique: qvToNrIjPBOM8KeZ9kk-hg-1
X-Mimecast-MFC-AGG-ID: qvToNrIjPBOM8KeZ9kk-hg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20319195608A;
	Tue, 10 Dec 2024 13:13:25 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B32F195605A;
	Tue, 10 Dec 2024 13:13:23 +0000 (UTC)
Date: Tue, 10 Dec 2024 08:15:10 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] generic/363: remove _supported_fs xfs
Message-ID: <Z1g-3jUKnObTqjWj@bfoster>
References: <20241210065900.1235379-1-hch@lst.de>
 <20241210065900.1235379-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210065900.1235379-2-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Dec 10, 2024 at 07:58:25AM +0100, Christoph Hellwig wrote:
> Run this test for all file systems.  Just because they are broken doesn't
> mean that zeroing should not be tested.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/363 | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tests/generic/363 b/tests/generic/363
> index 477c111ccb60..74226a458427 100755
> --- a/tests/generic/363
> +++ b/tests/generic/363
> @@ -13,9 +13,6 @@ _begin_fstest rw auto
>  
>  _require_test
>  
> -# currently only xfs performs enough zeroing to satisfy fsx
> -_supported_fs xfs
> -

IIRC pretty much every fs except for xfs failed this test when I wrote
it, so I didn't want to drop it on folks until I had a chance to look
into it. I had pending ext4 fixes which appear to have now been merged,
so on a quick test of -rc2 this now passes on ext4.

I haven't got to the others, but if it's particularly disruptive for
anybody I suppose it could still be excluded easy enough:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  # on failure, replace -q with -d to see post-eof writes in the dump output
>  run_fsx "-q -S 0 -e 1 -N 100000"
>  
> -- 
> 2.45.2
> 
> 


