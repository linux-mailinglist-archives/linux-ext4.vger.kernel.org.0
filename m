Return-Path: <linux-ext4+bounces-2044-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AB8A2035
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 22:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8B728E19D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 20:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F3182DF;
	Thu, 11 Apr 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A0OLAO0v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD361CAA3
	for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867249; cv=none; b=c/0II7FiWFm5moMUvrB44jKhdnfL/e8dcYW7cS5famwMfycRDvqHtn8kAeN4NYiReTB0EmJID24T2jA0hmWmJEa/LGvf1VYYwoWXGR9dnFfKVws9sVVMJXDVhK8/C1J1ShJlpwSygHQ02Hkr127k803Z6xmi7lqoBsH8+8tA9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867249; c=relaxed/simple;
	bh=l6Zg8E5l9E7YNNsH7iIZ4LMXwRy2isDpxVf8d7paD+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAbKdzBt26Zmdt/7EzWcAVEp/0qnMyLAdTUf/7b76RiPL48yO3MrZmeqj0V5wmuQ2pnLSY1piRk/Wj5SFTIWxYqqMxPt8zhK/UDi5811mf7X+r7hKARPmWFkGurwxwkyA0a7GYpP+xqtexj5th4h4IsPHC/rNHPQZo+wacTjon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A0OLAO0v; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d743f3654so15915585a.0
        for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712867246; x=1713472046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnP8JVadrwUCkWdsPrjw1n1Qkf19BHzW9gV2hIgU+kk=;
        b=A0OLAO0vUbboK5mhCquWaRInaJmJqcCCEQhl13HPTOeNWyDWDVUuPWrkWpuFlv/alB
         H9POk+4jcQBO/p+WZIN+3qifxrLSClSoQ9jAPMmqqAzyHRsqMeHknP3CYrz9Falh9jRk
         HY+TeJ6tUHbwEoe5RBnK6pqIpR6A3hb1+EMEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867246; x=1713472046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnP8JVadrwUCkWdsPrjw1n1Qkf19BHzW9gV2hIgU+kk=;
        b=A2913faVD3YeWu0OqVQM2iyth/92/2vtbyvl9mOa6n/VNkauZshA0+mqNECAk/DY4z
         xdbXQnrZZh28klynQf4FMABd8vSh/hd7tBdo0rywvolW734XqOwHq2J4h08P3egqdT5x
         HPOWPns9VMjfCET8Xwi5tk3NwXHO7bqsccAC1+mKeaACLnTZyjmwVc9Hq+T3MF2gdd2d
         88iytvgyO3JHZHacCJchI74sGGEn3ztorTyGMOYPHkB3wZhcz9llEMvqDrBWdrBzOQZy
         W76/frnZ8fZdvGpYNQ3htiC7uMOYGSMqTHcsxGnhADTaXuSRytcOBmj14/BD9Pkb0Qer
         2UGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLkMwGQr6dG8B4rNw/YdoyVsB+t3prdh7YqMdDpy4JHySTAjfv6SB/ONRD/ZKR0AOz2BLnnIppMTJakehjF1Xm1Mun/1XtZ2g5/g==
X-Gm-Message-State: AOJu0YwnZUPo2mXzxgEYtyF50FPu9MYj3KIu+l410ftEOykjZm+SUugN
	5InR7M4+MTbXXvIjZVfFNdN5famJGCPEc0+k2+kjvASJHo+jJRjlTkkRlUdU/JC00NQSL3Ie/ME
	=
X-Google-Smtp-Source: AGHT+IE8hZuMa2xJMUuGjAyRaenBU4ByvHh+dxs+hj19DEXqHeMGUp/CWrNEKU8k4xDXd+Ze74AEhQ==
X-Received: by 2002:a05:620a:5a73:b0:78d:696d:6b9b with SMTP id wx51-20020a05620a5a7300b0078d696d6b9bmr724014qkn.29.1712867246441;
        Thu, 11 Apr 2024 13:27:26 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d15-20020a05620a158f00b0078d54363075sm1460949qkk.40.2024.04.11.13.27.25
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:27:25 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43477091797so12201cf.1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Apr 2024 13:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8O/hU10EwkoQM1QQxhv+O6dmAmkWGAvjnecRg6PraKITDAqlUcbIUHEWzAnxaogY/aN4H68Mrl5cvgzyg5LYGTEBlIKGoiX3/jQ==
X-Received: by 2002:a05:622a:5a13:b0:436:5ce5:cfc5 with SMTP id
 fy19-20020a05622a5a1300b004365ce5cfc5mr71333qtb.2.1712867245457; Thu, 11 Apr
 2024 13:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000042c9190615cdb315@google.com> <20240411121319.adhz4ylacbv6ocuu@quack3>
 <CAOQ4uxi9L_Rs7q=fcLGqJMx15jLAArOWGwGfdCL8LOUCPR3L+w@mail.gmail.com> <875xwn8zxa.fsf@mailhost.krisman.be>
In-Reply-To: <875xwn8zxa.fsf@mailhost.krisman.be>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Thu, 11 Apr 2024 13:27:12 -0700
X-Gmail-Original-Message-ID: <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
Message-ID: <CACGdZYLJESbS6VCAza_V6PAeNb8k9nU2wYhBi-KmeYqYJ337mA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 12:25=E2=80=AFPM Gabriel Krisman Bertazi
<krisman@suse.de> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Apr 11, 2024 at 3:13=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >>
> >> On Thu 11-04-24 01:11:20, syzbot wrote:
> >> > Hello,
> >> >
> >> > syzbot found the following issue on:
> >> >
> >> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240=
410
> >> > git tree:       linux-next
> >> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12be955d=
180000
> >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D16ca158e=
f7e08662
> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e3f9b2a67=
b45f16d4e6
> >> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils fo=
r Debian) 2.40
> >> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13c911=
75180000
> >> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d=
180000
> >> >
> >> > Downloadable assets:
> >> > disk image: https://storage.googleapis.com/syzbot-assets/b050f81f73e=
d/disk-6ebf211b.raw.xz
> >> > vmlinux: https://storage.googleapis.com/syzbot-assets/412c9b9a536e/v=
mlinux-6ebf211b.xz
> >> > kernel image: https://storage.googleapis.com/syzbot-assets/016527216=
c47/bzImage-6ebf211b.xz
> >> > mounted in repro: https://storage.googleapis.com/syzbot-assets/75ad0=
50c9945/mount_0.gz
> >> >
> >> > IMPORTANT: if you fix the issue, please add the following tag to the=
 commit:
> >> > Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> >> >
> >> > Quota error (device loop0): do_check_range: Getting block 0 out of r=
ange 1-5
> >> > EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/=
u8:4: Failed to release dquot type 1
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > BUG: KASAN: slab-use-after-free in fsnotify+0x2a4/0x1f70 fs/notify/f=
snotify.c:539
> >> > Read of size 8 at addr ffff88802f1dce80 by task kworker/u8:4/62
> >> >
> >> > CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-2024041=
0-syzkaller #0
> >> > Hardware name: Google Google Compute Engine/Google Compute Engine, B=
IOS Google 03/27/2024
> >> > Workqueue: events_unbound quota_release_workfn
> >> > Call Trace:
> >> >  <TASK>
> >> >  __dump_stack lib/dump_stack.c:88 [inline]
> >> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> >> >  print_address_description mm/kasan/report.c:377 [inline]
> >> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >> >  fsnotify+0x2a4/0x1f70 fs/notify/fsnotify.c:539
> >> >  fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
> >> >  __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
> >> >  ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
> >> >  quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
> >> >  process_one_work kernel/workqueue.c:3218 [inline]
> >> >  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
> >> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
> >> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >> >  </TASK>
> >>
> >> Amir, I believe this happens on umount when the filesystem calls
> >> fsnotify_sb_error() after calling fsnotify_sb_delete().
Hmm, so we're releasing dquots after already shutting down the
filesystem? Is that expected? This "Failed to release dquot type"
error message only appears if we have an open handle from
ext4_journal_start (although this filesystem was mounted without a
journal, so we hit ext4_get_nojournal()...)
> In theory these two
> >> calls can even run in parallel and fsnotify() can be holding
> >> fsnotify_sb_info pointer while fsnotify_sb_delete() is freeing it so w=
e
> >> need to figure out some proper synchronization for that...
> >
> > Is it really needed to handle any for non SB_ACTIVE sb?
>
> I think it should be fine to exclude volumes being teared down.  Cc'ing
> Khazhy, who sponsored this work at the time and owned the use-case.
In terms of real-world use case... not sure there is one - you'll
notice the errors when you fsck/mount again later on, and any users
who care about notifs should be gone by the time we're unmounting. But
it seems weird to me that we can get write errors shutting everything
down.
>
> --
> Gabriel Krisman Bertazi

