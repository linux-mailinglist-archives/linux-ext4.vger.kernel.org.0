Return-Path: <linux-ext4+bounces-1866-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A2898D00
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCA72857FA
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5C12DDBF;
	Thu,  4 Apr 2024 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jC5EaRQM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2E12BF22
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250539; cv=none; b=aprB0+vada2zHPGUoIai4+TNTXbxJHjxebVEFKIeppKMDyeH2drHvXZiaN+7V33YEqV1Q8P9522MJlHSLlvyL46z8icShqZj52kmG5Cn3zBR+fwT9jeUfCQ952X88m9j4strGLfKE9P69eZpxJPD1tkgeuI3VwsCEUlB/5+Jnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250539; c=relaxed/simple;
	bh=qIeHxQSzEKN+T+ZMX5PFicsmdKmy6EfcZQYdz44LOBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHv0JIEMhOmecHQWz+Vfjm4iHLZ1i/vN4mCT6AWDQ5ZGITkz8pCMfgWOCmRvp1HoDSPFqjh0CKbvM0birW6sgmMQUIzG7LhXmCc7mL0gyu7Tc0YOtSNilbYNnmrJjdGKKtor+xtXAsjikYoFZm+95AegTnfbaZWwCThILTzEEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jC5EaRQM; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1284144276.2
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 10:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712250536; x=1712855336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuDs1drwJi9Z+z9OuWkhK3ckPKS9r4/p1uVUkFqevFk=;
        b=jC5EaRQMXoWxXcT/PNqSjrcsftwnvseB5AtKBg2vqgAyyLVQgp20SRegZq7YLIrdO/
         HTQWScQM/DW37R2IYh+dwMOL2ayL0pQIQzYyP1lXQTLRA97VQiYJ9PHXRyMfJ/Z9ZvVJ
         oFpUWCWEB1bSpDEyqEQ7RCqnI1td28ZhCzX2yYyMeaCp+6hQUqHZ6EtZjij0pKovvOgy
         stCx6Jb+d1gT/UvnialtOoZLUIi5qkRs+J/dXYzAxsZr67uO7BH+bPTh4Ub09lLJuNIn
         17mjFsnILx+0qC4dxBW5VMWwIa7xznM4mAxRt/Jwv9KrNYGo+0DSWcP592JJrWie/m+S
         e2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712250536; x=1712855336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuDs1drwJi9Z+z9OuWkhK3ckPKS9r4/p1uVUkFqevFk=;
        b=tNSMiI4+Zrp6ek0HDRxe0mq/gjEjl0+9nErUyMseAeRto2gnlgn8bC5bVnKi/DpgTi
         iSkBRH45FNP43p1k41UxjC+pNhhmIk/3uOLitaTPJvSor3vcib21QuL9JDvJRdB9Kda+
         +cUny/m1qcrLiWPJ6ADuxj/i3oZ7ZEA5/Zd9bl05EwetWCymWZaO7/gW7V0R+UmNkQZY
         16VuEZVEKE8S6CkXjMsHuePRPFXkvNUy1q4OsO54yxnaOFoNWXlAOU2fUS0cshOjlRVs
         c6FBgMCF9/OxsLw7PCU0TPCozU1g4HOOkqgxSFIT9M3HYY6YarWTllGdq+Qh/47j8bK0
         Vzxg==
X-Forwarded-Encrypted: i=1; AJvYcCVTQvyMoPSZ/Jyo4OTrwSZZWtuK4qjN3xxs0ZKELtu9aVWnt2eRZCWYFp35VNQXTMglEFBAUeLF/rCMTDYc2NaqpmbewS/IX/wZxA==
X-Gm-Message-State: AOJu0YzNNBpSEPSRBf1BHzQjZ8bng1QvleIgUzPdlyUlGUfDPLwUecY4
	qaei0lV3QGx0RW1xNoL7ycZ/2JulBqbGCdv/v5Vwsdx2buEeacL13ax56Tl9HKqCpL3/dV23zW4
	vnXiYUW/9k+FAxjE0Ph01mCJ8C1nwtSMl8296
X-Google-Smtp-Source: AGHT+IFt2ASldzAexjX0sPM2NMrH0Lqtd66mUXGVX9ZgF2XSVZKC+BEFwLxb4crFlAjVgX0qYdICDkkyaJeo+de/1Hw=
X-Received: by 2002:a25:ac19:0:b0:dcb:b072:82d5 with SMTP id
 w25-20020a25ac19000000b00dcbb07282d5mr3065164ybi.64.1712250536330; Thu, 04
 Apr 2024 10:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404165404.3805498-1-surenb@google.com> <Zg7dmp5VJkm1nLRM@casper.infradead.org>
In-Reply-To: <Zg7dmp5VJkm1nLRM@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 4 Apr 2024 10:08:45 -0700
Message-ID: <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, joro@8bytes.org, will@kernel.org, 
	trond.myklebust@hammerspace.com, anna@kernel.org, arnd@arndb.de, 
	herbert@gondor.apana.org.au, davem@davemloft.net, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, tytso@mit.edu, jack@suse.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, jakub@cloudflare.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	vbabka@suse.cz, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kent.overstreet@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 10:04=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 04, 2024 at 09:54:04AM -0700, Suren Baghdasaryan wrote:
> > +++ b/include/linux/dma-fence-chain.h
> > @@ -86,10 +86,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
> >   *
> >   * Returns a new struct dma_fence_chain object or NULL on failure.
> >   */
> > -static inline struct dma_fence_chain *dma_fence_chain_alloc(void)
> > -{
> > -     return kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL);
> > -};
> > +#define dma_fence_chain_alloc()      kmalloc(sizeof(struct dma_fence_c=
hain), GFP_KERNEL)
>
> You've removed some typesafety here.  Before, if I wrote:
>
>         struct page *page =3D dma_fence_chain_alloc();
>
> the compiler would warn me that I've done something stupid.  Now it
> can't tell.  Suggest perhaps:
>
> #define dma_fence_chain_alloc()                                          =
 \
>         (struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),=
 \
>                                                 GFP_KERNEL)
>
> but maybe there's a better way of doing that.  There are a few other
> occurrences of the same problem in this monster patch.

Got your point.

>
> > +++ b/include/linux/hid_bpf.h
> > @@ -149,10 +149,7 @@ static inline int hid_bpf_connect_device(struct hi=
d_device *hdev) { return 0; }
> >  static inline void hid_bpf_disconnect_device(struct hid_device *hdev) =
{}
> >  static inline void hid_bpf_destroy_device(struct hid_device *hid) {}
> >  static inline void hid_bpf_device_init(struct hid_device *hid) {}
> > -static inline u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8=
 *rdesc, unsigned int *size)
> > -{
> > -     return kmemdup(rdesc, *size, GFP_KERNEL);
> > -}
> > +#define call_hid_bpf_rdesc_fixup(_hdev, _rdesc, _size) kmemdup(_rdesc,=
 *(_size), GFP_KERNEL)
>
> here
>
> > -static inline handle_t *jbd2_alloc_handle(gfp_t gfp_flags)
> > -{
> > -     return kmem_cache_zalloc(jbd2_handle_cache, gfp_flags);
> > -}
> > +#define jbd2_alloc_handle(_gfp_flags)        kmem_cache_zalloc(jbd2_ha=
ndle_cache, _gfp_flags)
>
> here
>
> > +++ b/include/linux/skmsg.h
> > @@ -410,11 +410,8 @@ void sk_psock_stop_verdict(struct sock *sk, struct=
 sk_psock *psock);
> >  int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
> >                        struct sk_msg *msg);
> >
> > -static inline struct sk_psock_link *sk_psock_init_link(void)
> > -{
> > -     return kzalloc(sizeof(struct sk_psock_link),
> > -                    GFP_ATOMIC | __GFP_NOWARN);
> > -}
> > +#define sk_psock_init_link() \
> > +             kzalloc(sizeof(struct sk_psock_link), GFP_ATOMIC | __GFP_=
NOWARN)
>
> here
>
> ... I kind of gave up at this point.  You'll want to audit for yourself
> anyway ;-)

Yes, I'll go over it and will make the required changes. Thanks for
looking into it!
Suren.

