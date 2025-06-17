Return-Path: <linux-ext4+bounces-8475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F3ADC6CB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 11:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786B23B07C8
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B0296151;
	Tue, 17 Jun 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcsDhlyV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CD293C72
	for <linux-ext4@vger.kernel.org>; Tue, 17 Jun 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153063; cv=none; b=N73jmfI3FkemfDjK+Bz/cm8HCwBKwOv2iNDEPOXR9TUqMDWad1jaqhlFn26qO4X9JSOtHCcAm0yIOKs2uRiV5BjPCmdBxhi8KYRWLJQEjPttfU5+s6Pw1ykfc7b/aUa4CUvO+RNi47z0nH3uRBQ0jOwZeX1Yhx8psZMQeJW31eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153063; c=relaxed/simple;
	bh=4dKkLCw4bk4ek60+ugXGulWj9MacP7xMcntewdkIip0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtXicV+a43N8F4PFeXm6bcUrKy1UyUTSCHakPs2+CaRRePnvKOXML9qVG4dbMqoYMSkdvjxVc1zOE1nkrn6PSaLKSboKuSkmn5e47FDWP6GkmKGJFpDEv9QrOOnTAIfGh5U0sSx0VuaO2EQY6+tIt2+JnZaf36KJajcUP+Bes4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcsDhlyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2tVggpdHRMe70SNIVLjgFowvBJ62eIYbXphR2T3zCDQ=;
	b=PcsDhlyVvDorkmhP8uemET1+nb5ry+oepbX4PejvDmQD5bxIQk55Ka6kfk/Mv0rUhTDkQY
	q8FlvuPFuEg2kAGzM7CjS6GWG4fpE1KRBayUfCg5uRjpFueEJtuPkIqNVfqW8AACRSJRCY
	2ZwvWIGaoKqvcVOp7Yfl+uc7Dv0oZBY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-RzVFFCdMMpm0lil9fvfIvQ-1; Tue, 17 Jun 2025 05:37:36 -0400
X-MC-Unique: RzVFFCdMMpm0lil9fvfIvQ-1
X-Mimecast-MFC-AGG-ID: RzVFFCdMMpm0lil9fvfIvQ_1750153056
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704cdbso28374245e9.1
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jun 2025 02:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153055; x=1750757855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2tVggpdHRMe70SNIVLjgFowvBJ62eIYbXphR2T3zCDQ=;
        b=CEivpmZsJZU2XxgMlZxR7GB69cvuihQmCYBea/Ed6tMlQcuIJgyg+kzOtzShVR3Jq8
         QwsDt1Rghj6gpAqEWoroExwG6mQsbg6aDUk4c8PvAezuMhG/++Jiat1gMribN97enCQ9
         r4HPr7clxDkbmm7SdSOMcv/tGbnUJuZ97mlD0Rxp6Q73qTzn439ASOpWweToyWz3XmKi
         ebfcBDw8sIPLW4pFZJ48a6JnjXQRQNl2FcqG+qBJTE5OgsvfmwaQtBBQed/0o8kTVVA/
         YeLXvy/qrdmTtpnnX+Ut/c1MZYMgRxH3LgzX5rIlU84wH8GNoVkxFeEnd9blVCsMveAA
         TkNg==
X-Forwarded-Encrypted: i=1; AJvYcCX7m9mQDFMqwQWGsE2Ka4b5j2gFNDREz824uvX+f7V+uuKa5iYxNjYUg3HsmFdx3cAN9+Z9scWNKfpp@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmJVijSmOAMUUy0Kn8rPpD87sgmKTLTG0sPpze+Q3fpWq2pk8
	C02TmfavW+ik8ECkYXlvmKWaefOs5jfk7ybtbXRppozLd5RYOuAnaz4JWnSWP4fKSgQVQYzCWhr
	sg4P247YpFLBfzLVxRfm8G0im3p5xoZBOPtVl03fFIyuEhZs/yQNWt1VuBcO/WD0=
X-Gm-Gg: ASbGncsE8XV75NnVN9bquZRwyR5URLtXDtpR4ZVx1nk+zhBgStPx3DkRkcdc45qD6vA
	tU23KF2lNN5gS5EAT/50eTjuMWPVaq66Lg19Rm4qc3JKR9L5ADrZvkUlM5ve50+mvoSUGW0k8J/
	ih6bAKJ2d02a8aVYi0FzHIuDLIG7qhZu5i0JerGXWzgyagdbrxjvGGRhZGebIwh9JUsexzcLPAY
	9+L7nnKQEiiBV4Ht/eSOPkHK3V/5+8Po6Yt+HVrnHPaRDu+nSlRVzibWe4aCx9I+NMqx8bSebd+
	D+RB7fuWpAumlE3zI+1skrfqI8Pf/VIuppShfmt64ozYaL9oH0LPoJ7m1PTPCyW1SNP8rJpLlZd
	fknbcjidTo6lnFYUASJx6g4sBV4NOIN8rFnj3mOahG57+Ywo=
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-4533cad1aa0mr127694915e9.31.1750153055535;
        Tue, 17 Jun 2025 02:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE33mK7aAFnuzBQX82pmdkrCA/cX+3l1nAlm3F6BLNfxNOkhwo9+uvgQ5HQNw5b5NLLg7ZP1w==
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-4533cad1aa0mr127694505e9.31.1750153055045;
        Tue, 17 Jun 2025 02:37:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f31:700:3851:c66a:b6b9:3490? (p200300d82f3107003851c66ab6b93490.dip0.t-ipconnect.de. [2003:d8:2f31:700:3851:c66a:b6b9:3490])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm172776835e9.1.2025.06.17.02.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:37:34 -0700 (PDT)
Message-ID: <338a45b0-40dd-4c11-bbe8-a047559fb77c@redhat.com>
Date: Tue, 17 Jun 2025 11:37:32 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] powerpc: Remove checks for devmap pages and
 PMDs/PUDs
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
 dan.j.williams@intel.com, jgg@ziepe.ca, willy@infradead.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
 balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org, John@Groves.net,
 m.szyprowski@samsung.com, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.8d04615eb17b9e46fc0ae7402ca54b69e04b1043.1750075065.git-series.apopple@nvidia.com>
 <818b2fb2f2cf7450ecdd698f2fa019aed3be7b85.1750075065.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <818b2fb2f2cf7450ecdd698f2fa019aed3be7b85.1750075065.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.06.25 13:58, Alistair Popple wrote:
> PFN_DEV no longer exists. This means no devmap PMDs or PUDs will be
> created, so checking for them is redundant. Instead mappings of pages that
> would have previously returned true for pXd_devmap() will return true for
> pXd_trans_huge()
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


