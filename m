Return-Path: <linux-ext4+bounces-3374-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79E939EA2
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 12:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC82A1C21FEC
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 10:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B0914E2F9;
	Tue, 23 Jul 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA6wtirb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A3414BF98;
	Tue, 23 Jul 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721729634; cv=none; b=KJTX8vPHgPS0iOIvJ1apeSRKf07tR/1O6OH8i94mkWQ9WG8tXidSVXoiskxBoJ8flUL1Brq8XeApMw16AB7uOfRZSUM67sHW35f7azZ7w5BBW7W8BgRSn9O4xLAM3fVOL4VU0a6/P8KmI3punOquii1h04MQkMl+FrkY4lMl4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721729634; c=relaxed/simple;
	bh=KEk0smRLPVkFTP6+3W2ooQcQf5x72wZKLgttJGDtM8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9iMLysgLPDhUW5z7BJz+ThboV5esSGoNbPqNc2uEGESaHzGOENJR6x+dNm4RzPqo5WhzZ9788jphNQr7/XIBjnR3hLSYJLSHhWT4C9Yx8xme3gL3cGK/OOak9zrDooP4g0oo2n5meVMDfBE0IsgtxI36k7KTcbjQ5wcjhVTCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA6wtirb; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e087264e297so2903089276.3;
        Tue, 23 Jul 2024 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721729632; x=1722334432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEk0smRLPVkFTP6+3W2ooQcQf5x72wZKLgttJGDtM8A=;
        b=iA6wtirbceGJOiVFzws7sx2h8WojMApK1tW69zhEASWiMjZfLqhniCoAlqW1nFnQLQ
         1cn8TtQXpfB7/PNtWuwl8nC+eHFU4m0+tvsz77x/PJJ9iA+qn8a0T18EJKK99U9CHzv1
         l5szKg5Y2MvzAceq500lMdBdPsfkIgoAKNVmWW/xJ4Ao+2LydLBEMezogX365ZZfPoGF
         huMTkJZZacncsKlQL5UHcvAEuPFEKxo3CJIvCbD+9WecH/UH+/2sWP5PhCMOO4oPubbd
         ZUDW21xPYoVC2VU0yBT6yxBjlJHV/pWz/LBZyrTf55hgGqiss2no2QvxmD/9hDM9dDby
         /8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721729632; x=1722334432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEk0smRLPVkFTP6+3W2ooQcQf5x72wZKLgttJGDtM8A=;
        b=vBTjOYb6wF0Pz5aA75MuESkDrJrFTVlOCJkWzVZekiSjjYh6xVl7mydZ+aMXmM91WT
         Q8oMFxsBNr0BONR2V8YRxrAftsmWdXTkErezBj/TGl/s/TA+cNCQxxapuf3K/1/UmnB7
         Qwtrn972D87w+s/yZ0lsCXpJ93uuWAkjHxa+9FNINozdy5baqO0XuYnnpxr6ch3TavVR
         p2COZRThU/8KaUP4D9nSvKuq5Anv7ZHF0jLHfXJsHwlTRegz5CeFS+61M0pn/9n/QyM9
         fTHya2dB3O1dKSm80UPmnb2HR+z2gLajOawqWoMMXojIZmR8cRFiA9vvc1bn4vnFB92y
         EraA==
X-Forwarded-Encrypted: i=1; AJvYcCU5aJAneMKMSqfVDbupnYzEULQxLq4ZwNGglxFB74Pbw2INBeXcn1kXDY9xK5Z4V8t2NlifiWeNL1M9LNiQvH3osV+vpS+mnFUX2xp7itPCMcME5rFDJBmrSEvEgV1HzfsSyg==
X-Gm-Message-State: AOJu0YxFh7m8c0JDtuN3f8Zy+Uvlu7L9yP9zf5yaQSKk9lBlCFILHTVk
	aGRV1vNZo3uL2BHppE+GS0BonoMGvlI/y99xrE1h0b5Kat1gtS6z5xEicaEsVUHJHBsaGmJHhrT
	aQ2eLEgSFr7tsvhf2GLPCE3Ug5hU=
X-Google-Smtp-Source: AGHT+IFQ4zPPSQuppKaSAmeMi32D6OCmwZWSG4R7sgAN2pLVjB8laSzPFfYfg33GVFpZciwNSLIWa2mDTWNrfVBxi1M=
X-Received: by 2002:a05:6902:150e:b0:e08:7171:698d with SMTP id
 3f1490d57ef6-e0871716fe2mr10571110276.20.1721729632472; Tue, 23 Jul 2024
 03:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618123422.213844892@linuxfoundation.org> <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <20240723092916.gtpvnifv2rizbyii@quack3>
In-Reply-To: <20240723092916.gtpvnifv2rizbyii@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jul 2024 13:13:41 +0300
Message-ID: <CAOQ4uxjGrPbq8=znBSV8i79Kj2Or4p5O5BZ0+RL1oXbxxNu3rw@mail.gmail.com>
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
To: Jan Kara <jack@suse.cz>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, gregkh@linuxfoundation.org, 
	chuck.lever@oracle.com, krisman@collabora.com, patches@lists.linux.dev, 
	sashal@kernel.org, stable@vger.kernel.org, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, tytso@mit.edu, alexey.makhalov@broadcom.com, 
	vasavi.sirnapalli@broadcom.com, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:29=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 23-07-24 12:36:27, Ajay Kaher wrote:
> > > [ Upstream commit 9709bd548f11a092d124698118013f66e1740f9b ]
> > >
> > > Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> > > user space to request the monitoring of FAN_FS_ERROR events.
> > >
> > > These events are limited to filesystem marks, so check it is the
> > > case in the syscall handler.
> >
> > Greg,
> >
> > Without 9709bd548f11 in v5.10.y skips LTP fanotify22 test case, as:
> > fanotify22.c:312: TCONF: FAN_FS_ERROR not supported in kernel
> >
> > With 9709bd548f11 in v5.10.220, LTP fanotify22 is failing because of
> > timeout as no notification. To fix need to merge following two upstream
> > commit to v5.10:
> >
> > 124e7c61deb27d758df5ec0521c36cf08d417f7a:
> > 0001-ext4_fix_error_code_saved_on_super_block_during_file_system.patch
> > https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-ajay.ka=
her@broadcom.com/T/#mf76930487697d8c1383ed5d21678fe504e8e2305
> >
> > 9a089b21f79b47eed240d4da7ea0d049de7c9b4d:
> > 0001-ext4_Send_notifications_on_error.patch
> > Link: https://lore.kernel.org/stable/1721717240-8786-1-git-send-email-a=
jay.kaher@broadcom.com/T/#md1be98e0ecafe4f92d7b61c048e15bcf286cbd53
>
> I know Chuck has been backporting the huge pile of fsnotify changes for
> stable and he was running LTP so I'm a bit curious if he saw the fanotify=
22
> failure as well. The reason for the test failure seems to be that the
> combination of features now present in stable has never been upstream whi=
ch
> confuses the test. As such I'm not sure if backporting more features to
> stable is warranted just to fix a broken LTP test... But given the huge
> pile Chuck has backported already I'm not strongly opposed to backporting=
 a
> few more, there's just a question where does this stop :)

I'm not sure is it exactly "more features".
The fanotify patches and ext4 patches that use them where merges as
a feature together.

IOW, FAN_FS_ERROR was merged with support for a single fs (ext4)
it would be weird to backport the feature with support for zero fs.
Also, 5.15.y already has the ext4 patches - not sure why 5.10.y didn't get =
them.

Thanks,
Amir.

