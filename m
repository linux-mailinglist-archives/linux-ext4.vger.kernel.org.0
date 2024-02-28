Return-Path: <linux-ext4+bounces-1416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34F86B821
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B33E1F286B7
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Feb 2024 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2691A159585;
	Wed, 28 Feb 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aB4VxPfe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9479B71
	for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148385; cv=none; b=G02vKO8wk2CyC9IuPSHQHvlMOVLzmV64cdgUEQEnuULRSlZlU7ZtbVdxEkk2KtJ84VbhnCtTu73DVpQCn3ROz0a5LUfbr1wpLjLNUdbHbMAOGWlyg3tLpa4MUiVfWZL/50hz74nlHN5pv54Xg3O1cXlWfd3h5zb2fsP+1yR0gvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148385; c=relaxed/simple;
	bh=A/wKTs25P2h+C0/iIm+ViouQFJW7MRQ3etRuF2hNBTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNJsdvkKXrwsf9OtuvyU8NQDTuiX+bhsRjxsmJjzjh2WjdswzPQw0naaBTJ8jRNE/Z/UpM96UtdU/lFmCM8hnvOdTfYWtjvCcsB/ZmsGS0KRpgvaPGWrJuYh+TEG42eCZRrdP1z2ZDcuPoi6MoAop0neYXJm8UOdO7M5yHonRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aB4VxPfe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29a6dcfdd30so38104a91.0
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 11:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709148380; x=1709753180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzu726Ai+TBY59G18muQwvBjEx5EepyiU/9T7B11GAA=;
        b=aB4VxPfe+YlsayFt7jmytzM6MrxpKcV7d4AM4C+Px4OJ6lTcus97cSb/rHydnjD0ec
         3DD3qSZ3FLH3ZNEEWcun0PSInwlYY5HibiYCSlPm25FyLq9cIDsmWmL4PTR6EjHbFzRY
         Xkzg/C0I0XY1SwtC4W48QmSQJOviX0fclpRnczIp69enfW+qYApJJLotUQlc+DTjk66y
         115qZIcns0S6ktlbEgzjwhOTyiBYFKliz9jytuUeSVYRINRghR6d0BcHIPV9S4Kas7Ry
         nDIgLjP2+1YkiSHNZFZgO5te5wJY3gmDu4iHQQ5WI0u+vO9VWa/V0KTfd1Z0n7foMYPZ
         hzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148380; x=1709753180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzu726Ai+TBY59G18muQwvBjEx5EepyiU/9T7B11GAA=;
        b=EE/2rO+co6iXbe4yZ5i6c6S0WxeEarjMB1VKOewYVpAwZgdnarGKJ5NAryd5dSc3cc
         KkNdJ37hfNdFnTAL6tRs0d3s/2K3xWS2cpTtFClhqRfzAUmuKoL/s3CuQbFVcgWqPsoB
         oVP4Irr5VnvToDzD6bOhvA2jfMcKacHpZyWSWZNQ0ZgFWTCuOYV0PdgbEjZ4OWKyXkt3
         aRDUL3vDRrpaaA93Y9IfxSydXHU/4H/AL9IPSsyashRxXNLYxRCteUHaGuSSqNZMtjKM
         rBN5PiBcSQQQ3sv581vEPBAM9j8pQEjEo63wzA+Di28FH0vQqPV7cgRFczqBbIUp76Mq
         4T4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4DrIEScxErctPRE78ELz1YrSAuE6XlVuVj8hQXgg6WjVXsJ1aKTVwwkTFSoZikZcOSo6fUV1F6HfwjbOpM5DFrjgJJs0/wuz54Q==
X-Gm-Message-State: AOJu0YzT2IhRX5FoPc1YgjjW/KZy+4TctbgcTSw9z/l7hSFXbzVlBL1U
	O2aL/nX3FORFtos6Q/E/Cf82bOvgxu0rr4ElLnC6gwZZsl8NlBCYzLhrkFnxDjO60OcgsMQAuMr
	cHpB19IVsQ/h3oJYc9aAXiYLdL6pFdGjNs5suXQ==
X-Google-Smtp-Source: AGHT+IHTS9N1iSPObTmgV9ohsjg2Tk/XgOveZ2b1BxdAL4F8Qrbrt+SBVO0cj4z1Jp4dgkTzLRzo2DRMmsDTgOeAOGU=
X-Received: by 2002:a17:90a:d58b:b0:29a:1351:59c8 with SMTP id
 v11-20020a17090ad58b00b0029a135159c8mr117187pju.22.1709148380358; Wed, 28 Feb
 2024 11:26:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
In-Reply-To: <CA+G9fYvnjDcmVBPwbPwhFDMewPiFj6z69iiPJrjjCP4Z7Q4AbQ@mail.gmail.com>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Wed, 28 Feb 2024 13:26:09 -0600
Message-ID: <CAEUSe79PhGgg4-3ucMAzSE4fgXqgynAY_t8Xp+yiuZsw4Aj1jg@mail.gmail.com>
Subject: Re: ext4_mballoc_test: Internal error: Oops: map_id_range_down (kernel/user_namespace.c:318)
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: open list <linux-kernel@vger.kernel.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Jan Kara <jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, shikemeng@huaweicloud.com, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Wed, 28 Feb 2024 at 12:19, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
> Kunit ext4_mballoc_test tests found following kernel oops on Linux next.
> All ways reproducible on all the architectures and steps to reproduce sha=
red
> in the bottom of this email.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Test log:
> ---------
> <6>[   14.297909]     KTAP version 1
> <6>[   14.298306]     # Subtest: ext4_mballoc_test
> <6>[   14.299114]     # module: ext4
> <6>[   14.300048]     1..6
> <6>[   14.301204]         KTAP version 1
> <6>[   14.301853]         # Subtest: test_new_blocks_simple
> <1>[   14.308203] Unable to handle kernel paging request at virtual
> address dfff800000000000
> <1>[   14.309700] KASAN: null-ptr-deref in range
> [0x0000000000000000-0x0000000000000007]
> <1>[   14.310671] Mem abort info:
> <1>[   14.311141]   ESR =3D 0x0000000096000004
> <1>[   14.312969]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> <1>[   14.313566]   SET =3D 0, FnV =3D 0
> <1>[   14.314228]   EA =3D 0, S1PTW =3D 0
> <1>[   14.314750]   FSC =3D 0x04: level 0 translation fault
> <1>[   14.316382] Data abort info:
> <1>[   14.316838]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> <1>[   14.317742]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> <1>[   14.318637]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> <1>[   14.319975] [dfff800000000000] address between user and kernel
> address ranges
> <0>[   14.322307] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> <4>[   14.324184] Modules linked in:
> <4>[   14.326693] CPU: 1 PID: 104 Comm: kunit_try_catch Tainted: G
>             N 6.8.0-rc6-next-20240228 #1
> <4>[   14.327913] Hardware name: linux,dummy-virt (DT)
> <4>[   14.329173] pstate: 11400009 (nzcV daif +PAN -UAO -TCO +DIT
> -SSBS BTYPE=3D--)
> <4>[ 14.330117] pc : map_id_range_down (kernel/user_namespace.c:318)
> <4>[ 14.331618] lr : make_kuid (kernel/user_namespace.c:415)
> <trim>
> <4>[   14.344145] Call trace:
> <4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
> <4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
> <4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174=
)
> <4>[ 14.346696] alloc_inode (fs/inode.c:268)
> <4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
> <4>[ 14.348016] new_inode (fs/inode.c:1033)
> <4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:37=
19)
> <4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
> fs/ext4/mballoc-test.c:314)
> <4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c=
:443)
> <4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c=
:30)
> <4>[ 14.351530] kthread (kernel/kthread.c:388)
> <4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
> <0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0: 52808004 mov w4, #0x400                  // #1024
>    4: b8236ae7 str w7, [x23, x3]
>    8: 72be5e44 movk w4, #0xf2f2, lsl #16
>    c: b90004c4 str w4, [x6, #4]
>   10:* 38e368a1 ldrsb w1, [x5, x3] <-- trapping instruction
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0: 38e368a1 ldrsb w1, [x5, x3]
> <4>[   14.354545] ---[ end trace 0000000000000000 ]---
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202402=
28/testrun/22877850/suite/log-parser-test/test/check-kernel-bug/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202402=
28/testrun/22877850/suite/log-parser-test/tests/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202402=
28/testrun/22877850/suite/log-parser-test/test/check-kernel-bug-43e0665fdb2=
d5768ac093e1634e6d9a7c65ff1b6a66af7d0c12b3bce5ca7e717/details/
>
> Steps to reproduce:
>  - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2czN4=
PCDk4BIKg76qUnQE4WkNny/reproducer

+Guenter. Just the thing we were talking about, at about the same time.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

