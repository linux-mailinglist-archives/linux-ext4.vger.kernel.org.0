Return-Path: <linux-ext4+bounces-7878-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE8AB6A6A
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 13:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CEB8C3B55
	for <lists+linux-ext4@lfdr.de>; Wed, 14 May 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921D270EC3;
	Wed, 14 May 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPqGaeXU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23E26FD9D;
	Wed, 14 May 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223035; cv=none; b=StaOKICGeUxZnZEkcmcTSbTIofyLzPFPy4/0y4Lt2B+EF3cVyTG0ahZww9NMMK4Oq+QTAjwC5hQvS8LQHsHayZYg7cfiZPVc/bG4MeiDdocYdCXMwrX4sXfhp/3X3B7QA5uriCs9Jv289EfIbsNRYfaYfa4g5PmrJkvqOk0MWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223035; c=relaxed/simple;
	bh=MJPH7ofh9ksYl+G/0VUZOtP8j6tVQOLUt7dwY85MRhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0H5dqtK2qfuCJm9QuJwblSm/+8k2LTWWlwDhVmRypUVcKnO52MQL5k4LZhhC1dGVcDhUmJcriCfGTqI8rALMLh0hoOhAluk9jy8ynTfyxn8oPAWa49lQM3RfvBHu15cEaEyngv+Cifve+MPfRjwz6Gqn11nf0Y7r9tdu9lF+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPqGaeXU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2302d90c7f7so42356045ad.3;
        Wed, 14 May 2025 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747223033; x=1747827833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o1hN4e2mExqyewN9B5XgXnPqUITvNSdn1a5A80eoAeA=;
        b=RPqGaeXUnd2MOZftMahFQ9lNygof0nuE+4+cNRoaJPMfb8U2cqRCWxQaxnNu4wah1t
         L1J3wdSsUwqQ8E7tmjMF1jbanH8Kqrsbvg0vFEeUOppzx6G1NE7V4veVDKBDBCMe8v54
         WmsKQ/aPW9b56t0LuQb6vopHVAY3rpUOa50TOdtNusYX84HLqB4CTH6nu9w2xC0ueV+v
         8sn2+7pH2oePx0qu0Pj3Fph6e3K1d2ggPkHot868K/pvfkulvwdx47mT2hVJ8mzeoL4J
         11lzTOEPv+8H9x9FFSeuOXKbvUQCzH1ZlJQCISFu/BgrLNRkglyiHZeecRmkRqNyj7On
         H+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747223033; x=1747827833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1hN4e2mExqyewN9B5XgXnPqUITvNSdn1a5A80eoAeA=;
        b=plIFChssXei3RanR/1jR8kVKlE2joF6GybyvvA3NJJ4Ha/VHr3+/KW4SP/PJh/2SC0
         DRvvdlxIT3EKf/vTtBIGk9qyolC8z4YxZ47OIJnBAdN3FkFTwxWYv2udslFsZw9I31uB
         tmdYNedlJuaysW2Tqv+aoNcCRwpToLeuoWjNZCT2DYpOl3mVOJ15EgRXK/JfiNddTTnP
         9uYKR8eDHp0GvlgWoYdI+rErPRiUd3yQ4WcMOIacflHI+8pdNUkUW80s75WMgrsseqz8
         SPIXe24+yUpfWUxrXkkvnsoIsIEsOlfKYBmqtyemWM2gecqGYuomrLldCjEyR2mRMVQ6
         KaAw==
X-Forwarded-Encrypted: i=1; AJvYcCUC3q6db7MVKBDG86PiSF6l5E4nKCIyMHygaHoV+7G9yvT4josozcCsF9VwgHvr7kePhvY45BJmTkjG@vger.kernel.org, AJvYcCXyXoAq6s1gt1gWjHTZCoUayBjcB2faAnJX1SApI1F/WzOb1uEgxv2zOLtzggwyx1pPysto2Y3zc+GIsuu+@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGaiOzCYzZA0hM79zSkI+/AwmNbcuVaPGQXfrT9up7SFZS5KL
	0Wk51lbuCqrHVzS47+WZxoP0dJte2mecKADDNZOk4mdRhirVFvqd/8dDqvIjYvkMnCwhQVTPjcv
	RZKhGfXQmICyBgpqw85hXuzXXBq4=
X-Gm-Gg: ASbGnct3S6it6TyvLn+yiOJQzaxCtGhozowKGRt67mod35qx4dvDuKn9ZIqxSQjRuu9
	Fx/QXdqw9tWEuc+ljLCM71ftNsZPsNYhnb/piFOdZJryZTpQSLhJ7pQGtYbhgzj4TuIQ/k3T8Bu
	x3nGwiY7jBMRqN5eg8joTgxrcYnD4Lkhyd9CJLK1oJwAYUemIV/GKIzYOWyUolClT0cz3toFprO
	ak=
X-Google-Smtp-Source: AGHT+IGJIdHWyukRqtG7ZEfvpi9Qe1OQOfaFmzf9CdrD485OGHqqRWkswxr6HLCVeX58TK0uyugEDqGag6Cy94AzmrU=
X-Received: by 2002:a17:902:ce02:b0:220:e655:d77 with SMTP id
 d9443c01a7336-231981a2d8bmr49245625ad.36.1747223032332; Wed, 14 May 2025
 04:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513170441.54658-1-aha310510@gmail.com> <ikdnwnux5ks25eqn5nbya6dpb2wrtsb22m57757ewdzd4qo6rx@e46o3ugl5wfa>
In-Reply-To: <ikdnwnux5ks25eqn5nbya6dpb2wrtsb22m57757ewdzd4qo6rx@e46o3ugl5wfa>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 14 May 2025 20:43:40 +0900
X-Gm-Features: AX0GCFsG6hGod5oSkfYfR3-C7mB4bIjj2anCVJBgXewK0MSK9xZEe5pjT-TI1rg
Message-ID: <CAO9qdTG913f55dSa9OutUS98dHcjgjRngeTQUT-34uOzYN684Q@mail.gmail.com>
Subject: Re: [PATCH] jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Jan Kara <jack@suse.cz> wrote:
>
> On Wed 14-05-25 02:04:41, Jeongjun Park wrote:
> > Since handle->h_transaction may be a NULL pointer, so we should change it
> > to call is_handle_aborted(handle) first before dereferencing it.
> >
> > And the following data-race was reported in my fuzzer:
> >
> > ==================================================================
> > BUG: KCSAN: data-race in jbd2_journal_dirty_metadata / jbd2_journal_dirty_metadata
> >
> > write to 0xffff888011024104 of 4 bytes by task 10881 on cpu 1:
> >  jbd2_journal_dirty_metadata+0x2a5/0x770 fs/jbd2/transaction.c:1556
> >  __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
> >  ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
> >  ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
> >  __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
> >  ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
> > ....
> >
> > read to 0xffff888011024104 of 4 bytes by task 10880 on cpu 0:
> >  jbd2_journal_dirty_metadata+0xf2/0x770 fs/jbd2/transaction.c:1512
> >  __ext4_handle_dirty_metadata+0xe7/0x4b0 fs/ext4/ext4_jbd2.c:358
> >  ext4_do_update_inode fs/ext4/inode.c:5220 [inline]
> >  ext4_mark_iloc_dirty+0x32c/0xd50 fs/ext4/inode.c:5869
> >  __ext4_mark_inode_dirty+0xe1/0x450 fs/ext4/inode.c:6074
> >  ext4_dirty_inode+0x98/0xc0 fs/ext4/inode.c:6103
> > ....
> >
> > value changed: 0x00000000 -> 0x00000001
> > ==================================================================
> >
> > According to this crash report, there is a read/write data-race in
> > jh->b_modified.
> >
> > This is because the b_state_lock is locked too late.
> >
> > For some reason, jbd2_journal_dirty_metadata() has been written in a way
> > that it does not lock b_state_lock before checking jh->b_transaction.
>
> Yes and that is deliberate because for some buffers like bitmaps the
> contention (and cacheline bouncing) on the b_state_lock can be actually
> quite significant. See commit 6e06ae88edae ("jbd2: speedup
> jbd2_journal_dirty_metadata()") for a bit more description.
>
> > However, This makes the code that checks jh->b_transaction messy and
> > causes a data-race in jh->b_* variables. Since locking b_state_lock
> > earlier is not enough to significantly affect performance and most of the
> > functions defined in transaction.c lock b_state_lock before
> > reading/writing jh->b_*.
>
> Well, the code is written with the expectation that b_transaction, b_jlist,
> and b_modified fields can be changing underneath. Since this was
> implemented 10 years ago, we didn't really bother with properly annotating
> this but the code as is is safe. I agree the data_race() annotation for the
> b_modified check was missed when adding data_race() annotations 4 years
> ago so that should be fixed.
>
>                                                                 Honza
>

It's surprising that the spinlock protection for just two if statements
has such a big impact on performance. I'll change it to annotate
jh->b_modified with data_race() and send v2 patch.

Regards,

Jeongjun Park

> > Thereforce, I think it would be appropriate to modify
> > jbd2_journal_dirty_metadata() to lock b_state_lock earlier as well.
> >
> > Reported-by: syzbot+de24c3fe3c4091051710@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=de24c3fe3c4091051710
> > Fixes: 6e06ae88edae ("jbd2: speedup jbd2_journal_dirty_metadata()")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  fs/jbd2/transaction.c | 49 +++++++++++++++----------------------------
> >  1 file changed, 17 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > index cbc4785462f5..7e6dbf37396f 100644
> > --- a/fs/jbd2/transaction.c
> > +++ b/fs/jbd2/transaction.c
> > @@ -1496,41 +1496,25 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
> >       jbd2_debug(5, "journal_head %p\n", jh);
> >       JBUFFER_TRACE(jh, "entry");
> >
> > -     /*
> > -      * This and the following assertions are unreliable since we may see jh
> > -      * in inconsistent state unless we grab bh_state lock. But this is
> > -      * crucial to catch bugs so let's do a reliable check until the
> > -      * lockless handling is fully proven.
> > -      */
> > -     if (data_race(jh->b_transaction != transaction &&
> > -         jh->b_next_transaction != transaction)) {
> > -             spin_lock(&jh->b_state_lock);
> > -             J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> > -                             jh->b_next_transaction == transaction);
> > -             spin_unlock(&jh->b_state_lock);
> > -     }
> > +     spin_lock(&jh->b_state_lock);
> > +
> > +     J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> > +                     jh->b_next_transaction == transaction);
> > +
> >       if (jh->b_modified == 1) {
> >               /* If it's in our transaction it must be in BJ_Metadata list. */
> > -             if (data_race(jh->b_transaction == transaction &&
> > -                 jh->b_jlist != BJ_Metadata)) {
> > -                     spin_lock(&jh->b_state_lock);
> > -                     if (jh->b_transaction == transaction &&
> > -                         jh->b_jlist != BJ_Metadata)
> > -                             pr_err("JBD2: assertion failure: h_type=%u "
> > -                                    "h_line_no=%u block_no=%llu jlist=%u\n",
> > -                                    handle->h_type, handle->h_line_no,
> > -                                    (unsigned long long) bh->b_blocknr,
> > -                                    jh->b_jlist);
> > -                     J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> > -                                     jh->b_jlist == BJ_Metadata);
> > -                     spin_unlock(&jh->b_state_lock);
> > -             }
> > -             goto out;
> > +             if (jh->b_transaction == transaction &&
> > +                     jh->b_jlist != BJ_Metadata)
> > +                     pr_err("JBD2: assertion failure: h_type=%u "
> > +                            "h_line_no=%u block_no=%llu jlist=%u\n",
> > +                            handle->h_type, handle->h_line_no,
> > +                            (unsigned long long) bh->b_blocknr,
> > +                            jh->b_jlist);
> > +             J_ASSERT_JH(jh, jh->b_transaction != transaction ||
> > +                             jh->b_jlist == BJ_Metadata);
> > +             goto out_unlock_bh;
> >       }
> >
> > -     journal = transaction->t_journal;
> > -     spin_lock(&jh->b_state_lock);
> > -
> >       if (is_handle_aborted(handle)) {
> >               /*
> >                * Check journal aborting with @jh->b_state_lock locked,
> > @@ -1543,6 +1527,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
> >               goto out_unlock_bh;
> >       }
> >
> > +     journal = transaction->t_journal;
> > +
> >       if (jh->b_modified == 0) {
> >               /*
> >                * This buffer's got modified and becoming part
> > @@ -1628,7 +1614,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
> >       spin_unlock(&journal->j_list_lock);
> >  out_unlock_bh:
> >       spin_unlock(&jh->b_state_lock);
> > -out:
> >       JBUFFER_TRACE(jh, "exit");
> >       return ret;
> >  }
> > --
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

