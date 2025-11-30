Return-Path: <linux-ext4+bounces-12092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBEEC94A6F
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Nov 2025 03:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E98D3A65E1
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Nov 2025 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A931E5714;
	Sun, 30 Nov 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwEzFh18"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399017D6
	for <linux-ext4@vger.kernel.org>; Sun, 30 Nov 2025 02:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764468405; cv=none; b=YgUpShBwNZb1IcsoNRnaag76WZUGLRbdB4ZpKrPUs8l0gSXQhIWKasqvE0Mq4fzcfEGbtWp13D0jUAhk970Nwb9Dl0TUGzwcscQn03o5kyijJHyQVLImICK3lpvn8B+Mn9mwdXJaccn2uSccgis12WDejk70hXFGJf3p9r7G6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764468405; c=relaxed/simple;
	bh=pbj+rRLfLR8bW1T20lBIAoyi5CAdOA3DkKJMLqQv55g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO0qZ3txbT8MHmmCVZ5VSm0JABA6pCYwrOYv21RD1TTlvuSFZ+apExDMkqnbDVx1ALfP3shf3QGvkaovsIVML/k8KSRZBKDMGloChT1klyH+hZVkuKEVvdh8AMWiSXDhVi+qkyeTO4gK31ZjpBI35zm4m2ZMd+HbqWt38QRJIqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwEzFh18; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a712cfbc0so30164707b3.1
        for <linux-ext4@vger.kernel.org>; Sat, 29 Nov 2025 18:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764468403; x=1765073203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipl5emlqkpqZxw8JYKKulTN6SGyULg2ei+Ak+Y1p1dw=;
        b=dwEzFh18eZNkP/b8GsRcYToJr6EjjT/qduLhPazHcCY5na9vLHBm6ua0HLi8Lviu/Y
         LSfuejd+vFEU5JWtF++I8HP3aH2Kd6eL8x2Yqo2vZ2XGO9PWdHO0spmAcMV4E9F81aJo
         S8ZpZTp1sCcv19LHNgh+FmsluuKpX+DOnKscyrN6AFu20UQUk/2SDPpltTYLB0jKnQAg
         NMlJzJq3w1xCRVckndRORFKiHfq/bSEx7BRC0HjA1D+ARHJmK6+vP6h3MEicni/QK5sz
         jlOK8slG582ZyFfipizotM7f4Ppw7z9xzhDytdVPM6FhttNAbsDDhUaUUanEFmMSIWCH
         twPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764468403; x=1765073203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ipl5emlqkpqZxw8JYKKulTN6SGyULg2ei+Ak+Y1p1dw=;
        b=IaRJok4AkwfwC7Pg/KyVmLF+oPh875iUs6damUKJIMz26RNaIrGlDGvDLpEhUrRdn4
         Zarm4OutYTSuHbpjyVZigAlQI0R+gW8X59kPObin4T2uE5wDY2JwRkSnBn+ZZ/DKERuM
         GM+QOC2yd0ZcFoF3R3Io0qgayPW7xH45uv47GhaK41gtOU3LNNKjOaEiQL5ZjMdn2ALP
         PHY/cCRLjEVXF9CFgFjdfCjp/i16uRa2+0BuL09iEamthrakM0hE/kvP8/OIvTDMarHB
         kTN4ykSpcEMpK5JEWQLUrZbBCfZPjj7Fe0J4yQKkmGQBEcN8P4QOsjumeCvPcpoD3djZ
         sBLQ==
X-Gm-Message-State: AOJu0YxUIe2YA2D0OhqP4vpFMfUGlRtgp+GJzQhGhHnivFfGurLKdc1C
	XWtKDpY7mpq9mWl0TTOl0HNz7PPuUqicdPNbq/SOFO6hGCn6Rb8CRAGy6rQZfJiA4IQCbf6afu1
	LhmtHkArEDGcfmolA2ks+6w2Xx6w4zlo=
X-Gm-Gg: ASbGncvhYsGBOSXg+J/TVs5raiauM23nPGlTUi0egtJrT4yLiixMGqrb7P8LTEebwL2
	GW9SgfrJaS3dwYLagvPA1SkL7XBIg7Mnjju2muy2zBJpp+Hvmv2cxnKVEAxOL7WZF+vO/a0mYv+
	Eebi4zMcMhWjQLKVzlXBBjNTVQjPyo56FNy3JSAthM86v0LlolFrL96WdtIsmhrnzJkdyabqc+q
	wbJaQnjqp8m1+j9HjpGUHjJWgBQ/q8G1+I3gW7E9MK08nWBDxw2hRiQhjW9rAt/B4o0kxfxaL1Z
	r1NPI3f8j5MoCUSPKiKPTnVBVIxk
X-Google-Smtp-Source: AGHT+IEH1uX6WMU3kUH4mvlsuglEM5Qc8G72cEUvjOHSdtouc9feaY1P/YZYxCsf4xCq9E/fOJAnEDARngRQGbdWZfE=
X-Received: by 2002:a05:690c:7448:b0:783:6f68:2a05 with SMTP id
 00721157ae682-78a8b47ad1cmr288567987b3.14.1764468403033; Sat, 29 Nov 2025
 18:06:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122015742.362444-1-kartikey406@gmail.com>
In-Reply-To: <20251122015742.362444-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 30 Nov 2025 07:36:31 +0530
X-Gm-Features: AWmQ_bmLke6W5ZUTStGQRzS150c6VYFmzdOFM_3eNZDz4w7fUGtSvxo4eyNSNDE
Message-ID: <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 7:27=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> When delayed block allocation fails due to filesystem corruption,
> ext4's writeback error handling invalidates affected folios by calling
> mpage_release_unused_pages() with invalidate=3Dtrue, which explicitly
> clears the uptodate flag:
>
>     static void mpage_release_unused_pages(..., bool invalidate)
>     {
>         ...
>         if (invalidate) {
>             block_invalidate_folio(folio, 0, folio_size(folio));
>             folio_clear_uptodate(folio);
>         }
>     }
>
> If ext4_page_mkwrite() is subsequently called on such a non-uptodate
> folio, it can proceed to mark the folio dirty without checking its
> state. This triggers a warning in __folio_mark_dirty():
>
>     WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
>     __folio_mark_dirty+0x578/0x880
>
>     Call Trace:
>      fault_dirty_shared_page+0x16e/0x2d0
>      do_wp_page+0x38b/0xd20
>      handle_pte_fault+0x1da/0x450
>      __handle_mm_fault+0x652/0x13b0
>      handle_mm_fault+0x22a/0x6f0
>      do_user_addr_fault+0x200/0x8a0
>      exc_page_fault+0x81/0x1b0
>
> This scenario occurs when:
> 1. A write with delayed allocation marks a folio dirty (uptodate=3D1)
> 2. Writeback attempts block allocation but detects filesystem corruption
> 3. Error handling calls mpage_release_unused_pages(invalidate=3Dtrue),
>    which clears the uptodate flag via folio_clear_uptodate()
> 4. A subsequent ftruncate() triggers ext4_truncate()
> 5. ext4_block_truncate_page() attempts to zero the page tail
> 6. This triggers a write fault on the mmap'd page
> 7. ext4_page_mkwrite() is called with the non-uptodate folio
> 8. Without checking uptodate, it proceeds to mark the folio dirty
> 9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate())
>
> Fix this by checking folio_test_uptodate() early in ext4_page_mkwrite()
> and returning VM_FAULT_SIGBUS if the folio is not uptodate. This prevents
> attempting to write to invalidated folios and properly signals the error
> to userspace.
>
> The check is placed early, before the delalloc/journal/normal code paths,
> as none of these paths should proceed with a non-uptodate folio.
>
> Reported-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
> Tested-by: syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db0a0670332b6b3230a0a
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  fs/ext4/inode.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..18a029362c1f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6688,6 +6688,14 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>         if (err)
>                 goto out_ret;
>
> +       folio_lock(folio);
> +       if (!folio_test_uptodate(folio)) {
> +               folio_unlock(folio);
> +               ret =3D VM_FAULT_SIGBUS;
> +               goto out;
> +       }
> +       folio_unlock(folio);
> +
>         /*
>          * On data journalling we skip straight to the transaction handle=
:
>          * there's no delalloc; page truncated will be checked later; the
> --
> 2.43.0
>

Hi Ted and ext4 maintainers,

I wanted to follow up on this patch submitted a week ago. This fixes
a syzbot-reported WARNING in __folio_mark_dirty() that occurs when
ext4_page_mkwrite() is called with a non-uptodate folio after delayed
allocation writeback failure.

Please let me know if there's any feedback or if I should make any
changes.

Thanks,
Deepanshu

