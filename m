Return-Path: <linux-ext4+bounces-5085-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B09C5C30
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14D31F23561
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0B2022D4;
	Tue, 12 Nov 2024 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcSl+8h2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168220127A;
	Tue, 12 Nov 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426267; cv=none; b=b3Haw8DHtbf6Php0mo+ZUNPpv8JkJQ78VJs4ifqy32wx++oEXY/nK6NRq/KqDJgzWnJorp7lYmD9+ft3RKCyir6jl57h//AU2IaDETUY/JNllFCBUGA8EWrQTDZ8bidTdtVuE91av+Z9i5b5uRs+MxQtiqSuaPAsrjoDzoN5Ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426267; c=relaxed/simple;
	bh=fS4J7yDzI39PL8ZoMu2IAbRx82SFhb6U/y0jz6ClThc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLPCjfgA3bviMRNJkQfgRSPb+yCFhu7I1+GjSMbhNnaVmndd101KZKIMzlJ0RHEOhkoGNK6swf23VwcJxgmLl9/dfodizv7nHuEqatrAtJzca/ba/LN/Tlr5ouJiujr6+y5Xvcsw0XqBCaemkIN472XBPBNqwLyYRHk7llQIUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcSl+8h2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso73519415e9.0;
        Tue, 12 Nov 2024 07:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731426264; x=1732031064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETNP9yNkXTf1tz0U03wjmJSDsqqTZhQALvrSEprwsMI=;
        b=IcSl+8h2U6nzlqpHyki4u68mQQcowXhrqkBVDzN/0udL7MWj4qeJ3HiuCVL9AXulKW
         787zjW+ayklakDUY7AK54ZsxV+P9nYE1N7vacL1EiHq6LHcnyJBvDs7ON3EjLqv2aj9v
         8jdxvN4clpcOSit3ooyopw8CuqnVHWGWyH335/scm9h1lqoLAlQQ1PeSO6BVJ5fmaaF+
         SIzLc7sXbGi/SatoY0PK7jXoFJ0xwtC+ACo1qoIJcYVCthaa6z3ZBrOt4/LcEWHCo4hm
         X9EheTme7m2IzIxyUZ7kQi6iUV9yJ+YV1dm3GaU7iDNG1yhWoZGfzOzgTSPsVCc1FJYY
         tUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426264; x=1732031064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETNP9yNkXTf1tz0U03wjmJSDsqqTZhQALvrSEprwsMI=;
        b=BsVhx4RUsQTk3LXueUBrRTGeTo8dc8e/tRNw99yL7R/+wc3iobsP//+k3n+fNMQ4qd
         B+UpPtZuFCqK9yZc8hzgsMMbv20QW0O3mzhkLc51vxh8jTZWvjJBVX7uQn2/XNjJUjb4
         cuNnUEd7hT0By5+Eg2n8pwgjwjkIMNyFUkbjbFyFwU7rLvwAWL0sSkYCaq2FvT3Y86wq
         Gmlx5f/C0LvJ1IQ2TBIJWLN3W9rrHcf1D29jYs7QAY+h72JylfytbqicwWouYPdxYk07
         6GAO7N84u+wHW1UKoGKLpmg2z9t8tEZc8dbZ9jVtkki6qkI6G2vvcSASlFMF+4ML3MCR
         p1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2jX1z9t/GmanxndeeQSbgiSJp63MZQaLu85/MudHqA50Mx+3/luwtEGSPCkp30dMLbNW8i6YLc5op@vger.kernel.org, AJvYcCUbULUm84PZOBGtpNLbMgn809ZM/tANdAznSjwMk55WaI6yaPB8T8V27Z+IBIDfZgOksQAIUd5ANo+DN7/C@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZKTGyj5G1gRRAZrAQGDqqSOcvv7ex7J0NcHzWXUB0+nolYy3
	P6cU7f3Zcc47tA+k9BkTsitwAWiPp6Xzp7LVWQ1iPflRADnvM4wh8G9GNbtEQo+AMm+FON0aZPV
	OLUHxMh/jMr5bKjoqAmwpePn+frg=
X-Google-Smtp-Source: AGHT+IE61eEBj4n6mhK0OCpunvztbqR9xM2DivLuqQVsFuGTsrkTKylWTl3i9wckZHzRDbO8a4R0t2xJPPlSIT/M268=
X-Received: by 2002:a5d:47aa:0:b0:382:6d2:d86c with SMTP id
 ffacd0b85a97d-38206d2d8bcmr4284365f8f.37.1731426263576; Tue, 12 Nov 2024
 07:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016111624.5229-1-linmaxi@gmail.com> <20241107050307.GA287288@mit.edu>
In-Reply-To: <20241107050307.GA287288@mit.edu>
From: Max Brener <linmaxi@gmail.com>
Date: Tue, 12 Nov 2024 17:44:11 +0200
Message-ID: <CAJcXncXSLsHah+7KvtEHK-Y0xD5K-b3yCSAFiYfibmmZnc4P1Q@mail.gmail.com>
Subject: Re: [RESEND v2] ext4: Optimization of no-op ext4_truncate triggers
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=D7=
=B3, 7 =D7=91=D7=A0=D7=95=D7=91=D7=B3 2024 =D7=91-7:03 =D7=9E=D7=90=D7=AA =
=E2=80=AATheodore Ts'o=E2=80=AC=E2=80=8F <=E2=80=AAtytso@mit.edu=E2=80=AC=
=E2=80=8F>:=E2=80=AC
>
> On Wed, Oct 16, 2024 at 02:16:24PM +0300, Max Brener wrote:
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219306
> > v1: https://lore.kernel.org/lkml/20240926221103.24423-1-linmaxi@gmail.c=
om/T/
> >
> > Changes from last version: Moved vfs-level changes to be ext4-level,
> > and improved the description of the patch.
> >
> > This patch enables skipping no-op 'ext4_truncate' calls. Analyzing the =
kernel
> > with ftrace shows ext4_truncate is being sometimes called without makin=
g any
> > impact, and sometimes userspace programs might call ext4_truncate in ve=
in. By
> > detecting these calls and skipping them, cpu time is saved.
> >
> > I'll fix this by skipping ext4_truncate call in 'ext4_setattr' when the=
 file's size
> > hasn't changed AND it hasn't been truncated since the last disk space p=
reallocation.
> > It is meant to consider the case when ext4_truncate is being called to =
truncate
> > preallocated blocks too. Notice that so far, the condition to triggerin=
g
> > ext4_truncate by the user was: if (attr->ia_size <=3D oldsize) which me=
ans it is
> > being triggered when attr->ia_size =3D=3D oldsize regardless of whether=
 there are
> > preallocated blocks or not - if there are none, then the call is redund=
ant.
> >
> > Steps:
> > 1.Add a new inode state flag: EXT4_STATE_TRUNCATED
> > 2.Clear the flag when ext4_fallocate is being called with FALLOC_FL_KEE=
P_SIZE flag
> > to enable using ext4_truncate again, to remove preallocated disk space =
that may
> > have resulted from this call.
> > 3.Set EXT4_STATE_TRUNCATED when ext4_truncated is called successfully.
> > 4.Don't skip ext4_truncate in ext4_setattr when the size of the file ha=
s either been
> > reduced OR stayed the same, but hasn't been truncated yet. This is in o=
rder to allow
> > truncating of preallocated blocks.
>
> This patch is still not quite right.  See Jan's comment from [1]:
>
>    Agreed as well. I'll also note that keeping such flag uptodate is not =
as
>    simple as it seems because there are various places that may be alloca=
ting
>    blocks beyond EOF (for example extending writes) and that rely on
>    ext4_truncate() removing them so one needs to be careful to capture al=
l the
>    places where the "truncated" state needs to be cleared.
>
> [1] https://lore.kernel.org/all/20240930095601.x66iqw74bxffytgq@quack3/
>
>                                                 - Ted

Okay I understand now, I initially thought any preallocation is necessarily=
 done
through a VFS interface. Now that I see preallocations are done at mballoc,
what I can offer is to clear the TRUNCATED flag at ext4_mb_new_blocks().
Would that be ok in your opinion?

