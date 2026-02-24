Return-Path: <linux-ext4+bounces-13995-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOibOlUEnmlaTAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13995-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 21:04:37 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458DA18C44B
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 21:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6481B306C533
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 20:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07ED335064;
	Tue, 24 Feb 2026 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar0F7sd5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D9334688
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963438; cv=pass; b=MqCTHRImFEgU63412TCjl+NhLIcz9PP1XQKM5VOzCHG9iyrOW7D8w2lb1CMEeWTA6vP5QEfk6RCRLJSQxEwqVYTO8XSn8MoJzmoEL9bL4op3OFw3BVX9EIO4ygrPK5xZvpbfqdLtNW1eaqhCJeHrddcqsrofK4w38sRIhVaHlh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963438; c=relaxed/simple;
	bh=gFm9sIszaRG76BMUOXhuMz0hkhlXHogVitmzULW2Yxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj1R9OHywWCjqxxcpzq3ZOCqLQ63TSUgHwW6nHRAXdOXWynAcrjo/o1bMRIlnid+yzQmSK5gVQCpa46O/iIlNWC2vsWALyB0peHoiVKkfsS5QHnNo/p0UO3PjwZSarlDYzUQRYmvhYTGjfkTQFlYsQJZcBvwhIq62hBgaSCxzXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar0F7sd5; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50335b926c2so54630511cf.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 12:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963435; cv=none;
        d=google.com; s=arc-20240605;
        b=c9ySxke3JcOJH+JNag4sxDaTDAof24eSgQpD8KANHX/Ke+xzpCcWtcOq/SNe7T8f0m
         AGhBqs5o0TSdXrT2318psfE6RXYAH5hjZbi4xDsFQzA58usDxDku22o8MtAuBn62eL7w
         qXvlYfdA9jagUSLj0lQ5xNW+NdM861/KESAkrHv8MjIO0/N/qP28MCWN5C2j2tsMbtlV
         kLYQRYl0bZisN0NkDRV+9ubQumwFHMw7moQ0jK/q2pMMhi4RmyajqxePuDBkSiNhlxBn
         reUgzUS9oVlTvr2YyFMHg1UdCAk74yjc+zyOG6Vd62OISihXWBfIUb69Pnv9UxklRgWE
         nBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        fh=eQ7nJQGK0KZyz7MlFv2e4pyycltMynPBtWILKq/+6vE=;
        b=AYW57M02R46gSlRIOgPw692O0Bzzs5RXkFtRxw7BN+T/a9PGTmhKKZRGHyGskJ9wJr
         +ZyBAOMQoebxtjDymdRR514j4N6jhu3zUE2noCJT55yTf1y5/AhT9bT3auC/hxpcGJJ+
         vJHyxMZas+EzHCInwpEIGZvXosGcOlQZrgBqLcjl491rRmH+tBOH/zvb4v3IIFyu1ric
         I8ux8hVUJh3L4VBh2hfj+ABNt/UQocqbXdgTlrvBdZleiBp6UNMEvkaw2orIna4RL2em
         ZzmAAKKtdFqAng66566zdMxHxPsoVrw2LN1cv8Q4pfYj5g0t0ginlLHWbmrJ/nJJvw95
         onww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963435; x=1772568235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        b=ar0F7sd5ICOrVDrfcrzUZJbNfklEbb2SqRjOoT0za/DqIF2xISuD3qKD04q0UmPF7x
         +brYYDkKb1BjwqYsLNvzw71FatH3LmXIAGOSmR3GAO4L1yFvC3tMVVq3zAhnahkSeiBh
         YC39ppeH5YbWQWU44j2zPm0nwKaC6qBoiTfSmPKDBIMCi30SWdd17/jvzS4oDaV2nJHh
         hw/UYY9ECPzTc30HbYowQkTa3dc1xt58YqWkZaIV84ou7iLsJfC8+kxpOMx1acttXNeD
         qL9dZgCnPEOCQ7OKis9245Op9MroVt3shDkcEKBcBaYGzQbIsPfDXCgZT5Li13M2C7SW
         ULkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963435; x=1772568235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IpFpRcZdLrJGysSA531c0+kE4YiRmcxwugRbkIrjyU=;
        b=D3Z14Y52sV19C4fHDFV4P75mvzItOLMHiF5Xlu7hQLERjnMQI8C423xXj7isRpSzL4
         ayGEE3mNLO8zT3VyO0x4X8faO5AHin2DpWNEwVa94kLi5ZuypUcN4KTd2a0Ymw0sxYT0
         +p8YBFizi59JcdRd7AZX6/KcTrq+cHZ3JJPNocSJSrJv1fbRLT3GhNvdUfWAm3b6uBMJ
         YUTBplIxnA6KHHsY3K8oN4QodU4YmIT3LCvWGQx85HezkMIHIlffQa6YE2IGEKI0jmtf
         6S8c241KAMAOKBDeJtPMcu/Re6NR4je9O1+J1vXGRW1HgXnbiBq5HFdiGF8E1BhnnAqF
         Vj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWida+Jfw6Ps31RYWGn9OafWUJwu8EZ/Nll1LQbDpiG/+WaNsNGb5bS41x7k4eUDcVw9fc9CUuxsLfx@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVOTAX0YV5aftpQ6Sq/tVB30Vcx88qwEDkfGpkfgy/EXwbhnX
	6Eobzr5qUn9kKv0eOfA/pJOihnENWi9nJOcBltpjHRxxFQB0yLtvu7z6rYm6aPuBddRAqsM1SKF
	OP2z2UQvH71YTtNMLqBJOsafftfoAd78=
X-Gm-Gg: AZuq6aK0yQheiM7Zq8LM/wqWU1cl3cZ5NTZ9j7m2ZFo/JtcSFLIbi9vci1Q2EnkIQLR
	MeyNw/i2x1rrQWZ1f4RUOo//JJUv4zwQq7EXm+uEHVROpD/RpjzAdgSsLj4A6y9EapoOlQzWTES
	c9jl1o67E0ADDMkcL3xHNi/I2gzxbNu5UBlnG1Pzqsx+Q7lm8KVJo1WwwXxfEEKV3lRmi0CryWi
	wIW3CHhOWk5j+l0rydLgNryeT9ebeul7vxU0iI4kjCLQIg7sfXLRXyR3bspVZqbl+0Tpc6h6HBr
	Dez4QA==
X-Received: by 2002:a05:622a:509:b0:4ee:1d84:306a with SMTP id
 d75a77b69052e-5070bcea3bcmr176449401cf.71.1771963434766; Tue, 24 Feb 2026
 12:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs>
 <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
 <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com> <20260224195728.GE13829@frogsfrogsfrogs>
In-Reply-To: <20260224195728.GE13829@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:03:44 -0800
X-Gm-Features: AaiRm53oIeOstds6Px0N7w_1YklUZg4R-rODjC8FziXfiS_kg8Tvo9XRpKUaex4
Message-ID: <CAJnrk1YCh=CsFmxGwnK37d-31ravAOR8uLH+CrhpFzPX=ZTxUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before
 sending FUSE_DESTROY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13995-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 458DA18C44B
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:57=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Tue, Feb 24, 2026 at 11:33:12AM -0800, Joanne Koong wrote:
> > On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > generic/488 fails with fuse2fs in the following fashion:
> > >
> > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf i=
s inconsistent
> > > (see /var/tmp/fstests/generic/488.full for details)
> > >
> > > This test opens a large number of files, unlinks them (which really j=
ust
> > > renames them to fuse hidden files), closes the program, unmounts the
> > > filesystem, and runs fsck to check that there aren't any inconsistenc=
ies
> > > in the filesystem.
> > >
> > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > files left over in the filesystem, with incorrect link counts.  Traci=
ng
> > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > commands that are queued up on behalf of the unlinked files at the ti=
me
> > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > aborted, the fuse server would have responded to the RELEASE commands=
 by
> > > removing the hidden files; instead they stick around.
> > >
> > > For upper-level fuse servers that don't use fuseblk mode this isn't a
> > > problem because libfuse responds to the connection going down by prun=
ing
> > > its inode cache and calling the fuse server's ->release for any open
> > > files before calling the server's ->destroy function.
> > >
> > > For fuseblk servers this is a problem, however, because the kernel se=
nds
> > > FUSE_DESTROY to the fuse server, and the fuse server has to write all=
 of
> > > its pending changes to the block device before replying to the DESTRO=
Y
> > > request because the kernel releases its O_EXCL hold on the block devi=
ce.
> > > This means that the kernel must flush all pending FUSE_RELEASE reques=
ts
> > > before issuing FUSE_DESTROY.
> > >
> > > For fuse-iomap servers this will also be a problem because iomap serv=
ers
> > > are expected to release all exclusively-held resources before unmount
> > > returns from the kernel.
> > >
> > > Create a function to push all the background requests to the queue
> > > before sending FUSE_DESTROY.  That way, all the pending file release
> > > events are processed by the fuse server before it tears itself down, =
and
> > > we don't end up with a corrupt filesystem.
> > >
> > > Note that multithreaded fuse servers will need to track the number of
> > > open files and defer a FUSE_DESTROY request until that number reaches
> > > zero.  An earlier version of this patch made the kernel wait for the
> > > RELEASE acknowledgements before sending DESTROY, but the kernel peopl=
e
> > > weren't comfortable with adding blocking waits to unmount.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > Overall LGTM, left a few comments below
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
>
> Thanks!
>
> > > ---
> > >  fs/fuse/fuse_i.h |    5 +++++
> > >  fs/fuse/dev.c    |   19 +++++++++++++++++++
> > >  fs/fuse/inode.c  |   12 +++++++++++-
> > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 7f16049387d15e..1d4beca5c7018d 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
> > >  void fuse_abort_conn(struct fuse_conn *fc);
> > >  void fuse_wait_aborted(struct fuse_conn *fc);
> > >
> > > +/**
> > > + * Flush all pending requests but do not wait for them.
> > > + */
> >
> > nit: /*  */ comment style
>
> I'm very confused by the comment style in this header file.  Some of
> them look like kerneldoc comments (albeit not documenting the sole
> parameter), but others are just regular C comments.

Oh I see your confusion now. Yeah the comment styles in this .h file
are kind of all over the place. Most of the functions don't even have
comments.

>
> <shrug> I sorta dislike kerneldoc's fussiness so I'll change it to a C
> comment so that I don't have to propagate this "@param fc fuse
> connection" verbosity.
>
> > > +void fuse_flush_requests(struct fuse_conn *fc);
> > > +
> > >  /* Check if any requests timed out */
> > >  void fuse_check_timeout(struct work_struct *work);
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 0b0241f47170d4..ac9d7a7b3f5e68 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/splice.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/seq_file.h>
> > > +#include <linux/nmi.h>
> >
> > I don't think you meant to add this?
>
> Yep, that was added for a previous iteration and can go away now.
>
> > >
> > >  #include "fuse_trace.h"
> > >
> > > @@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
> > >         }
> > >  }
> > >
> > > +/*
> > > + * Flush all pending requests and wait for them.  Only call this fun=
ction when
> >
> > I think you meant "don't wait" for them?
>
> Right.  Fixed.
>
> > > + * it is no longer possible for other threads to add requests.
> > > + */
> > > +void fuse_flush_requests(struct fuse_conn *fc)
> > > +{
> > > +       spin_lock(&fc->lock);
> > > +       spin_lock(&fc->bg_lock);
> > > +       if (fc->connected) {
> > > +               /* Push all the background requests to the queue. */
> > > +               fc->blocked =3D 0;
> > > +               fc->max_background =3D UINT_MAX;
> > > +               flush_bg_queue(fc);
> > > +       }
> > > +       spin_unlock(&fc->bg_lock);
> > > +       spin_unlock(&fc->lock);
> > > +}
> > > +
> > >  /*
> > >   * Abort all requests.
> > >   *
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index e57b8af06be93e..58c3351b467221 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
> > >  {
> > >         struct fuse_conn *fc =3D fm->fc;
> > >
> > > -       if (fc->destroy)
> > > +       if (fc->destroy) {
> > > +               /*
> > > +                * Flush all pending requests (most of which will be
> > > +                * FUSE_RELEASE) before sending FUSE_DESTROY, because=
 the fuse
> > > +                * server must close the filesystem before replying t=
o the
> > > +                * destroy message, because unmount is about to relea=
se its
> > > +                * O_EXCL hold on the block device.  We don't wait, s=
o libfuse
> > > +                * has to do that for us.
> >
> > nit: imo the "because the fuse server must close the filesystem before
> > replying to the destroy message, because..." part is confusing. Even
> > if that weren't true, the pending requests would still have to be sent
> > before the destroy, no? i think it would be less confusing if that
> > part of the paragraph was removed. I think it might be better to
> > remove the "we don't wait, so libfuse has to do that for us" part too
> > or rewording it to something like "flushed requests are sent before
> > the FUSE_DESTROY. Userspace is responsible for ensuring flushed
> > requests are handled before replying to the FUSE_DESTROY".
>
> How about I simplify it to:
>
>         /*
>          * Flush all pending requests before sending FUSE_DESTROY.  The
>          * fuse server must reply to the flushed requests before
>          * handling FUSE_DESTROY because unmount is about to release
>          * its O_EXCL hold on the block device.
>          */

This sounds a lot better to me.

Thanks,
Joanne
>
> --D
>
> >
> > Thanks,
> > Joanne
> >
> > > +                */
> > > +               fuse_flush_requests(fc);
> > >                 fuse_send_destroy(fm);
> > > +       }
> > >
> > >         fuse_abort_conn(fc);
> > >         fuse_wait_aborted(fc);
> > >
> >

