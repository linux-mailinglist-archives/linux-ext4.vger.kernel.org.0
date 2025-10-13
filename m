Return-Path: <linux-ext4+bounces-10852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93462BD3357
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 15:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659F14E0F3C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D0307AEE;
	Mon, 13 Oct 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKRLzPXZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CABA307ACD
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362226; cv=none; b=EqHaoO9gWmdtzkN+5ju6odMN/Jixayvn3zx3k+9WcZCr4xRnl8Op+4mUXfIVx7W8TRFxEca4OFMoHcZRUhmEoOnno0pdCDyrGTmgAkrxe4t//J0taO7KFpVy8E2fucOxOVYcneLySdnp0l7XI1PWLlE1uDlizM9vW5N0bLubeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362226; c=relaxed/simple;
	bh=pYKv/ZHAQal8b6v/icrawjp0xeugJB+Yhx7Gqtpqskc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdD0uO73ckjAn/nCYrVI1q3+ASUov91Qzz/a7RH/sk2T3XChpkQtwM3a+jD2jNnI3dO9KRoM2/p/McdkeGEzzhY+Y++iKvPB1zSnWHQuRfW5TFPnQL4/JmM7M5S9BMI1lxo4WDqa3IW73xh8z0B+xGs4+TR64V/ZMuEyx6YBtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKRLzPXZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so50936175e9.2
        for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760362224; x=1760967024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZlmO7Er2VNfUt2lW8HD8G8xjeR52/0o/FyblKyrXi0=;
        b=nKRLzPXZnQf9ilLT2raNaKwPMG6B8Vee1uWqwMVCnAKqSukvQpx/qcvB400LvbTRYx
         fDZe5SHGtw9N/OmQD1fp+c20mNiIoCa7S0RTxayO7va4bk0AYZIOyHwbOj4vNB4tb9lN
         bDY5zZQosZZ3k6ApeKSFrEUwzob5gRGlEPeWCe+hfRjO2Q4+2xbXi8K5lIkkNpIQxvYy
         V8OGvKAJ6FdFO0bcqmacw5NecjeQUrtEPOZoUl8g/Buiy3JLKQg1IuddCiXv65nA1IlB
         jsEr6eXzXiqQ7TnC3MZw/sBS5/L3XBvLIZRHM2jk0DCOxNJHcyWKzuTSIlA8saTZEdtO
         vVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760362224; x=1760967024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZlmO7Er2VNfUt2lW8HD8G8xjeR52/0o/FyblKyrXi0=;
        b=GxrgLqNmJ0d58oTV4kKRzXI+8LnbtFnBHoVfeXYEe2v0E6lxTxGgog+ABJIPcMSC7/
         hsclMiPia0fVa2WGIpi+q7xhbcsHa8Gj/Mw0PD9/jguf2nZ0XcqfQzC32FSqghi4LD5g
         Ahp1xhKKSw1SGOyTQ2TyduZn7W6E3I18niaWzPQNlu8i95adCROT+bDFWdXqDveB8YI4
         LIvMIR4xGMV3P4ytO+wrBPCrhZGR4mi43socJyshgyh14yHildtk8sHXeVr2XyHvyKfw
         RPvV2dM3SW70vvZ197u7SDho/4KiIn7bClfNSMZDDjEuYi8NxlqHuFFmAcJlLvMUKyN9
         zYaA==
X-Forwarded-Encrypted: i=1; AJvYcCXaUSCVuy7COAzqUbN03vRoyBnb0JKJ0nfFCoD09TJjUZ+Wnxr0FCOI4RRyfdkE0SXL7a0SWF3UtPfs@vger.kernel.org
X-Gm-Message-State: AOJu0YykEfYf07myMlnkM6p35qhBr6MAr2rkkuWZ/QaQdD2T4CSG7oJw
	gL6NAhGG6lmWCGvwoAe+qqAWwa30eAmQHBVw7JUrdSwCb+1M7jTZ5jBt
X-Gm-Gg: ASbGncvjBXTR/PjvkXeRXYREOITj7h3gvJRvyFCXs5h8WtNZrJZhAbz4++8Ep3ZjdmS
	afl9BkeDGqvLX9yeHv33kem0UMb+D7IN1gIP1K/owoQcdys7yR2eS4ZU1hwt+8He6hNPlLQyRJm
	DWX8+89CB2rGCWWItciQWMvrPOplYWXP8nruTj24p09VkOL92p9A11lufvUXqjD/Yg0cI6t4MBO
	1FWPYHumNKN0msPTzCe8guDCGDFgsXqQ7Cm8E1zDLrOKgesfFbK5ecZFkTV3hk1m/ESBRLqgSzH
	wu1RUcYcdrBcyhmKkJkSX1VyDUGoHWphDrtYZ+6Ar6QU1PzmeU/E1sWnUij20+HtjhaaiJVkVtc
	RIfzCV2uLfxWncMG8ot3J8Dxd4OAlIti+e+TxbQepZqfi7a3QFpZTzzAauw5syPwV7wCz99M1Kn
	j2cUVCJ2Zv
X-Google-Smtp-Source: AGHT+IFb8vtBJitNnjBlDbVIUCm2gATTzzIuI7S2acOd2FoeBSuIxAzk1vmdrirRWyHwbC1aiC5zwg==
X-Received: by 2002:a05:600c:6092:b0:45d:e28c:8741 with SMTP id 5b1f17b1804b1-46fa9b02e5amr148223315e9.29.1760362223296;
        Mon, 13 Oct 2025 06:30:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49c3e49sm185108555e9.16.2025.10.13.06.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 06:30:22 -0700 (PDT)
Message-ID: <d785cc8e-d8fd-4bee-950c-7f3f7d452efc@gmail.com>
Date: Mon, 13 Oct 2025 14:31:32 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] block: enable per-cpu bio cache by default
To: Fengnan Chang <changfengnan@bytedance.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: fengnan chang <fengnanchang@gmail.com>, axboe@kernel.dk,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 willy@infradead.org, djwong@kernel.org, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20251011013312.20698-1-changfengnan@bytedance.com>
 <aOxxBS8075_gMXgy@infradead.org>
 <CALWNXx8pDOvDdNvw+v0rEyi33W8TL+OZW1YiFbF6Gns3PeWOLA@mail.gmail.com>
 <aOyb-NyCopUKridK@infradead.org>
 <CAPFOzZumoCERUj+VuegQNoAwFCoGxiaASD6R_4bE+p1TVbspUA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAPFOzZumoCERUj+VuegQNoAwFCoGxiaASD6R_4bE+p1TVbspUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 13:58, Fengnan Chang wrote:
> Christoph Hellwig <hch@infradead.org> 于2025年10月13日周一 14:28写道：
>>
>> On Mon, Oct 13, 2025 at 01:42:47PM +0800, fengnan chang wrote:
>>>> Just set the req flag in the branch instead of unconditionally setting
>>>> it and then clearing it.
>>>
>>> clearing this flag is necessary, because bio_alloc_clone will call this in
>>> boot stage, maybe the bs->cache of the new bio is not initialized yet.
>>
>> Given that we're using the flag by default and setting it here,
>> bio_alloc_clone should not inherit it.  In fact we should probably
>> figure out a way to remove it entirely, but if that is not possible
>> it should only be set when the cache was actually used.
> 
> For now bio_alloc_clone will inherit all flag of source bio, IMO if only not
> inherit REQ_ALLOC_CACHE, it's a little strange.
> The REQ_ALLOC_CACHE flag can not remove entirely.  maybe we can
> modify like this:
> 
> if (bs->cache && nr_vecs <= BIO_INLINE_VECS) {
>      opf |= REQ_ALLOC_CACHE;
>      bio = bio_alloc_percpu_cache(bdev, nr_vecs, opf,
>      gfp_mask, bs);
>      if (bio)
>          return bio;
>      /*
>       * No cached bio available, bio returned below marked with
>       * REQ_ALLOC_CACHE to participate in per-cpu alloc cache.
>      */
> } else
>          opf &= ~REQ_ALLOC_CACHE;
> 
>>
>>>>> +     /*
>>>>> +      * Even REQ_ALLOC_CACHE is enabled by default, we still need this to
>>>>> +      * mark bio is allocated by bio_alloc_bioset.
>>>>> +      */
>>>>>        if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <= BIO_INLINE_VECS)) {
>>>>
>>>> I can't really parse the comment, can you explain what you mean?
>>>
>>> This is to tell others that REQ_ALLOC_CACHE can't be deleted here, and
>>> that this flag
>>> serves other purposes here.
>>
>> So what can't it be deleted?
> 
> blk_rq_map_bio_alloc use REQ_ALLOC_CACHE to tell whether to use
> bio_alloc_bioset or bio_kmalloc, I considered removing the flag in
> blk_rq_map_bio_alloc, but then there would have to be the introduction
> of a new flag like  REQ_xx. So I keep this and comment.

That can likely be made unconditional as well. Regardless of that,
it can't be removed without additional changes because it's used to
avoid de-allocating into the pcpu cache requests that wasn't
allocated for it. i.e.

if (bio->bi_opf & REQ_ALLOC_CACHE)
	bio_put_percpu_cache(bio);
else
	bio_free(bio);

Without it under memory pressure you can end up in a situation
where bios are put into pcpu caches of other CPUs and can't be
reallocated by the current CPU, effectively loosing the mempool
forward progress guarantees. See:

commit 759aa12f19155fe4e4fb4740450b4aa4233b7d9f
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed Nov 2 15:18:20 2022 +0000

     bio: don't rob starving biosets of bios

-- 
Pavel Begunkov


