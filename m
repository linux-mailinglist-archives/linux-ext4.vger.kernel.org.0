Return-Path: <linux-ext4+bounces-3239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FDB930309
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 03:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405CE1F22910
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A97FBF6;
	Sat, 13 Jul 2024 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBeALm1k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D14437
	for <linux-ext4@vger.kernel.org>; Sat, 13 Jul 2024 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720834715; cv=none; b=idmjScrzTD1UnyNXCB8jnKG8gzUhyTVkA3MinbQaDP3vzYyoajwc7XNiBPfFr/x/VbhB8G5POC0ax4g3l9znMYOCAzy3gAqvh3Mi6z2yL8+7IHrdiN8KvKrvtrd1L6se1hpeu9e2dvVxy3CFOQwGIblHPU1HA5KSO2ULbQ4a168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720834715; c=relaxed/simple;
	bh=PaJ0X5dQRHOl4qsEwRxNnUq18pOyOLhEBYXUxRZKbVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngTplkml91aQAtQkVriyvjZEWJe/QqxqFGGa7zj1CcxzKdSVVesF3+QsTUAW1kJf9UTPHG00dUVPw5Bljj5lMrBn/rJXUBAADG/UTs6mh/60WrZOBClK3daUli4Td7kcP0S0wyD7tRZlVriHYi4SahOyVSMrh+bv8xTOTXIohbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBeALm1k; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c661519bc2so1368099eaf.2
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 18:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720834712; x=1721439512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN9YybMQjR6hEo2QJ0R5jgZP88I/Uf9rv+48/NBSd5A=;
        b=SBeALm1kmX/LCPA37KecBnIALq6XLb8l8fT71KPgPHFPYpM0KqmGgmNoFZhSN8rdoN
         EA3UhpnK+K3k9vt4fW84L5PRMB4mZTI6b0hQkvAIF1OhcWl9KNPdyDkTtyt0jYamI9JE
         +EqGcn2oXuZGdm1SiVu2cUdwWTbInKd/vpdspc4YHJuaUHzlTceRep/CGAlwQcYu1cHZ
         pbSQNUHpa3IHNjFZ3ZtviFqRuPr7vYLIvTxoQYwXoAzxRk5pR4izzC3Rvp+TdgNe93c5
         wxdAbdg6oXad9RfmchIvj0EFkJndME9M1q0Nlu5otuKsZWYW1IuzAR7ePRtjmZGXbB5y
         Tm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720834712; x=1721439512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN9YybMQjR6hEo2QJ0R5jgZP88I/Uf9rv+48/NBSd5A=;
        b=msjLCYhE1vYXOeAjmf2GqaRbWm4cr5xave8oALRMTpYgOREuNBuao8eB724Yvr/SRJ
         HqR1sTbUbq7ol7Kq8Bq684UA2oTtjCqbZdGh5nHrvDfkC0dHZ4kncbr6TmhHGl46FKqB
         c6kpkqmE3Vz+xtlctx5JaJvFnQT1KKim3TQmGD1y2X5cqEhwWYC+qDPDR2ukSHEa0zzo
         FX/KDoBwae9dYkLe0JZoNEKy2LUkmWGFBZn2szh4fO3IDWsY5ehv/Q9U+gORnBtax6Cd
         PMzpXagOk6vRPU417p8Sbf3uRH3xUH9AVBt4UufnbNMw9+UJFWelaftW/UYYHEWmnvDy
         87iA==
X-Gm-Message-State: AOJu0Yy/tV9+sXV1wzLr8bXAuBRdv96Ff8VtFUinf76KA3+F5DBfKPQw
	RE1S+wkncjq4IE/LfxJ/kJddKoavrcZ2KTDf/P6c0JQ8hqC4vGBW+TDG4jU8X7yYyFuXx+qi7FT
	CKKB98zjzerJZt9DiiNgRd4xOgWLj7CWwgck=
X-Google-Smtp-Source: AGHT+IEeuxkveTK5Uszj2+OZis3shsKiEmERzx56Uh07J5YFE7OhHfU20d1Tq5A15gs8CXtLwYKSdK8rLQK0cKAGZPo=
X-Received: by 2002:a05:6359:6487:b0:19f:5244:d91b with SMTP id
 e5c5f4694b2df-1aade0df6ccmr923964555d.21.1720834712303; Fri, 12 Jul 2024
 18:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-5-harshadshirwadkar@gmail.com> <20240628134310.jlne3gscmac3e2ab@quack3>
In-Reply-To: <20240628134310.jlne3gscmac3e2ab@quack3>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Fri, 12 Jul 2024 18:38:21 -0700
Message-ID: <CAD+ocbxzTnB9Jd0NNgY3JtgiZdNgkdLRPTpr9qJoZVk0qMXHsA@mail.gmail.com>
Subject: Re: [PATCH v6 04/10] ext4: rework fast commit commit path
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com, 
	harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:43=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-05-24 01:19:57, Harshad Shirwadkar wrote:
> > This patch reworks fast commit's commit path to remove locking the
> > journal for the entire duration of a fast commit. Instead, we only lock
> > the journal while marking all the eligible inodes as "committing". This
> > allows handles to make progress in parallel with the fast commit.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ...
> > @@ -1124,6 +1119,20 @@ static int ext4_fc_perform_commit(journal_t *jou=
rnal)
> >       int ret =3D 0;
> >       u32 crc =3D 0;
> >
> > +     /*
> > +      * Wait for all the handles of the current transaction to complet=
e
> > +      * and then lock the journal. Since this is essentially the commi=
t
> > +      * path, we don't need to wait for reserved handles.
> > +      */
>
> Here I'd expand the comment to explain better why this is safe. Like:
>
>         /*
>          * Wait for all the handles of the current transaction to complet=
e
>          * and then lock the journal. We don't need to wait for reserved
>          * handles since we only need to set EXT4_STATE_FC_COMMITTING sta=
te
>          * while the journal is locked - in particular we don't depend on
>          * page writeback state so there's no risk of deadlocking reserve=
d
>          * handles.
>          */
>
> > +     jbd2_journal_lock_updates_no_rsv(journal);
> > +     spin_lock(&sbi->s_fc_lock);
> > +     list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> > +             ext4_set_inode_state(&iter->vfs_inode,
> > +                                  EXT4_STATE_FC_COMMITTING);
> > +     }
> > +     spin_unlock(&sbi->s_fc_lock);
> > +     jbd2_journal_unlock_updates(journal);
> > +
> >       ret =3D ext4_fc_submit_inode_data_all(journal);
> >       if (ret)
> >               return ret;
> > @@ -1174,6 +1183,18 @@ static int ext4_fc_perform_commit(journal_t *jou=
rnal)
> >               ret =3D ext4_fc_write_inode(inode, &crc);
> >               if (ret)
> >                       goto out;
> > +             ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> > +             /*
> > +              * Make sure clearing of EXT4_STATE_FC_COMMITTING is
> > +              * visible before we send the wakeup. Pairs with implicit
> > +              * barrier in prepare_to_wait() in ext4_fc_track_inode().
> > +              */
> > +             smp_mb();
> > +#if (BITS_PER_LONG < 64)
> > +             wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTIN=
G);
> > +#else
> > +             wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
> > +#endif
>
> Maybe create a helper function for clearing the EXT4_STATE_FC_COMMITTING
> bit and waking up the wait queue? It's a bit subtle and used in a few
> places.
>
> > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > index cb0b8d6fc0c6..4361e5c56490 100644
> > --- a/fs/jbd2/transaction.c
> > +++ b/fs/jbd2/transaction.c
> > @@ -865,25 +865,15 @@ void jbd2_journal_wait_updates(journal_t *journal=
)
> >       }
> >  }
> >
> > -/**
> > - * jbd2_journal_lock_updates () - establish a transaction barrier.
> > - * @journal:  Journal to establish a barrier on.
> > - *
> > - * This locks out any further updates from being started, and blocks
> > - * until all existing updates have completed, returning only once the
> > - * journal is in a quiescent state with no updates running.
> > - *
> > - * The journal lock should not be held on entry.
> > - */
> > -void jbd2_journal_lock_updates(journal_t *journal)
> > +static void __jbd2_journal_lock_updates(journal_t *journal, bool wait_=
on_rsv)
> >  {
> >       jbd2_might_wait_for_commit(journal);
> >
> >       write_lock(&journal->j_state_lock);
> >       ++journal->j_barrier_count;
> >
> > -     /* Wait until there are no reserved handles */
> > -     if (atomic_read(&journal->j_reserved_credits)) {
> > +     if (wait_on_rsv && atomic_read(&journal->j_reserved_credits)) {
> > +             /* Wait until there are no reserved handles */
>
> So it is not as simple as this. start_this_handle() ignores
> journal->j_barrier_count for reserved handles so they would happily start
> while you have the journal locked with jbd2_journal_lock_updates_no_rsv()
> and then writeback code could mess with your fastcommit state. Or perhaps=
 I
> miss some subtlety why this is fine - but that then deserves a good
> explanation in a comment or maybe a different API because currently
> jbd2_journal_lock_updates_no_rsv() doesn't do what one would naively
> expect.

AFAICT, jbd2_journal_commit_transaction() only calls
jbd2_journal_wait_updates(journal) which waits for
trasaction->t_updates to reach 0. But it doesn't wait for
journal->j_reserved_credits to reach 0. I saw a performance
improvement by removing waiting on reserved handles in FC commit code
as well. Given that JBD2 doesn't wait, I (perhaps incorrectly) thought
that it'd be okay to not wait in FC as well. Could you help me
understand why the JBD2 journal commit doesn't need to wait for
reserved handles?

- Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

