Return-Path: <linux-ext4+bounces-12567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A111CF19A5
	for <lists+linux-ext4@lfdr.de>; Mon, 05 Jan 2026 03:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9A8300C0DE
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jan 2026 02:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256E30DD1F;
	Mon,  5 Jan 2026 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pz7f+Je5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FD21D5BC
	for <linux-ext4@vger.kernel.org>; Mon,  5 Jan 2026 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767578894; cv=none; b=eW3KEWNSF8yLXmUwqlrYFwNcuMCKEo8o9UiQhFo5C2Bn48lEDW9j5ri1AmPnbfqXLq0oI9RRb9Vu0LBF1ogMHTpA7kUzSm7MLG/6YvPjTLBmuvi1KF4Wkuu8B0UmRKPGTb7g/vdoRuEyyPfeX34Maqf1IRQ2XfEl3MiEdVDyT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767578894; c=relaxed/simple;
	bh=VLCGO8LMVTfOOMXGO7eFxyOVpedERZ44XFhOcjH+tPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKj3lxsYxvJmgKTV8JOSkhJeDpIEUiokASJBrTMcSlMBHgS5Y4iQZPSF/wwrDlRDFF6S9RBwutUY/DDR6nXikAlZzea+ApGz/zm8tusiCiLEnNylhv3xEdhrsAjpNGCVJe9K7nxuPN53iaqhsaM6etXFFruBZGEHcCEUTEmLQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pz7f+Je5; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78fccbc683bso103460777b3.3
        for <linux-ext4@vger.kernel.org>; Sun, 04 Jan 2026 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767578891; x=1768183691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COz1YZYMuufDYpR4+kwbVsVbm5B2OI27JSM61iZDZAc=;
        b=Pz7f+Je5evrRAL2jKALDubcLgDd4Jhz5/pJ/yQkv7iABlg2vDVMAYowsPtlG7O8YLS
         czD7eDlTgjLHfMPDB2CXEqaNIMVa+yvjR9B5bca3HfSIF4k37sD+XBhWiRhurkan0eA1
         5kjH4pz7lLobXGutm7I/IdXz14PYosVY9IdNAOW9wmkylZx5XE/rNocTP6P4BWNvZ84Y
         ehnkjrpu6B27nS3wNlcEH0uAekU4a25MFbjJX8HTI6xFF3O+XiFpFyS7eD1HTFlqB6dW
         hlcW7qYhk4gf+I733oMOErUXemFQj3DypftXi0W2yr/BCq0X2ajXy2If3sKQBnEd8opx
         jrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767578891; x=1768183691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=COz1YZYMuufDYpR4+kwbVsVbm5B2OI27JSM61iZDZAc=;
        b=pSDAUPh2kt/cndjPAVNLLx9d7dYd2ksMeyxvgwwd1ELxo/c3zafvB7yfiOWAfffAei
         QVVpdEQ0jKx3DtiANz4Nv210JfIByRE3e5a00xefN1nsbYpWmCDgJkjmoSLmtkHsP+np
         WRxsp+O5TEuPCuhHuMBPLWi9MQeDr/+P4JVsU0zO0hDGo5+apgAqS+gClnxydT+IOUuK
         BZ/wVg6y8gDer1z+VDI8vaaNaNoM4dMpkv9yemGIsiKQnVkweAD/RcAs+Zik6bFdfJzH
         iHwUXzttyYshxT46IVTMR85j9rSkPKhcqw/C+L37aGE/cSuIb+l0UadCj67Sg7p8Sf5J
         iO+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz6OK70IV/I011Bhzn7XNbIspWP/+gJLo0GXwY5NkaW4NbjZlcHb4lWCE6S6fTNNw5py1cBN8NH41L@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfx99/Tt7E8lIqd+i0nHyUhoLDnG5B5Dh7w1d8S+xYcGxEMos7
	mYtc3QqfQLacF8yf/10RO/08cnVf5oRn3w+f3CoJMbagwP8tp9UQsQH80gfJm8wCQC9BM4gmyL2
	SST2Z3wE2sgrV9dXUNgZt1pgfrHdjVgU=
X-Gm-Gg: AY/fxX6tNaGs1BemmpT0khwaRhPUShDLovr71rB36rNaSG3hC9f4ZuE7KobcmR0Z0qo
	aCshcqM/inICP0Hs+MqZsT6sLEDW7f2hW8e99F5hOvfFhBGLjXKSHoAR2uAnshopNUgPKrdQn2L
	fMkHFlXiosKWU0mLsDwvWOIG3C4OVwsUsnxK7f9tg8houH3yD/Z+zP5OtsUSCSIZBp3wi1q7tD3
	0CkkOK0zEDxHbn1f2mEkVUWaTpal+JIYc7pHFATa5cn3l1fcVmaWNqTF1mfOnxXhcLJc40UMh38
	Q4CXZ7Yjw1j2ZoR9UauRU3+Hmsot6vri07f/87pNtDYUdOCneFMAR7tsmN0W
X-Google-Smtp-Source: AGHT+IG2DN6+m1VVgsg2DZ0jSZaguOv/8nDEh4/+XY03NOx9Ro0ClSJKf+HJUausMBH5GRXiOPDoBr83pe0Olt5QW60=
X-Received: by 2002:a05:690c:7083:b0:78c:2857:7e8d with SMTP id
 00721157ae682-78fb4001161mr448959507b3.37.1767578891490; Sun, 04 Jan 2026
 18:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com> <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan> <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan> <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
 <20251205021818.GF71988@macsyma.lan> <aTJSglQznqeph5lM@casper.infradead.org>
 <20251205133739.GA19558@macsyma.lan> <CADhLXY6bvnv9eipp1Uo5N3s9dKFoqEL+qom+ni3_4D_==+wJAg@mail.gmail.com>
In-Reply-To: <CADhLXY6bvnv9eipp1Uo5N3s9dKFoqEL+qom+ni3_4D_==+wJAg@mail.gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 5 Jan 2026 07:38:00 +0530
X-Gm-Features: AQt7F2qJ3vvGmUZHv3lUyOtnE0Z8wgHQVqfjiDJEM5DNYd4Z1Woes_ZBUgROfNA
Message-ID: <CADhLXY6ZPwXU8EQuLKF99mv9p5t85=jA0aKG=5+8TF=sVZjJyg@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: check folio uptodate state in ext4_page_mkwrite()
To: Theodore Tso <tytso@mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com, 
	adilger.kernel@dilger.ca, djwong@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 7:58=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> On Fri, Dec 5, 2025 at 7:08=E2=80=AFPM Theodore Tso <tytso@mit.edu> wrote=
:
> >
> > On Fri, Dec 05, 2025 at 03:33:22AM +0000, Matthew Wilcox wrote:
> > > It sounds like I was confused -- I thought the folios being
> > > invalidated in mpage_release_unused_pages() belonged to the block
> > > device, but from what you're saying, they belong to a user-visible
> > > file?
> >
> > Yes, correct.  I'm guessing that we were marking the page !uptodate
> > back when that was the only way to indicate that there had been any
> > kind of I/O error (either on the read or write side).  Obviously we
> > have much better ways of doing it in the 21st century.  :-)
> >
> > > Now, is the folio necessarily dirty at this point?  I guess so if
> > > we're in the writeback path.  Darrick got rid of similar code in
> > > iomap a few years ago; see commit e9c3a8e820ed.  So it'd probably be
> > > good to have ext4 behave the same way.
> >
> > Hmm, yes.   Agreed.
> >
> >     commit e9c3a8e820ed0eeb2be05072f29f80d1b79f053b
> >     Author: Darrick J. Wong <djwong@kernel.org>
> >     Date:   Mon May 16 15:27:38 2022 -0700
> >
> >     iomap: don't invalidate folios after writeback errors
> >
> >     XFS has the unique behavior (as compared to the other Linux
> >     filesystems) that on writeback errors it will completely
> >     invalidate the affected folio and force the page cache to reread
> >     the contents from disk.  All other filesystems leave the page
> >     mapped and up to date.
> >
> >     This is a rude awakening for user programs, since (in the case
> >     where write fails but reread doesn't) file contents will appear to
> >     revert old disk contents with no notification other than an EIO on
> >     fsync.  This might have been annoying back in the days when iomap
> >     dealt with one page at a time, but with multipage folios, we can
> >     now throw away *megabytes* worth of data for a single write error..=
.
> >
> > As Darrick pointed out we could potentially append a *single* byte to
> > a file, and if there was some kind of writeback error, we could
> > potentially throw away *vast* amounts of data for no good reason.
> >
> >                                      - Ted
>
>
> Hi Ted and Matthew,
>
> Thank you for pointing out the iomap commit. I now understand that
> invalidating folios on writeback errors is the wrong approach.
>
> Looking at Darrick's commit e9c3a8e820ed, iomap removed both
> folio_clear_uptodate() and the invalidation call, keeping folios in
> memory with their data intact even after writeback errors.
>
> For ext4, should I apply the same approach to mpage_release_unused_pages(=
)?
> Specifically, remove the invalidation entirely:
>
>   if (invalidate) {
>       /*
>        * On writeback errors, do not invalidate the folio or
>        * clear the uptodate flag. This follows the behavior
>        * established by iomap (commit e9c3a8e820ed "iomap:
>        * don't invalidate folios after writeback errors").
>        */
>       if (folio_mapped(folio))
>           folio_clear_dirty_for_io(folio);
> -     block_invalidate_folio(folio, 0, folio_size(folio));
> -     folio_clear_uptodate(folio);
>   }
>
> This would:
> - Keep user data in memory instead of discarding it
> - Prevent the WARNING since folio remains uptodate
> - Match the behavior of modern filesystems
> - Prevent data loss from discarding potentially megabytes of data
>
> Is this the correct approach? If so, I'll send v4 with this fix.
>
> Best regards,
> Deepanshu

Hi Ted and Matthew,

I wanted to follow up on my previous email about the fix approach.

Just to confirm: should I remove the folio invalidation from
mpage_release_unused_pages() entirely, following Darrick's commit
e9c3a8e820ed for iomap?

The change would be:

  if (invalidate) {
      if (folio_mapped(folio))
          folio_clear_dirty_for_io(folio);
-     block_invalidate_folio(folio, 0, folio_size(folio));
-     folio_clear_uptodate(folio);
  }

This keeps the folio in memory with data intact, prevents the WARNING,
and matches modern filesystem behavior.

If this approach is correct, I'll test and send v4. Otherwise, please
let me know what adjustments are needed.

Thank you,
Deepanshu

