Return-Path: <linux-ext4+bounces-7251-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DCA88930
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E74188AB2C
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538A27F757;
	Mon, 14 Apr 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhLdmIQB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B6253930
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649982; cv=none; b=QFsB+TxSj75IxELMg6CrlgScY+qjy0CzJKD0Aeoni0/Gfq6pIiw7WW0cweIKR8ktJGCqIhY0nOI4aQurNFYI2HJCysKIWkjMys0WxaSfy5p449vhUJuo8dUPwa6772GfnmxXFQFZEMK5rT3SU/5VDweLUYz62yU+Z28ZKSzuQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649982; c=relaxed/simple;
	bh=e6lDvvc472PPcFT4D944KTWCPdWmL9qB8kwYcoDymyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+tshyPch1OkRhAuJtdQhW1jCu5xbuIEtCPflz5xDtKE2HEGTKccUgS37XyCD6RZDThDA1JbvmUoX9DykHbCdV3RJDSVGD+83I3k98vKh0kuMT1zWDnftO3D9nSBwwAg53fYC6VAfoWkPXvJYSccn44QCp1XsMRiSqdVe4plkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhLdmIQB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso3748587a91.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649980; x=1745254780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFM+Pcenw1OdEqlvMCnhV+fqD82SOENTV0JNJ3LEbFo=;
        b=lhLdmIQBXG/ZAuYY6ywChuPPx5aDjqacYCV4lpRFfp1jKdR7RcNjBs4K7+6M5qHVwp
         8ZmTqZjjj7s1odi7eZimY/gUXrquodAVRd8tR2n4VkboTMFyOFVRmqD2GJXA0WnJ0fbc
         Eq8o4NkLSt1NOC+l6yIQv1xKIDBm/5+/Mfaz3JpSi9ebwvGJue/QWChF9xZD3yukBl8L
         6qPfV5MQz5MVuwSTgAd7qtFSWNvmce8eo5vPIgw0tmyDa9nUwoJxXwbwGXJg/5bzYsv1
         CG6bI9IwpnRLEG+r05vnYOKl6gI5R7fHxNadWeIxs01qj12cqh95Y1T2eV/kD8G55U/s
         AJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649980; x=1745254780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFM+Pcenw1OdEqlvMCnhV+fqD82SOENTV0JNJ3LEbFo=;
        b=PiHdO/+uksJ5IYK9f1StzBkV+thHzPXRuSRcwhFPBmiN4FulYhGCJYh9yLBHkp7PG0
         7dalirRcnkIZ4K3iE7HisHTlCYxp1xzVxdPWjPuINtd5l2IpRr7+KP8LPxZeMj/JTqZf
         mnN0gW0U513kUvxHSZ3+E5I6xxpoPHU1Qwtw4/R4xD0pVkMnbx2tbpkr6RV52WnG4E6u
         BUa5JmTGu6B1LpQawDtoGe3gHojjY9Uf7DQ+BuyjQkFXsaxPYLnbhuzKXlilNh319aGh
         LCFlpS7THNWzzGwx6SVVm6R1H8ObCDn8efqR8DErdxBx+s7gF5GoIyOA1F2IwoRVxX+q
         m0ZQ==
X-Gm-Message-State: AOJu0YzBh1TkyIDMsU1cMO8c1M+Tj52dwgOst12k0T7y3ySqTtGi+zZE
	R4/UrcqCverWiYqzgFskPSSOG6s2+o3Z+CeZYyAlYuxz9Iw7iSiAMgJWDoCsu/nsGIH8cJN8naF
	jZRW6aLw7rOq2wYqc+dThiM9t3JI=
X-Gm-Gg: ASbGnctvilVBlLDOuB2cfHs4rSCAgo7xRSjMXCb6H/QD8oGLKsphzSHWVTOjqgI0CQz
	Ks0gSnIo82G0hn1uzZV1z6DFwpKX7qsniOt4o+Iht5z9y4cHNoRWPlSQxUNYSCmTNaexhnSAurl
	ThotVMX1SexImjYsL7Qmid
X-Google-Smtp-Source: AGHT+IEYd4K/oF9wP6WQi+fJsjVqwu2XZ+OOJNYsJHTanYn34fC8+MnBP1rDk+maJ/oH+RaPE7hH4bqE7lav5RZkBBA=
X-Received: by 2002:a17:90b:38d0:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-308236723b8mr17268312a91.28.1744649979990; Mon, 14 Apr 2025
 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-11-harshadshirwadkar@gmail.com> <40b04c68-377b-4770-bff1-ecff8afa70e9@huawei.com>
In-Reply-To: <40b04c68-377b-4770-bff1-ecff8afa70e9@huawei.com>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Mon, 14 Apr 2025 09:59:28 -0700
X-Gm-Features: ATxdqUEg_1V0XRYtHpGy1ddoBN_0r4aGPwsOouWl-xE3XGsFAmi1mtCZZ0eDttA
Message-ID: <CAD+ocbwFH8HfgF1JVQq4tCaiL6o5iOCMx0hGp4J3juE4EaPxgg@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] ext4: hold s_fc_lock while during fast commit
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	harshads@google.com, Yang Erkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 6:16=E2=80=AFAM Baokun Li <libaokun1@huawei.com> wr=
ote:
>
> Hi Harshad,
>
> On 2024/8/18 12:03, Harshad Shirwadkar wrote:
> > Leaving s_fc_lock in between during commit in ext4_fc_perform_commit()
> > function leaves room for subtle concurrency bugs where ext4_fc_del() ma=
y
> > delete an inode from the fast commit list, leaving list in an inconsist=
ent
> > state. Also, this patch converts s_fc_lock to mutex type so that it can=
 be
> > held when kmem_cache_* functions are called.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >   fs/ext4/ext4.h        |  2 +-
> >   fs/ext4/fast_commit.c | 91 +++++++++++++++++-------------------------=
-
> >   fs/ext4/super.c       |  2 +-
> >   3 files changed, 38 insertions(+), 57 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 4ecb63f95..a1acd34ff 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1748,7 +1748,7 @@ struct ext4_sb_info {
> >        * following fields:
> >        * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
> >        */
> > -     spinlock_t s_fc_lock;
> > +     struct mutex s_fc_lock;
> >       struct buffer_head *s_fc_bh;
> >       struct ext4_fc_stats s_fc_stats;
> >       tid_t s_fc_ineligible_tid;
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 7525450f1..c3627efd9 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -236,9 +236,9 @@ void ext4_fc_del(struct inode *inode)
> >       if (ext4_fc_disabled(inode->i_sb))
> >               return;
> >
> > -     spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +     mutex_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> >       if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
> > -             spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +             mutex_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> >               return;
> >       }
> >
> > @@ -266,7 +266,7 @@ void ext4_fc_del(struct inode *inode)
> >        * dentry create references, since it is not needed to log it any=
ways.
> >        */
> >       if (list_empty(&ei->i_fc_dilist)) {
> > -             spin_unlock(&sbi->s_fc_lock);
> > +             mutex_unlock(&sbi->s_fc_lock);
> >               return;
> >       }
> >
> > @@ -276,7 +276,7 @@ void ext4_fc_del(struct inode *inode)
> >       list_del_init(&fc_dentry->fcd_dilist);
> >
> >       WARN_ON(!list_empty(&ei->i_fc_dilist));
> > -     spin_unlock(&sbi->s_fc_lock);
> > +     mutex_unlock(&sbi->s_fc_lock);
> >
> >       if (fc_dentry->fcd_name.name &&
> >               fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> > @@ -306,10 +306,10 @@ void ext4_fc_mark_ineligible(struct super_block *=
sb, int reason, handle_t *handl
> >                               sbi->s_journal->j_running_transaction->t_=
tid : 0;
> >               read_unlock(&sbi->s_journal->j_state_lock);
> >       }
> > -     spin_lock(&sbi->s_fc_lock);
> > +     mutex_lock(&sbi->s_fc_lock);
> >       if (tid_gt(tid, sbi->s_fc_ineligible_tid))
> >               sbi->s_fc_ineligible_tid =3D tid;
> > -     spin_unlock(&sbi->s_fc_lock);
> > +     mutex_unlock(&sbi->s_fc_lock);
> >       WARN_ON(reason >=3D EXT4_FC_REASON_MAX);
> >       sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
> >   }
> > @@ -349,14 +349,14 @@ static int ext4_fc_track_template(
> >       if (!enqueue)
> >               return ret;
> >
> > -     spin_lock(&sbi->s_fc_lock);
> > +     mutex_lock(&sbi->s_fc_lock);
> >       if (list_empty(&EXT4_I(inode)->i_fc_list))
> >               list_add_tail(&EXT4_I(inode)->i_fc_list,
> >                               (sbi->s_journal->j_flags & JBD2_FULL_COMM=
IT_ONGOING ||
> >                                sbi->s_journal->j_flags & JBD2_FAST_COMM=
IT_ONGOING) ?
> >                               &sbi->s_fc_q[FC_Q_STAGING] :
> >                               &sbi->s_fc_q[FC_Q_MAIN]);
> > -     spin_unlock(&sbi->s_fc_lock);
> > +     mutex_unlock(&sbi->s_fc_lock);
> >
> >       return ret;
> >   }
> > @@ -414,7 +414,8 @@ static int __track_dentry_update(struct inode *inod=
e, void *arg, bool update)
> >       }
> >       node->fcd_name.len =3D dentry->d_name.len;
> >       INIT_LIST_HEAD(&node->fcd_dilist);
> > -     spin_lock(&sbi->s_fc_lock);
> > +     INIT_LIST_HEAD(&node->fcd_list);
> > +     mutex_lock(&sbi->s_fc_lock);
> >       if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> >               sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
> >               list_add_tail(&node->fcd_list,
> > @@ -435,7 +436,7 @@ static int __track_dentry_update(struct inode *inod=
e, void *arg, bool update)
> >               WARN_ON(!list_empty(&ei->i_fc_dilist));
> >               list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
> >       }
> > -     spin_unlock(&sbi->s_fc_lock);
> > +     mutex_unlock(&sbi->s_fc_lock);
> >       spin_lock(&ei->i_fc_lock);
> >
> >       return 0;
> > @@ -955,15 +956,15 @@ static int ext4_fc_submit_inode_data_all(journal_=
t *journal)
> >       struct ext4_inode_info *ei;
> >       int ret =3D 0;
> >
> > -     spin_lock(&sbi->s_fc_lock);
> > +     mutex_lock(&sbi->s_fc_lock);
> >       list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> > -             spin_unlock(&sbi->s_fc_lock);
> > +             mutex_unlock(&sbi->s_fc_lock);
> >               ret =3D jbd2_submit_inode_data(journal, ei->jinode);
> >               if (ret)
> >                       return ret;
> > -             spin_lock(&sbi->s_fc_lock);
> > +             mutex_lock(&sbi->s_fc_lock);
> >       }
> > -     spin_unlock(&sbi->s_fc_lock);
> > +     mutex_unlock(&sbi->s_fc_lock);
> >
> We're also seeing a similar race condition here. This issue was encounter=
ed
> while running `kvm-xfstests -c ext4/adv -C 500 generic/241`:
>
>      P1                |         P2
> ----------------------------------------------------
>                             evict
>                              ext4_evict_inode
>                               ext4_free_inode
>                                ext4_clear_inode
>                                 ext4_fc_del(inode)
> ext4_sync_file
>   ext4_fsync_journal
>    ext4_fc_commit
>     ext4_fc_perform_commit
>      ext4_fc_submit_inode_data_all
>       -- spin_lock(&sbi->s_fc_lock);
>        list_for_each_entry(i_fc_list)
>          -- spin_unlock(&sbi->s_fc_lock);
>                                 -- spin_lock(&sbi->s_fc_lock)
>                                   if (!list_empty(&ei->i_fc_list))
> list_del_init(&ei->i_fc_list);
>                                 -- spin_unlock(&sbi->s_fc_lock);
> jbd2_free_inode(EXT4_I(inode)->jinode)
>                                 EXT4_I(inode)->jinode =3D NULL
>           jbd2_submit_inode_data
>            journal->j_submit_inode_data_buffers
>             ext4_journal_submit_inode_data_buffers
>              ext4_should_journal_data(jinode->i_vfs_inode)
>               // a. jinode may use-after-free !!!
>               ext4_inode_journal_mode(inode)
>                EXT4_JOURNAL(inode)
>                 (inode)->i_sb
>                  // b. inode may null-ptr-deref !!!
>          -- spin_lock(&sbi->s_fc_lock);
>       -- spin_unlock(&sbi->s_fc_lock);
>
> By the way, the WARN_ON added in patch 5 can detect this issue without
> enabling KASAN, but patch 5 also introduced softlocks and other UAFs.

Thanks for mentioning this. V8 of the patchset handles this race by
not releasing s_fc_lock in ext4_fc_submit_inode_data_all().

- Harshad
>
>
> Regards,
> Baokun
>

