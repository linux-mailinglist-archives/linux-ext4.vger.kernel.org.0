Return-Path: <linux-ext4+bounces-2715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C18D3D1E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66428285122
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E6C187320;
	Wed, 29 May 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyxSnmTn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FE156978;
	Wed, 29 May 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001549; cv=none; b=G01blq4gndxVOaC5gr2jgDU8RGll009gkdBBPs8R6BuLJtNbX4HjYRMYYHjhYsarB2ou85G2fwv3wyq1BQU8kaXTjmlYW0I4r/Q3g2ZgWyNFuao+7ArmeJ/B6uKaf0gDMtMX5Ob+zxzcLUuz5Qn8pgSQNVcVYmFitsyTufz88dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001549; c=relaxed/simple;
	bh=lhmTSP5KkBtml0allUWgmBZsBqqH1RON7RLAlmIh4ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1pE1vCgv3uZbsaKkSU+le3Uq5dm+UFVj4iUlb+lzRdMelmUW099pR59LXkD8RxKFrA14tFhqaK8azjPpS+1nuRzwsNBbBoAIEIlT8TH4pMZfPTyUTzer3cKxEC34Mn+dHl6/ggEtTh9UGZVTccjw5WdzQr2e2k6zf23yQ/IrLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyxSnmTn; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a0809c805so24574727b3.0;
        Wed, 29 May 2024 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717001547; x=1717606347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MEs2nLK5nYgOc+8YCIgrapGI28e79137f7LPZefBNU=;
        b=dyxSnmTnWOY4rIHtkKt3TP5ySmhbynXsEr0NyK61bSsvq6h85bpWLKfNNsf7VgY+vR
         a6LOm/xoTj+pLTXGozeiHAvVBsDZjI+SL5589y0e9Dd1GqjKoFExDR5YGTPCww7dWI5S
         fI39KqLsHDpn6cZAMhrI4+jKxx+S1G8xr3BDL2HfEMqOqzDaAm8LbgLnxC+xy5sv6P8Z
         5QuexAij+dAO+p5gRAOtHa7tYQ6skaS0as19AONNJmPWu+k2voAt9fjHogcZw3aMBJy0
         GHZdtai7DimQSwqtbfjQDyZZzWAO2alpGUiiaY2QUG3kjdnMj79YhQcJEmoLARunW3UL
         oIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717001547; x=1717606347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MEs2nLK5nYgOc+8YCIgrapGI28e79137f7LPZefBNU=;
        b=W8sthqj7VBTpfNISFCuxQA+K3u9pygdClmKrRJP7P1OzGgzk8DXDcmw01hINjDAfEn
         Kb3QYfYafbT4M0pWKVP+mJVUwxmnGYfwVxv+6jEK4ao0k3ViOizofz8ECECtcC+RA4xF
         aA4jk+SAjMRx4kDwfhwRbcfgc2pp27T60x9cjzg80vVpa2DrfLe3RmmYzeYkC/cSz7Sd
         LkD4+QrUfRHzRIEh88wrcB9UUB+BwSpl6KaExy+YQBNA+a+A3BTQIyGXMwLPRH1XG6oz
         An19/qDpm+AoYV/MIHoyBzv4hySGMGTBWtHgqv4FQj4nQylClvvkljsKVZ3kqHK5cVDH
         jJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEyXurPdmvv7REDbiyoa6mcqDX9xt7eyllLZbBh4P7lmNQajn8k7jMd7VNwhcx6pFycZ9OVSdDFYhTrswgsyh3JTLwKGSAJDLm0L6friSgI8RV3itqcc7hCXpR6AFP8cWLeHme2Pv/6w==
X-Gm-Message-State: AOJu0YzT7lqqOOexQkiVw71HbHLMf7Xe1Ho6SnoxSVYnrhTjq0f7GUa6
	z5o1z3a6iXqK92pdj+Yw6GGR/MMcx9XCkvzXIScFP2GCM+VdLu9cG/XwdnL8/CwnOpB57f98aia
	Zr5I8j84SayqKsg6NRPKIG1M3W135BWmd
X-Google-Smtp-Source: AGHT+IFAMqIX3LEiCZe4nYflWQTVNDXp+MSaj/ia8y1Wp9ehvgjUgZoOPkcBzwtgqYVe6fZ8JaIpWZoeLlTfv4cutBI=
X-Received: by 2002:a05:690c:660d:b0:62a:530:1e53 with SMTP id
 00721157ae682-62a35ec8f2cmr126279067b3.30.1717001547085; Wed, 29 May 2024
 09:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <20240529092030.9557-2-luis.henriques@linux.dev> <20240529095032.kax3nwtsofyk6qxz@quack3>
In-Reply-To: <20240529095032.kax3nwtsofyk6qxz@quack3>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Wed, 29 May 2024 09:52:15 -0700
Message-ID: <CAD+ocbzb5YR2gLxCJcafH4e0Zcq6CCE5Ugibk6urx0yJ8WMfjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Wed, May 29, 2024 at 2:50=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-05-24 10:20:29, Luis Henriques (SUSE) wrote:
> > When a full journal commit is on-going, any fast commit has to be enque=
ued
> > into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueu=
eing
> > is done only once, i.e. if an inode is already queued in a previous fas=
t
> > commit entry it won't be enqueued again.  However, if a full commit sta=
rts
> > _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit need=
s to
> > be done into FC_Q_STAGING.  And this is not being done in function
> > ext4_fc_track_template().
> >
> > This patch fixes the issue by re-enqueuing an inode into the STAGING qu=
eue
> > during the fast commit clean-up callback if it has a tid (i_sync_tid)
> > greater than the one being handled.  The STAGING queue will then be spl=
iced
> > back into MAIN.
> >
> > This bug was found using fstest generic/047.  This test creates several=
 32k
> > bytes files, sync'ing each of them after it's creation, and then shutti=
ng
> > down the filesystem.  Some data may be loss in this operation; for exam=
ple a
> > file may have it's size truncated to zero.
> >
> > Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Looks good to me! Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> Just a typo correction below.
>
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 87c009e0c59a..088bd509b116 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1282,8 +1282,17 @@ static void ext4_fc_cleanup(journal_t *journal, =
int full, tid_t tid)
> >               list_del_init(&iter->i_fc_list);
> >               ext4_clear_inode_state(&iter->vfs_inode,
> >                                      EXT4_STATE_FC_COMMITTING);
> > -             if (iter->i_sync_tid <=3D tid)
> > +             if (iter->i_sync_tid <=3D tid) {
> >                       ext4_fc_reset_inode(&iter->vfs_inode);
> > +             } else {
> > +                     /*
> > +                      * re-enqueue inode into STAGING, which later wil=
l be
> > +                      * splice back into MAIN
>                            ^^^ spliced
>
> > +                      */
> > +                     list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_lis=
t,
> > +                                   &sbi->s_fc_q[FC_Q_STAGING]);
> > +             }
> > +
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

