Return-Path: <linux-ext4+bounces-3369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C26939D69
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 11:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449B1281970
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249814C582;
	Tue, 23 Jul 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4/Ko+ji"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E814A639;
	Tue, 23 Jul 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726453; cv=none; b=ellbX/Amimp0Bh9RiBC+aIA8JYQvhxxvjDJSyFWzRQ0/FbcndjNLUQZJM9GYEXytozRwdll+E2EKpLrW6yD9VxkEbZvYmg2jVKeVHoJiSsL2UmpaZ4iSQfyClbGQP+A8Wp5iKWZ29XX2kZxhQ6RShjxnVKTs1dXmplq747Taveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726453; c=relaxed/simple;
	bh=8yy+rbLTVl1v9LEfxIdWFqrtokzsNG6TszVLeKeZsIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF0ymJ8go0UoUp8NgOsG8XY2tzNR0by3T96aZ51mn+Bf6g7yHped77Gjxe2uTgv4G0oDowlZkzNFA2PW3MBir51WDfuwxP1NIVwg0syO5ylfkXdLXQ8/D1hkkT3LlysTsNXvRsrcFmVmFfOIa00cjxeztiojif2es/Ok4Zh9yQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4/Ko+ji; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1a6af9401so208968685a.0;
        Tue, 23 Jul 2024 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721726451; x=1722331251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yy+rbLTVl1v9LEfxIdWFqrtokzsNG6TszVLeKeZsIY=;
        b=X4/Ko+jiRpXSBVhdYAx3gl7tmu3zYEIE7LrVDUKWHbjYlQGt8c7RTE9V9naF9yguM+
         NuClXUQjSj2G/vXBSPJ8W5+DXwMhh3NKAq2u/DugT5NsL3L8E4nEUdOD6g/p41Rwd2rD
         rr3hV7fs9KXvPapE8M4UBEjrBl+wB8pdgf+S1xeQkYZW/0HO9Vq0lUNyCn/Jn/ezPUmj
         StY8WebmznejTBH5mkIBU1gmYW25/gz+8m+oMZzegskte2EHev6W8aJyQ+HtEqRjsUej
         LY6ie5zljeTAhpAkMHjYieAvaUQ1ln//V0ttEDTtyjjBsLr8UfKcmlhkbwqoOWDaZ3+v
         RuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726451; x=1722331251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yy+rbLTVl1v9LEfxIdWFqrtokzsNG6TszVLeKeZsIY=;
        b=let+bpZYg2WeSkR2arJC7mHts1k+JDz7rewOptG0DIb4OjRgXMC8S4PyGX1BMSTzEf
         mtawuoqUWA0PtQVHNKMD6EQuVzuGg4nEFRPbQTh7zm2F0Qk6fRbxI1V2vEgtMxDhpveo
         H1i+fnHRdAKapf36F7SNDk2b3ndcooKHc1ncTOhdg+LEU+TOZTiiVAsP9WFqXAuLAyA0
         B2FWGCpCF48PvWBtxUCAMzqofZlW13P24kOpJ7UPLSFnTApHQlOAH585ZF6n/SKP97SC
         lU2G4wL8cGX1vm/i4RGYKle8JXPRQyIlo/ZI6ccRRNcC2VDmxD6yLqkwbymvwWPMiyIH
         wAFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGQLTbtWJbbW8RbmDX5KGK9RfeB7uMt0m3yFXaPAUv63HUPWdQaue3cZdMKrtuShbyU/xxCn+om4bcXtIz12WJuiFUtDWgkR1mgJAVPDOqLkkg98YpK5SqeTF/tW1O+FF8yQ==
X-Gm-Message-State: AOJu0YyDca00qDHjpv8rgXgXfqBqmdROHkInDcBZwbg4nBNkuUcRzWx/
	xDLnD0HKasok1GlD6XagwnwepGcdk6ytaOgZVSVVvzGl8HfimhH1K5GhKHiyy8YW4gZvmVXSw1n
	SvstSaUxK+v/s+vIval20kEKB4jo=
X-Google-Smtp-Source: AGHT+IE73OAgH4DfytlYjeMKjbOMoaZbFZgeGl+saAzlAJ6H2jd5JojFCpwiV/nEV8aexgs+whhuuutVBJ34sBHNlb8=
X-Received: by 2002:a05:620a:29ce:b0:79f:1860:5629 with SMTP id
 af79cd13be357-7a1a13a8992mr1223374485a.55.1721726450830; Tue, 23 Jul 2024
 02:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618123422.213844892@linuxfoundation.org> <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
In-Reply-To: <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jul 2024 12:20:39 +0300
Message-ID: <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
To: Ajay Kaher <ajay.kaher@broadcom.com>, chuck.lever@oracle.com
Cc: gregkh@linuxfoundation.org, jack@suse.cz, krisman@collabora.com, 
	patches@lists.linux.dev, sashal@kernel.org, stable@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com, 
	florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 10:06=E2=80=AFAM Ajay Kaher <ajay.kaher@broadcom.co=
m> wrote:
>
> > [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> >
> > Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> > user space to request the monitoring of FAN_FS_ERROR events.
> >
> > These events are limited to filesystem marks, so check it is the
> > case in the syscall handler.
>
> Greg,
>
> Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as:
> fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
>
> With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
> timeout as no notification. To fix need to merge following two upstream
> commit to v5.10:
>
> 124e7c61deb27d758df5ec0521c36cf08d417f7a:
> 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
> https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.kahe=
r@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
>
> 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
> 0001-ext4_Send_notifications_on_error.patch
> Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-aja=
y.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53
>
> -Ajay

I agree that this is the best approach, because the test has no other
way to test
if ext4 specifically supports FAN_FS_ERROR.

Chuck,

I wonder how those patches end up in 5.15.y but not in 5.10.y?

Also, since you backported *most* of this series:
https://lore.kernel.org/all/20211025192746.66445-1-krisman@collabora.com/

I think it would be wise to also backport the sample code and documentation
patches to 5.15.y and 5.10.y.

9abeae5d4458 docs: Fix formatting of literal sections in fanotify docs
8fc70b3a142f samples: Make fs-monitor depend on libc and headers
c0baf9ac0b05 docs: Document the FAN_FS_ERROR event
5451093081db samples: Add fs error monitoring example.

Gabriel, if 9abeae5d4458 has a Fixes: tag it may have been auto seleced
for 5.15.y after c0baf9ac0b05 was picked up...

Thanks,
Amir.

