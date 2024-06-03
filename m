Return-Path: <linux-ext4+bounces-2755-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A28D8554
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE781C21648
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DD130A76;
	Mon,  3 Jun 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw9GPi8t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288F130A54
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425810; cv=none; b=I1W7zDLSpCsN7Lh++OUijx19q2nqkpEH/spJPqggIzb72HbMQslZewfMaZMJMNn+e66d++/zrUyQlLqZwSyfBUUpjyyXlNjfffsx1YJXVumdDZPLh/fLAP+8a8FR2x9tRynLwDFrGZGQxOQNUfX0lOFezevNRRnSRDOUYHT6LzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425810; c=relaxed/simple;
	bh=qoJ5Iy4yFwa1SFVcehQ4ALiqel5bYIC+hTfSwU2yAjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaBjs5FRykxn7bMgraRFugxhsxCG0JV7YXxHzmYKCMrIdCeOwRvGl092q3SqY3mjHIn9v9jYypANOsuDCLcdzheCg2MI746ztOtu3SfVp/qQ/GS84TcYX9rjR87P0dalML4rnTcseeLwhYfHeNNiqIJFWMqXTD2vRlLkhqbyCwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw9GPi8t; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so3901309a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 03 Jun 2024 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717425808; x=1718030608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0ILl6untH+VccYEAmzkW+dUDoohQnatMzvdT/ns45o=;
        b=lw9GPi8tckh0CgidC80CWyfKS6RztSPtHPPopKV36CgRCoda/ZrsJaHx6DkC9YYOEN
         m2Me2tt04i7QcQDBkDnadNir2sbv0NkpQYWg0UmOTo0GZhlIYi3Sg3mO15pBePH1Tvu1
         TUnfQ1q5M+MC2ZGj1RbE0FHh4y6AIpquTsrJXK1lkm4LGsedQIIDkNMQQPwHVCHlllTz
         OwmD6oqsnLwZNg8AMLNpSJyK1g+dUHDFMnkdjfTHbkkTq55KptpK4hiidc74tlDBPBKh
         EXOh1bK4eg8f4W5gQmMEaaj9icSCl0jxWW+qEnEql6S6spC3BlMOHX3t6q3HlPJc6ZEs
         Zjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717425808; x=1718030608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0ILl6untH+VccYEAmzkW+dUDoohQnatMzvdT/ns45o=;
        b=K8GHCpIJuXWVvOjyOb0G5Q11Byb6XeU58HrqS5Jrr5ky1jhCRHgNsr+5mDgfY0sEqm
         mfD/iofDq23IZJL7zHsTHY+DMnCu6R3HMc1XzNTrqI5CDpSeQMRAE7jFM2HLHcJ1rldc
         MEZNpKiTYSEqAvqvCpucHiiMr/dvP/r/MJcjdAMGIDOc6wHj6W/9lH3v7cXZ4SOpfQDj
         dkQ6gOYhls34R+VlEnTlMfTZVQPUQiRl+xmMCp3/Y6eDXXYeg5pLopLIaB2JU0QhwwQC
         vjXvJI05r62kil4rws7k1ase+CzTtiqHhpKopmO/XorIFk8bDtpGP0F5CTYIzdP4pp/7
         0exw==
X-Gm-Message-State: AOJu0Yz1UNU3D2dKVUQvBcyT4zJbNwPPPuuIlDzS7kuYSJSNw8IzmG19
	c8WEayCoCOV6o1AtIvGR+N7wRyEmZhM6CI/mz3/DgRnWKSKuZD9pr0zo4d9IRDxuJBeUbBTHxrJ
	Sla2B1/fUYWF7Dr1qDhUR0hRrJ5k=
X-Google-Smtp-Source: AGHT+IF+pRLAz3s2t6zz5l+//DI1l/tQMT5utlusujBNFJiqWlq+ieZUixTXmeoGHIJ44OIrT4PP2W6hF93F68w4fvk=
X-Received: by 2002:a50:ba89:0:b0:57a:321f:cc4f with SMTP id
 4fb4d7f45d1cf-57a3f55eb7emr6178429a12.19.1717425807401; Mon, 03 Jun 2024
 07:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603131524.324224-1-sunjunchao2870@gmail.com> <20240603140705.vfpdrbyljw6yfxpd@quack3>
In-Reply-To: <20240603140705.vfpdrbyljw6yfxpd@quack3>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Mon, 3 Jun 2024 22:43:16 +0800
Message-ID: <CAHB1NagapRk62L9vn0uSKYJMMSq=9kNiB+jdaxA3JBY16f9jig@mail.gmail.com>
Subject: Re: [PATCH] ext4: Adjust the layout of the ext4_inode_info structure
 to save memory.
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B46=E6=9C=883=E6=97=A5=E5=91=A8=
=E4=B8=80 22:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon 03-06-24 21:15:24, Junchao Sun wrote:
> > Using pahole, we can see that there are some padding holes
> > in the current ext4_inode_info structure. Adjusting the
> > layout of ext4_inode_info can reduce these holes,
> > resulting in the size of the structure decreasing
> > from 2424 bytes to 2408 bytes.
>
>
> > But AFAICT this will save two holes 4 bytes each so only 8 bytes in tot=
al?
> > Not 16?

Indeed it's 16.
Consider the layout int a; hole 0; int b; hole 1; And then move int b
to hole 0 position, this adjustment resulted in saving 8 bytes. There
are two adjustments like this, so it's 16. And GDB confirmed this.

>
> >
> > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
>
> Otherwise looks good. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>                                                                 Honza
>
> > ---
> >  fs/ext4/ext4.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 023571f8dd1b..42bcd4f749a8 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1055,6 +1055,7 @@ struct ext4_inode_info {
> >
> >       /* Number of ongoing updates on this inode */
> >       atomic_t  i_fc_updates;
> > +     atomic_t i_unwritten; /* Nr. of inflight conversions pending */
> >
> >       /* Fast commit wait queue for this inode */
> >       wait_queue_head_t i_fc_wait;
> > @@ -1103,6 +1104,10 @@ struct ext4_inode_info {
> >
> >       /* mballoc */
> >       atomic_t i_prealloc_active;
> > +
> > +     /* allocation reservation info for delalloc */
> > +     /* In case of bigalloc, this refer to clusters rather than blocks=
 */
> > +     unsigned int i_reserved_data_blocks;
> >       struct rb_root i_prealloc_node;
> >       rwlock_t i_prealloc_lock;
> >
> > @@ -1119,10 +1124,6 @@ struct ext4_inode_info {
> >       /* ialloc */
> >       ext4_group_t    i_last_alloc_group;
> >
> > -     /* allocation reservation info for delalloc */
> > -     /* In case of bigalloc, this refer to clusters rather than blocks=
 */
> > -     unsigned int i_reserved_data_blocks;
> > -
> >       /* pending cluster reservations for bigalloc file systems */
> >       struct ext4_pending_tree i_pending_tree;
> >
> > @@ -1146,7 +1147,6 @@ struct ext4_inode_info {
> >        */
> >       struct list_head i_rsv_conversion_list;
> >       struct work_struct i_rsv_conversion_work;
> > -     atomic_t i_unwritten; /* Nr. of inflight conversions pending */
> >
> >       spinlock_t i_block_reservation_lock;
> >
> > --
> > 2.39.2
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

