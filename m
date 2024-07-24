Return-Path: <linux-ext4+bounces-3410-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A574093ACD8
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 08:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3B1F23678
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097C67A0D;
	Wed, 24 Jul 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Q8C8wS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF26D29E;
	Wed, 24 Jul 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803961; cv=none; b=BEACeLJLoaQ2tt3roJweyY/K9pqxRPpA+38JF7MO9aUaDAKCH2OZQ/o9R3tlVI5pI1ik8d+AXUsnIIqA/YAWyJtqfKBmahPrqb8WrXc9U1VKmBPndJAtgOer9dsDND6Sq48ajCtOZu4Dh3gziULFJkSq9jx2p1BWx85xIhnb1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803961; c=relaxed/simple;
	bh=Bfx5l7uwGafxxKFg8g544NeKdX/OJ82VNbHROmOPw5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA580erEKOmyxnu+6i+U8sLWxuo8AkJZ692rPhfh33kJ1VaVxDe4lZFn5oXHq46lfh4N4lgbbkVnvZua/vjEGpldtvQf8RclwEK6xZzVj0ye89oePhBkitCkrA0Fg1HwC3qdZX6FXsHqLodhf91ThtxA+6qLseltusHC6FYrLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Q8C8wS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f15e7c879so437082685a.1;
        Tue, 23 Jul 2024 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721803959; x=1722408759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfx5l7uwGafxxKFg8g544NeKdX/OJ82VNbHROmOPw5M=;
        b=A3Q8C8wSHTLjn9T6tTCCJaIErKOz9ThUiIwUM9LodnuJXEPORCV2MvOoROjpbniqR4
         RCW1QHEgyT47rPUHMqTZxKtHCZn3W4pMe+G2qyzQOkgzlikhIddLvFMFqM7HZcq3TkhD
         kSsP8OJr5MIsNn7gL1BL8UnVZfR9pqfsSVTbcdmhm9q0gClJ4gXmrCQFEnEjmozfDB5o
         X8muNZF40G51tRoL43YO1EfkUpEBK3AQx3wyUt2+gRV4X3cJGUpvUN0MbuBdLVYbG8qk
         f8vvuI4nFFArgvSsxMPnsvD57io1DQhQgv4WirW33NbQXeYdmapbE4ENpgstV+aG6tYS
         6aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721803959; x=1722408759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bfx5l7uwGafxxKFg8g544NeKdX/OJ82VNbHROmOPw5M=;
        b=SyfmVbHlU36AiNlhRm9600p0/zzW7UFcVsvy4BF/451hD/Q3FM3shBFLJg8CQHbz18
         LBR9lZP+obKZvTKyzaw0p8K07Sf7z26hjSAcFgJkJjBxHQlBvQ3z6vr8GtZNr9YrQyeA
         mu/X62CQEfHebkMq1k9uFOej6iauStxRXJCJ/0Y7IM19vHyhDIAkqNO7Q2woEZRXC0xK
         9Yjfz903LZ4chZ7buWUT7HKSjXR+aHdD1ScHvVn/eGEnh2w94oJA8WzpwyFZ7cK7XVHD
         XKs3jbuJuarhVBSXiDOQIhwygX4UpW07Zdj+jrtWLOUaukANdYOsw0zwd7oAaxqfPcfL
         5ClQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEYV14wiV7F1MwMkdKBQJKY6wzy0pKQUqjp0JPlthDuRH5s++lnBdk7F1Z5uUDGjcKGK5fIruzb2RM5ru2Y5Xkc1+ZbehlBnxof2GecJVJIrQtQUwxk+sjQcqXsd8/1jbAYg==
X-Gm-Message-State: AOJu0Yyvztsktb2T2nF7XTyi+t/Dbog7p3hfVKEx+OY94uh67jkMcoLT
	fPZNikfumdNIhvmcTr+edAN7+aZeYNjIYvc/QGQCN8EipPFTZjik2ZmOCru8bDfC96k5GI6pxlR
	F/FMXZTft4P38VriabUQ0/nenwBs=
X-Google-Smtp-Source: AGHT+IFfEqKfp851TI5GZPpKydt1I9aSw9uQDJMX+tizWj/bXIso7OPQLfv/VqnOOQ/0D4vxzeFCclLX2uexl3AmuU4=
X-Received: by 2002:a05:620a:400a:b0:79f:b34:9edc with SMTP id
 af79cd13be357-7a1cbd35be0mr139400485a.66.1721803958898; Tue, 23 Jul 2024
 23:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618123422.213844892@linuxfoundation.org> <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com> <1C4B79C7-D88F-4664-AA99-4C9A39A32934@oracle.com>
In-Reply-To: <1C4B79C7-D88F-4664-AA99-4C9A39A32934@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jul 2024 09:52:27 +0300
Message-ID: <CAOQ4uxiWttnpLBbFzVjQLKbeubbwWG35pn3Ve_majuV9a0mPJQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "jack@suse.cz" <jack@suse.cz>, 
	"krisman@collabora.com" <krisman@collabora.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>, 
	"sashal@kernel.org" <sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "tytso@mit.edu" <tytso@mit.edu>, 
	"alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>, 
	"vasavi.sirnapalli@broadcom.com" <vasavi.sirnapalli@broadcom.com>, 
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 4:48=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jul 23, 2024, at 5:20=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Tue, Jul 23, 2024 at 10:06=E2=80=AFAM Ajay Kaher <ajay.kaher@broadco=
m.com> wrote:
> >>
> >>> [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> >>>
> >>> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> >>> user space to request the monitoring of FAN_FS_ERROR events.
> >>>
> >>> These events are limited to filesystem marks, so check it is the
> >>> case in the syscall handler.
> >>
> >> Greg,
> >>
> >> Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as:
> >> fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
> >>
> >> With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
> >> timeout as no notification. To fix need to merge following two upstrea=
m
> >> commit to v5.10:
> >>
> >> 124e7c61deb27d758df5ec0521c36cf08d417f7a:
> >> 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
> >> https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.k=
aher@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
> >>
> >> 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
> >> 0001-ext4_Send_notifications_on_error.patch
> >> Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-=
ajay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53
> >>
> >> -Ajay
> >
> > I agree that this is the best approach, because the test has no other
> > way to test
> > if ext4 specifically supports FAN_FS_ERROR.
> >
> > Chuck,
> >
> > I wonder how those patches end up in 5.15.y but not in 5.10.y?
>
> The process was by hand. I tried to copy the same
> commit ID set from 5.15 to 5.10, but some patches
> did not apply to 5.10, or may have been omitted
> unintentionally.
>
>
> > Also, since you backported *most* of this series:
> > https://lore.kernel.org/all/20211025192746.66445-1-krisman@collabora.co=
m/
> >
> > I think it would be wise to also backport the sample code and documenta=
tion
> > patches to 5.15.y and 5.10.y.
> >
> > 9abeae5d4458 docs: Fix formatting of literal sections in fanotify docs
> > 8fc70b3a142f samples: Make fs-monitor depend on libc and headers
> > c0baf9ac0b05 docs: Document the FAN_FS_ERROR event
> > 5451093081db samples: Add fs error monitoring example.
> >
> > Gabriel, if 9abeae5d4458 has a Fixes: tag it may have been auto seleced
> > for 5.15.y after c0baf9ac0b05 was picked up...
>
> Or this... I might not have backported those at all
> to 5.15, and they got pulled in by another process.
>
> In any event, do you want me to backport these to
> 5.10, or would you like to do it yourself?
>

Please backport the docs and sample patches above to 5.15 and 5.10
for completion of the backport.

I do not expect you should have any major conflicts with these standalone
document and sample code.

Thanks,
Amir.

