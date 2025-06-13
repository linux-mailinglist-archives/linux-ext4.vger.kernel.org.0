Return-Path: <linux-ext4+bounces-8407-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A4AD8102
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 04:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F17A364E
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2C22F770;
	Fri, 13 Jun 2025 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNGlIXkJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10512EAE5
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749781898; cv=none; b=Yj8AIeXBEikNRhIoSV8WFQopbBqnn7KfMnMgc5+W/n4SOiMim5NcWbNQUp2osRBuwLwDV4P81LaHQZeWRZCdvao4ClC6ZaEK5ZKRb5SjGCZXqZcnJStmSHzSETqrStZoAfUh9YHQD0fRJnWZ0AmYgXL3hIq0FAUj4OXyM1wfXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749781898; c=relaxed/simple;
	bh=L3wD9sTjjdKg+ZhQeerd0GOe7e4k3/cfuUIH3z873d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgK182UFJiKBWwWxYdp0mIWR+/oUo+PTiTy51uW1Hps/tu3fEyZjloRQBKq+P95GcsFV2zkPwzqPygwxhI3sruxXSML78fneuDOBhjVaVgrOBwWlAdDFoPaNV3l3mdmBfWbslZdVlHtr6++g5TutBUar+FawvxcHARq/Rs1QC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNGlIXkJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553644b8f56so1628987e87.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749781895; x=1750386695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1s6XbPJSX+YCoKOPLgfOXLdhaBWp+NzFys3E04ARtU=;
        b=PNGlIXkJJTsIvQGTPkfySrZxKGDCnl2FQgmauhqmJUEIqK616cx1VgibxC609D4PAd
         BnfbOYoRpviKpxgFlQIpEVr9q7TVVzSQ6fX6XyvmGNPf+lCMuYJKLsYnFkpYlrl0PBH7
         0+COZR1JUKYI+ErgGzRHRVYcWMOmxKB8k+glcuIkMSsYHVNxYbH7av8ZPCmV4c1VCZXG
         fH1/HLLG5ByIapSHB7Ya0a+FFnKODB9Zaenu2ZQbQS9SqKrXK87nm243tmiVQA5kT7bu
         bl8N+RVxprtehyICv5U2Udu2ZUlMTjXcV+MtGAotubBK/etHQ74Oh/u1dnzmDarF/iGQ
         D7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749781895; x=1750386695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1s6XbPJSX+YCoKOPLgfOXLdhaBWp+NzFys3E04ARtU=;
        b=YNP7wxbvmnC9U1H/V6f7GcB3e486UeuJ7IQAAV0D2YvyRJ1tyfeIeR36fMNkG4Lvoz
         GkOdMEeaP6uauom6TOtfg+mXp8y3zbwLPrv1Saf0nMnjbnp2zGwW2mG0/EySjhzrs40Y
         aRXrKUjfNgTUkKcnH1XARXEgmsBMIfZu2ega/XvhxI2PFz5LfoBM3muftSGLDStOiCPM
         HmQEeiHPkRr9h/9x9d76DXuYdVwVBAueJLzfJ6UrlpQiJLKIcZFj4xFGdDfdJlFdlghA
         iktvDG8d8G0+xum4NUnd3kAS0G3rAf5LDNiM8EeaJkFvU7i/TBNL0Qy8nPb8tVb5Yo3n
         7ISw==
X-Gm-Message-State: AOJu0Yxdvv85msCr0YKhQHz7b4MN3Oowk5XbMcqCMZ5IssS/MdOp3lEY
	thXpw6kevhJa5fWGlK6nk9lRxIroJL3EglqdXfCSnRteaG37DulXjlV37oN+9tXlRF/P3Jrv1MD
	39YoFV23dkIgfJJb3leo8rNjb1R3TVv7urCPJ91Ks7w==
X-Gm-Gg: ASbGncuZLUIfpVmmPkRXX9W9GiUVNNmL3As2DJHLpKmiAnL6Mvds69nci9k+eeIs8F4
	uCVjvNbQkVgwqoU/F1T89JdtDSSbuZdnfbt7lsEhb9wi/lh0ntaHFEVL60KMWvzii8ZQi6Iemv5
	iMI2D7UK9fds3vwO0EXBtTrcSttgB9PB/+AeXjxadtl9mXRxFa8EFQtIp3
X-Google-Smtp-Source: AGHT+IFtuUdbYUuhRUf83nY2Zv7f6NjkbcSJ40Hs+kOw+r78XuMs2v4r78FG4a/sZIsELG8t201H0dpaBkdXjt84+Fw=
X-Received: by 2002:a05:6512:3ba8:b0:553:515a:5ebd with SMTP id
 2adb3069b0e04-553af9044a1mr363952e87.8.1749781894436; Thu, 12 Jun 2025
 19:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHB1NahGodp3=NovantwmhM2=faVWuuusfRPUiUZaXZt58K7Qg@mail.gmail.com>
 <20250612215003.GR784455@mit.edu>
In-Reply-To: <20250612215003.GR784455@mit.edu>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Fri, 13 Jun 2025 10:31:22 +0800
X-Gm-Features: AX0GCFuKd-QfA5YwQ2GH9pwVCfoFZDK_EwOjeKq6jUVygXbOwYHL__yfXR5u5Ew
Message-ID: <CAHB1NagzeV+RdndRWU5eXY-NdBuG+mhOccke-fQ0FkVJmQkhFA@mail.gmail.com>
Subject: Re: Discrepancy between mkfs.ext4 man page and code on
 lazy_journal_init default
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:50=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Thu, Jun 12, 2025 at 08:54:59PM +0800, Julian Sun wrote:
> > Hi,
> >
> > Recently, I observed a significant difference in the number of
> > blk_mq_get_tag() calls when executing mkfs.ext4 -F -q /dev/$nvme
> > versus mkfs.ext4 -F -q -E lazy_itable_init=3D1,lazy_journal_init=3D1
> > /dev/$nvme. The former has over 2,000 more calls than the latter,
> > which is confusing because the mkfs.ext4 man page states both features
> > should be enabled by default. This implies the commands should be
> > equivalent, with no I/O difference.
> >
> >        lazy_journal_init[=3D <0 to disable, 1 to enable>]
> >              If  enabled, the journal inode will not be
> > fully zeroed out by mke2fs.  This speeds up file system initialization
> > noticeably, but carries some small risk if the system crashes before
> > the journal has been overwritten entirely one time.  If the option
> > value is omitted, it defaults to 1 to enable lazy journal inode
> >                               ^^^^^^^^^^^
> > zeroing.
>
> I agree that this might be a bit misleading, but what was meant was
> that:
>
>         mke2fs -E lazy_journal_init
>
> and
>
>         mke2fs -E lazy_journal_init=3D1
>
> are identical.  The key words here is "If the option value is
> omitted".
>

That's a bit surprising... Because for readers searching for the
default value in the man page, they actually want to know the value
when the configuration is completely unspecified, including in
/etc/mke2fs.conf and when not specified via mke2fs -E. It feels like
the current man page description avoids the majority of scenarios and
only describes a rare case.

What do you think about changing the man page description to: "If the
value is not specified in /etc/mke2fs.conf or via mke2fs, it defaults
to disabled."?
This also implicitly conveys that the default value can be overridden
by configurations in /etc/mke2fs.conf or via the mkfs.ext4 -E option.
>
> Note that there is a distinct difference between the extended option
> using -E command-line option and specifying the default in
> mke2fs.conf.  That is documented in the mke2fs.conf(5) man page.
>
> So the bottom line is that it is possible to change the default of
> lazy_journal_init (and lazy_itable_init, etc.) in /etc/mke2fs.conf.
> So specifying exactly what the default should be is tricky, because
> the system administrator could have changed what is in
> /etc/mke2fs.conf.
>
> So there is the default if there is no mention of the option in
> /etc/mke2fs.conf; the default that is used if the extended option -E
> lazy_itable_init=3DN is not specified (which is the value in
> /etc/mke2fs.conf, or the default if it is not mentioned in
> /etc/mke2fs.conf); and then there is the default value if "=3DN" is not
> specified.
>
> 'm not sure what's the best way of making this more explicit, short
> of doubling or tripling the paragraphs in man pages for mke2fs(8) and
> mke2fs.conf(5).  Which would not be ideal....  I'm happy to receive
> any suggestions for how to make things a bit more clear but hopefully
> in a succint way.
>
> Fortunately, it's super rare that users would ever need to change the
> default, and most of the time, it's best not to mess with these knobs
> at all....
>
> Cheers,
>
>                                                 - Ted


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

