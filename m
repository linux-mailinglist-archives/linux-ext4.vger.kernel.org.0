Return-Path: <linux-ext4+bounces-10877-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E518CBDC1E8
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 04:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D96D4F76F9
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B430C349;
	Wed, 15 Oct 2025 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mowiwkkc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFE3081A8
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494227; cv=none; b=is2keDufgrKy5xI0rKNw4Z8D/N7KMA1+VtzIIGAn93bL8kFckIF5GO4rBjmYWgwfghfmZfrouvUVvTEEHZGYY86uza83J7L9iESNIFV6AjrPLhQTs0lCwhZnc4OY1jJopaim7OmdTeOSN+Kk9GpbMoCxmiBCWkOaPis4YDUMINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494227; c=relaxed/simple;
	bh=D54eOCSdeufYDLdWrbR8Ycvs+NXgYkk492AJPpiaEtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpvx6pn54qFlgY3MV4JHqnzz0QzFLqbPd73K14Gva7RyqL4+ySMX+cLqWp85B0c2EyJlotnXlfXXmAhoFe0SShW+BbdeOblifJlWU6yWKWbLkBtJUPtagtmaOgmt95NvEqlxIZuDmu026id5oTvAFYw86+CZYmgHdUz9cterk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mowiwkkc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3b27b50090so1110117166b.0
        for <linux-ext4@vger.kernel.org>; Tue, 14 Oct 2025 19:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760494223; x=1761099023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf2fQ0gJbCyc+H10TcghIqVsJ4/+Biafcb9EsAvZcl0=;
        b=MowiwkkcodcqOn3cLNQ53GZ+9sNXYdLITsBEgjBYyf58FCn4C2SWwlrpwlscUEMZxa
         Ynrd8Q2jr8OtSHhjhGCMPeZA4guwEyuIjNzoPD0bE6snbgD1RTt+ePHugQ6cLGrH5Hjp
         v6sVG5OeSm/+Wxs2O5ZU1KuEfgIqDCWUacoF6VHfAGuHQm5kapU03WTYZhr6OCb+SfXW
         DCmk7awp025eXX8jqBH7e39fk4dhFuAev+jWfnge+3ESHl8zMMWTXAZeimi+5keg+Dre
         cvw4LcLebikcTGi27kqRxfnLnebb8HYhEdD618c8zjYIW0PZBVehr7N7hLT3v42tTOnb
         WReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494223; x=1761099023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tf2fQ0gJbCyc+H10TcghIqVsJ4/+Biafcb9EsAvZcl0=;
        b=WzSgmax58Arkz9iOYiS08UIq/b2e+fs2t+wxiAbGi5E2awXPT83M5dXP7rABI+WfXl
         AO7jR6ecxlUS/nqVVTJspeHMpvPOqWxes0DivOsQEQ7II5DqstpvTeVghdKO5TZ1ToVx
         PRMCzT2Xnel7ksQEAZztDMNLKjkBvBAGLqC1QbFQVgSy4qlOBU8wVZz+bTS/SWa/KS4t
         8YjAa9iVJ8UMCA5i4rwurhZittEfFAil0Jx6K0Fr5XtB9O1x9qdBfNTaEX3ONrn42GzY
         Eo708t+8YKsbsVm4CL5x23ZnNp7VDeoxzfEQzVDQci+uaGD/Z/AyZOUMngTXT28d3tXN
         GRww==
X-Forwarded-Encrypted: i=1; AJvYcCWD7F9+iyNIx9KtZKLU7KlGrcCUTDqyLoggRSk6y7fGmAzeRBXrlZpo+RMhFqFAJtqdjQyC5SEWJSXb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OCZ70m5Zkk8GJIDfgjwDEcJFcx4DDv6PCNFJZdp0vVmAguoo
	jHMHbaqpOIG3WcROotdMja8LRsfeDqt4ZeF+iA26ayzx7zkjEe133KaWJonhVUnAPtJndy94MLv
	YHsyL9eQqSafvtqqR/3MI6TEqbc834nprnA==
X-Gm-Gg: ASbGncu+YBerwGj9KwEbH5ikzgBs+lq+u9tmOv64oRdKvrCjn6uaSTJq6qwG3hnHxPF
	DEM+mz8OqA52pRFnkTW3+SPtMVEGQQ6+2WI6vjCTMfI2k2uYeJ+z1B6MLl3YyYQAlvmlWA5d68Q
	lLHWDFPoty/7tG2URg15CNl81GM14FL+W9hmYhxkvbKbiNs062Yf6l4X8qfEGzDcDrR8+DjQrBY
	1z0MEsKbTlDVUxmXebGwDGl51ptbRcNOCsSHpTRumomRgMaKR6anghQQg==
X-Google-Smtp-Source: AGHT+IHdVVEm39YWzMl1LNpGiBlqkvaUyflBG1tNW6GMG9o/ZGDg1s+GsqNDZBzZGU20lHi3/5OtOSjsi5i+koqZYh4=
X-Received: by 2002:a17:906:ef05:b0:b4e:d6e3:1670 with SMTP id
 a640c23a62f3a-b50aa48ca83mr2928920266b.11.1760494222641; Tue, 14 Oct 2025
 19:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009075929.1203950-1-mjguzik@gmail.com> <20251009075929.1203950-14-mjguzik@gmail.com>
 <ua3koqbakm6e4dpbzfmhei2evc566c5p2t65nsvmlab5yyibxu@u6zp4pwex5s7>
 <CAGudoHGckJHiWN9yCngP1JMGNa1PPNvnpSuriCxSM1mwWhpBUQ@mail.gmail.com> <aO7khoBHdfPlEBAE@dread.disaster.area>
In-Reply-To: <aO7khoBHdfPlEBAE@dread.disaster.area>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 15 Oct 2025 04:10:10 +0200
X-Gm-Features: AS18NWA6lCnHDvapi5wh7WY086sFtNru8nAF8St7zzP5vFF3dZCD2VdTn7VIJY4
Message-ID: <CAGudoHHY2ZpSjYda94FZos8jRsaqZ_XcR7ZDDuY0AgvbnvehyQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/14] xfs: use the new ->i_state accessors
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:02=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Oct 10, 2025 at 05:40:49PM +0200, Mateusz Guzik wrote:
> > On Fri, Oct 10, 2025 at 4:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 09-10-25 09:59:27, Mateusz Guzik wrote:
> > > > Change generated with coccinelle and fixed up by hand as appropriat=
e.
> > > >
> > > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > >
> > > ...
> > >
> > > > @@ -2111,7 +2111,7 @@ xfs_rename_alloc_whiteout(
> > > >        */
> > > >       xfs_setup_iops(tmpfile);
> > > >       xfs_finish_inode_setup(tmpfile);
> > > > -     VFS_I(tmpfile)->i_state |=3D I_LINKABLE;
> > > > +     inode_state_set_raw(VFS_I(tmpfile), I_LINKABLE);
> > > >
> > > >       *wip =3D tmpfile;
> > > >       return 0;
> > > > @@ -2330,7 +2330,7 @@ xfs_rename(
> > > >                * flag from the inode so it doesn't accidentally get=
 misused in
> > > >                * future.
> > > >                */
> > > > -             VFS_I(du_wip.ip)->i_state &=3D ~I_LINKABLE;
> > > > +             inode_state_clear_raw(VFS_I(du_wip.ip), I_LINKABLE);
> > > >       }
> > > >
> > > >  out_commit:
> > >
> > > These two accesses look fishy (not your fault but when we are doing t=
his
> > > i_state exercise better make sure all the places are correct before
> > > papering over bugs with _raw function variant). How come they cannot =
race
> > > with other i_state modifications and thus corrupt i_state?
> > >
> >
> > I asked about this here:
> > https://lore.kernel.org/linux-xfs/CAGudoHEi05JGkTQ9PbM20D98S9fv0hTqpWRd=
5fWjEwkExSiVSw@mail.gmail.com/
>
> Yes, as I said, we can add locking here if necessary, but locking
> isn't necessary at this point in time because nothing else can
> change the state of the newly allocated whiteout inode until we
> unlock it.
>

I don't have much of an opinion about this bit. Not as per my response
I added routines to facilitate not taking the lock (for the time being
anyway).

> Keep in mind the reason why we need I_LINKABLE here - it's not
> needed for correctness - it's needed to avoid a warning embedded
> in inc_nlink() because filesystems aren't trusted to implement
> link counts correctly anymore.

Ok, I did not know that. Maybe I'll take a stab at sorting this out.

xfs aside, for unrelated reasons I was looking at the placement of the
indicator to begin with. Seems like for basic correctness this in fact
wants the inode lock (not the spin lock) and the spin lock is only
taken to synchronize against other spots which modify i_state. Perhaps
it should move, which would also obsolete the above woes.

> Now we're being told that "it is too dangerous to let filesystems
> manage inode state themselves" and so we have to add extra overhead
> to code that we were forced to add to avoid VFS warnings added
> because the VFS doesn't trust filesystems to maintain some other
> important inode state....
>

Given that this is how XFS behaved for a long time now and that
perhaps the I_LINKABLE handling can be redone in the first place,
perhaps Jan will be willing to un-NAK this bit.

> So, if you want to get rid of XFS using I_LINKABLE here, please fix
> the nlink VFS api to allow us to call inc_nlink_<something>() on a
> zero link inode without I_LINKABLE needing to be set. We do actually
> know what we are doing here, and as such needing I_LINKABLE here is
> nothing but a hacky workaround for inflexible, trustless VFS APIs...
>
> > > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > > index caff0125faea..ad94fbf55014 100644
> > > > --- a/fs/xfs/xfs_iops.c
> > > > +++ b/fs/xfs/xfs_iops.c
> > > > @@ -1420,7 +1420,7 @@ xfs_setup_inode(
> > > >       bool                    is_meta =3D xfs_is_internal_inode(ip)=
;
> > > >
> > > >       inode->i_ino =3D ip->i_ino;
> > > > -     inode->i_state |=3D I_NEW;
> > > > +     inode_state_set_raw(inode, I_NEW);
>
> "set" is wrong and will introduce a regression. This must be an
> "add" operation as inode->i_state may have already been modified
> by the time we get here.

There were complaints about original naming and _add/_del/_set got
whacked. So now this settled on _set/_clear/_assign, per the cheat
sheet in the patch. So this does what it was supposed to.

