Return-Path: <linux-ext4+bounces-12129-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF184C9D82A
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 02:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3143B34AE33
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74822D7B5;
	Wed,  3 Dec 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am9zXgga"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315F226541
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 01:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725891; cv=none; b=uubyk2/KD6ANu5jJaI5sHjQjRw1bhsI60jL34mCAUvivjsowqolO58BCNRawTIQcWaTWu4g9UEpxhJTAee5gtEmptSOs7gG+A7aB/OY8P0mFCtDykt8HoKVI2SvP6Zg0j7mIH4FyRKJyIdzD6UJGOI+QrJkA+PCTsOjtx19i2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725891; c=relaxed/simple;
	bh=ivBEWAn6Qc9em8Wo7P+U93se6vWYd+RQQN4Dp5R4vxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln8cNDbAOC98HQ2wGzb52B31/J9T9mTcAcp9aGKgMrIGGEHG0BvTiseVna8UbVXX0IZg+hV+nbxIj09jfi13s/zqbDXNHzpHQevz1KO0IxaBRA9Y13C6rIDmYkf9PrZ++1CZ/T5NSJbLnUxlJgp4F6vdj9jHNveFXE8y9WCPn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am9zXgga; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787e84ceaf7so61635037b3.2
        for <linux-ext4@vger.kernel.org>; Tue, 02 Dec 2025 17:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764725889; x=1765330689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NXWG4xH8YKl04Fp/mD3CU2nd+rC/QdIJE3L2Y7f3t0=;
        b=Am9zXggap0AyxyzzO3XimqAUGvGk9Im67uJrf+Ww9DeU5mvPQq58xPwvbh/XRXEENX
         q5hTSTr4/12Wi4jMCrVeP1gyapdBKXlMjTezLuJT3rwR0baSra3nqG0+fWXyX9mYwf6q
         gVlHgSPnO0X5o6Uw/XT57BxHSkW+8aZDE/r7qsTn/c5i6zTQlOTsrsdjd/XpCMwVsOlO
         21oHXIODoXN1rf1rjhrBsCSnAkabmEXInDvuVw70+ACQB6hnA34bVwARVQoMoNcsVpdJ
         J1+F/XgO7egAbpQgLKjMQ4rF1LnZKQpxkbQdqAyvwU3lAfCAhPxuUS+wg6ZB7hOFbd/q
         zCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764725889; x=1765330689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5NXWG4xH8YKl04Fp/mD3CU2nd+rC/QdIJE3L2Y7f3t0=;
        b=gpvtezcA/w09N9Q0M5akOpJbfHPUkt5wp3lcOiKdlpIeMTXjrKGEMwE3rrPU6xjfdq
         Hs8/TODiz3VBt0xLfCIg2/PCSjxrYLrrnmRsoVW5ZL70Ov9ExVRoCu9fp1BfWkIc3H/N
         fiAnq8y4++8FxprycV8e3uch7CR75H29iHfACOt5KLwNH03eeaTt8LpegfDv7hIa9A43
         5Tk3dT006vq8QR0GPJhw/8y6DXW4ORxIw+YCDIiqVLeDZs7wXIlHJY8KviWNznzz0Ufi
         wKGGELoWrmo2LBxdnSnr0m7/wb8I+ivL5XmjYuf5PwCpHuaV1uLPbJq3sDBjUijAiWAe
         zE1Q==
X-Gm-Message-State: AOJu0YwGuQpPTK3M1xSzQfXCbyktFXD51F+eI8wJKdDtl+qSodk9pgUx
	YelYKGh92Yji/QdX+1jhYYOC5/hBEYl8w3mgXRC6DiuciMHukcjABvd+9W2Cv85eKwp8ZgUuRGi
	q2OJYiXUS6v3MLO+rkfFMJTxqeH/nDRY=
X-Gm-Gg: ASbGncv0HBtPqL/8Cv9WeVFwFHVxRfCGQHqA9nl6T0D45vHXknFx202LqL/8O+IX8I1
	wzwhIJXjH4ZOwmGncjqYijXWXMoR78OioqeQn5/IupMSh53jMD2QH3MLfruvksLoRAFIAX2wAZL
	w9etpJ/10dQIDtvL1oKscpVxxHfVczqsV/BnC6Tqc2RCwuFPr+apUNx+/BUl2Gq/S/ex0klBZEi
	CyWupLTeBl9Mvgf9ath9rzwoQlvq0KC0VvH7QjmUFy00eQ5yvRUAoRS3MU98RceRk8scMvdzbED
	IQ35y4lxA7wKg5d+8q7cmhPhaAk8hT1lgtz2v0nRyhaRKYuWNaySWGEASJE=
X-Google-Smtp-Source: AGHT+IHXzVRCEGB5PDvtyDXja+nZBNYTd/jhSb0I48MN2sEMR2lv5+C7XbKheoytGkZaWQo4cCR2egFmfm1Xy7jQQQQ=
X-Received: by 2002:a05:690c:360b:b0:786:4fd5:e5df with SMTP id
 00721157ae682-78c0c0259d1mr6031737b3.39.1764725889161; Tue, 02 Dec 2025
 17:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com> <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
In-Reply-To: <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 3 Dec 2025 07:07:57 +0530
X-Gm-Features: AWmQ_bmYGAk6l7oLISYJFcjW59HY7Dz-DN8q2Bdljv1tuM13LL3Y99ckGc_n8Bc
Message-ID: <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 5:54=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com> =
wrote:
>
> Hi Deepanshu!
>
> On 11/30/2025 10:06 AM, Deepanshu Kartikey wrote:
> > On Sat, Nov 22, 2025 at 7:27=E2=80=AFAM Deepanshu Kartikey
> > <kartikey406@gmail.com> wrote:
> >>
> >> When delayed block allocation fails due to filesystem corruption,
> >> ext4's writeback error handling invalidates affected folios by calling
> >> mpage_release_unused_pages() with invalidate=3Dtrue, which explicitly
> >> clears the uptodate flag:
> >>
> >>     static void mpage_release_unused_pages(..., bool invalidate)
> >>     {
> >>         ...
> >>         if (invalidate) {
> >>             block_invalidate_folio(folio, 0, folio_size(folio));
> >>             folio_clear_uptodate(folio);
> >>         }
> >>     }
> >>
> >> If ext4_page_mkwrite() is subsequently called on such a non-uptodate
> >> folio, it can proceed to mark the folio dirty without checking its
> >> state. This triggers a warning in __folio_mark_dirty():
> >>
> >>     WARNING: CPU: 0 PID: 5 at mm/page-writeback.c:2960
> >>     __folio_mark_dirty+0x578/0x880
> >>
> >>     Call Trace:
> >>      fault_dirty_shared_page+0x16e/0x2d0
> >>      do_wp_page+0x38b/0xd20
> >>      handle_pte_fault+0x1da/0x450
> >>      __handle_mm_fault+0x652/0x13b0
> >>      handle_mm_fault+0x22a/0x6f0
> >>      do_user_addr_fault+0x200/0x8a0
> >>      exc_page_fault+0x81/0x1b0
> >>
> >> This scenario occurs when:
> >> 1. A write with delayed allocation marks a folio dirty (uptodate=3D1)
> >> 2. Writeback attempts block allocation but detects filesystem corrupti=
on
> >> 3. Error handling calls mpage_release_unused_pages(invalidate=3Dtrue),
> >>    which clears the uptodate flag via folio_clear_uptodate()
> >> 4. A subsequent ftruncate() triggers ext4_truncate()
> >> 5. ext4_block_truncate_page() attempts to zero the page tail
> >> 6. This triggers a write fault on the mmap'd page
> >> 7. ext4_page_mkwrite() is called with the non-uptodate folio
> >> 8. Without checking uptodate, it proceeds to mark the folio dirty
> >> 9. __folio_mark_dirty() triggers: WARN_ON_ONCE(!folio_test_uptodate())
>
> Thank you a lot for analyzing this issue and the fix patch. As I was
> going through the process of understanding this issue, I had one
> question. Is the code flow that triggers the warning as follows?
>
> wp_page_shared()
>   do_page_mkwrite()
>     ext4_page_mkwrite()
>       block_page_mkwrite()   //The default delalloc path
>         block_commit_write()
>           mark_buffer_dirty()
>             __folio_mark_dirty(0)  //'warn' is false, doesn't trigger war=
ning
>         folio_mark_dirty()
>           ext4_dirty_folio()
>             block_dirty_folio  //newly_dirty is false, doesn't call __fol=
io_mark_dirty()
>   fault_dirty_shared_page()
>     folio_mark_dirty()  //Trigger warning ?
>
> This folio has been marked as dirty. How was this warning triggered?
> Am I missing something?
>
> Thanks,
> Yi.
>

Hi Yi,

Thank you for your question about the exact flow that triggers the warning.

You're correct that the code paths within ext4_page_mkwrite() and
block_page_mkwrite() call __folio_mark_dirty() with warn=3D0, so no
warning occurs there. The warning actually triggers later, in
fault_dirty_shared_page() after page_mkwrite returns.

Here's the complete flow:

  wp_page_shared()
    =E2=86=93
    do_page_mkwrite()
      =E2=86=93
      ext4_page_mkwrite()
        =E2=86=93
        block_page_mkwrite()
          =E2=86=93
          mark_buffer_dirty() =E2=86=92 __folio_mark_dirty(warn=3D0)  // No=
 warning
        =E2=86=93
        Returns success
    =E2=86=93
    fault_dirty_shared_page(vma, folio)  =E2=86=90 Warning triggers here
      =E2=86=93
      folio_mark_dirty(folio)
        =E2=86=93
        ext4_dirty_folio()
          =E2=86=93
          block_dirty_folio()
            =E2=86=93
            if (!folio_test_set_dirty(folio))  // Folio not already dirty
              __folio_mark_dirty(folio, mapping, 1)  =E2=86=90 warn=3D1, tr=
iggers WARNING

The key is that the folio can become non-uptodate between when it's
initially read and when wp_page_shared() is called. This happens when:

1. Delayed block allocation fails due to filesystem corruption
2. Error handling in mpage_release_unused_pages() explicitly clears uptodat=
e:

     if (invalidate) {
         block_invalidate_folio(folio, 0, folio_size(folio));
         folio_clear_uptodate(folio);
     }

3. A subsequent operation (like ftruncate) triggers ext4_block_truncate_pag=
e()
4. This causes a write fault on the mmap'd page
5. wp_page_shared() is called with the now-non-uptodate folio

From my debug logs with a test kernel:

  [22.387777] EXT4-fs error: lblock 0 mapped to illegal pblock 0
  [22.389798] EXT4-fs: Delayed block allocation failed... error 117
  [22.390401] EXT4-fs: This should not happen!! Data will be lost

  [22.399463] EXT4-fs error: Corrupt filesystem

  [22.400513] WP_PAGE_SHARED: ENTER folio=3D... uptodate=3D0 dirty=3D0
  [22.401953] WP_PAGE_SHARED: page_mkwrite failed, returning 2

With my fix, ext4_page_mkwrite() detects the non-uptodate state and
returns VM_FAULT_SIGBUS before block_page_mkwrite() is called,
preventing wp_page_shared() from reaching fault_dirty_shared_page().

Without the fix, the sequence would be:
- ext4_page_mkwrite() succeeds (doesn't check uptodate)
- block_page_mkwrite() marks buffers dirty (warn=3D0, no warning)
- Returns to wp_page_shared()
- fault_dirty_shared_page() calls folio_mark_dirty()
- block_dirty_folio() finds folio not dirty (uptodate=3D0, dirty=3D0)
- Calls __folio_mark_dirty() with warn=3D1
- WARNING triggers: WARN_ON_ONCE(warn && !folio_test_uptodate(folio)
&& !folio_test_dirty(folio))

The syzbot call trace confirms this:

  Call Trace:
   fault_dirty_shared_page+0x16e/0x2d0
   do_wp_page+0x38b/0xd20
   handle_pte_fault+0x1da/0x450

Does this clarify the flow?

Best regards,
Deepanshu

