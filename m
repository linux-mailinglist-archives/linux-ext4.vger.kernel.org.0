Return-Path: <linux-ext4+bounces-11639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F70C3ED0D
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 08:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040DE1883C25
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09B30BB89;
	Fri,  7 Nov 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsK+QnaS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E82D5C91
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501874; cv=none; b=eVRCF6ga92E7+bbw3R/gqmWXM9uqwpKrjFDCwtqEu4ofF1GA87ihj4yPSDizV/iKMEZX9hIO3cRPM47T1QK6DZipDnkjobf0ZILq8j0e6eDrvZjRJyjIY2jvuhcVYT+LcqSxuWnLtRE4roKebb47xM4uD3vJmJIxdGC9Q8y2n2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501874; c=relaxed/simple;
	bh=DBkxoSNlKaSPUMK4zellr7NQI5sAgx6z9H/pZ4MGVqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcU1cCZ/yNga7CpBjyuM/zOyO0P5z0X90mfCADq0HpbZCp2jS0MelMsNYXiwIK19+VYc8cui2R6E+7mpr9LnOucQ38hKfg+zpWtx5QvK4fSPkF55LRWlNGxLT5RAlxqEy+UGDgFlF9lzCCPaZxTIwqBu9/ok5zagFOR/DFtHU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsK+QnaS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so739016a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 06 Nov 2025 23:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762501871; x=1763106671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gypdu32AjBdl8JRh/paj6OCLfQy8ztkLDfHJejFEMqc=;
        b=HsK+QnaS3sPxVxk2m3RzVCU2iYIyNIc5wvyVaCv24AUeONkHsTfrSk8lNa4Jb4QQFL
         5dR+H8N2sTQ3cf1WWLirpqmLue1oB3LfW4aRXBKDU0iBKiPPBYHMEhkVwdGYjDOKNxTd
         TrOSZAA4k9wUBFklMWGF45+1uQObdRWWMIec4W4HcxcKsvJJQYrue2iAzlYshrj1YsLL
         q9p68hUnqC5ArqOUb9bsCKL0f97NwUNIbMhhU8l3EduOpqtzjVoGVBS7dkOsvK7B5tCU
         P9f8bIq1ZAnk2t/t+h8jR4nOVRVJSuw4jOxou26H3NPehG0Cwbp60DT1hYQwK31A1fZi
         unBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762501871; x=1763106671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gypdu32AjBdl8JRh/paj6OCLfQy8ztkLDfHJejFEMqc=;
        b=S0bHiKs2mX+C9O6bd3YuMPeeJbVpAhFpkBqo4rj2vzUuaB5kKXDvTD46fbnPGC5NPc
         3SqCNOF+C8WCjxvRoGqsAPkVzT5is5Zb/SuRYCOF9sTKdoXGTt0qVDO91/Ym/aAu+1c7
         yAfqzszEMJirpKftl78rijR1qx7AvkqGWHR1qz4kGg1SulKGfQY53L2akm27+QmHyBPq
         kz5MRHt8mTuq3VvAwpO96u+KXQbkHX8vKWrjcnlu2Y1MFRXlrz+PjR9xZ2O4WbCvzYbM
         aziNHt1lO7i2OD6D2zb6o4WwZoLFrcIO1+9SM8wS02C74ShrySDRwfhmPSVWTxOYqtOc
         Cyzw==
X-Forwarded-Encrypted: i=1; AJvYcCWguQTQFy4ZOpO57U4tqDt2fQHhVWSWVqRLxmlOvjZiN0CAs47lvAIQAImROyfhSFe26YFF4FFv2McR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5hyX9XMHejz0ojfOCeE2Kvko1lYZe4VkLyRG2UUQ1kBgxtTpW
	3I1J12dwBgiwhAGPMJ7XD6vlhhagoAa8TdTolnutWuBnFfqKDgedChpBHkevvcpPOn7Vx8TqhSg
	oLBfqvIE4N6a9MeL4fDBT6OYqnwDltSI=
X-Gm-Gg: ASbGncsbmFZ3ms0fvxvEWul2vyUU5ZicG/1TZLn8edIjqdCsbzwhMn5+nwW5OnwVk+G
	u2pKUcq3e6v6psAHvAsw8wH2slJSGOWkWga10xJv437n82ZVIyq+4A+aJ4gvQfYkQSOjk0NEE7g
	h3WRmHFihkiuXjXepB2mpHsQKevSanVBHRVXbHY2g79/5YlB5WkB+vYbnQ0EsuVPt2igop7fPG6
	HblFdwAxNJr8V5Nzx0QJOsRefY8pL5bj6ux9yzfGJmCMKr8GISC7uT00iYbHO2DPJiSXNn0mGZf
	gXkuTeyZktbeilKeDZg=
X-Google-Smtp-Source: AGHT+IE0wn+JgXGDP+/X23JJiJR87uZ3bU9Eku9RD/Xf6SIQu9XEELdfWfIJb6UWtw6QwSr76TEb6t86wyo+1imQhyo=
X-Received: by 2002:a05:6402:51c6:b0:640:ca67:848d with SMTP id
 4fb4d7f45d1cf-6413eeb9fb6mr2107882a12.8.1762501870320; Thu, 06 Nov 2025
 23:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
 <176169819994.1433624.4365613323075287467.stgit@frogsfrogsfrogs>
 <CAOQ4uxj7yaX5qLEs4BOJBJwybkHzv8WmNsUt0w_zehueOLLP9A@mail.gmail.com>
 <20251105225355.GC196358@frogsfrogsfrogs> <CAOQ4uxjC+rFKrp3SMMabyBwSKOWDGGpVR7-5gyodGbH80ucnkA@mail.gmail.com>
 <20251106231215.GC196366@frogsfrogsfrogs>
In-Reply-To: <20251106231215.GC196366@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Nov 2025 08:50:58 +0100
X-Gm-Features: AWmQ_bka4NhoB4_0GzsMDp2JL8GmrqvBcI2VdjLITQEvTx--8zNv2vTizrwbetI
Message-ID: <CAOQ4uxjBpm_2cUDHyU72pSRc5KLDNm9tRgGYsoaAtp6tM6yFwg@mail.gmail.com>
Subject: Re: [PATCH 01/33] misc: adapt tests to handle the fuse ext[234] drivers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:12=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Nov 06, 2025 at 09:58:28AM +0100, Amir Goldstein wrote:
> > On Wed, Nov 5, 2025 at 11:53=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 10:51:06AM +0100, Amir Goldstein wrote:
> > > > On Wed, Oct 29, 2025 at 2:22=E2=80=AFAM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > It would be useful to be able to run fstests against the userspac=
e
> > > > > ext[234] driver program fuse2fs.  A convention (at least on Debia=
n)
> > > > > seems to be to install fuse drivers as /sbin/mount.fuse.XXX so th=
at
> > > > > users can run "mount -t fuse.XXX" to start a fuse driver for a
> > > > > disk-based filesystem type XXX.
> > > > >
> > > > > Therefore, we'll adopt the practice of setting FSTYP=3Dfuse.ext4 =
to
> > > > > test ext4 with fuse2fs.  Change all the library code as needed to=
 handle
> > > > > this new type alongside all the existing ext[234] checks, which s=
eems a
> > > > > little cleaner than FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4, which also =
would
> > > > > require even more treewide cleanups to work properly because most
> > > > > fstests code switches on $FSTYP alone.
> > > > >
> > > >
> > > > I agree that FSTYP=3Dfuse.ext4 is cleaner than
> > > > FSTYP=3Dfuse FUSE_SUBTYPE=3Dext4
> > > > but it is not extendable to future (e.g. fuse.xfs)
> > > > and it is still a bit ugly.
> > > >
> > > > Consider:
> > > > FSTYP=3Dfuse.ext4
> > > > MKFSTYP=3Dext4
> > > >
> > > > I think this is the correct abstraction -
> > > > fuse2fs/ext4 are formatted that same and mounted differently
> > > >
> > > > See how some of your patch looks nicer and naturally extends to
> > > > the imaginary fuse.xfs...
> > >
> > > Maybe I'd rather do it the other way around for fuse4fs:
> > >
> > > FSTYP=3Dext4
> > > MOUNT_FSTYP=3Dfuse.ext4
> > >
> >
> > Sounds good. Will need to see the final patch.
> >
> > > (obviously, MOUNT_FSTYP=3D$FSTYP if the test runner hasn't overridden=
 it)
> > >
> > > Where $MOUNT_FSTYP is what you pass to mount -t and what you'd see in
> > > /proc/mounts.  The only weirdness with that is that some of the helpe=
rs
> > > will end up with code like:
> > >
> > >         case $FSTYP in
> > >         ext4)
> > >                 # do ext4 stuff
> > >                 ;;
> > >         esac
> > >
> > >         case $MOUNT_FSTYP in
> > >         fuse.ext4)
> > >                 # do fuse4fs stuff that overrides ext4
> > >                 ;;
> > >         esac
> > >
> > > which would be a little weird.
> > >
> >
> > Sounds weird, but there is always going to be weirdness
> > somewhere - need to pick the least weird result or most
> > easy to understand code IMO.
> >
> > > _scratch_mount would end up with:
> > >
> > >         $MOUNT_PROG -t $MOUNT_FSTYP ...
> > >
> > > and detecting it would be
> > >
> > >         grep -q -w $MOUNT_FSTYP /proc/mounts || _fail "booooo"
> > >
> > > Hrm?
> >
> > Those look obviously nice.
> >
> > Maybe the answer is to have all MOUNT_FSTYP, MKFS_FSTYP
> > and FSTYP and use whichever best fits in the context.
>
> Hrmm well I would /like/ avoid adding MKFS_FSTYP since ext4 is ext4, no
> matter whether we're using the kernel or fuse42fs.  Do you have a use
> case for adding such a thing?
>

No use case, beyond more flexibility in writing clear code.
I agree with Zorro that ext4 is not only ext4.
ext4 is ext4 on-disk format and it is ext4 driver and this ambiguity
can be a source of confusion sometimes.

I don't see the problem with defining MKFS_FSTYP
the controversial part IMO is what FSTYP should be
referring to, the flesh or the spirit...

Trying to think up a use case, ntfs has at least 3 Linux drivers
that I know of (ntfs,ntfs3 and fuse.ntfs-3g) and another one that was recen=
tly
proposed (ntfsplus). At least some have also their matching mkfs
and should be able to cross mount an ntfs formatted by other mkfs.

So testing any variation of MKFS_FSTYP and MOUNT_FSTYP
makes sense.

Using MKFS_FSTYP in mkfs and fsck helpers and using MOUNT_FSTYP
in mount helpers is always good practice IMO.

My intuition is that FSTYP should be defined to whichever
results in less churn and less weird looking code, but I don't know
which one that would be.

Thanks,
Amir.

