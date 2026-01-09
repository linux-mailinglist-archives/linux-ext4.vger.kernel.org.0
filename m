Return-Path: <linux-ext4+bounces-12699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79146D083FE
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31BF130D1C53
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7654358D19;
	Fri,  9 Jan 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2LN2Okl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9B33342E
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951087; cv=none; b=RcgRLqUf/KwnqL3AzTGfWAncPDAvcC5aICdFBb65R0mCamwDODYDgcUpC0SMTH5Kr3A6JoQaYS+GGWnnYPLXSL5GiZwUWOfGrdjTKERTdTvyNDN7bj7HOhLbULMaIZWT8pUDuUqiSK93wSQ7A2w/TrA7pNGnMH0KzJSEOwxByz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951087; c=relaxed/simple;
	bh=HOUvCNWeC/QU/EutK4DSQdm70DXyuV5GqGuLIHtLRCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSg2wPCg4AvgA+M9YnYoDf5+lmy5CARkYrpdDDOXZT+4vQxtKOzPEYJRAlJn2vcEuZOKCZzamD3h6zSpOzAJn/ZFuoADPNC/qohHJYqRQyzEjk9IwcWMrpo2KNeZEuzCS+g7JAIlOPmcwtnDjANoslCpTJFLtFge/0qvf1qgIcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2LN2Okl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88fdac49a85so42737926d6.0
        for <linux-ext4@vger.kernel.org>; Fri, 09 Jan 2026 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767951085; x=1768555885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mHnWhSbgGLtJHz6aBPfGHzXRQNyBXUT1iG+fdLJ00Bc=;
        b=E2LN2OklxhUTYxe+6j9IomTwaGFt4u6zrIA6Aa+MdSMWAEyj5b3BtJ0pjpb29hz85G
         kGz6Y8bJwA8+q/DK5FDo58IQd1gMpHuXQRbuI1Zre3YG3UpuLWwVjCe7YgQDhhFbbcq6
         Vj6VUNLBp/UFH5wCwhYQebaLqARoMRB70J6C7o+ubU/goqs6V6/M2b0NvHsrFAKh4lZf
         A4dMJ2TyszaH0Cy3HFLs9cuvDpUwMplU7cKZQVkr7Nfxe1r9QeqQrKlS0BNsEtjv6Is7
         C09rJyxDqvOrJ4ahdfxq3topIkRUzbKy3n8kZCp8YR8lGE/uUiEqYmcY+sdzJB+5H+i6
         GRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767951085; x=1768555885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHnWhSbgGLtJHz6aBPfGHzXRQNyBXUT1iG+fdLJ00Bc=;
        b=gWzbCjtmP5SaX2BJzICZ+ZkFCLyc+N1IFt9+y2RsLLDG2a3pQgttXHo8tCondCZb2C
         aebCNsosLmKjqo/No7mwQxlXI2v9WTzHjT/zPIWkS8dyEmdmZCAgh/tRMyZI1flMNx8P
         cVfwyvlI7faxd6IGh0tKlQAoyz73T/5jw6obquQStlbsK86fCuAxNstC5F2w8AjPpbul
         otL7I3oFy/WEFD9BHg16sG8t8p1XhQkIX8Jjnska+khW6MwZ2JcIaj6T0wW8H59YrLZA
         T9gXB40wP9S++9WsLD3PeY7r1jBvbs0Q8YUs4ui/Ib3V0lLNaZH3A5tiEIa5iHBRKmM1
         SpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnzwJm2bM2p+z/m+ZxuuVsRiF/a1lTZlApTo7eCwCUKzV7YtpKN/QYcOoJbSgK2mKRPcZHtP3Q7wCs@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnsYCjB23N+5xGm+6zIPsOgIk7kWQgtt0JpbHcrEWHEa4Y5dd
	ZvQFjjwvLmR70LDgxU9SwUmhZII0Z6/Svu568o/hrlxrCClYtQQxYO75hLG1QTXJxIwzOJIiptt
	JtRw9bFHj86E/BfseAt/L6zHTIFCRG/598u6zcDjo
X-Gm-Gg: AY/fxX772XkMVBrkRYMTXc84qsQp84C5WkybBdZgzxX6gbW2ouNaKDLBnRA6mQaNzqI
	FrqeK/ZVcOlRwLyM4D1CxHl1alUd94ESa3I2b+W8SZZPkBDmC5a3TqyK4Z2izE4kD9uGX/x4fWM
	vyX0zQ4zgM8XlfWpNkJtd0Q6Oxhzc1VkY2joUXZ5WShPyfPDSndSKI4NU14Jc2sYOVh9h6lt+yT
	plVdQf3Msag4V6qpv2vz4iq82XPQ8WTGaqTZeEBM+SQhVTRKO8wxb8PVXCVWw+TxH+tAEY=
X-Google-Smtp-Source: AGHT+IFuFRZsFV/d44doIWgLvsMS/CZDqe4Cye+eagGw1hb+ysMh9BDNkivJ6fQHv4v5oqRYdhbNmI5coNvj7Pn6Sz0=
X-Received: by 2002:a05:6214:485:b0:888:8088:209e with SMTP id
 6a1803df08f44-890841a3ab6mr123084486d6.16.1767951084728; Fri, 09 Jan 2026
 01:31:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105080230.13171-1-harry.yoo@oracle.com> <20260105080230.13171-2-harry.yoo@oracle.com>
 <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com> <aWBfZ4ga9HQ8L8KM@hyeyoo>
In-Reply-To: <aWBfZ4ga9HQ8L8KM@hyeyoo>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 9 Jan 2026 10:30:47 +0100
X-Gm-Features: AZwV_Qj86V__IEzdz2ouZQE2ozn-rnAWTPpJPtDCUGLbUdOgH8MfcTAHgVsMofI
Message-ID: <CAG_fn=Wyw-fGGQ802A1cUpkHHTnZi5gN7wZzRaF1s31SPOpC9g@mail.gmail.com>
Subject: Re: [PATCH V5 1/8] mm/slab: use unsigned long for orig_size to ensure
 proper metadata align
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com, 
	cl@gentwo.org, dvyukov@google.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, 
	surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com, 
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Instead of calculating the offset of the original size in several
> > places, should we maybe introduce a function that returns a pointer to
> > it?
>
> Good point.
>
> The calculation of various metadata offset (including the original size)
> is repeated in several places, and perhaps it's worth cleaning up,
> something like this:
>
> enum {
>   FREE_POINTER_OFFSET,
>   ALLOC_TRACK_OFFSET,
>   FREE_TRACK_OFFSET,
>   ORIG_SIZE_OFFSET,
>   KASAN_ALLOC_META_OFFSET,
>   OBJ_EXT_OFFSET,
>   FINAL_ALIGNMENT_PADDING_OFFSET,
>   ...
> };
>
> orig_size = *(unsigned long *)get_metadata_ptr(p, ORIG_SIZE_OFFSET);

An alternative would be to declare a struct containing all the
metadata fields and use offsetof() (or simply do a cast and access the
fields via the struct pointer)

