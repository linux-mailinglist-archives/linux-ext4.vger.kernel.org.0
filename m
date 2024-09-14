Return-Path: <linux-ext4+bounces-4175-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B849793C2
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2024 01:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CFA1C21156
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2024 23:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5E1474CF;
	Sat, 14 Sep 2024 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsY7qSbS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E4BA49;
	Sat, 14 Sep 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726355650; cv=none; b=JiAfVRTYCIYBOTCg5z+2V/iZqo6/cI/WMQBj1yz6oNieFE3QZ6KBhANvwRRo0qXHHRvKsxZ9YStqy5doOVq7u170ozKoCaiD5xhVl3xwY2EGBlf3ZLkofFRtOV5QAu0eF3f+w9rzseGfLgCK7f9hnjAhwdqDKaWtb/ZlDzdgatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726355650; c=relaxed/simple;
	bh=Tlf3ImrTd3tKtsB4NFTexVCJZGdlq1aFiKphnW52w6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDwhsaNlz+K4Ne1W3Ee8oafrY7Om77NFC7teYpJyIVlFonJBoTx8ZtvUynPpLmYiLJdWLDLitHl9wRUaB6fq4qawOE5zAGNnLlg5hgj69F/dMykTYL4XhMOo1MthnI/0OcsrriZVgiq9dYPPMDK08tXjgW7/Q2ev6itN+tlGAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsY7qSbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD42C4CEC0;
	Sat, 14 Sep 2024 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726355649;
	bh=Tlf3ImrTd3tKtsB4NFTexVCJZGdlq1aFiKphnW52w6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BsY7qSbS/NUdA3Wwt8/6uhL91WzrSGHZq4tPn1LcKvCPB3S62LXop13Kg+qd9mHOm
	 IM+Iyxx/D+2oAw4Nv1dgozyAEtyvPQZg/5qx9gGHedbdf6mKArsOpreAr6meZvIltH
	 X0H+J4kxN5y9rNES1PIXA8hLWZOBmuKgL+CS3L0nRC/+ZCHfv/eSVLnqsDL1CezJzF
	 yLNm8YWQZzb6Z9Qrxbv6ZfOxQZXMhtI75Bo4/CBOiHq/X6hB6/e9a6yz2gDyIGGljv
	 knHzaTskLy7fwdpRgB/39ONiHLG6eRs3jnpdZmJ5+1M3aR9ZqOjGY0nY7a1Wxcs8Id
	 mYLOsYJF5poig==
Message-ID: <a273a8e6bb6785c5666bd2b8b83e3a437ebdeae4.camel@kernel.org>
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
From: Jeff Layton <jlayton@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,  Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J.
 Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,  Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Chuck Lever
 <chuck.lever@oracle.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org,  linux-btrfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-mm@kvack.org
Date: Sat, 14 Sep 2024 19:14:06 -0400
In-Reply-To: <CANDhNCpaySH5HmkEb9BS738Fo+Kk=6s0_zNwB=uYtOQ63uc6xw@mail.gmail.com>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
	 <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
	 <CANDhNCpaySH5HmkEb9BS738Fo+Kk=6s0_zNwB=uYtOQ63uc6xw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-09-14 at 13:10 -0700, John Stultz wrote:
> On Sat, Sep 14, 2024 at 10:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > For multigrain timestamps, we must keep track of the latest timestamp
> > that has ever been handed out, and never hand out a coarse time below
> > that value.
> >=20
> > Add a static singleton atomic64_t into timekeeper.c that we can use to
> > keep track of the latest fine-grained time ever handed out. This is
> > tracked as a monotonic ktime_t value to ensure that it isn't affected b=
y
> > clock jumps.
> >=20
> > Add two new public interfaces:
> >=20
> > - ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of =
the
> >   coarse-grained clock and the floor time
> >=20
> > - ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
> >   to swap it into the floor. A timespec64 is filled with the result.
> >=20
> > Since the floor is global, we take great pains to avoid updating it
> > unless it's absolutely necessary. If we do the cmpxchg and find that th=
e
> > value has been updated since we fetched it, then we discard the
> > fine-grained time that was fetched in favor of the recent update.
> >=20
> > To maximize the window of this occurring when multiple tasks are racing
> > to update the floor, ktime_get_coarse_real_ts64_mg returns a cookie
> > value that represents the state of the floor tracking word, and
> > ktime_get_real_ts64_mg accepts a cookie value that it uses as the "old"
> > value when calling cmpxchg().
>=20
> This last bit seems out of date.
>=20

Thanks. Dropped the last paragraph.

> > ---
> >  include/linux/timekeeping.h |  4 +++
> >  kernel/time/timekeeping.c   | 82 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 86 insertions(+)
> >=20
> > diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> > index fc12a9ba2c88..7aa85246c183 100644
> > --- a/include/linux/timekeeping.h
> > +++ b/include/linux/timekeeping.h
> > @@ -45,6 +45,10 @@ extern void ktime_get_real_ts64(struct timespec64 *t=
v);
> >  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
> >  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> >=20
> > +/* Multigrain timestamp interfaces */
> > +extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
> > +extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
> > +
> >  void getboottime64(struct timespec64 *ts);
> >=20
> >  /*
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 5391e4167d60..16937242b904 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_a=
ligned =3D {
> >         .base[1] =3D FAST_TK_INIT,
> >  };
> >=20
> > +/*
> > + * This represents the latest fine-grained time that we have handed ou=
t as a
> > + * timestamp on the system. Tracked as a monotonic ktime_t, and conver=
ted to the
> > + * realtime clock on an as-needed basis.
> > + */
> > +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> > +
> >  static inline void tk_normalize_xtime(struct timekeeper *tk)
> >  {
> >         while (tk->tkr_mono.xtime_nsec >=3D ((u64)NSEC_PER_SEC << tk->t=
kr_mono.shift)) {
> > @@ -2394,6 +2401,81 @@ void ktime_get_coarse_real_ts64(struct timespec6=
4 *ts)
> >  }
> >  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
> >=20
> > +/**
> > + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or=
 floor
> > + * @ts: timespec64 to be filled
> > + *
> > + * Adjust floor to realtime and compare it to the coarse time. Fill
> > + * @ts with the latest one. Note that this is a filesystem-specific
> > + * interface and should be avoided outside of that context.
> > + */
> > +void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       u64 floor =3D atomic64_read(&mg_floor);
> > +       ktime_t f_real, offset, coarse;
> > +       unsigned int seq;
> > +
> > +       WARN_ON(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +               *ts =3D tk_xtime(tk);
> > +               offset =3D *offsets[TK_OFFS_REAL];
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       coarse =3D timespec64_to_ktime(*ts);
> > +       f_real =3D ktime_add(floor, offset);
> > +       if (ktime_after(f_real, coarse))
> > +               *ts =3D ktime_to_timespec64(f_real);
> > +}
> > +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
> > +
> > +/**
> > + * ktime_get_real_ts64_mg - attempt to update floor value and return r=
esult
> > + * @ts:                pointer to the timespec to be set
> > + *
> > + * Get a current monotonic fine-grained time value and attempt to swap
> > + * it into the floor. @ts will be filled with the resulting floor valu=
e,
> > + * regardless of the outcome of the swap. Note that this is a filesyst=
em
> > + * specific interface and should be avoided outside of that context.
> > + */
> > +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)
>=20
> Still passing a cookie. It doesn't match the header definition, so I'm
> surprised this builds.
>=20

Yeah, I didn't see a warning when I built it. Luckily the extra
parameter is ignored anyway, so it no harm. I've fixed that up in my
tree.

> > +{
> > +       struct timekeeper *tk =3D &tk_core.timekeeper;
> > +       ktime_t old =3D atomic64_read(&mg_floor);
> > +       ktime_t offset, mono;
> > +       unsigned int seq;
> > +       u64 nsecs;
> > +
> > +       WARN_ON(timekeeping_suspended);
> > +
> > +       do {
> > +               seq =3D read_seqcount_begin(&tk_core.seq);
> > +
> > +               ts->tv_sec =3D tk->xtime_sec;
> > +               mono =3D tk->tkr_mono.base;
> > +               nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
> > +               offset =3D *offsets[TK_OFFS_REAL];
> > +       } while (read_seqcount_retry(&tk_core.seq, seq));
> > +
> > +       mono =3D ktime_add_ns(mono, nsecs);
> > +
> > +       if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> > +               ts->tv_nsec =3D 0;
> > +               timespec64_add_ns(ts, nsecs);
> > +       } else {
> > +               /*
> > +                * Something has changed mg_floor since "old" was
> > +                * fetched. "old" has now been updated with the
> > +                * current value of mg_floor, so use that to return
> > +                * the current coarse floor value.
> > +                */
> > +               *ts =3D ktime_to_timespec64(ktime_add(old, offset));
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(ktime_get_real_ts64_mg);
>=20
> Other than those issues, I'm ok with it. Thanks again for working
> through my concerns!
>=20
> Since I'm traveling for LPC soon, to save the next cycle, once the
> fixes above are sorted:
>  Acked-by: John Stultz <jstultz@google.com>
>=20

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

