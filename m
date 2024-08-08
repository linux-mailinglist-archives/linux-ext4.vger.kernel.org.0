Return-Path: <linux-ext4+bounces-3667-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3C94B550
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A01C20D55
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FA2D052;
	Thu,  8 Aug 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4egLMh6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35861A291;
	Thu,  8 Aug 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086365; cv=none; b=e1DbMZxbolr7ObZ/dB3/CPAp93os0PihQ5cOMEoG0QF1jFfLfWE2Qg1B8e4yNOJGrMtk4/LqZvNmBJRSZAKzigMabTgYzrxJblENllbGTKc0ttQZZb5rTDmZQSjsn1jvjaBWYMCO/CfxpktBXLwR1ZP0aVuYiO/NXCsJUfudmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086365; c=relaxed/simple;
	bh=NTVg4k52Ld7Qb5fRMa1cOVh7BXz9c+aNB4LooZF0n7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXM0CaR2BtANm1l7MDYW21s6V8h2lzM7wboWjKJ1twi7sz7yFPxall7qs7Yuo3pLfJ9m8hbFLEkJx1q9NtvFOsMqqMiznuhiNC3KVjeCusHlY0to7bwJcAz8x4QAHiYgls5efZjLajJ9qeRgQXHn9dXHjfgS9Ihdgcr72widwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4egLMh6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ff50affc5so3078561cf.1;
        Wed, 07 Aug 2024 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723086362; x=1723691162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+aurtEh+//psw1dedoJ0a/PdwxNeh43gUGAszzKC0k=;
        b=G4egLMh6QtTcZelco+k9fon0JX0UPgmcyYPOrUfzZKDpn48I5ZtfddHx3k95jagPhS
         YEcJVWpXGedQAcrVleDV8uGtnmB6Zjm/2UkyocCA7x9Fq2pPm3PkrXA+lZX5wG3+w+FU
         Mh0npSi+BGlrJkOT5zg/9U3vaeZGa4iTJTfu/inJdSdSd5SCmzSHN4UV7AbP0oI4k0Cr
         yP7JH5e616h11gzSbf38PSUp/splnq0oHVpeZypHbedkdBdGuEHy+Dfe47+yVZMxZifD
         OajZXTeAsUIVzzkFJvBvD6ctUBQIVkn3lbnTj4rnyksNGyPFPxPCxlCiff7ul+VSI1+S
         CcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723086362; x=1723691162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+aurtEh+//psw1dedoJ0a/PdwxNeh43gUGAszzKC0k=;
        b=F+rKMMomcw0kp2XT3V5MivvbX+s4xuUMKy4Pc2yC4zhum5yB5lGYz06XFVNc1FYXm2
         BbkYv2lAzecYvdTn7xB31NYokNZ6N9AOTNTeuzGu9DTaIpit9JXEC0iZb+jlmEW1Xq2D
         lxl6ikQ+Bl41iJ5jfPvi3QOSe5GjEFg3g3agay10drwu9uqCkiK35RvjFmSFSfKOwACo
         AiQ7eYUUYXS+/hgPuiRgXUHcBiLiIVdvZ+soD6fggZkDQmQLkVf+2jw3jSB+3SiP4nY/
         iaMfWZ7AM0FRlhTaU9zhq0qPlLlykRq6u47yYsyEIQ8D8XmaxK7OEf0AQCDph99Twl5H
         NJIA==
X-Forwarded-Encrypted: i=1; AJvYcCUvoj4gcgSaa9LKGg55ftrJYbDB3z4tkEU4kUygiXmPwCv8wdYDzHPyElCggkvGOL7YNJSJmA29VrwpzPJW2T6TPuGFyAh5CbuzmoWEc2Imirg40rczB9xeh9nCHF3WmQuPnm0feojHTQ==
X-Gm-Message-State: AOJu0YywNVnMwqyxcSP5A+iV4XNTjwvOdRJjL/aWQ1aceGlVOn39olek
	WwMuCmEwdXR9NuobKBzB4xFUrhtvEp9eQB37iOiIEwA4MqDurrd57Wmk+tGrFg+PpI1DuTHZDwa
	G0XzlP4iXwgnRakrZI+A65SFIGfg=
X-Google-Smtp-Source: AGHT+IGbxRYYeWrxFBirDQVYm9kGQ0jwT983PaKpIulhAXv0XPmXZ+4rOojNGMeQENWtEnQdEC/abcfiU0jcEfW7n8Q=
X-Received: by 2002:a05:622a:598c:b0:447:e6d8:57a4 with SMTP id
 d75a77b69052e-451d430b037mr5885061cf.62.1723086362395; Wed, 07 Aug 2024
 20:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062356.2522658-1-zhangshida@kylinos.cn>
 <20240806134023.rm2ggd7swopryqci@quack3> <CANubcdV32L71ARCznZgKdrt0BmSyOYwW50L17zP=TG4PO2MH4Q@mail.gmail.com>
 <20240807120659.y6cpxas5g3mze2rr@quack3>
In-Reply-To: <20240807120659.y6cpxas5g3mze2rr@quack3>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Thu, 8 Aug 2024 11:05:26 +0800
Message-ID: <CANubcdVHbbq=WsTXU4EWAUPUby5--CLe5rf1GPzNPv+Y0a9VzQ@mail.gmail.com>
Subject: Re: [RFC PATCH] jbd2: fix a potential assertion failure due to
 improperly dirtied buffer
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B48=E6=9C=887=E6=97=A5=E5=91=A8=
=E4=B8=89 20:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed 07-08-24 16:10:50, Stephen Zhang wrote:
> > Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B48=E6=9C=886=E6=97=A5=E5=
=91=A8=E4=BA=8C 21:40=E5=86=99=E9=81=93=EF=BC=9A
> > > On Sat 20-07-24 14:23:56, zhangshida wrote:
> > > > From: Shida Zhang <zhangshida@kylinos.cn>
> > > >
> > > > On an old kernel version(4.19, ext3, journal=3Ddata, pagesize=3D64k=
),
> > > > an assertion failure will occasionally be triggered by the line bel=
ow:
> > >
> > > OK, just out of curiosity, why are you using data=3Djournal mode? It =
doesn't
> > > really get that much testing and the performance is quite bad...
> > >
> >
> > It is used by one of our customers. It's more like a historical issue:
> > About 12 years ago, they used data=3Djournal mode for the benefit of us=
er
> > data consistency brought by the mode.
> > Time goes by, they attempted to change, say, maybe change it to ext4
> > at least, but found it is no more stable than it was under ext3...
> > And yeah, they decided to just leave the thing as it was and keep the s=
ystem
> > under that state until now...
>
> I see, thanks for sharing. I was asking because we are mostly trying to
> steer away people from using data=3Djournal mode and deprecate it because=
 it
> adds a lot of complexity into the code without significant benefit.
>

Yeah. Though I am not an experienced file system developer, I was thinking
the philosophy behind the data=3Djournal design sometimes.

In essence, unlike the metadata, the user data could be dirtied in an unexp=
ected
and uncontrollable way.

For example, calls like __block_write_begin() is a function that could dirt=
y
the user data, but __block_write_begin() is beyond ext4 maintainer's contro=
l.
We cannot tell the block layer maintainer, =E2=80=98Hey, we want to trace t=
he dirty user
data in ext4, can we add some special code for ext4 in __block_write_begin?=
=E2=80=99:P

Whilst for metadata, each time the dirting of each piece of metadata is man=
aged
by ext4's internal code logic.

The uncontrollable dirting of user data is the root cause of all problems.

> > > > jbd2_journal_commit_transaction
> > > > {
> > > > ...
> > > > J_ASSERT_BH(bh, !buffer_dirty(bh));
> > > > /*
> > > > * The buffer on BJ_Forget list and not jbddirty means
> > > > ...
> > > > }
> > > >
> > > > AFAIC, that's how the problem works:
> > > > --------
> > > > journal_unmap_buffer
> > > > jbd2_journal_invalidatepage
> > > > __ext4_journalled_invalidatepage
> > > > ext4_journalled_invalidatepage
> > > > do_invalidatepage
> > > > truncate_inode_pages_range
> > > > truncate_inode_pages
> > > > truncate_pagecache
> > > > ext4_setattr
> > > > --------
> > > >
> > > > First try to truncate and invalidate the page.
> > > > Sometimes the buffer and the page won't be freed immediately.
> > > > the buffer will be sent to the BJ_Forget list of the currently
> > > > committing transaction. Maybe the transaction knows when and how
> > > > to free the buffer better.
> > > > The buffer's states now: !jbd_dirty !mapped !dirty
> > > >
> > > > Then jbd2_journal_commit_transaction(=EF=BC=89will try to iterate o=
ver the
> > > > BJ_Forget list:
> > > > --------
> > > > jbd2_journal_commit_transaction()
> > > >       while (commit_transaction->t_forget) {
> > > >       ...
> > > >       }
> > > > --------
> > > >
> > > > At this exact moment, another write comes:
> > > > --------
> > > > mark_buffer_dirty
> > > > __block_write_begin_int
> > > > __block_write_begin
> > > > ext4_write_begin
> > > > --------
> > > > it sees a unmapped new buffer, and marks it as dirty.
> > >
> > > This should not happen. When ext4_setattr() truncates the file, we do=
 not
> > > allow reallocating these blocks for other purposes until the transact=
ion
> >
> > ext4_setattr() will try to free it by adding it to the BJ_Forget list
> > for further processing.
> > Put it more clearly,
> > when ext4_setattr() truncates the file, the buffer is not fully freed
> > yet. It's half-freed.
> > Furthermore,
> > Because the buffer is half-freed, the reallocating thing won't need to =
happen.
> > Now,
> > under that scenario, can we redirty the half-freed buffer on the BJ_For=
get list?
> > The answer may be 'yes'.
> >
> > redirty it by the following code:
> > ext4_block_write_begin
> >     if (!buffer_mapped(bh)) { // check 1
> >          _ext4_get_block(inode, block, bh, 1);
> >         (buffer_new(bh)) { // check 2
> >              if (folio_test_uptodate(folio)) { // check 3
> >                  mark_buffer_dirty(bh);
>
> <snip>
>
> I see, right. It is not that the block would get reused. It is just that
> the buffer_head on the file's tail page gets reused and this causes issue=
s.
> In fact, the problem is with ext4_block_write_begin() (and
> __block_write_begin_int()) that they call mark_buffer_dirty() on a
> journalled buffer before calling jbd2_journal_get_write_access() (which
> would remove the buffer from BJ_Forget list). This is what ultimately
> confuses the commit code.
>
> > For another proof, there is indeed a small window where the buffer coul=
d be
> > seen dirty.
> > Have a look at the code and comment in do_journal_get_write_access:
> > ----------------
> > int do_journal_get_write_access(handle_t *handle, struct inode *inode,
> > struct buffer_head *bh)
> > {
> > ...
> > /*
> > * __block_write_begin() could have dirtied some buffers. Clean
> > * the dirty bit as jbd2_journal_get_write_access() could complain
> > * otherwise about fs integrity issues. Setting of the dirty bit
> > * by __block_write_begin() isn't a real problem here as we clear
> > * the bit before releasing a page lock and thus writeback cannot
> > * ever write the buffer.
> > */
> > if (dirty)
> > clear_buffer_dirty(bh); // clear the dirty immdiately in case some bad
> > things happen
>
> OK, it was even me adding that comment 14 years ago ;) I already forgot
> about this nuance.
>

That's quite a long time. Jan, you are a great developer. Cheers for you.:P

> So I agree with your analysis now. But still don't like adding hacks to
> jbd2 to acommodate for this oddity of data=3Djournal mode. Since we alrea=
dy
> have ext4_block_write_begin() implementation anyway, we should be able to
> tweak it to do the right thing for data=3Djournal mode inodes...
>
> So we could replace uses of __block_write_begin() with
> ext4_block_write_begin() and then call do_journal_get_write_access() in
> ext4_block_write_begin() for inodes with journalled data after the buffer
> is mapped with get_block().
>
> From the part:
>                                 if (folio_test_uptodate(folio)) {
>                                         clear_buffer_new(bh);
>                                         set_buffer_uptodate(bh);
>                                         mark_buffer_dirty(bh);
>                                         continue;
>                                 }
>
> we can actually remove the clear_buffer_new() and mark_buffer_dirty() bit=
s
> because they will be done by block_commit_write() or
> folio_zero_new_buffers() and they are superfluous and somewhat odd here
> anyway.
>
> And the call to folio_zero_new_buffers() from ext4_block_write_begin()
> needs to call ext4_journalled_zero_new_buffers() for inodes where data is
> journalled.
>
> Will you try to implement this or should I look into it?
>

Yeah, Thank you for giving me the opportunity to work on something truly
meaningful. All I can do until now is some small cleanups. And doing cleanu=
ps
all the time is annoyable to the maintainers and frustrating to me. I
will try my best.

So basically, we should:
1.Trace the user data dirting in ext4_block_write_begin().
2.Replace the uncontrollable __block_write_begin with ext4_block_write_begi=
n().
3.Remove some superfluous things.

Cheers,
Stephen.

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

