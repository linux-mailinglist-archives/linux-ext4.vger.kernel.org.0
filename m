Return-Path: <linux-ext4+bounces-829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECFF82F1FF
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 16:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7401F23FF2
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 15:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77D91C692;
	Tue, 16 Jan 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZWKnw/v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFE1C68C
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d47fae33e0so422435ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705420639; x=1706025439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4RhZpXa8cxxbTmltT2uMDAVbFEnYgLBeqxEfdznCVE=;
        b=UZWKnw/vXxHat+l12OSCVaBua2SyQ57xqGYCJMHMHIWDKQF+c7W0Y34z4gi3XZjqsx
         1KL8CPmEZd1WPVdsXqRqjkIXRbXy/2iBXDEizTgNjk+B7rpCDQWaHW4+4DTuE1yNvM8t
         Wg0N+spvT2vJlU0TsKnvBCIU37aoNW4Tr+SwbAwcHHaqvUXpOz8NoqxtQHp+EjnyeX9m
         E4HzE/h6VGYv4spbNDLQ+7p0ooiT2aUvZuHcT45/gryJ936btvdVeN683KbjbfrIn9ck
         3IDRlkW22b+W6nI1p9jB7y8pPeyUEMpEKWmd4vloaoPRriB4mQ6OEC9TQkD5tCWVnaEF
         8lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420639; x=1706025439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4RhZpXa8cxxbTmltT2uMDAVbFEnYgLBeqxEfdznCVE=;
        b=Q4TRHj2i2LNB/fPgz6bx/BtsJfu+asTALe1hMNBA4wB463doFR3xYlhsSvWrfgpH1e
         ACR+G1wB2ZHbT6LNq8P9CigC2rISwzIDC+XtXI2jo6pGJWXNXUVupJvm9V1FTkWzQOiB
         Pz3kQFaWNN1z8qpHVc3aW03+YSqKGeo3DxyjM7sYbXiGgI7k1PGzApv2KLTN/2Wq8hhl
         sXfd1oT4f6rJAuPHZFrGDQ3FEQSOEtfiN6P1Qis9ezf6q9CjeDGv8bRWpt+KMoPuz7qU
         aGScKoHDsuTVyZt0n/XvgbnaRhOwkRjjfjWz8GReS9XG2wA11WwfCVl6PBEfGHA8pEZD
         yYVQ==
X-Gm-Message-State: AOJu0YwGdqhlmzU/d+YTaPcNPu3YtRgyJ7DNja2k/J95up8O/AfW7aUG
	8D8LUrGYeNmVUaODERTXrGli1wsB7liaN009QEUZns0ZKZ3e
X-Google-Smtp-Source: AGHT+IGrbyVr57m05yfAu8DAczpHcQVB3Lxz6qUfOyq8g85sgXMAGkQW1/TuqiYzaCrBBz1c4ENLyLiHyHXiDaYhel4=
X-Received: by 2002:a17:903:248:b0:1d5:c390:af86 with SMTP id
 j8-20020a170903024800b001d5c390af86mr334255plh.25.1705420639260; Tue, 16 Jan
 2024 07:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000743ce2060060e5ce@google.com> <000000000000f447a1060f11e6ed@google.com>
In-Reply-To: <000000000000f447a1060f11e6ed@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 16:57:07 +0100
Message-ID: <CANp29Y7P2rNrriEFKZAOy=UZJ+D_khwS-rY4C9Xhy-ymeTBEBA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in find_inode_fast (2)
To: syzbot <syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 4:37=E2=80=AFPM syzbot
<syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17852f7be8=
0000
> start commit:   2a5a4326e583 Merge tag 'scsi-misc' of git://git.kernel.or=
g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd5e7bcb9a41fc=
9b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadfd362e7719c02=
b3015
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d27994680=
000
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

