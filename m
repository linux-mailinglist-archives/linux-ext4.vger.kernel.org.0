Return-Path: <linux-ext4+bounces-2032-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208588A15BE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD8F1F23101
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76F214D431;
	Thu, 11 Apr 2024 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdZr9owC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B814D29C
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842661; cv=none; b=l2yUvHzyDE1JvCDZ5HTICM41GczjmRihVeLrWoaGOmTvSbCYFUwDCkK0l0b8t36ovR8aBicSF1NglmzafJ+Ft7G3Dc37CVReZBmlaJEzv9qlUKhYINm10YKdECAiPe2KkTwE7H+E6yUDhxpaDuBj1FJLPskjb+It4Sb0UkGZGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842661; c=relaxed/simple;
	bh=DIAb7MBg/O79YuapLR2aNqATub3e0SOKNJsfHZ2b5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTrMnb5FRXtm94UsYKE2a8d1FoXg79n7KZoifr0F8nvtw+3zYA0EcJyc9bjfDYyY+i49jjG706IdyLcwBz61MmdiuoQ8JZRcbyLkGkVY7Fen9DQ3nQYux8lPZyWdXqDZgIIHPch5IRCuDbfpFmynlZhW2PeNof9qK7ouYceII34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdZr9owC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712842659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dERZePAMGY5Ogff4MXaSm74/ezvcT6trwfEdO0OfoQE=;
	b=VdZr9owC+8APMHB3glMhT0+GoERpECKD3T8BC9YDTW+BJl57CNFRMO+ue4QDnRUrcWeMuZ
	ogOpAwkR6EDGfNM1AaYWrlhS90kr1hA+0RbvzexO8WZ5a6XXzWvfDiYselGKQlpYveZ3Bg
	Yatf18y1hEBa8VAULB2o0YbXavYuV0k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-xbC2Ob5TMJ2u1w8JoC5gLg-1; Thu, 11 Apr 2024 09:37:37 -0400
X-MC-Unique: xbC2Ob5TMJ2u1w8JoC5gLg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-434ed2e412fso11561831cf.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 06:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712842657; x=1713447457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dERZePAMGY5Ogff4MXaSm74/ezvcT6trwfEdO0OfoQE=;
        b=LOIxNU1/aFRYnw8mVMSinbxeLBaHTY+x0HbJr2Mn9207a5n9XS3xjl56E88zEktYQ2
         hxQOGq9rfIbrtGxVuCk94l8EGq2bPQd9o4eeVKS8Rq9hkj5d2/nPV6Qt2Ma8SMH9/Fu9
         6lqlNTT80vhoqA2/UGTLicQmZgaaU2nfVlJWSTNTrjnqpaHsmc6vbwR2/amRuyGdi9p4
         3ZE6MwFaiten2j8XoaSBnHLG3ufNBfe0ShS0nvoUpBw99YrDsfynjKJyNC4vSM0O0d1R
         I0BGZNOT/COCqg9YNSxRpSKBcU4KmKjtHhIajEatIkvd2KTCYcM2GxqBL9LgIJMaEjtS
         b13A==
X-Forwarded-Encrypted: i=1; AJvYcCUGI/6//0TNwzq3OD1n/QQCtOlBfrDaUpeOPJLUHVpBW4xkcVyQs8+ut0wDl/uA8bjYxtXxtaJw+tqnRjgy5AmQq7iFbtI+H2GLhQ==
X-Gm-Message-State: AOJu0YyAJd5KbDOh+f+QqPPEePZLSLavGNr0W9evV+/WEEPdiDu0Lh9p
	BwjBR/vul6OJeIAsY9fFqXT8SFmk83K3EdDu3rlg26aECDtY6q9/yTIGmVaHvVJ9pOpb8l5MNM0
	aSXRGWnDg+jr2JP6R25qgw0b+bheX0RTPUENfEfHNd+xKWgYuyFm9pwwh5SA=
X-Received: by 2002:a05:6214:da1:b0:69b:1833:598e with SMTP id h1-20020a0562140da100b0069b1833598emr6052237qvh.6.1712842656864;
        Thu, 11 Apr 2024 06:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ6y7GR0pZzFXXvPoL0L/gLuIw2bwjbZR6CEdv4NI7c2F2dzHLnZvnROzJ8bJwU9WvPh/HLg==
X-Received: by 2002:a05:6214:da1:b0:69b:1833:598e with SMTP id h1-20020a0562140da100b0069b1833598emr6052197qvh.6.1712842656337;
        Thu, 11 Apr 2024 06:37:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id e7-20020a0cf747000000b0069943d0e5a3sm946973qvo.93.2024.04.11.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:37:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:37:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com,
	rcampbell@nvidia.com, willy@infradead.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 02/10] mm/hmm: Remove dead check for HugeTLB and FS DAX
Message-ID: <ZhfnnYfqWKZn5Inh@x1n>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <e4a877d1f77d778a2e820b9df66f6b7422bf2276.1712796818.git-series.apopple@nvidia.com>
 <20240411122530.GQ5383@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411122530.GQ5383@nvidia.com>

On Thu, Apr 11, 2024 at 09:25:30AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 11, 2024 at 10:57:23AM +1000, Alistair Popple wrote:
> > pud_huge() returns true only for a HugeTLB page. pud_devmap() is only
> > used by FS DAX pages. These two things are mutually exclusive so this
> > code is dead code and can be removed.
> 
> I'm not sure this is true.. pud_huge() is mostly a misspelling of pud_leaf()..
> 
> > -	if (pud_huge(pud) && pud_devmap(pud)) {
> 
> I suspect this should be written as:
> 
>    if (pud_leaf(pud) && pud_devmap(pud)) {
> 
> In line with Peter's work here:
> 
> https://lore.kernel.org/linux-mm/20240321220802.679544-1-peterx@redhat.com/

Just to provide more information for Alistair, this patch already switched
that over to a _leaf():

https://lore.kernel.org/r/20240318200404.448346-12-peterx@redhat.com

That's in mm-unstable now, so should see that in a rebase.

And btw it's great to see that pxx_devmap() can go away.

Thanks,

-- 
Peter Xu


