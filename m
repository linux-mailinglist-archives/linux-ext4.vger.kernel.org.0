Return-Path: <linux-ext4+bounces-2714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6B8D3D19
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 18:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC58A1F24A65
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B36184138;
	Wed, 29 May 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ5SqURa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37059156978;
	Wed, 29 May 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717001505; cv=none; b=aEY4pHaXabcPS9uVY3mhOMK4+de4XDC9/ne0P2QaWN8MNVLC0ufgMFxpP5us1JydwcO5LknRRP3Ve5kTOyxooFKa0OJv/F43ETX3Cq72don2RR99Vx9lKRw9S2YJZNwbobvZ5DV0gYKGgMPiUjWzsHuhtqdWkWBNO91+3qiAozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717001505; c=relaxed/simple;
	bh=VPgKlgdFN2OwMZZCbkCzrWejPt99PvTRuiI793jxjKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlPeTaxnHdDyyYOy7kLRcIsMQEZG0G1KT5gIpBOxxyVDds+tWwErUkSs3TAG6gAOwjBmprv+vHLIZJecIc4tiGWiKpR5hA0evJvvbwoge+9wwpBpXlCv5TYREN9FHyuz6CnDs358cxxp4arp5gyNaXc4e9GRoMGCXbJbx/goTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ5SqURa; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a0827316eso23153897b3.1;
        Wed, 29 May 2024 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717001503; x=1717606303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFPICCOhOH0BYtaoyCICMZQxCXss3C7sP/8izB2OWrU=;
        b=AZ5SqURaz6Q7i11sRGmSDpnKP3YGYxas32R+Y15Kvhb8tyAGyOW5tezU1rKDV+YHak
         /Z0yVErNIrwliRF/AeTjJX0Niv5wy62CR+GAQhpnsNURsMAeYYzM/KIMH8MPq/WwiV5s
         tD67Rv4Nt0JfOcqWzna0jxFg9DDvDE33m5sXxeQB3GDPQniBma65vG0pMOpNXU/rf6qB
         lrSY2lCMeGYfiF/P2kOeNq6x+ckzDc8qYwQOlkxdrRKpfR6JdDyRbyEk0SCfJ9IRXdXw
         F0JLjhCMzksxOaY87gmzf13xdGw9bom3iAZarhtv64Ysnvae/GQa+92BElBu56D8xTRz
         oGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717001503; x=1717606303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFPICCOhOH0BYtaoyCICMZQxCXss3C7sP/8izB2OWrU=;
        b=gmS/IUbKO3yW8SJe4e8NdUNGW2XTbGzjStfTyNNRllx+67aoJF1rUuQHpWp6uVXOvn
         MAY7my0VAu0J5fAiArR75IkPj2Nfw70MMnpDsckToAg/YBHv0hXQZMSMB7DQvAWQgXrD
         AOEvhzUsY28j/+fGoa3tdYL+GL15bvqhHrfij/k2oyEbFS9u654eCUAG+TqwTVtsSC/F
         rlgmbMdY7QCrO3VtkRY2M+smV6H8+0AUu96iltnMvb1JFEkq3n2aGpgHEM+2cnN3ZezZ
         ky3VFJ8n329DWus0Gf65ssY7cr/mFglXE/0CnG4lh+hhgq55hdv94AHydmrN3BGmyxHp
         xmWw==
X-Forwarded-Encrypted: i=1; AJvYcCWV8ZQ6dluCs8ti7j3+lpXtcBXhBiImUBb4D5Fp8RZ6EcpgeReomuQPX09ZVGaTCPoxjyxvM5CdYx/PvQqfXFZ5aS4z4mgk/fd8mbGMofkFQSWUuz8bhc12JEtpS7qz/rXn6ARyqs6Nuw==
X-Gm-Message-State: AOJu0Yw1kbIee6uujEMCjrFw6gYfXMMRgGEfj6Ho4RtJt+iNJUq9bMJF
	Zgq7/LbxjqFXCjSBfqWMLJXiKZApSxeCWQib9eUZsnv2Sm39ClQIYEXmcnoKjDxphx9WhU5Vmjd
	PEauMez5vI0solQm49nhJ986K8UQ=
X-Google-Smtp-Source: AGHT+IE3afUL0RV98DI4QowoC6bm6wbxQFBcEq4igP8DUOT75gRCSRInym/4bhiihsBNogC6Mrtb/+cs5/VkEpc4qNg=
X-Received: by 2002:a81:b649:0:b0:627:dd90:daed with SMTP id
 00721157ae682-62c59cddb46mr38261717b3.27.1717001503066; Wed, 29 May 2024
 09:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <20240529092030.9557-3-luis.henriques@linux.dev> <20240529095116.b3arzr5rjz6cs2rb@quack3>
In-Reply-To: <20240529095116.b3arzr5rjz6cs2rb@quack3>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Wed, 29 May 2024 09:51:31 -0700
Message-ID: <CAD+ocbxzkLJuVhTCwEZpcjZk5tVP3H6KBL_73S2xhA7xeb3Qkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ext4: fix possible tid_t sequence overflows
To: Jan Kara <jack@suse.cz>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, thanks for the patch!

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>


On Wed, May 29, 2024 at 2:51=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-05-24 10:20:30, Luis Henriques (SUSE) wrote:
> > In the fast commit code there are a few places where tid_t variables ar=
e
> > being compared without taking into account the fact that these sequence
> > numbers may wrap.  Fix this issue by using the helper functions tid_gt(=
)
> > and tid_geq().
> >
> > Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>
> Thanks! Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/fast_commit.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 088bd509b116..30d312e16916 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -353,7 +353,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb=
, int reason, handle_t *handl
> >               read_unlock(&sbi->s_journal->j_state_lock);
> >       }
> >       spin_lock(&sbi->s_fc_lock);
> > -     if (sbi->s_fc_ineligible_tid < tid)
> > +     if (tid_gt(tid, sbi->s_fc_ineligible_tid))
> >               sbi->s_fc_ineligible_tid =3D tid;
> >       spin_unlock(&sbi->s_fc_lock);
> >       WARN_ON(reason >=3D EXT4_FC_REASON_MAX);
> > @@ -1207,7 +1207,7 @@ int ext4_fc_commit(journal_t *journal, tid_t comm=
it_tid)
> >       if (ret =3D=3D -EALREADY) {
> >               /* There was an ongoing commit, check if we need to resta=
rt */
> >               if (atomic_read(&sbi->s_fc_subtid) <=3D subtid &&
> > -                     commit_tid > journal->j_commit_sequence)
> > +                 tid_gt(commit_tid, journal->j_commit_sequence))
> >                       goto restart_fc;
> >               ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
> >                               commit_tid);
> > @@ -1282,7 +1282,7 @@ static void ext4_fc_cleanup(journal_t *journal, i=
nt full, tid_t tid)
> >               list_del_init(&iter->i_fc_list);
> >               ext4_clear_inode_state(&iter->vfs_inode,
> >                                      EXT4_STATE_FC_COMMITTING);
> > -             if (iter->i_sync_tid <=3D tid) {
> > +             if (tid_geq(tid, iter->i_sync_tid)) {
> >                       ext4_fc_reset_inode(&iter->vfs_inode);
> >               } else {
> >                       /*
> > @@ -1322,7 +1322,7 @@ static void ext4_fc_cleanup(journal_t *journal, i=
nt full, tid_t tid)
> >       list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
> >                               &sbi->s_fc_q[FC_Q_MAIN]);
> >
> > -     if (tid >=3D sbi->s_fc_ineligible_tid) {
> > +     if (tid_geq(tid, sbi->s_fc_ineligible_tid)) {
> >               sbi->s_fc_ineligible_tid =3D 0;
> >               ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> >       }
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

