Return-Path: <linux-ext4+bounces-2033-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 124AB8A1639
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F912B2604F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1E14EC5E;
	Thu, 11 Apr 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qnr472qY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAC14E2C5
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843164; cv=none; b=qPUyW2DkakKl/D3pTayBRzB9jN9Xh9v7/GYad8elibjYm1kcS4cG77+h6ZsMFtNhc2Zf1IFVVRkTyQiNdVy+Aqv123KkJ7Ox5tEdCZR026ze+NYDr3wzu5QXJvwu0Q634U20Kj6tXyRD96BU5lVjdzMs3kREU/QlCH8++vfhZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843164; c=relaxed/simple;
	bh=Cbd/JWEjqPlGu1by3uygBOshRGfgss8BPdmBpj3a8d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ji3uZ0d0d0eemxjMKN0i3sAKBB1eMag6rCdON4CaCVZ4VWJEol3Lgp3BjpbecH2wN3zKRbU/+K4VRvweljoWCALkYLRcuNSesgk4aNSyba2qszgpT6zBnIqnabiYzY/+PpI63k2i+YdbxF0zHPigZoPzYhKvUvbaRQmLzgwcS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qnr472qY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712843162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F7Urs0rDzbqxItHnrZ7ae7xENmqnSenFgbOKlg0MdQ0=;
	b=Qnr472qY2PnQgPGhTQUtcmwNobkyuNTCWxDR/mAckKUjlVqYFGiKvcOSr5FwpbcVXlFrAL
	Lg1+UuOWZXqDIwPvgnHgRI+/z2EztkGE5ufYFTrdLbjRn0rkcfxiEojA/k5cYXA3xA3N7C
	LNahx/CUU8WqjCV9nyVgq0HeTX6DOX8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-OFPWVcyVNZCdTW10mj5URQ-1; Thu, 11 Apr 2024 09:46:00 -0400
X-MC-Unique: OFPWVcyVNZCdTW10mj5URQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d86a38bb94so58527591fa.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 06:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712843159; x=1713447959;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F7Urs0rDzbqxItHnrZ7ae7xENmqnSenFgbOKlg0MdQ0=;
        b=OBTkj7ARYe+Vpooj50TZF2afz5RiVZeNNkThl/LJpA1PPnan6DjlXVSo/wak1tt/UG
         +atjR16zfgKMavAJPLuXU+6HtVjnMkuyacj9S0JUsnKL5TSka8hh+RCSmL+B9HmXky/4
         oHT23wuzpf2jzzwtnLNi8HRZk3GDTgJWXWuN3RipSlFsaUC/k56L5oSfV4Bo+bSGusAo
         m6nj68QP11BSQPotv+c9FqDvf3iHKz7td9cLMtY3/QxOFg5EMX65zXPEr/S+n56gPcbe
         USLLMJOxK9ch9u6UJqk0fZGJlYvwYNQ6uylk9xFCXoILdMkc//wAz4AtQAfEBD62y7qN
         I6hg==
X-Forwarded-Encrypted: i=1; AJvYcCUQy9YvSAr/r/zCqKu4VJKyU1iz7d6BVtxSxE8rpHvB1rRgFiUNnorXZPXNl+tq1m8b0AVPu2rcNF848C6BgfyLFX1L2tK9FSjD6g==
X-Gm-Message-State: AOJu0YzuxIjdiBaB11kGRGi63nw/4S+jlSJV3LAy8zH+tnjPrzZc8/M/
	EDGdogpzrWlOYPvtBEWiXALQ2w7NlcempdyozQr/V7Luqsr8h+BY+g2OB96dKQykqbog5/iVV/m
	+TwZv52mhlt0PaFQC7JboaipAda9TIAmK1T41hXQeiNb6Us6Tg2gxmaFyLtk=
X-Received: by 2002:a2e:bb8f:0:b0:2d8:60a4:cfa with SMTP id y15-20020a2ebb8f000000b002d860a40cfamr3198622lje.41.1712843159357;
        Thu, 11 Apr 2024 06:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoohYbmctnHgVhi1eqtPtWYp69R/AxHOo1KVhWBe0vqP8HvCmImItbhaUhpGaoXJpn7qNHLw==
X-Received: by 2002:a2e:bb8f:0:b0:2d8:60a4:cfa with SMTP id y15-20020a2ebb8f000000b002d860a40cfamr3198599lje.41.1712843158943;
        Thu, 11 Apr 2024 06:45:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id jh4-20020a05600ca08400b004147db8a91asm5427425wmb.40.2024.04.11.06.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:45:58 -0700 (PDT)
Message-ID: <ce3ea542-9b68-4630-b437-c9daddad2e83@redhat.com>
Date: Thu, 11 Apr 2024 15:45:57 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/10] mm/khugepage.c: Warn if trying to scan devmap pmd
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: david@fromorbit.com, dan.j.williams@intel.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, willy@infradead.org, jgg@nvidia.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org, hch@lst.de,
 ruansy.fnst@fujitsu.com, nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jglisse@redhat.com
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <68427031c58645ba4b751022bf032ffd6b247427.1712796818.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <68427031c58645ba4b751022bf032ffd6b247427.1712796818.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 02:57, Alistair Popple wrote:
> The only user of devmap PTEs is FS DAX, and khugepaged should not be
> scanning these VMAs. This is checked by calling
> hugepage_vma_check. Therefore khugepaged should never encounter a
> devmap PTE. Warn if this occurs.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Note this is a transitory patch to test the above assumption both at
> runtime and during review. I will likely remove it as the whole thing
> gets deleted when pXX_devmap is removed.

Yes, doesn't make sense for this patch to exist if it would go upstream 
along with the next patch that removes that completely.

-- 
Cheers,

David / dhildenb


