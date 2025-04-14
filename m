Return-Path: <linux-ext4+bounces-7250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EFA8892C
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FFC3A6622
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1427F73D;
	Mon, 14 Apr 2025 16:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQb9WgvG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26683280A4D
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649889; cv=none; b=nKbBmdvyVd+2xz0jGVQob2H9eskewil2lnyfTJemmOPPF5P4ikLSEieosCMnKlJiMYEaV2ZnLbTnZKOaXy/kDUdMSyZCUnRSVJw7NnmuuZgifGyAEc7cRGsPl+ltWKebEk9wrFJXAUQUGAjszT5FcZ7Z1um3zIj1Oegpw78mSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649889; c=relaxed/simple;
	bh=pKEdAXZ+f37Nlkkg5vPkeMpQOjhXLBxCnOv2rVQqPZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2QWGQ9nfy1k38joubD1RWs+x6oG9g8U5qFOIw88vZO+BDV2/Derq6CxfUEm7HV7KDaP7QqDpjqilUULt0VsG9/Yu3wcXMWWTQFJe27FqsffPWI+xAspPvCElaLs3bO9QMvplNPQp0YGAHFkOcwYhKn58I2vsLK0SBp8hI9/PXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQb9WgvG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so4277677a91.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649887; x=1745254687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byEn7g/2/s26JsF3lWQT1U/1dEtTufLnp5OwvOL7vT4=;
        b=gQb9WgvGzDjPn/ONCrWsqY61GeQq0PirLB5RLgl+THsJUrHLhgGC9k4/zDfhsBxc1q
         DnWANqpIjCa4X5Ufy1ldevybnnvzAqFMTVj6eEce0AGH9Di5YlwEqnr0CB1DpUjEf8Bi
         ci3bQetr52zO5Rx74RVlXStKvEadg56C6ge8RyYLXiJcHoDEjdGvmtLTz7QzsH3GzZ8c
         g9GDr8K1AdCiDM4kLXZJoaA7s6oFWK9Ns9F3bi1jYAN4yJZuyEhKi/3tfxHbO+MXE9f6
         CCsHrB0P+LomnamEjEVnnlQQtG+i8Zl6iYFlwUXKclv4iCgg8yPEmS0WPa+9QQXY+srD
         /nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649887; x=1745254687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byEn7g/2/s26JsF3lWQT1U/1dEtTufLnp5OwvOL7vT4=;
        b=oFiD8lcpwKAxMNNLsCY1GZv/ylIdZ16+L7wHHGURjnMFKuq7ZlMHmHEYcSQ81ziH9r
         tzUs+B2nQHixrwJT6KVsJvZkHA77V/7Aoc+gOZ0lpQhd8B7lAMhkPqthsWfnf47OB9i4
         4q/JfiBiUxTIJpr15X4FzCPdVPbC0vYzhTnTYwDPousXxoN76V5pQbFjUCuRVmKjPZdG
         X/ZuvQRGsWrjihk5cLtL3ltmEw3lfWoGJIXjdTlYUUB5DsEToeVdBSJJOhU1cjj6vnZq
         fj323CO0ue/yGouDPULL5kIrjx6zwCN1DhpLx6xZIRWHLmPIqaZP1YTmWAAOtLLAfPjg
         9HvA==
X-Gm-Message-State: AOJu0Yz+0FO0oZj74B7hPN6PjeZHGhk9mhpskOSEQeo/ZWNHJjfuspcW
	UHTPCiXLKtk+1LMSXqS6GdHM5BqgAQTBTO/y6J9jijAg2V5Zxk+1IIJbj5C0e4EJrR8ymeXSRNw
	0aCSU6+6tfV8srC4S3v7iiwmoZQyZj0eD
X-Gm-Gg: ASbGncvzXWHSu/b++ttRIl7pyChJVovVx76QOjP0pfJj05YKM7RsHx/gew58KbThrMr
	3TUXn4KIwH/T8Ecm+y1MQcSUj24dD2fnbiD9iXh6HyYcdsOlWaRD0DPXNXB1+dgbock4WBGhB7F
	ZcBJeh4+bVo3ZtlV9Ee2ka
X-Google-Smtp-Source: AGHT+IHOJftNGNZWx2IGuZ+qWNASXbUIjjdUisGFl/c+cFUUC3lvVqi72fBJtUbkrvAGc9zfQTZJL6h9elqAhAaw2zk=
X-Received: by 2002:a17:90b:58c3:b0:2fe:afbc:cd53 with SMTP id
 98e67ed59e1d1-308237a857cmr18973963a91.28.1744649887134; Mon, 14 Apr 2025
 09:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-4-harshadshirwadkar@gmail.com> <20241212220043.a6hiif444v4jwnkm@quack3>
In-Reply-To: <20241212220043.a6hiif444v4jwnkm@quack3>
From: harshad shirwadkar <harshadshirwadkar@gmail.com>
Date: Mon, 14 Apr 2025 09:57:45 -0700
X-Gm-Features: ATxdqUHMkX8fDcP2I-uKPag2hsve53kvsC7Q4djOfbbzgLM6SBL6dPsgWp2Jai8
Message-ID: <CAD+ocbx0O88URnRZ6fQi6vAVxdH_gAk4G9eg9iz_OOeg-zT6mA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ext4: for committing inode, make
 ext4_fc_track_inode wait
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, harshads@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 2:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 18-08-24 04:03:49, Harshad Shirwadkar wrote:
> > If the inode that's being requested to track using ext4_fc_track_inode
> > is being committed, then wait until the inode finishes the
> > commit. Also, add calls to ext4_fc_track_inode at the right places.
> >
> > With this patch, now calling ext4_reserve_inode_write() results in
> > inode being tracked for next fast commit. A subtle lock ordering
> > requirement with i_data_sem (which is documented in the code) requires
> > that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> > this patch also adds explicit ext4_fc_track_inode() calls in places
> > where i_data_sem grabbed.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Sorry for the huge delay! Some comments are below:

Hi Jan,

Sorry for a huge delay from my end as well. Thank you for your
comments on V7 of this patchset. I just sent out a V8 of this patchset
where I have handled all of your comments on this and subsequent
patches in the series.

Thank you,
Harshad

>
> > @@ -598,6 +601,36 @@ void ext4_fc_track_inode(handle_t *handle, struct =
inode *inode)
> >       if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
> >               return;
> >
> > +     if (!list_empty(&ei->i_fc_list))
> > +             return;
> > +
> > +#ifdef CONFIG_LOCKDEP
> > +     /*
> > +      * If we come here, we may sleep while waiting for the inode to
> > +      * commit. We shouldn't be holding i_data_sem when we go to sleep=
 since
> > +      * the commit path needs to grab the lock while committing the in=
ode.
> > +      */
> > +     WARN_ON(lockdep_is_held(&ei->i_data_sem));
> > +#endif
>
> We have lockdep_assert_not_held() for this so you can avoid the ifdef.
>
> > +
> > +     while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> > +#if (BITS_PER_LONG < 64)
> > +             DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq =3D bit_waitqueue(&ei->i_state_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#else
> > +             DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq =3D bit_waitqueue(&ei->i_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#endif
> > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE)=
;
> > +             if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING=
))
> > +                     schedule();
> > +             finish_wait(wq, &wait.wq_entry);
> > +     }
>
> But what protects us from fastcommit setting EXT4_STATE_FC_COMMITTING at
> this moment before we call ext4_fc_track_template(). Don't you need
> to grab sbi->s_fc_lock and hold it until the inode is attached to the
> fastcommit?
>
> I might be missing something so some documentation (like a comment here)
> would be nice to explain what are you actually trying to achieve with the
> waiting...
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

