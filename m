Return-Path: <linux-ext4+bounces-12637-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17538D02CC2
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1CC6339CF0E
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5C472D98;
	Thu,  8 Jan 2026 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YawHteLV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD24735A1
	for <linux-ext4@vger.kernel.org>; Thu,  8 Jan 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872408; cv=none; b=cm3owDP0akM4vIO7hudS4MoNe7/1jmBMP9nodZtEwNGHTgvBn4iNokg7ESiN7uYSEnJpa4XUuAGAz3bo/rOGwV0jV2h9onvHHJeMxpo7GqTDCbaf/sWs4FwUenkYbyLk87OCo0H19Ryxlb2IVMtLL1y4RzGW/hW3D1Nh0ZZSDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872408; c=relaxed/simple;
	bh=ezvnqHz57gvkldOznzeZCMww1jUfcQ7xappaEfnvzZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfXioZsR9WykaXJFKeAkVO+M5kpb5JpvCSVqsIDXoGSiUNtPRjrFJRJE2ims+PywGWnbbYdhDRN0x4zn4PoxlMoDQKuUBJRTXRLbK671DWsSNPq/owVUmdxcE1wSze/QvulG4o0e1f1liCHBVJbZ5r6bwjX2uwl8BtLmEmZxIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YawHteLV; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8907ec50855so32942526d6.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Jan 2026 03:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767872400; x=1768477200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De/F7GrZ3a7XQW11zwFhVMyznAHPN5+HCcRNv17+1Go=;
        b=YawHteLVrnHK3lXXOFIIgMvlqbUWb1l2jMcI7SZhdlee5Hk49JnqZPZHuqm+TVpzZz
         4RicRRov650HZEdbMMi3ueF/cXYISxpVbPE3M4WZVRsxHM53TZnDdoRJiva3rFqsnjTV
         GwOZxFVa5V0hxW/DDbqvAXSnvAQLvH1evxeMNUpFshLrEWEsFXmo+o29w3mve3mIjfPW
         lBrdOYalCBklb+kcFbqrC1c0jeb6nOYkmKKQMNaEkoWGHs070V9YKA7TKkSYwaBRL/b5
         e+ky/HkNZclcQoKMLxzmqhmjvq57wXiaiGu2KK7noDOY9rdvSGbmVPMYab+QmIgXiGUT
         zHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872400; x=1768477200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=De/F7GrZ3a7XQW11zwFhVMyznAHPN5+HCcRNv17+1Go=;
        b=LecV4+VF2fHtoKO9B0kOUfrMxutl4s/Fovu23zB3inHq6XG+w3g7WCNh9HsTHNLnBC
         28AwIaaOmQ9nbvrRICX9QCrNrBKTo7LSHG31kEl/OkOjVgKqxApFtJ3CLSj43kbw/K8K
         xshX2vG2U3HlPTK9X4dmktNVHZdyk7ZsattEVebLyukiZVPUrE9wBxteDcumHrzn+JVE
         F3yJ4lZijBX7jTk5mMJLExhq6V1GSuktpGvH42OppDyt2Zs4RaHEGd+lwNMqbWxkpAjQ
         W8nVKkd+rdfS0+mVPSYUpsFpD2U2AvBf/dEW6m/dRJ5pktdLk63iOy2hIlW9ZEaWwaBC
         H03Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkQCLb70dGeNmB65PMRe3qxGFBadxdPoVCMJj1tP3U30/UyGcK6+LrUoFEW+bV6X4KEFjbpYOLPfNI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx815OvSmZWRi9ybXuvCn5vAvHXqW3n2z/WLl+fhu+yejqoLvpW
	0ScZrXu7KXEkUzOTgHV3fryBee2PjAfM98g8OBTvu+5/6AjK5E+4PDECVSuQ/nS5Ybdkz+4+Mye
	TNH3sdF/kl4rl42OFoIoCtQipij0rpi+zIuz7AvF1
X-Gm-Gg: AY/fxX5YSPmc01J+Ipkk4arjX7B4OjO2rq0XxC/bDuq0Z9Y+A0jH1xZO6hMR8PxeQmD
	YLThYe+SRQAY3MUfHwHuG7REpR2ipuyvYXqHv9yTqcYkcCLLiFV1RPL2HujXdLd9YnV8s6HFqko
	OiFLWAS9BsHeK7lUfpbEnfPvV0u9ZYTbkSsbs7R7QHfeUNX7oDc7RqnMLLOJXlA9CwdKcB9/0O4
	HF5USrbzGOf8GuAlKJk49x5q+/0LQoaQz23ozKdn2NNacre2LO4xijbXPvJf4LvKGsAxQCz4WiB
	pO+WiTmTMew5wOr3/S8b+5yshz/qd3iVjuie
X-Google-Smtp-Source: AGHT+IEtTsutQpO25KKJJxkwWclrV1NkoOFyJBOS1res7lIatKk2McpUxH3uFSbvGt+LR+VAYJv6MCV9dzQjj1c4j+4=
X-Received: by 2002:a05:6214:20c4:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-8908417a83emr85986576d6.13.1767872399549; Thu, 08 Jan 2026
 03:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105080230.13171-1-harry.yoo@oracle.com> <20260105080230.13171-2-harry.yoo@oracle.com>
In-Reply-To: <20260105080230.13171-2-harry.yoo@oracle.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 8 Jan 2026 12:39:22 +0100
X-Gm-Features: AQt7F2p4_VUyRgHz6qqEM5-JBZ5E2KV2nkrPg5vKNyZeCt2rwmq1SfsxSID667s
Message-ID: <CAG_fn=XCx9-uYOhRQXTde7ud=H9kwM_Sf3ZjHQd9hfYDspzeOA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 9:02=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
> When both KASAN and SLAB_STORE_USER are enabled, accesses to
> struct kasan_alloc_meta fields can be misaligned on 64-bit architectures.
> This occurs because orig_size is currently defined as unsigned int,
> which only guarantees 4-byte alignment. When struct kasan_alloc_meta is
> placed after orig_size, it may end up at a 4-byte boundary rather than
> the required 8-byte boundary on 64-bit systems.
>
> Note that 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
> are assumed to require 64-bit accesses to be 64-bit aligned.
> See HAVE_64BIT_ALIGNED_ACCESS and commit adab66b71abf ("Revert:
> "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"") for more details.
>
> Change orig_size from unsigned int to unsigned long to ensure proper
> alignment for any subsequent metadata. This should not waste additional
> memory because kmalloc objects are already aligned to at least
> ARCH_KMALLOC_MINALIGN.
>
> Suggested-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: stable@vger.kernel.org
> Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc=
")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slub.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index ad71f01571f0..1c747435a6ab 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -857,7 +857,7 @@ static inline bool slab_update_freelist(struct kmem_c=
ache *s, struct slab *slab,
>   * request size in the meta data area, for better debug and sanity check=
.
>   */
>  static inline void set_orig_size(struct kmem_cache *s,
> -                               void *object, unsigned int orig_size)
> +                               void *object, unsigned long orig_size)
>  {
>         void *p =3D kasan_reset_tag(object);
>
> @@ -867,10 +867,10 @@ static inline void set_orig_size(struct kmem_cache =
*s,
>         p +=3D get_info_end(s);
>         p +=3D sizeof(struct track) * 2;
>
> -       *(unsigned int *)p =3D orig_size;
> +       *(unsigned long *)p =3D orig_size;

Instead of calculating the offset of the original size in several
places, should we maybe introduce a function that returns a pointer to
it?

