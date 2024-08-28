Return-Path: <linux-ext4+bounces-3941-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADA296266D
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897E0281D31
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0D16EBE2;
	Wed, 28 Aug 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAkss3Gq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB315FCE6;
	Wed, 28 Aug 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724846131; cv=none; b=Tgh2TSL5PDXqQEOSO7UxB4/+Ft6AXl/HqntdSCC8TT3xNR3pS7H1NKr8FsmjhaVeip1ApmV8+GkBJMr8ezervLux5xfBacfjUdZzYcRhVNsIqvNhEu2eJFtkWbsHjigjR7Wl8+6eHaTeYKJszA5uTjWbT7G2XAN3Pj+PO/pVsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724846131; c=relaxed/simple;
	bh=yfSTqVh0PVbcNpBNzOmM83uKErU/WC+SwjK3o2JpC54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGUmLCpUUMLpiIdkEbi/Skj18YmSMEgwOyRrPz45yKh0MxO629LailnlNatUk14OE4ID69+eak0uSDmUM4SiZ1bTbMu9yTlEKQImSEUQm3bZZ/YUY7YJGJKIDW73YbaYpn1p7s4r1Y/fL5VV42FRIC6MIKO4A4rNE6uUPW39B30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAkss3Gq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2021a99af5eso60085205ad.1;
        Wed, 28 Aug 2024 04:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724846129; x=1725450929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfSTqVh0PVbcNpBNzOmM83uKErU/WC+SwjK3o2JpC54=;
        b=UAkss3GqlZL5KZfA/AWYHfS0iKhWCTyOUX3RSkWtBKpeRv+Q02g9SLtkukI8lcqZJW
         oR9OTIfG3SC0ytFWyd+B1xYEG5Vz6wywc87ytVEi1M9h3yYYhGpZbXL0TZULZgQwan5U
         QWeFT8sGw1YEoruTuHXLJitqbxBm/m05Kl7oOtKFJjS0nlUsqdchwedMDzhdKCdPti0z
         ojNvyjOhDnGK5rGVsaQE6UG8+CSmewUM+Mj6fPwtZ4DX/heh0QY4t7Jv48hGxXz8eLhe
         lb6zdxu+kFaR0UmaOi1qRHXFtB9ZpkNi+FnanJ62ltW6ewuXtYYAj0EUa5cro5AwhuiP
         aaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724846129; x=1725450929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfSTqVh0PVbcNpBNzOmM83uKErU/WC+SwjK3o2JpC54=;
        b=a4sg2CqZeIc836E2HUpZn/f5Ww6xvCh1JBufJ7zvMZyaWN+r6eQiVPnYHXGNrNy/5R
         fjpfoIn6h3BtUBtZk9/bQnisyB3NXtddWLT8tQZipd9p74FORQ3p9Cppu4w3cvV+Vt1m
         3XZ9U4aLcLYLbENkS+sO6W6p8E0Vf6cY7KOpzTko/hDmhLbWCY1Q1/2ndxE9RyNeVSW3
         vUfNkNxvUspZ8UVVW71IG5eS0vxQdjYmHuvqx6OnEg+tFFeyMOcj3QmCtsgtKWHR43SD
         IxWac34P5yQ/brW4esOejV9+oIJi2S++VqlXdNAkRM1sKc3XxZDf7GX93YoMYoaaC/aA
         Iz0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkSZsVRm7EhhsYR9DjKFKURVOHZobP3+S0eRlMWZjYUO+Vnzq11+ae50GAJ/7L+qAmQcx3DJLO9LQeLdtN@vger.kernel.org, AJvYcCUo/bkPdW7ON5ruT5ZSDBkPoPN+cIrrSOeyOhqDOBQz3oRHzv7JvPnQJIncMwfxsJUmNFVblpZUGgRp@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkRKLLJR3X+qMvDDXomdmy7CBycNzLZje1Y9NsSNf6eUGbH/a
	71CeL4t0O9lwTIs7cr/zqlKLPsqHhkJSLekXlRCIDPjiWyDKND9BLImK1w==
X-Google-Smtp-Source: AGHT+IGNA51zq81heq7J7h/aE5w6K8YB6Q9qPr97tQJ1HYBWNEwDTBbf/K0iFAkvfJ+kgjaG7/5gzw==
X-Received: by 2002:a17:903:22c5:b0:203:a11a:30c8 with SMTP id d9443c01a7336-203a11a30e9mr177455475ad.43.1724846129316;
        Wed, 28 Aug 2024 04:55:29 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556685dsm97194805ad.62.2024.08.28.04.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:55:28 -0700 (PDT)
Message-ID: <c2724c5c2c17127866e6ed5c69b8f1f24d4c2db3.camel@gmail.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in
 jbd2_cleanup_journal_tail
From: Julian Sun <sunjunchao2870@gmail.com>
To: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>, 
 syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com, jack@suse.com, 
 jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
 linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org, mark@fasheh.com,
 ocfs2-devel@lists.linux.dev,  syzkaller-bugs@googlegroups.com,
 ~lkcamp/discussion@lists.sr.ht
Date: Wed, 28 Aug 2024 19:55:24 +0800
In-Reply-To: <20240828105452.z6tqwq47bcnmrevd@quack3>
References: <00000000000070a66706204e7698@google.com>
	 <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>
	 <20240826133208.GB424729@mit.edu> <20240828105452.z6tqwq47bcnmrevd@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 12:54 +0200, Jan Kara wrote:
> On Mon 26-08-24 09:32:08, Theodore Ts'o wrote:
> > On Mon, Aug 26, 2024 at 01:22:54AM -0300, Vinicius Peixoto wrote:
> > > Since the disk data is bogus, journal_reset fails with -EINVAL
> > > ("JBD2:
> > > Journal too short (blocks 2-1024)"); this leaves journal->j_head
> > > =3D=3D NULL.
> > > However, jbd2_journal_load clears the JBD2_ABORT flag right
> > > before calling
> > > journal_reset. This leads to a problem later when
> > > ofcs2_mount_volume tries
> > > to flush the journal as part of the cleanup when aborting the
> > > mount
> > > operation:
> > >=20
> > > =C2=A0 -> ofcs2_mount_volume (error; goto out_system_inodes)
> > > =C2=A0=C2=A0=C2=A0 -> ofcs2_journal_shutdown
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> jbd2_journal_flush
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> jbd2_cleanup_journal_ta=
il (J_ASSERT fails)
> > > ...
> > >=20
> > > I confirmed that setting the JBD2_ABORT flag in journal_reset
> > > before
> > > returning -EINVAL fixes the problem:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static int journal_reset(j=
ournal_t *journal)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 journ=
al_fail_superblock(journal);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 journal->j_fla=
gs |=3D JBD2_ABORT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -EINVAL;
> > >=20
> > > You can find a proper patch file + the syzbot re-test result in
> > > [1].
> > > However, I'm not entirely sure whether this is the correct
> > > decision, and I
> > > wanted to confirm that this is an appropriate solution before
> > > sending a
> > > proper patch to the mailing list.
> >=20
> > The reason why this isn't an issue with ext4 is because the normal
> > "right" way to do this is if jbd2_journal_load() returns an error,
> > is
> > to call jbd2_journal_destroy() to release the data structures with
> > the
> > journal --- and then don't try to use the journal afterwards.
>=20
> Yep. OCFS2 guys are actually looking into fixing this in OCFS2
> (
> https://lore.kernel.org/ocfs2-devel/20240819131120.746077-1-sunjunchao287=
0@gmail.com
> /)
> Not sure what's the status though. Julian, did you send v2 of your
> fix?

Yeah, I have already submitted the v2[1] of the patch and it is
awaiting review.

[1]:
https://lore.kernel.org/ocfs2-devel/20240823083150.17590-1-sunjunchao2870@g=
mail.com/
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Honza
>=20
> > The weird thing is that there are two code paths in ocfs2 that
> > calls
> > jbd2_journal_load().=C2=A0 One is in ocfs2_replay_journal() which does
> > what
> > ext4 does.=C2=A0 The other is ocfs2_load_journal() which does *not* do
> > this, and this is the one which you saw in the syzkaller
> > reproducer.
> > It looks like one codepath is used to replay the ocfs2 for some
> > other
> > node, and the is to load (and presumably later, replay) the journal
> > for the mounting node.
> >=20
> > There are also some other things which look very confusing, such as
> > the
> > fact that ocfs2_journal_shutdown calls igrab:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* need to inc inode us=
e count - jbd2_journal_destroy will
> > iput. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!igrab(inode))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0BUG();
> >=20
> > ... which is *weird*.=C2=A0 Normaly the journal inode refcount is
> > expected
> > to be bumped before calling jbd2_journal_init_inode() --- which
> > normally is done by an iget() function, and is needed to make sure
> > the
> > journal inode isn't released out from under the jbd2 layer.=C2=A0 It
> > looks
> > like ocfs2 uses the journal inode for other stuff so get the
> > journal
> > inode without calling something like iget().=C2=A0 Which is OK, I guess=
,
> > but it means that there are a whole bunch of places where it has to
> > call !BUG_ON(igrab(journal->j_inode) before calling
> > jbd2_journal_destroy().=C2=A0 It would seem like the *right* thing to d=
o
> > is
> > to bump the refcount in ocfs2_journal_init(), and if for some
> > reason
> > the igrab fails, it can just return an error early, instead of
> > having
> > to resort to BUG_ON() later, and if you don't realize that you have
> > to
> > do this weird igrab() before calling jbd2_journal_destroy(), you'll
> > end up leaking the journal inode.
> >=20
> > Anyway, I think the right thing to do is to restructure how ocfs2
> > calls the jbd2 journal, but that's going to require a more careful
> > examination of the code paths.=C2=A0 Your patch is a bit of a blunt
> > force
> > hack that should be harmless, but it's probably not the best way to
> > fix the problem, although doing it "right" would be more
> > complicated....
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0- Ted

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

