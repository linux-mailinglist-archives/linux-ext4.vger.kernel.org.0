Return-Path: <linux-ext4+bounces-4472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42499034E
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5D41F21EC9
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2A820FA95;
	Fri,  4 Oct 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3QJrdpS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2929422
	for <linux-ext4@vger.kernel.org>; Fri,  4 Oct 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046261; cv=none; b=dz5+ejdY0+0gh9s3s6LvQqsL6P9UoATf3Bd3BGIaNsJf1rK98F8hxS+4Fn+5rDiq58BoH1/S7WJgqilwNqrBZzy38t3bfgEBUCtpZI3PvQQ/8i9P/sr6brYCW7gdk9ATEP9XSUy/jreaKx+kh9PQkRpF1TUj0ZYAto7Bu2ZZdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046261; c=relaxed/simple;
	bh=fTD2ucq9J26AkeNSNPlAWDmTU4qktKPFMukHQfAOpKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrrJgFynQgMjKDr4JvtW9iopQWxdHcXPSEiBmOSp0/yDPlw9qdbGf44kvZAp//kX+sje29WW3YahaTEIjrJIypHxk8NB0ao/AqoUP6M/ky5LXmqj7NbltPi1OQsqmpKLini8jxtR/IrDDBR+jqMlEgFZy9GelPSxgx6Mlups2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3QJrdpS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728046258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
	b=Z3QJrdpS7iQuZ/ih39BYvwOwtkoy2KyLtqdERxDBSasUtMmj9TzkyH2xtDOuRs+ztb/sX1
	xSjo/YMuB0VgBhhX80/Ti2384uNAny/TsMRC6glPJVO38c9rdeH8iQ84eRY6SHALbv/Sr0
	72H4zBG3euJJ8qy92MbVe3StXqg1nzY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-bmBk4yaZPZGHwM5v_4dy8w-1; Fri, 04 Oct 2024 08:50:57 -0400
X-MC-Unique: bmBk4yaZPZGHwM5v_4dy8w-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e04c60d101so1893003b6e.3
        for <linux-ext4@vger.kernel.org>; Fri, 04 Oct 2024 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046256; x=1728651056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVF8DgPOYH31LJm3NWs4Ti1Tq8gTaEHw5QsDrHnfb/s=;
        b=SdxlgQU3lL5lc4vQq6Hadsaff3gCXdRfb2bDNM/IHCivyq08wDCCAi+miX4RgjCyh4
         I1o7zUUbX6+y/JTsAbQ7MZ12SLVyL8jjsZ1uqSq/wgtIAncaXkD0tc0q5r4YIuwZja+6
         gvmFTp5qQH6pwJeRLP0fXlDcUYjrKOVnC3WqQiE+gV/891FbtlKZjMB8i3Kt4Up6fOua
         pYuPArmaU/pcKtXIaq+hif7f9bXdJYZ7rdeYlRqy5vyEUYLO42XFOpS6MKqCzN8aG5Af
         E+gN0Jn+yU1W+57d6W2JW+RVpJ6Su01n23gY6/OpACahxe1Q65FVn+9hm5H120vAzkOG
         62RA==
X-Forwarded-Encrypted: i=1; AJvYcCXLhF83Z0XsbWFB59SG+po/FGgWZFr/Hc5um3QFAKvaM+go01WMqvTl+Q+Yuf5XbZT7r5QL4q2vov/9@vger.kernel.org
X-Gm-Message-State: AOJu0YxaS0E7Hf/YEPT2S1tddLB48a4J0fR2WcSwrfLsIA8UrlQBGNFe
	CsdYu+RN9FkQGWjzdFSmoPkfwIqdB0OSa48SN426fBhFeNTkg/+z1RlLWC6Yeg37YFT3wxlDWXy
	jjxN8LL2UNcCihkVESDJRlYID6LmyQpcE7VMCiMh6vWTdT/4SEdfcs8N6Hso5IVA2YHbvz9rzGp
	vC52pJp5nKGZhUY3r1AbMp6tbI0isCs4HZsA==
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id 5614622812f47-3e3c411848dmr812686b6e.35.1728046256379;
        Fri, 04 Oct 2024 05:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpqfAKYzgpxhx1Y0BybucSFPMqmPot5eRKUtb/w2XIi6XfDKI/xhyBng1Hj827T1HCrAcFDKKTHQWLD2IflRU=
X-Received: by 2002:a05:6808:448c:b0:3e3:c411:5e86 with SMTP id
 5614622812f47-3e3c411848dmr812677b6e.35.1728046256097; Fri, 04 Oct 2024
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3> <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Oct 2024 14:50:40 +0200
Message-ID: <CAASaF6yASRgEKfhAVktFit31Yw5e9gwMD0jupchD0gWK9EppTw@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, ltp@lists.linux.it, 
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:32=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Sep 30, 2024 at 1:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 30-09-24 12:15:11, Jan Stancek wrote:
> > > On Mon, Aug 05, 2024 at 10:12:41PM +0200, Jan Kara wrote:
> > > > When the filesystem is mounted with errors=3Dremount-ro, we were se=
tting
> > > > SB_RDONLY flag to stop all filesystem modifications. We knew this m=
isses
> > > > proper locking (sb->s_umount) and does not go through proper filesy=
stem
> > > > remount procedure but it has been the way this worked since early e=
xt2
> > > > days and it was good enough for catastrophic situation damage
> > > > mitigation. Recently, syzbot has found a way (see link) to trigger
> > > > warnings in filesystem freezing because the code got confused by
> > > > SB_RDONLY changing under its hands. Since these days we set
> > > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. =
So
> > > > stop doing that.
> > > >
> > > > Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@goog=
le.com
> > > > Reported-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > > fs/ext4/super.c | 9 +++++----
> > > > 1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > Note that this patch introduces fstests failure with generic/459 te=
st because
> > > > it assumes that either freezing succeeds or 'ro' is among mount opt=
ions. But
> > > > we fail the freeze with EFSCORRUPTED. This needs fixing in the test=
 but at this
> > > > point I'm not sure how exactly.
> > > >
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index e72145c4ae5a..93c016b186c0 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_bl=
ock *sb, bool force_ro, int error,
> > > >
> > > >     ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
> > > >     /*
> > > > -    * Make sure updated value of ->s_mount_flags will be visible b=
efore
> > > > -    * ->s_flags update
> > > > +    * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
> > > > +    * modifications. We don't set SB_RDONLY because that requires
> > > > +    * sb->s_umount semaphore and setting it without proper remount
> > > > +    * procedure is confusing code such as freeze_super() leading t=
o
> > > > +    * deadlocks and other problems.
> > > >      */
> > > > -   smp_wmb();
> > > > -   sb->s_flags |=3D SB_RDONLY;
> > >
> > > Hi,
> > >
> > > shouldn't the SB_RDONLY still be set (in __ext4_remount()) for the ca=
se
> > > when user triggers the abort with mount(.., "abort")? Because now we =
seem
> > > to always hit the condition that returns EROFS to user-space.
> >
> > Thanks for report! I agree returning EROFS from the mount although
> > 'aborting' succeeded is confusing and is mostly an unintended side effe=
ct
> > that after aborting the fs further changes to mount state are forbidden=
 but
> > the testcase additionally wants to remount the fs read-only.
>
> Regardless of what is right or wrong to do in ext4, I don't think that th=
e test
> really cares about remount read-only.
> I don't see anything in the test that requires it. Gabriel?
> If I remove MS_RDONLY from the test it works just fine.
>
> Any objection for LTP maintainers to apply this simple test fix?

Does that change work for you on older kernels? On 6.11 I get EROFS:

fanotify22.c:59: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fangb5wuO/test_mnt fstyp=3Dext4 flags=3D20
fanotify22.c:59: TBROK: mount(/dev/loop0, test_mnt, ext4, 32,
0x4211ed) failed: EROFS (30)

>
> Thanks,
> Amir.
>
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -57,7 +57,7 @@ static struct fanotify_fid_t bad_link_fid;
>  static void trigger_fs_abort(void)
>  {
>         SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> -                  MS_REMOUNT|MS_RDONLY, "abort");
> +                  MS_REMOUNT, "abort");
>  }
>


