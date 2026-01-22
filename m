Return-Path: <linux-ext4+bounces-13175-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLpQCwRucWkPHAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13175-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 01:23:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B35FEB6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 01:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949CD504EBB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1229D27D;
	Thu, 22 Jan 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcmMfGYb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3980298CA3
	for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041402; cv=pass; b=dvJDQg+JZpK7EB0COqJd1Pd+bT7DUd2aNgMpiCystLS5IoiVQqCxSinOYIrhwgaq3eub/5fN+a8H0SnyLabAeKyrUrntBXxSi7lPQ56X29WwcffehStwhBjE1ROXkFCq2gjGx44bpY6bnL1sDIUlQoTKqZADj8e4VoZmhPuama0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041402; c=relaxed/simple;
	bh=IvHSX40nTc/ek4uvlvk06j7MjqF6iPY31dTzU/pChqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez0ES9FHYBDvhKuk67z/zwI8ZXr6Ix/TwNilJoa2usGskMcsyy492+jW/w7ms1Z7gPe2IfgbsFCK7Z1YHjTw3okldjDYsrCGbE3bHbXj5wi6xL/njs5NcZ1A9k5OSePbMMmFZTW7n+93YtjDEPYbvklnH4Po5FPMwyaleHGNtYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcmMfGYb; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014d4ddb54so4323611cf.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 16:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041400; cv=none;
        d=google.com; s=arc-20240605;
        b=Q067QA/yS9aUHBNTnZLsP/xq9srI/W0ZdlcyCaloyztf4R0NIiSPNF9IkHQ5sYAR6x
         fTogBgKFrJFn0TLFtAf68htCObbmfLh1rlLIOYOX4RuRJQpJaZeLR1eG+/27BCYESTWL
         sZrCMqXHr1SfKFILmNFB17A2rmSNiLYFSwfZGZw91GJDgvOLL7yScMe5nimgJwqT7D2Y
         Ck8XVr6YnGkuYR609qvBAJUZld3vk29dE68oWAWN46CbbdZu9uqYNKehs/enU998V2Jk
         caFN9tOjc714jvqKAnkotGwXe/sKrsT/hRcOFlQOWcx3AqWrtTho9G3wBuaByfLlXqpJ
         YEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        fh=6Gn/GHMpNQtG4inqGnh6F0gQQU61+SwGvpP3Vq7yvoE=;
        b=c5EHqeFYllitz7FPRd7d24rucEVnAE7bceFvvq/yKNW938EKZZmQ6LAq/DJrRJQNnd
         7D+0o20lu5ASbZQ48PjiQzncu1PgScARcl0ZkEJIIyxYGRpzWGyIYnZBXtHB8vCaILVr
         GxvwnU/Hg6EnS3barzywzFCW6Z89EuYiVlN3GlJ+9QaGgyq9WTPjrpczQXZJtttybO/7
         p9Dr5ZGGPtHO1ZWnicAPUW+uzh2kqWAiqz4j9/Ekp71W3kfsK4iA0SAqxo0aHvmMknfq
         t22YhQ+B/jHDsmdEwi7z0bM4b2zevKGyCmFFuW8DLKeAdUNXZ8O9SrXENSA7gJZVPh/b
         T/ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041400; x=1769646200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        b=RcmMfGYbQRjDlgMdgTk6wguPQ6WEM7/P3qT5HapoK9DU5EDqoc5yptx9GxgFJQILur
         BfGaM3mQuVEG1QMVv1+6auCRhz5BDfOCncBNxoDXuBpItcsBEZfrNN7KqAK/qHEFJbvq
         NQQFj2ffXh8piJwsrE59aVyYHMWspJf7ZJKiciR0plPUeCgWDniSyg8O643YlRao27+Y
         8m1/81UM5adKwT9U16isuLsyBOtxmus8H/JFEVwH5zXjfV+EMfnv4/AovfrByMQXMQv0
         pgKjQRrCuA9qkn2uYJNklX77T3QIneL6zIckjqcGktAwqxyC7aVLqmp7uaBmCCFcEmpJ
         m49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041400; x=1769646200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyXMwGrZK/5Ub3ARxZ1O1ZyOE7guC/+ZIizn3kEzzYc=;
        b=QfI6EPG6++1lcXWBKO1IMKxeqnt4P/UhOsQZPKOXB2FBi0ouURQt2aaTmUApjSecRV
         yYzjnykwRGwO2urfnknPvLwjHrWX/kcYOGIi2PR1Crj800PdrYoUHW/CHKMwFNfvA6la
         qDypBAvHSRsV0TIlhG98P2ao8RxDWRLeHryU5/AiA4YJhV+vNNdt3QMifOSJGxxRSH0k
         OTV44Cow65llHa5gMy0m8dsqnODf711vifCJ5VVJkSIrpYg+Rp6vBDR5JFD5oCEmBQ6P
         2nFSCXQw5SOlYdrfryEor1ym3iNPWIMR42PuGXDjhIuWIpr0aOm1mSgPjHTzbrCzzdP1
         2KZg==
X-Forwarded-Encrypted: i=1; AJvYcCV0VNdq0p64CgTXj7lgu3HskPZdU4e4v4YE6zrAG/hsS6iC04uyOjLF7zCmGJ8E17I2oDBLY29RrRel@vger.kernel.org
X-Gm-Message-State: AOJu0YxqlbRMrJjWwkz17fbX0o7Et59URqqJdhAJnDN7SiGLRHY2xD2q
	H+8GU0Ap/8Yfiq5yyBLfpIR1876Ip0DQD45WaoMig7+dsbxRlPRN9rfi9rwQDGzKC0h1rDWatzV
	/GQ8dUcAvRLvqxTeY7mbSkapMOW52Vd0=
X-Gm-Gg: AZuq6aL007d23OwZcBRuSvJiGnQpsyd+sJw/e9MMmw9tuRyE2hr+ZXb69Xj/dcI5QiR
	FidqMDBR3edfTkwAJGnGHxv5EiLl6PaPCm6JycVfa2gwj63qJSOELDj3GZxmL51kllIP7/tJ9mr
	WXuaUPLl/zTdO5oIeCwtl+f/s4eTcm6Bxht2eVT7Z/jlU1zcQoO9m5BHot5Q6/JEf6mip851GeA
	FTZy8A+kF3+kzqCJIYDg668J97+AvuUPaD5xICrlDB/NeAWHqXzUWdLNQ8iti3vAaHw4w==
X-Received: by 2002:ac8:7f56:0:b0:4ff:c884:31ad with SMTP id
 d75a77b69052e-502a175713dmr303665671cf.53.1769041399655; Wed, 21 Jan 2026
 16:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
 <CAJnrk1ZUbuAER90xbagWnBZ9dWKkdUAqVRa1vmZ5BtL_o=TnnA@mail.gmail.com> <20260122000227.GK5966@frogsfrogsfrogs>
In-Reply-To: <20260122000227.GK5966@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 16:23:08 -0800
X-Gm-Features: AZwV_Qgjb8XgeysXcP88DDgVJSYEpHtw7nd-7kRskGNM3PdmVUgS62gjGWMSLYQ
Message-ID: <CAJnrk1Z_M4XP7dApmuLA9Na+7+9OO0he9EcaZJrubTrHKKUk8w@mail.gmail.com>
Subject: Re: [PATCH 03/31] fuse: make debugging configurable at runtime
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13175-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8D0B35FEB6
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 4:02=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 03:42:04PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Use static keys so that we can configure debugging assertions and dme=
sg
> > > warnings at runtime.  By default this is turned off so the cost is
> > > merely scanning a nop sled.  However, fuse server developers can turn
> > > it on for their debugging systems.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h     |    8 +++++
> > >  fs/fuse/iomap_i.h    |   16 ++++++++--
> > >  fs/fuse/Kconfig      |   15 +++++++++
> > >  fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c      |    7 ++++
> > >  5 files changed, 124 insertions(+), 3 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> > > index a88f5d8d2bce15..b6fc70068c5542 100644
> > > --- a/fs/fuse/file_iomap.c
> > > +++ b/fs/fuse/file_iomap.c
> > > @@ -8,6 +8,12 @@
> > >  #include "fuse_trace.h"
> > >  #include "iomap_i.h"
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
> > > +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> > > +#else
> > > +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> > > +#endif
> > > +
> > >  static bool __read_mostly enable_iomap =3D
> > >  #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> > >         true;
> > > @@ -17,6 +23,81 @@ static bool __read_mostly enable_iomap =3D
> > >  module_param(enable_iomap, bool, 0644);
> > >  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> > > +static struct kobject *iomap_kobj;
> > > +
> > > +static ssize_t fuse_iomap_debug_show(struct kobject *kobject,
> > > +                                    struct kobj_attribute *a, char *=
buf)
> > > +{
> > > +       return sysfs_emit(buf, "%d\n", !!static_key_enabled(&fuse_iom=
ap_debug));
> > > +}
> > > +
> > > +static ssize_t fuse_iomap_debug_store(struct kobject *kobject,
> > > +                                     struct kobj_attribute *a,
> > > +                                     const char *buf, size_t count)
> > > +{
> > > +       int ret;
> > > +       int val;
> > > +
> > > +       ret =3D kstrtoint(buf, 0, &val);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       if (val < 0 || val > 1)
> > > +               return -EINVAL;
> > > +
> > > +       if (val)
> > > +               static_branch_enable(&fuse_iomap_debug);
> > > +       else
> > > +               static_branch_disable(&fuse_iomap_debug);
> > > +
> > > +       return count;
> > > +}
> > > +
> > > +#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)               =
   \
> > > +{                                                                   =
   \
> > > +       .attr   =3D { .name =3D __stringify(_name), .mode =3D _mode }=
,        \
> > > +       .show   =3D _show,                                           =
     \
> > > +       .store  =3D _store,                                          =
     \
> > > +}
> > > +
> > > +#define FUSE_ATTR_RW(_name, _show, _store)                     \
> > > +       static struct kobj_attribute fuse_attr_##_name =3D        \
> > > +                       __INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> > > +
> > > +#define FUSE_ATTR_PTR(_name)                                   \
> > > +       (&fuse_attr_##_name.attr)
> > > +
> > > +FUSE_ATTR_RW(debug, fuse_iomap_debug_show, fuse_iomap_debug_store);
> > > +
> > > +static const struct attribute *fuse_iomap_attrs[] =3D {
> > > +       FUSE_ATTR_PTR(debug),
> > > +       NULL,
> > > +};
> > > +
> > > +int fuse_iomap_sysfs_init(struct kobject *fuse_kobj)
> > > +{
> > > +       int error;
> > > +
> > > +       iomap_kobj =3D kobject_create_and_add("iomap", fuse_kobj);
> > > +       if (!iomap_kobj)
> > > +               return -ENOMEM;
> > > +
> > > +       error =3D sysfs_create_files(iomap_kobj, fuse_iomap_attrs);
> > > +       if (error) {
> > > +               kobject_put(iomap_kobj);
> > > +               return error;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
> > > +{
> >
> > Is sysfs_remove_files() also needed here?
>
> kobject_put is supposed to tear down the attrs that sysfs_create_files
> attaches to iomap_kobj.  Though you're right to be suspicious -- there
> are a lot of places that explicitly call sysfs_remove_files to undo
> sysfs_create_files; and also a lot of places that just let kobject_put
> do the dirty work.

Makes sense, thanks for the context.
>
> > > +       kobject_put(iomap_kobj);
> > > +}
> > > +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> > > +
> > >  bool fuse_iomap_enabled(void)
> > >  {
> > >         /* Don't let anyone touch iomap until the end of the patchset=
. */
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 1eea8dc6e723c6..eec711302a4a13 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -2277,8 +2277,14 @@ static int fuse_sysfs_init(void)
> > >         if (err)
> > >                 goto out_fuse_unregister;
> > >
> > > +       err =3D fuse_iomap_sysfs_init(fuse_kobj);
> > > +       if (err)
> > > +               goto out_fuse_connections;
> > > +
> > >         return 0;
> > >
> > > + out_fuse_connections:
> > > +       sysfs_remove_mount_point(fuse_kobj, "connections");
> > >   out_fuse_unregister:
> > >         kobject_put(fuse_kobj);
> > >   out_err:
> > > @@ -2287,6 +2293,7 @@ static int fuse_sysfs_init(void)
> > >
> > >  static void fuse_sysfs_cleanup(void)
> > >  {
> > > +       fuse_iomap_sysfs_cleanup(fuse_kobj);
> > >         sysfs_remove_mount_point(fuse_kobj, "connections");
> > >         kobject_put(fuse_kobj);
> > >  }
> > >
> > Could you explain why it's better that this goes through sysfs than
> > through a module param?
>
> You can dynamically enable debugging on a production system.  I (by
> which I really mean the support org) wishes they could do that with XFS.
>
> Module parameters don't come with setter functions so you can't call
> static_branch_{enable,disable} when the parameter value updates.
>

Ohh I thought the "module_param_cb()" stuff does let you do that and
can be dynamically enabled/disabled as well? I mostly ask because it
feels like it'd be nicer from a user POV if all the config stuff (eg
enable uring, enable iomap, etc.) is in one place.

Thanks,
Joanne

> --D
>
> > Thanks,
> > Joanne

