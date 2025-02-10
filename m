Return-Path: <linux-ext4+bounces-6404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356CA2F77E
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBF61884A52
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77C257454;
	Mon, 10 Feb 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZh4WWDD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CD2566CA
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212895; cv=none; b=LI49aefoe7kHzZNFvC8l7B4enum+7LpxyivZxOv8+WunMeemtxX0zpte3Iy6bDbvVLDXfveJ3Dp84ymNBw3WTZgnpnZ0rKFkFnfCPqPCpTSRIKYDtG877d8N0H9ZmHgqw/9XSPOqvTeyUMK4pNy0HmSR0o6dobrb3tf42974fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212895; c=relaxed/simple;
	bh=bygnSuQXiuOQjyaBUGwyRn+UXTRR8Z74RGWMpAmL/Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIvDtwSwfVN5ViwWc8N+DCml+Mkz/NpLyU6EeflsPfJ2kCkzdEa2EOB48dGwTd6WRG4VIr7RKV8YqOlIGqMBWqFx+nhb0ns2pRI9XaQo40deM9PuuOalQkUenXHf42CwLy3GkGI1SQXPNzze3ccQr+EgYJ0T/I10t+t+eQ8+Jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZh4WWDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739212893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
	b=CZh4WWDDuQXu5RG4YFJr6NKOPmBfinLXe7+V8oJDUsYQwX860m5TBQHj8tM+QlpUbKb1iE
	WNwdbRcYc7c/Huk9FBQfItnkdx2pVyaJYWq0TSVSzBPUvyus+v8ieM8KZUVbe6oGDAB+Of
	yLx5xKY0LRlvsUAtpMU0GBlqBsBBd/o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-e_HAYXXHOW-fkcUcpVpsYA-1; Mon, 10 Feb 2025 13:41:31 -0500
X-MC-Unique: e_HAYXXHOW-fkcUcpVpsYA-1
X-Mimecast-MFC-AGG-ID: e_HAYXXHOW-fkcUcpVpsYA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38de0201961so791929f8f.2
        for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 10:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212890; x=1739817690;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5Y8uzPh19Vq/79ybTl3j5BilFyRa3IBZXW8XJ411wM=;
        b=wvoWg0ju9MlD4Uo3DxKvH4DTYjmE8GnxHxihBu2pDNZtk5TVHA6eKmIPAw8kLjPhJy
         kqRocrZkwMq20vRg6qEKsWzRteA3ueXyS2lM8i3HOtlOUBA8mzcAoKIb6ZetZrCsEHLG
         QIvJtnKsBWDJAkNT1eklpnIWQI+qzbA8EhIBBAOxE85uFADckFcJasfassMQTb30Ulyw
         WCGK0pi66QXv4cNxkAILLZd1vpd3k6bPIFeg23ssXBHwupG7iyTZg+5ByNI39IhKYGu9
         KN7O9NEiIkv5HgVjDroz+/yizxOrH7g1wab4ULKz2Frh3CQ3CQ2escp5A8W4wEaxnKFh
         vILA==
X-Forwarded-Encrypted: i=1; AJvYcCUi2ntfXo3RD3Aoiirr4BzkUTl+WUTDq938RWdJ9Qk0HeHaaLtD2Axk6Vh6HlnP0g2hoRMYDi+nsryH@vger.kernel.org
X-Gm-Message-State: AOJu0YyTF4947BiKu1fq2Ctej9yP8jSkUV7OA0EiQ6zBO0VU79kI3XE6
	d/JXDTdqFKOnlWTlwcZWdoxfPVEjz+Tt/VWPKjA/UxpQX4p5n5klYngwzF4tzIOJs0bfdyN9PF3
	0HOYEXI0roY+S6TGeqCttjLYG/w7XmUiY94Gl9EqHC0qIPS8DlN6oV4JyqRY=
X-Gm-Gg: ASbGnctJPc/0+gIhVJZ65WuBcQUKq8ZaVg5KbmawTKWchSQHUqqNt7qlfk7p1pYyL+F
	FleP0Nedui4arz2ZBm4Vc3MKV+GC4lQNKI8zM8Ixs262+8jfhJRkIF/XM3DTlpu1KjotP4DBJRg
	lxbeYnvrvE1xlBygI0ROmqhQswtULAQVBRTW7VY8SFhQfENOlIbyyuUOUk0sJI+y4Kw+bsxwYkS
	DPQIy2glRIHJMgSdaOhn+h7invPdA9wab0ySFV2lbc8jqMwk/6pYNA+k1ymFLfAVz1XYLc/eO/S
	mJ+5X+m0HeP2DEPVN+X/JBCgtulJaLtBHbY2dKo10mhlh+4+DSa8TVEdapjK0h4d/jcsNXb8sWN
	OOieOcgcowX6BxdscCQug8KhmgUY3pjEJ
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356778f8f.52.1739212890424;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjt5GOWnPQL8qWJWzWicp05/2CzwbVpqP4Iexee9A79WecGjReB/qxF3GuYmscVUvKpxlGrQ==
X-Received: by 2002:adf:f552:0:b0:38d:ba09:86b5 with SMTP id ffacd0b85a97d-38dc935fd30mr8356754f8f.52.1739212890044;
        Mon, 10 Feb 2025 10:41:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:b800:12c4:65cd:348a:aee6? (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd34f2af5sm7815443f8f.78.2025.02.10.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 10:41:28 -0800 (PST)
Message-ID: <cca05a6f-fbfe-43c9-815b-eadbdcd7050b@redhat.com>
Date: Mon, 10 Feb 2025 19:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/20] rmap: Add support for PUD sized mappings to rmap
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.472dfc700f28c65ecad7591096a1dc7878ff6172.1738709036.git-series.apopple@nvidia.com>
 <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1518b89f5659d2595bf9878da4a76221ffcfef60.1738709036.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.02.25 23:48, Alistair Popple wrote:
> The rmap doesn't currently support adding a PUD mapping of a
> folio. This patch adds support for entire PUD mappings of folios,
> primarily to allow for more standard refcounting of device DAX
> folios. Currently DAX is the only user of this and it doesn't require
> support for partially mapped PUD-sized folios so we don't support for
> that for now.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Nit: patch subject should start with "mm/rmap:"

-- 
Cheers,

David / dhildenb


