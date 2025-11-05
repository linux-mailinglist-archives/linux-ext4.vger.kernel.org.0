Return-Path: <linux-ext4+bounces-11489-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B7C35854
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 12:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B864F828C
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF663112DB;
	Wed,  5 Nov 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaDFH1P+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DA2FC034
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343493; cv=none; b=SwI/QMU9xxY39jk6QFYiFd3jdIlBLecsk87cZ/Ctk1kl2QYDlCEy5BpG+fWwwCZEKKab7SAxAYWwTZ1YTf5OcejKiLuQN0Z1pMvWPebmZTKYPyUVSlIebk08gGYnLESJF4u75Fr2DSMGV7mPeINsYpK5NmG75sdYEQg7++7K39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343493; c=relaxed/simple;
	bh=Tu9n9NnovVctLVlXdzYT3XTzj4GBSdV2bG12rdYeYhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyjFybSXwnkMoBdRYuZy6ygixJbyztJc2vchw9n9M4ocih89e+2b3rMx6WSqCXwfUyBWnzw0rZB4lvnqViWkkFccE9vtr/A9+194T9TIN1zf5DeG33gzDHqyOCI6/TM1Sy+g36pxx0qnChTrs5ZFouaI5uLRueMuwB9HY4xXgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaDFH1P+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b2a51750so6627593a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 05 Nov 2025 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762343490; x=1762948290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBOSl6pD9va2npR8bvYE6uY0VVOqzBIXrSyh8Q41oCY=;
        b=EaDFH1P+xt+cfCxJqjduzXKkIIOTl+KIQaxaDb9+jMXB1rliOpRyq87HWs+WZwBfQ8
         3+kVWxgV2pf63zl8bvAvszUGIokKKpnElS3cOg3jCLx6Y63sGXK91favapx5WVleuC/g
         3m4C20F2Fx9kFpvq3UYaMGl/yq9AxZ24ZU1EOMPGLh2PwmoQNkqDEGdQoVtb7LtH5Uu7
         rfb8e72PNysvzQoQeDVVhBsJ9YzA06qov9y5lCrGb5MuY46fedCC5wT+Aqe+Kkz0OvsB
         LyS//fx3QyeIas1bt+OEKia/mz9Zy/3ufDDp9LL067kmUMfWiLlJCSOToyolctgpSEzN
         J1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343490; x=1762948290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBOSl6pD9va2npR8bvYE6uY0VVOqzBIXrSyh8Q41oCY=;
        b=Yv1ln34voCbA0hwk6IcXgMAxLXwepua/g/v0sUQQfcMm21OtEYu7hgEcyx6+4QXXNO
         oLgOMYavQ7hQ76sKyaXdpEE3BXXyJMJYnuby5cma3h2L4duObyn0p76OEv7vNpWKCUyA
         9ggy21jWcbo3pyMiXZO6nweFulFnQwSF/OephpltXCiblkf/dmgA75fum5uQUHKN991G
         MIJGPXgDmkTn/NM7y09ycGqFDpi5pedjRP7CxxIVFV4y7gxXz6r1nX+arQd8yw0BXunQ
         XreGi8xbzAf6NlL+w2kbvgnMMISM04N4QkqbGAmUB3WUFwSpRJ/zn7omv/6314YiZ01X
         Sykg==
X-Forwarded-Encrypted: i=1; AJvYcCVnevVCveZNQCXTBdOWxoMREL1JgLfIZKO/+z9QuGpq4iu1U3g7acSLL2YjTUCqdI8JZE+buFYKYv3d@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhscgTGoongtmdIOVvjW950/fOl9Gk7rAOwW5JF4k8l9i0F7S
	Wb6ccNvzQDrOJZw0McZ6lUCx0iQouvnif+vUx92DtF7DDOESbHBCVuUekbg+Jn6vKC3iITzngzu
	/5B8dwMtVj+kO+e0ZKjZYNBJPNY5fjUI=
X-Gm-Gg: ASbGncuu7WuCiM7bG3fnDWThWaIL+s10NOkJ5DD9xOxlilRO71+Hn1GwWC8k4tkDo9r
	H60r3SQfL+/QoTM8HkXNo0ZP7mwy4RWk0E5A/YtwtQsCYc1smei0nxYzTr+dYLfQvnUGbLEsjjH
	yQaHI6EaN/jM+Eu5YFb8L0AV6BxWCf24yOXgx2dG9sA2xU4d2WOw5AQW+Qb3O3NRjyL2OavjOjW
	g3S9lbOn+8bmerw0Dw5IF8E/dJ0e+FUz9wOK8igMdRjbv+A000IRj549XbxsWz2UKN7E6zrm8Di
	SNZzd2abgG067+I=
X-Google-Smtp-Source: AGHT+IFxmWNp2BQNRRARVBw1UkvbAPrXqb7by6fcY2sFoKYINuOjwAC+gpfmeJUhpea01PtyF9yDw6J53Cypt4ETdms=
X-Received: by 2002:a05:6402:144a:b0:640:bb31:cbf4 with SMTP id
 4fb4d7f45d1cf-641058b30c2mr2389322a12.11.1762343489390; Wed, 05 Nov 2025
 03:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu> <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
 <20250413124054.GA1116327@mit.edu> <CAGudoHFciRp7qJtaHSOhLAxpCfT1NEf0+MN0iprnOYORYgXKbw@mail.gmail.com>
In-Reply-To: <CAGudoHFciRp7qJtaHSOhLAxpCfT1NEf0+MN0iprnOYORYgXKbw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Nov 2025 12:51:16 +0100
X-Gm-Features: AWmQ_blIK6-wuX86CTfA092C43j9omx8HCq1kgLMG--DuF0my_1OyHjIGCxPiEo
Message-ID: <CAGudoHHrUkcGvhE3kwc9+kgdia_NREEeTj=_UBtiHCpUGEYwZg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:50=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Sun, Apr 13, 2025 at 2:40=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wro=
te:
> >
> > On Sun, Apr 13, 2025 at 11:41:47AM +0200, Mateusz Guzik wrote:
> > > This is the rootfs of the thing, so I tried it out with merely
> > > printing it. I got 70 entries at boot time. I don't think figuring ou=
t
> > > what this is specifically is warranted (it is on debian though).
> >
> > Well, can you run:
> >
> > debugfs -R "stat <INO>" /dev/ROOT_DEV
> >
> > on say, two or three of the inodes (replace INO with a number, and
> > ROOT_DEV with the root file system device) and send me the result?
> > That would be really helpful in understanding what might be going on.
> >
> > > So... I think this is good enough to commit? I had no part in writing
> > > the patch and I'm not an ext4 person, so I'm not submitting it myself=
.
> > >
> > > Ted, you seem fine with the patch, so perhaps you could do the needfu=
l(tm)?
> >
> > Sure, I'll put together a more formal patch and do full QA run and
> > checking of the code paths, as a supposed a fairly superficial review
> > and hack.
> >
>
> It looks like this well through the cracks.
>
> To recount, here is the patch (by Linus, not me):
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index f386de8c12f6..3e0ba7c4723a 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block *sb=
, unsigned long ino,
> >                 goto bad_inode;
> >         brelse(iloc.bh);
> >
> > +       if (test_opt(sb, DEBUG) &&
> > +           (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> > +            ei->i_file_acl))
> > +               ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode->i_=
ino);
> > +
> >         unlock_new_inode(inode);
> >         return inode;
>

sigh, copy-pasto, the patch is:
  --- a/fs/ext4/inode.c
  +++ b/fs/ext4/inode.c
  @@ -5011,6 +5011,11 @@ struct inode *__ext4_iget(...
        }

        brelse(iloc.bh);
  +
  +     /* Initialize the "no ACL's" state for the simple cases */
  +     if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_=
acl)
  +             cache_no_acl(inode);
  +
        unlock_new_inode(inode);
        return inode;

> In my tests it covered most real-world lookups on my debian box.
>
> Sorting this out acts as blocker for a lookup optimization I'm working
> on which bypasses all perm checking if an inode has a flag indicating
> everyone can traverse through it.

