Return-Path: <linux-ext4+bounces-5043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C89C49CB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 00:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6711F22318
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F31B4F07;
	Mon, 11 Nov 2024 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MaFoWM7h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10715887C
	for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368407; cv=none; b=aA0+F39e0wudjlE+MdR36QzXnC+tkEP4cFvhEZIylYbbZQXOETuI1NEux192CkuhVifKozENrBZsefWDUwA8pBJtNgJFlpfNcal1JaiSVnUV/j5UN4RaB7bCCNVSyBfie2n9j+0jGkCaT6Ke8soHSF+ScY2iWO35SaDfxQgTDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368407; c=relaxed/simple;
	bh=5iMzA2h0qeiCLS/UE7L1mkZIgcrO/N5kJ3Okms4mkXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOWZeOpv+etq11oao19HqIq58DeCVnWsZOToK41kIf80uT5u20otSn82DeOsdIUnk+bKrGqUPm21XXOp5wW8KDE/22i6wtOLI5UONEKaehKEvTvIlQNrHi6hUxyDPfkyKE95E8Ds/CVYI3KceKY5STATbP4bk/IBEwE0cJgOXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MaFoWM7h; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1119114666b.1
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731368403; x=1731973203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfrZKwA8Q666Z7hBV0+zRbjc85gr+W93j+HNejLY+JI=;
        b=MaFoWM7hevsEdWFdrgCZSbWcdpEnFSNE4CP4FyvurW5Kj6wQm3Jggs9pKqwRqLnPvz
         Pi7x9auIB+Zyni48FVCjbLHpMekpS+A0J5yihRHUgK85qCgsDKFyccCgmgx/3obk4vua
         CS4Qx1baVn32N+xMX7r9pAhoaLQXccZxkQl3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368403; x=1731973203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfrZKwA8Q666Z7hBV0+zRbjc85gr+W93j+HNejLY+JI=;
        b=D29TvBbpQNC3MJ5fJe4kYtTx3iwSixD0V/W2k+DuH6I0veJVxStVQqngkS8OrSRP/e
         N3g91thj0r5nM1rS7c5fAoF3M4IPHf8Am9riMlrnxuMm9xNkpxAUVbRP1iNQgxAFrKtG
         ONMNVspZOZtnuNDRtsl/4iLBjGkA1V096cUdfsKXK+0vWVpak2c2ptUSl0ySk3spbCl+
         4MEX0sPpn1RKyz+ySjm7sN6T0PkxZVwsoZhPMGKfmBTXQJs2fRZcF2lBihMAS7WOn7Tw
         3WnAKmaQJgWvLX0MpfIsQf6k4QPE5i7rbZfw+VcStIgL3De70sNlvBn0mUdoENcZThD/
         SWhg==
X-Forwarded-Encrypted: i=1; AJvYcCW9tXPod/rAcn/5+JwPXMKmEH0GM0nWmTLF6gUHyElqgdBAeLVzL65TJ57t8G4E+cp9AXqy583/Ov85@vger.kernel.org
X-Gm-Message-State: AOJu0YycdGTs+iLqeOWBaI/aqjQ179FyENxu27a+7USqnKEENP3h9KyK
	t7xPpGSbPgcKx4/V1C6a9nzmrE3lb6ouOhNn34yNLia4yu27xt52hfeA1e05ZT1h56QDveeFi7T
	LsyY=
X-Google-Smtp-Source: AGHT+IFQlD/WEBSFfiN/puXrTg8XyJblnwpw5hXXOKxoUBvJOfqxj+HqdghincM9vVQqkz6lnl6vXQ==
X-Received: by 2002:a17:907:1c10:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9eecab7d2amr1376185266b.26.1731368403254;
        Mon, 11 Nov 2024 15:40:03 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b90esm653808066b.65.2024.11.11.15.40.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:40:02 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso10765070a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 11 Nov 2024 15:40:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUolcGFYU5vlQ/SGojcL69ddYbOtewrcLqhBg3CYSqdrOeb9DNJdkeqIS/tnwvsCjP/WmgN3B9MhCik@vger.kernel.org
X-Received: by 2002:a17:906:ee8c:b0:a93:a664:a23f with SMTP id
 a640c23a62f3a-a9eefe3f3famr1355377966b.5.1731368401330; Mon, 11 Nov 2024
 15:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com> <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 15:39:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9hc8sSNYwurp5cm2ub52yHYGfXC8=BfhuR3XgFr0vEA@mail.gmail.com>
Message-ID: <CAHk-=wh9hc8sSNYwurp5cm2ub52yHYGfXC8=BfhuR3XgFr0vEA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 15:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See why I'm shouting? You're doing insane things, and you're doing
> them for all the cases that DO NOT MATTER. You're doing all of this
> for the common case that doesn't want to see that kind of mindless
> overhead.

Side note: I think as filesystem people, you guys are taught to think
"IO is expensive, as long as you can avoid IO, things go fast".

And that's largely true at a filesystem level.

But on the VFS level, the common case is actually "everything is
cached in memory, we're never calling down to the filesystem at all".

And then IO isn't the issue.

So on a VFS level, to a very close approximation, the only thing that
matters is cache misses and mispredicted branches.

(Indirect calls have always had some overhead, and Spectre made it
much worse, so arguably indirect calls have become the third thing
that matters).

So in the VFS layer, we have ridiculous tricks like

        if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                if (likely(inode->i_op->permission))
                        return inode->i_op->permission(idmap, inode, mask);

                /* This gets set once for the inode lifetime */
                spin_lock(&inode->i_lock);
                inode->i_opflags |= IOP_FASTPERM;
                spin_unlock(&inode->i_lock);
        }
        return generic_permission(idmap, inode, mask);

in do_inode_permission, because it turns out that the IOP_FASTPERM
flag means that we literally don't even need to dereference
inode->i_op->permission (nasty chain of D$ accesses), and we can
*only* look at accesses off the 'inode' pointer.

Is this an extreme example? Yes. But the whole i_opflags kind of thing
does end up mattering, exactly because it keeps the D$ footprint
smaller.

                  Linus

