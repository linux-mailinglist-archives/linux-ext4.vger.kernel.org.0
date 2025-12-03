Return-Path: <linux-ext4+bounces-12137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B753C9E12F
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 08:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481FF4E06F8
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B8429D28B;
	Wed,  3 Dec 2025 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwRZO7Sc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8DD29B8DB
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764747832; cv=none; b=XFDveoF7GJAotOHin42MrwG/tXrHxN/dUssrXg2ziJNcG9rE2tr+eSiAQV2lap4uPg+lT+hml+ee5TLEnFwN5kcWeGmiMGemPSYHnP5J3HE1Z7mGRjNo5C2Dg1E7MJRTucX2huf+01BIwU/ge9hgRxtpwtSG/Cu9K0Swbkmr+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764747832; c=relaxed/simple;
	bh=xA+893f8aSh8f9llVysQVOELYSL0B09m1t8yCtzCKH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKYBfyFdgI93Wh6/XeLifBJ7ALWQrRgehWVt/3XNq5HtUIgO2zLumvZJtMgtfWRG9vom1dDK+VoBiQHFv6Vwhw/96oMQM5uPg4XIquFMhiWO2NJh90rveoPB4FoziE/kzWbQbTQcy9wSPkARLs9X0CMnqe7CDE0qUnrhjUWlSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwRZO7Sc; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78a8bed470bso50676277b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 02 Dec 2025 23:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764747829; x=1765352629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR4iX+z/HMqo2kh9fGo0qTl7dmXeuheWuB6jzJECbXQ=;
        b=QwRZO7ScXEMznl5QaEhKfEDQxfZodIG+GPrdtiNW1cyH5pENSQ1AlqoPQhmRLkoQ6t
         b40gbS1a+4hty9aYj/tAB/MjTD37/EA3t94vMly8fykKtXi+nF/YOKZk3cz4mchBtPVh
         5V18/oyj/QILeAvSpoQV5tdSdPjsalJuQ5iFZ+Z5iAIMn8dyyjOe7oV/6ZUD7jKHw4G0
         8pV/pE3ussbz56TaIZYM0hgVC6se9NJk4RQzu8ZJ0CjoNRoeQK5kHczLFBHG1XG5SS+I
         H5YZZTkzsnrRmixSNB+yFGZW599LNYR/eytj3P74WS3EVs5SPQ2oDPLaiL3zfRlmgSPe
         OPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764747829; x=1765352629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BR4iX+z/HMqo2kh9fGo0qTl7dmXeuheWuB6jzJECbXQ=;
        b=HjyYBJGF2nyg6+ByeVIGOAQFLThQbsNnO53umlsn497PRYPFwT3KGRiwRLx3k4v25D
         QAUyflQRQISJ5HV2XNDqamh0rjqACM1/MlGLghNYB0YmHUIRowKhETnX8mCUez2TnTyy
         rd7OD5/sRG9uadlc+i423fDT0m0dHYZkKteT1lhS8d7EmsJ8skXAWbU0pzaVG/4bIbKw
         +CrBVjYLbW1Dh5cUFWHcon+CJumaq1hv5zsvnR3XpXEeHYOeKRTuGA6GX/n7qjdxJxMN
         gahbHt8Fm9maFa+z0Z+XgDPODXYHObac7V+iOhtefkEW+FHOviUdkcMf5lH0SgkNALTu
         JDhQ==
X-Gm-Message-State: AOJu0Yw8SpEfE77YpTzSXkVxGMaIqySE2W87Dr0ktaKhnbw5qSUBWxit
	JTE6kBOQbulhhM7ZLji5T/Ao+CVeLExYjuIulW+N7xhnCsGmiB+yrzsdONUm5qparUVGUxdwNd6
	nfEN4C+efZRsaNHXL0W8fL3DBcz5vTlA=
X-Gm-Gg: ASbGnctV5kUaGFFEEoVkemD/KXjGNn054Vi2O976arMh5Mr5k4zZBvOiN3WK8sXyRCF
	6Lmbai2s5is9BDehsxqsfx6iHizn2YzlhZKrlXDIx8GkkSKVEX3w63hAw0PVBsEeIaPGDZcYqxm
	zIjOI8RPGaJus32hox/zCDt+txHAL6vgRs0VpIUdrFvAHCqbAM4xoCcqAwhJ/OasYLF0UyU435L
	AV4dKrG4dQ7C40ghcLu4MCK4FoVO6Nd0LkqxwGYTeA+DLqLOrPz/guBmnxQFDRaY769GhsroLSw
	iCg2MIk0Phro3cjvbfY2d8PnLP/t7mQo5DcSq8Ansx8dgbFvDOD7+0sASOg=
X-Google-Smtp-Source: AGHT+IH+77dXNfW15msvROXM+oUfPI5weixlN0hRHd+KLk4qrOAHjQTwiML/4mi4N8/RvMmBh7+UW2nnyEFbMWTd89E=
X-Received: by 2002:a05:690c:62c7:b0:788:989:fdae with SMTP id
 00721157ae682-78c0bfc17ffmr23272917b3.28.1764747829415; Tue, 02 Dec 2025
 23:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com> <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
In-Reply-To: <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 3 Dec 2025 13:13:35 +0530
X-Gm-Features: AWmQ_bm6tz1HrtIi-s0M0bC2A45lb1WbXoKMYK6q_ZxGKnYjZSQQKRkinbuJPQs
Message-ID: <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:22=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> On 12/3/2025 9:37 AM, Deepanshu Kartikey wrote:
> > On Tue, Dec 2, 2025 at 5:54=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.c=
om> wrote:
> >>
> >> Hi Deepanshu!
> >>
> >> On 11/30/2025 10:06 AM, Deepanshu Kartikey wrote:
> >>> On Sat, Nov 22, 2025 at 7:27=E2=80=AFAM Deepanshu Kartikey
> >>> <kartikey406@gmail.com> wrote:
> >>>>
> >>>> When delayed block allocation fails due to filesystem corruption,
> >>>> ext4's writeback error handling invalidates affected folios by calli=
ng
> >>>> mpage_release_unused_pages() with invalidate=3Dtrue, which explicitl=
y
> >>>> clears the uptodate flag:
> >>>>
> >>>>     static void mpage_release_unused_pages(..., bool invalidate)
> >>>>     {
> >>>>         ...
> >>>>         if (invalidate) {
> >>>>             block_invalidate_folio(folio, 0, folio_size(folio));
> >>>>             folio_clear_uptodate(folio);
> >>>>         }
> >>>>     }
> >>>>
> >>>> If ext4_page_mkwrite() is subsequently called on such a non-uptodate
> >>>> folio, it can proceed to mark the folio dirty without checking its
> >>>> state. This triggers a warning in __folio_mark_dirty():
> >>>>
> >>>>     WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
> >>>>     __folio_mark_dirty+0x578/0x880
> >>>>
> >>>>     Call Trace:
> >>>>      fault_dirty_shared_page+0x16e/0x2d0
> >>>>      do_wp_page+0x38b/0xd20
> >>>>      handle_pte_fault+0x1da/0x450
> >>>>      __handle_mm_fault+0x652/0x13b0
> >>>>      handle_mm_fault+0x22a/0x6f0
> >>>>      do_user_addr_fault+0x200/0x8a0
> >>>>      exc_page_fault+0x81/0x1b0
> >>>>
> >>>> This scenario occurs when:
> >>>> 1. A write with delayed allocation marks a folio dirty (uptodate=3D1=
)
> >>>> 2. Writeback attempts block allocation but detects filesystem corrup=
tion
> >>>> 3. Error handling calls mpage_release_unused_pages(invalidate=3Dtrue=
),
> >>>>    which clears the uptodate flag via folio_clear_uptodate()
> >>>> 4. A subsequent ftruncate() triggers ext4_truncate()
> >>>> 5. ext4_block_truncate_page() attempts to zero the page tail
> >>>> 6. This triggers a write fault on the mmap'd page
> >>>> 7. ext4_page_mkwrite() is called with the non-uptodate folio
> >>>> 8. Without checking uptodate, it proceeds to mark the folio dirty
> >>>> 9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate(=
))
> >>
> >> Thank you a lot for analyzing this issue and the fix patch. As I was
> >> going through the process of understanding this issue, I had one
> >> question. Is the code flow that triggers the warning as follows?
> >>
> >> wp_page_shared()
> >>   do_page_mkwrite()
> >>     ext4_page_mkwrite()
> >>       block_page_mkwrite()   //The default delalloc path
> >>         block_commit_write()
> >>           mark_buffer_dirty()
> >>             __folio_mark_dirty(0)  //'warn' is false, doesn't trigger =
warning
> >>         folio_mark_dirty()
> >>           ext4_dirty_folio()
> >>             block_dirty_folio  //newly_dirty is false, doesn't call __=
folio_mark_dirty()
> >>   fault_dirty_shared_page()
> >>     folio_mark_dirty()  //Trigger warning ?
> >>
> >> This folio has been marked as dirty. How was this warning triggered?
> >> Am I missing something?
> >>
> >> Thanks,
> >> Yi.
> >>
> >
> > Hi Yi,
> >
> > Thank you for your question about the exact flow that triggers the warn=
ing.
> >
>
> Thank you for the clarification, but there are still some details that
> are unclear.
>
> > You're correct that the code paths within ext4_page_mkwrite() and
> > block_page_mkwrite() call __folio_mark_dirty() with warn=3D0, so no
> > warning occurs there. The warning actually triggers later, in
> > fault_dirty_shared_page() after page_mkwrite returns.
> >
> > Here's the complete flow:
> >
> >   wp_page_shared()
> >     =E2=86=93
> >     do_page_mkwrite()
> >       =E2=86=93
> >       ext4_page_mkwrite()
> >         =E2=86=93
> >         block_page_mkwrite()
> >           =E2=86=93
> >           mark_buffer_dirty() =E2=86=92 __folio_mark_dirty(warn=3D0)  /=
/ No warning
>
>              =E2=86=93
>              if (!folio_test_set_dirty(folio))
>                         //The folio will be mark as dirty --- 1
>
> >         =E2=86=93
> >         Returns success
> >     =E2=86=93
> >     fault_dirty_shared_page(vma, folio)  =E2=86=90 Warning triggers her=
e
> >       =E2=86=93
> >       folio_mark_dirty(folio)
> >         =E2=86=93
> >         ext4_dirty_folio()
> >           =E2=86=93
> >           block_dirty_folio()
> >             =E2=86=93
> >             if (!folio_test_set_dirty(folio))  // Folio not already dir=
ty
>
>               This makes me confused, this folio should be set to dirty
>               at position 1. If it is not dirty here, who cleared the dir=
ty
>               flag for this folio?
>

Hi Yi,

Excellent question! You're absolutely right that mark_buffer_dirty()
marks the folio dirty at position 1. The key is that the folio dirty
flag is cleared later by the error handling code.

When delayed allocation fails and mpage_release_unused_pages() is
called with invalidate=3Dtrue, it calls:

  block_invalidate_folio(folio, 0, folio_size(folio));

This function not only invalidates the folio but also clears the dirty
flag. Looking at the code path:

  block_invalidate_folio()
    =E2=86=92 do_invalidate_folio()
      =E2=86=92 Clears the dirty flag
      =E2=86=92 Detaches buffer heads

So the sequence is:

1. First wp_page_shared(): folio becomes dirty=3D1, uptodate=3D1 (via
mark_buffer_dirty)
2. Writeback fails due to corruption
3. mpage_release_unused_pages(invalidate=3Dtrue):
   - block_invalidate_folio() clears dirty flag
   - folio_clear_uptodate() clears uptodate flag
   - Result: folio is now dirty=3D0, uptodate=3D0
4. Second wp_page_shared(): called with folio dirty=3D0, uptodate=3D0

This is confirmed by my debug logs:

  [22.400513] WP_PAGE_SHARED: ENTER folio=3D... uptodate=3D0 dirty=3D0

The folio is BOTH non-uptodate AND non-dirty when the second
wp_page_shared() is called.

Without my fix:
- ext4_page_mkwrite() succeeds (doesn't check uptodate)
- block_page_mkwrite() tries to mark the folio dirty again
- fault_dirty_shared_page() is reached
- block_dirty_folio() finds folio not dirty (dirty=3D0)
- Calls __folio_mark_dirty(warn=3D1) with uptodate=3D0
- WARNING triggers

With my fix:
- ext4_page_mkwrite() checks uptodate and returns VM_FAULT_SIGBUS
- Never reaches fault_dirty_shared_page()
- No warning

Does this answer your question?

Best regards,
Deepanshu

