Return-Path: <linux-ext4+bounces-8999-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821EB04D68
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 03:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F4983B832F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 01:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE01B0F23;
	Tue, 15 Jul 2025 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYnKfYtG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A752CCC5
	for <linux-ext4@vger.kernel.org>; Tue, 15 Jul 2025 01:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542836; cv=none; b=hB8TIzLHTraBGlpK7P0GzGu5LR6qC1LnuoBqGNXUU8u/M93SXcYH9gQ2dK15tULaey4S4ykvMThQd3TBZeZz4R+ElYRjrOqFV3/1R8xVxMlx+8D8mJ3tBh/shnC7J+uYJBLLCz5wBXc3a8J3mJY7ilUwtqhJe0V0ulIp+5awbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542836; c=relaxed/simple;
	bh=j/4sJZcbHC32K0ee+0YzpRwAqKArUBiWFvrwb4dVve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNAUYmi3uGl9Svn6O8ywCw5sIHr0ZAKRtoLWRtA02SB+53N/ssqVghR1F96ekw+x91RFrL0W5YDsJXfQo7lxz6lmzRs/aJb8Iwstg7Eo7Eh80HvC1Dmi2pRxgYK7T7nmDkNHldDuFfLSI6/gkgtjQ9eZfVtOvVbicsfZWemQbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYnKfYtG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32e14ce168eso44390891fa.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 18:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752542833; x=1753147633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lsB6I1d+zFCdyvil2uVYlX1q0vZUlgB88Dtk7XEVS4=;
        b=HYnKfYtGDt9ePRjPwRegH4WB7os9F6znpI91Fj2w9t8Z2fW+nQDh1W0K54Z8cXFxtX
         tZ9g2DCPEike6WuQw2BtXLLtteXmVcuYYiW+HOktlcROVL/udzptwF6Y6s207BAih3i5
         UMAMKLoiUEU3G/amJggo7mgNCxs2URTHNt95eAA2g3I4kgsZe+igihEU5nh7fHHrcvIn
         9bZfc51AQCNiVREd9qR8+OcJSTmgpIQ9UM+3ZOmPEmLn5BaAI0LhuxyYV1uB45YxdV3g
         wklN0L3/ggs/q5fAn+vNUanlzz8aUccN5BS87K0R6SDLoUjLvwCdqtPaqt19OEXM+czI
         uMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752542833; x=1753147633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lsB6I1d+zFCdyvil2uVYlX1q0vZUlgB88Dtk7XEVS4=;
        b=A5aiAMQ5ddrWFVMwtHG3vjCD3IJPIBNJ7Pa0DsLNyDnGlS1+xHyXYgfjLZ+tr3kPNP
         rIt1gEOGMMtCoN9zFy8FmowE0fTvXNecottwc6Vjr6M7Scd5aS9CcWAQCbfDfA0DOsJN
         vISXCdLWDZ1hdG1C+9qYr/mfLYWK5nQIQ4B7HWOOu4X693f8eH87zz3aTbtpfXiZOhQ9
         nUO2QerNRndLSZOMrEojNRfZE7NnZgYGGH3m76Glb6F+LtkAIGpyWwzGtIoAoKBWJxUx
         kxbS04rmNxlkDo36KIbvm1nuDlY7Du9gECbj+Iw1BMMwaBOQxNdrMi4TxX2J+LIz1hNf
         fvhA==
X-Forwarded-Encrypted: i=1; AJvYcCWyifZBuqR2mwchKSixgoBIVFCbPw1mkhe7g7gPdNXsfX/3cU6MP+jbsVr0xDmN19yvszrxXGDToZfg@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgDyH/JkKi1jhYiRhb0hEf5wZI6/bCOZ7+08581NyzTbk5Mgt
	JI1MEi6/xGCSY87P5WCdxQ1A+3x0XFLn8nvIhUmjMhsO89fw4XU+EUPu3qZnaNUQzWK87LwBdo+
	NhQ1i5BrTbxwWBspCjjegMtqgB6qYpxk=
X-Gm-Gg: ASbGncsaT1T0Obrozo8qeGdtbJlr+z9lZHZSi8yQ4Rrd+xjhLwI//ZOv6XP6APi8Clg
	9EEelj2YekoJ8/xLRXVdLif76KpvnxBJ3UBxGSPpWEyThKls6VjCN2ViW9DjHMwFc7F6pvAdwBg
	50/lhoIvntV3FBLdFPoG8Ec54qJiHyDJkg00k/xcWxZNEYQnwlnDZblyW70yrKT3VZVGU8gYzTw
	1P+
X-Google-Smtp-Source: AGHT+IG1mKsW0dIYEECbqgDfZa9CYtAyMZHjPk8Ws032PjUuaGVaDXgbb9MERd49B8PO5J6C7VF6kZy07eo1besHfJs=
X-Received: by 2002:a05:651c:154a:b0:32a:7270:5c29 with SMTP id
 38308e7fff4ca-33053292f80mr41641361fa.2.1752542832370; Mon, 14 Jul 2025
 18:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu> <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu> <20250712042714.GG2672022@frogsfrogsfrogs>
 <20250712143432.GE4040@mit.edu> <CAJxJ_jh=4q81OnSXk=yAU3u_7CCHZLGhb31eALF0cSyNv34E1g@mail.gmail.com>
 <20250714130951.GB41071@mit.edu>
In-Reply-To: <20250714130951.GB41071@mit.edu>
From: Jiany Wu <wujianyue000@gmail.com>
Date: Tue, 15 Jul 2025 09:27:01 +0800
X-Gm-Features: Ac12FXz27Ijgp8l77hlNPvem5zeYWGdsxPQsOmKqdCRulBSMxAuPYoFEk2J7f84
Message-ID: <CAJxJ_jgg0H=+JLSjc6SNwa5tiDhWjTunNPE2V1SP-v9_O8oCqw@mail.gmail.com>
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, yi.zhang@huawei.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Ted,

Thanks indeed for the clarification, it is clear now.
OK, if using a loopback mounted image on a disk, underlying file
system full then the block device will have I/O error.
This loopback mount belongs to a third party common config. I'll
fallocate lower disk space to not exhaust disk as a work around
firstly.
Thanks again for the help:)

Best regards,
Jianyue Wu


On Mon, Jul 14, 2025 at 9:09=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Mon, Jul 14, 2025 at 12:37:21PM +0800, Jiany Wu wrote:
> > Hello, Ted,
> >
> > Good day, thanks indeed for the clarification~
> > Yes, previously tried to mount a specific ext4 disk-img to /var/log,
> > with /dev/loop1 device, and rsyslogd will write to /var/log/syslog.
> > When /tmp directory exhaust manually via fallocate, / dir will be also
> > occupied as 100%, and rsyslog write errors in /dev/loop1 happen, later
> > mount as read-only. Different from the early scenario, but this
> > scenario is not easy to reproduce.
> > Tried updating the test case, not fallocate all spaces in disk, now
> > alloc 95%, everything is normal now, no related error prints anymore.
> > It is confirmed errors are caused by disk exhaust.
> > I think the main hesitation part is whether fallocate is allowed to
> > use the whole disk space.
>
> The fallocate system call is allowed to use the whole space on the
> *file system*.  But it doesn't know about how much free space a
> thin-provisioned device's underlying storage is available.  If you are
> using a loopback mounted image on a disk, if the underlying file
> system on the disk fills up then the block device will have I/O errors
> --- and then the file system on the loop device will run into
> problems, either data loss or metadata corruption.
>
> So this is working as intended.  If you don't want this, either don't
> use a loopback mount with a sparse file; either use fallocate when
> creating the image file, or don't use a loopback mount.
>
>                                 - Ted

