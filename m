Return-Path: <linux-ext4+bounces-3240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3093032A
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 04:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1CF1C21376
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2024 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABAFC0B;
	Sat, 13 Jul 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMGlxrOK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD323D6B
	for <linux-ext4@vger.kernel.org>; Sat, 13 Jul 2024 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836098; cv=none; b=iCMjDYcVmAQ5Plq3FktsbE2IEXOmpfinEyBsDaiyY5e2u1wCYkPi+whJli5ow0IUWZJ0Y3wTVw01ua7bkuhgTNqdI+/xIIxuAjwNQSAWDJUzIMPr7AFC0FNzBd2zBtEQ9AeSHvbmk/Cz1wArtJBhdWwHyS1jSSEL+GwgGoS1D3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836098; c=relaxed/simple;
	bh=tJ618CrQBDvcVce2fYZhs1m9ajE1nji6Zp6dToQm0v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm+iFMMKs1FAD7wpiNF23RswdpXqKyOtjkVFwyREHlNkQAN/PauywsirvUPmQa0BhqNlGfUNv70XFnGxLKG/82bu6+LY3k22APoB/g7aRCALyTwByQgDIgP0JdPv4h25KIobbuAJde/OVetfvk1n+UsJUn5X1a3T2LhdAvtWluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMGlxrOK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7515437ff16so1761722a12.2
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jul 2024 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720836096; x=1721440896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkHScemr6umJIZqSTMc8cN8BZNCaVQgJqX8yQxWnjlY=;
        b=JMGlxrOKlBnOttfrlhWebdxiiBuOXxHmLojspREkpXHODAI+e9gfQAQ9u0vqubJBct
         44CX5/4F8EG41bJZs60JI0MEkyg4f8zCdQ3r/7kuhYzKI8ri9ij6qcstowzjuJr703Vl
         CchePlw8pEjhGrAHtqtViw2x76x58bAGfGTVbcXT/fPnmzv8vf85dpp8HJmXxeAYagDe
         O6MQrEzbs01IXn0qrBahsrgP+PAGuhtIS98yMFFmFjNBRsVi9k4pnfkx0yW90aFnxHn+
         jzRDFZe3yi9BaY8JDMxadKR3XmdnuIO/fR1/ljM476D5wb2hlPh/8u330zT0aFIwml1k
         pApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720836096; x=1721440896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkHScemr6umJIZqSTMc8cN8BZNCaVQgJqX8yQxWnjlY=;
        b=p/w8TmXPJBQe29+yyqTNQVf3kLStRsrqTlxPc53DKX9Jz1Qio6RTQa4LhNxGsfcawR
         Pzp9WW9wvAoT5YP70Mlc5MJctAtw4oZXOFDNwGCJpBH5uPDWMoN09EcX7KQCk+pmP++2
         7OoYkJezy4lvMszOWQkrPcZGVG3trwAIMvgSSBiTeGKEFaemL4tmGyj6UhEo9hGZP/Yo
         0Ht/jwVEWN+acOmVETpk3NYp94liFfB/At9TVSQm24Y44tT/4GvourIY2T0RHNlAnTVs
         HXBjcmZcGV8JeBPD2loyUDpHdKfhv7z9mEAWiwQq85kc5GErN1+XKIt8/+5NYzQhQefK
         054A==
X-Gm-Message-State: AOJu0Yx2JiB33IG5yIDwoVsi0dfMvTJMI+ZvNe1JjkvKLyKUF3H7fKle
	bmTvBVP3Not3xyA0mN7E4XrwRocmcTaqaCpp7Cmskou/TwN5GkbQSFzy0SC1N68U0vjiSvF1meM
	dAEZn28htlzwqDP8wAiXGN2KlWSU=
X-Google-Smtp-Source: AGHT+IHhUWBMamzEJBsX96IUwNXL5WGWBU1JnqCXCmDULCM84AzvdXudIXaQ08DkkvM4ashfRnaMdILtPltPLs8OIHk=
X-Received: by 2002:a05:6a21:e93:b0:1c0:f677:e995 with SMTP id
 adf61e73a8af0-1c2982032a1mr15217544637.8.1720836096072; Fri, 12 Jul 2024
 19:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-8-harshadshirwadkar@gmail.com> <20240628141837.iu3knuvzb7kc7qag@quack3>
In-Reply-To: <20240628141837.iu3knuvzb7kc7qag@quack3>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Fri, 12 Jul 2024 19:01:25 -0700
Message-ID: <CAD+ocbzeAM=0_k=TBTHb3HA6tg6QKUfnd1Cw7235VHDFMsZVaQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/10] ext4: add nolock mode to ext4_map_blocks()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com, 
	harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 7:18=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 29-05-24 01:20:00, Harshad Shirwadkar wrote:
> > Add nolock flag to ext4_map_blocks() which skips grabbing
> > i_data_sem in ext4_map_blocks. In FC commit path, we first
> > mark the inode as committing and thereby prevent any mutations
> > on it. Thus, it should be safe to call ext4_map_blocks()
> > without i_data_sem in this case. This is a workaround to
> > the problem mentioned in RFC V4 version cover letter[1] of this
> > patch series which pointed out that there is in incosistency between
> > ext4_map_blocks() behavior when EXT4_GET_BLOCKS_CACHED_NOWAIT is
> > passed. This patch gets rid of the need to call ext4_map_blocks()
> > with EXT4_GET_BLOCKS_CACHED_NOWAIT and instead call it with
> > EXT4_GET_BLOCKS_NOLOCK. I verified that generic/311 which failed
> > in cached_nowait mode passes with nolock mode.
> >
> > [1] https://lwn.net/Articles/902022/
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> I'm sorry I forgot since last time - can you remind me why we cannot we
> grab i_data_sem from ext4_fc_write_inode_data()? Because as you write
> above, nobody should really be holding that lock while inode is
> EXT4_STATE_FC_COMMITTING anyway...
>
The original reason was that the commit path calls ext4_map_blocks()
which needs i_data_sem. But other places might grab i_data_sem and
then call ext4_mark_inode_dirty(). Ext4_mark_inode_dirty() can block
for a fast commit to finish, causing a deadlock.

In this patchset I'm attacking this problem 2 ways:
(1) Ensure i_data_sem is always grabbed before ext4_mark_inode_dirty()
(2) (This patch) Remove the need of grabbing i_data_sem in
ext4_map_blocks() when in the commit path.

I am now realizing either (1) or (2) is sufficient -- both are not
needed. (2) is more maintainable. (1) seems fragile and future code
paths can potentially break that rule which can cause hard to debug
failures. So, how about just keeping this patch and dropping the need
to remove grab i_data_sem before ext4_mark_inode_dirty()? If no
concerns, I'll handle this in V7.

- Harshad

>                                                                 Honza
>
> > ---
> >  fs/ext4/ext4.h        |  1 +
> >  fs/ext4/fast_commit.c | 16 ++++++++--------
> >  fs/ext4/inode.c       | 14 ++++++++++++--
> >  3 files changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index d802040e94df..196c513f82dd 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -720,6 +720,7 @@ enum {
> >  #define EXT4_GET_BLOCKS_IO_SUBMIT            0x0400
> >       /* Caller is in the atomic contex, find extent if it has been cac=
hed */
> >  #define EXT4_GET_BLOCKS_CACHED_NOWAIT                0x0800
> > +#define EXT4_GET_BLOCKS_NOLOCK                       0x1000
> >
> >  /*
> >   * The bit position of these flags must not overlap with any of the
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index b81b0292aa59..0b7064f8dfa5 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -559,13 +559,6 @@ void ext4_fc_track_inode(handle_t *handle, struct =
inode *inode)
> >               !list_empty(&ei->i_fc_list))
> >               return;
> >
> > -     /*
> > -      * If we come here, we may sleep while waiting for the inode to
> > -      * commit. We shouldn't be holding i_data_sem in write mode when =
we go
> > -      * to sleep since the commit path needs to grab the lock while
> > -      * committing the inode.
> > -      */
> > -     WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
> >
> >       while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> >  #if (BITS_PER_LONG < 64)
> > @@ -898,7 +891,14 @@ static int ext4_fc_write_inode_data(struct inode *=
inode, u32 *crc)
> >       while (cur_lblk_off <=3D new_blk_size) {
> >               map.m_lblk =3D cur_lblk_off;
> >               map.m_len =3D new_blk_size - cur_lblk_off + 1;
> > -             ret =3D ext4_map_blocks(NULL, inode, &map, 0);
> > +             /*
> > +              * Given that this inode is being committed,
> > +              * EXT4_STATE_FC_COMMITTING is already set on this inode.
> > +              * Which means all the mutations on the inode are paused
> > +              * until the commit operation is complete. Thus it is saf=
e
> > +              * call ext4_map_blocks() in no lock mode.
> > +              */
> > +             ret =3D ext4_map_blocks(NULL, inode, &map, EXT4_GET_BLOCK=
S_NOLOCK);
> >               if (ret < 0)
> >                       return -ECANCELED;
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 61ffbdc2fb16..f00408017c7a 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -546,7 +546,8 @@ int ext4_map_blocks(handle_t *handle, struct inode =
*inode,
> >        * Try to see if we can get the block without requesting a new
> >        * file system block.
> >        */
> > -     down_read(&EXT4_I(inode)->i_data_sem);
> > +     if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
> > +             down_read(&EXT4_I(inode)->i_data_sem);
> >       if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> >               retval =3D ext4_ext_map_blocks(handle, inode, map, 0);
> >       } else {
> > @@ -573,7 +574,15 @@ int ext4_map_blocks(handle_t *handle, struct inode=
 *inode,
> >               ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> >                                     map->m_pblk, status);
> >       }
> > -     up_read((&EXT4_I(inode)->i_data_sem));
> > +     /*
> > +      * We should never call ext4_map_blocks() in nolock mode outside
> > +      * of fast commit path.
> > +      */
> > +     WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) &&
> > +             !ext4_test_inode_state(inode,
> > +                                    EXT4_STATE_FC_COMMITTING));
> > +     if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
> > +             up_read((&EXT4_I(inode)->i_data_sem));
> >
> >  found:
> >       if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> > @@ -614,6 +623,7 @@ int ext4_map_blocks(handle_t *handle, struct inode =
*inode,
> >        * the write lock of i_data_sem, and call get_block()
> >        * with create =3D=3D 1 flag.
> >        */
> > +     WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) !=3D 0);
> >       down_write(&EXT4_I(inode)->i_data_sem);
> >
> >       /*
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

