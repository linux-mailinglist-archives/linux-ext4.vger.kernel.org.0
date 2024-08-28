Return-Path: <linux-ext4+bounces-3942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC25962719
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170A61F240F1
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28A175D5C;
	Wed, 28 Aug 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THq9inij"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635C175D32;
	Wed, 28 Aug 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848119; cv=none; b=mrlD15/oklS3MLD/APKw8OfMaQzmjOskw8678OV2z65ys+oM/yuSsBVn8EXJmuKFolIZRTCv9B6CENkdGtydhmYv8Fin4zVz/g+V3LloAkVwDYjhXkNYj2gGwv2xbjg4h/I+P6UdkbnOhcr5OV5xDNrenMAjQ7MLnGGVtLbBSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848119; c=relaxed/simple;
	bh=ydgTnPCTTt+R6cduYTkN8H0L9V2wA4s8+gRAaVsg7fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvsL4NOx5Lkj23azLUmgitTF8LebBJk09S7vBme96iJZD7gezdPDjzM0Hd26lNKlnXX+dNW8CsHWOeP0ei4ipXlvi3c9QxLhJip6qoWqBcpF4XCh84j0za7B8AJm9Vw0kGltdpUmbp65BAhiMsaOf1dIdPxhwxakf9UbQO9fS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THq9inij; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7143ae1b560so3750191b3a.1;
        Wed, 28 Aug 2024 05:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724848117; x=1725452917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydgTnPCTTt+R6cduYTkN8H0L9V2wA4s8+gRAaVsg7fk=;
        b=THq9inijOd6mcK29mcnGZDCRfeiduHrAhElHWytFCbOYnpFYOF4/zRdFgdOCaoAPAB
         Amb8e+rOvp44QXtb8I7aNLYfaeJbT0/MQ9TWyHwElTSktPHEP5Q1U6uG70x9vUQYE0tf
         lfsk94z1qNjFnHtqDCFkhnKlB96WSH8Nq7xtQo9hRQ5H88KjIbfoVE5/wzV8hjZFETXO
         aHOADdgTzHNs+SugRFy89kAWiRN41Gm+JNa4tSnAt9kBLjPCvu2sHfxnC7bMntIzUemT
         DrRECC8cukXcXVBEyd8T3i+ypNey6t/vTcdYq2MKPbDOGfW6oJhBUmu0hxeGCX2ALQcD
         Xz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848117; x=1725452917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydgTnPCTTt+R6cduYTkN8H0L9V2wA4s8+gRAaVsg7fk=;
        b=uPBuiFGnh21na0For0AU6HckUHtVOFyFmnWsf2Lg6caayoakeLrEQayN/Fbv/BvSFg
         89lDJR4dc/XBjCxU6JozlAkbO3zB53PJ+HX2FwDX5EcUiiceiiH99igD+zlzpPZA3toG
         l7sx4NfNb3PSNLBNxL6dRCxi3BsXmAaEnE3j4bbRzffb7gLsWFFz7leoVPbFvaSNsjg4
         TVTSWWrmTyTyBIF1bL8Uosd1tEdfpTcUuoHCVLjAPKN05X7fMJDzYa/GuVZ99yCm9nuy
         c6YUzCDRJi1X/Bhg8+5Hlwt+jKAsa5LzVjAX3VuXVhkzGCtyRtEvH1J+hoTsk1qnwrgi
         UEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWayyQ0fRRJwSEkDKw1kplMQ1zoAskYDpNAoMBcEXNLiLCAmZ1eG9K/rsjKcW/gOgi8QXl8C+N1i7sUxYqP@vger.kernel.org, AJvYcCXF10jzPjqRt11NQ1OyIX5TzI/OMSKX3bRdDStKluXoGvT8yOpucmVp8UmEKOAf4aUL/abMbx/7ozLl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5g/gwDA72lx2mutQ1u+6kqAJtfP6ajBL2OwBGZiOeOoOc3pf
	8EiF2TtSVr4KfUAPUn7xtJo5VZ885PueMOQLiVmGCfAhN+COUUAD
X-Google-Smtp-Source: AGHT+IGX0QEAP2skQLc03J6yMxkt2H76BNEBFwbKwZnMdRIouS7hPH/hEu6fMciyq6JVlpEW19CTpw==
X-Received: by 2002:a05:6a20:c6ce:b0:1ca:c673:9795 with SMTP id adf61e73a8af0-1ccd289e14bmr1603844637.22.1724848117070;
        Wed, 28 Aug 2024 05:28:37 -0700 (PDT)
Received: from [127.0.0.1] ([103.85.75.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556a2f7sm98404605ad.9.2024.08.28.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 05:28:36 -0700 (PDT)
Message-ID: <80ad8de73bc8bea5d77f0802e65e970d5993c65a.camel@gmail.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in
 jbd2_cleanup_journal_tail
From: Julian Sun <sunjunchao2870@gmail.com>
To: Joel Becker <jlbec@evilplan.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>, 
 syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com, jack@suse.com, 
 joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev,
  syzkaller-bugs@googlegroups.com, ~lkcamp/discussion@lists.sr.ht
Date: Wed, 28 Aug 2024 20:28:32 +0800
In-Reply-To: <ZszY3SHWTp7XfS3z@google.com>
References: <00000000000070a66706204e7698@google.com>
	 <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>
	 <20240826133208.GB424729@mit.edu> <ZszY3SHWTp7XfS3z@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 12:34 -0700, Joel Becker wrote:
> On Mon, Aug 26, 2024 at 09:32:08AM -0400, Theodore Ts'o wrote:
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
> > The reason why this isn't an issue with ext4 is because the normal
> > "right" way to do this is if jbd2_journal_load() returns an error,
> > is
> > to call jbd2_journal_destroy() to release the data structures with
> > the
> > journal --- and then don't try to use the journal afterwards.
> >=20
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
>=20
> You are correct, Ted, that one path is for the local journal and the
> other is to recover remote journals for other nodes that may have
> crashed.
>=20
> I think the big ordering issue is that we set
> osb->journal->j_state=3DOCFS2_JOURNAL_LOADED in ocfs2_journal_init(),
> before we've attempted any replay.=C2=A0 Later in
> ocfs2_journal_shutdown(),
> we check this state and decide to perform cleanup.
>=20
> Instead, we should not set OCFS2_JOURNAL_LOADED until
> ocfs2_journal_load() has called jbd2_journal_load().=C2=A0 Only then do w=
e
> actually know we have loaded a valid journal.

Yeah, it's right. We should not set OCFS2_JOURNAL_LOADED in
ocfs2_journal_load(). Instead, we should set other flag like
OCFS2_JOURNAL_INIT, to indicate that resources have been allocated.
This way, we can clean them up properly in ocfs2_journal_shutdown(). We
should distinguish between these two states to ensure the correct exit
procedure when an error occurs, just like this patch[1] does.

[1]:
https://lore.kernel.org/ocfs2-devel/20240823083150.17590-1-sunjunchao2870@g=
mail.com/
>=20
> Something like:
>=20
> ```
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D jbd2_journal_l=
oad(journal->j_journal);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (status < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mlog(ML_ERROR, "Failed to load journal!\n");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BUG_ON(!igrab(journal->j_inode));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0jbd2_journal_destroy(journal->j_journal);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0iput(journal->j_inode)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto done;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0journal->j_state =3D OCFS=
2_JOURNAL_LOADED;
> ```
>=20
> With code like this, when jbd2_journal_load() fails, the future
> ocfs2_journal_shutdown() will exit early, because
> !OCFS2_JOURNAL_LOADED.
>=20
> I think this is the right spot; a quick audit of the paths (it has
> been
> a while) doesn't find any other outstanding state; the rest of
> journal
> startup, such as the commit thread etc, only happen after this.
>=20
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
>=20
> There are interactions of journal inodes for nodes we don't own, and
> also connections to cluster locks for our own journal (don't replay
> ourselves while another node has locked it and is recovering us).=C2=A0 S=
o
> we
> do have some state to keep track of.=C2=A0 But it's been so long that I
> don't
> recall if there was a specific reason we do this late via igrab(), or
> if
> it's just that we should have done as you describe and missed it.
> You'll note that I copied the igrab/iput game in my snippet above.
>=20
> Should someone try to audit the igrab/iput thing later?=C2=A0 Yes.=C2=A0 =
But
> it's
> not a necessary part of this fix.
>=20
> Thanks,
> Joel
>=20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

