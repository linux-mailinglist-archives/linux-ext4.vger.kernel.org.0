Return-Path: <linux-ext4+bounces-4188-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29597A31F
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8781C21ABF
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C6156C5F;
	Mon, 16 Sep 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdmvRJLs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759C15624D
	for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494920; cv=none; b=X0p154AnQDeEzByAkdpwWKHboF0iM8IRr1LUOWq13oRbgIuKu9oRmAY98UVNYV0G/ezhJGKy0Py0RFofkh8rqimNYjIKce02CUZQz5RsfNeG4G6VFUevvXSXREX/C/TMvBA44Sqoh8+FVb4agnbhdKL5BEw4R7YpBZ3sgobQMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494920; c=relaxed/simple;
	bh=TQ9Z28VrXmhpoS/+5Enj8vZt41wK2AKLp3BMB68Uvjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTXtYL3fL5jbBLFZupF6pUB6gMVeJGrykw+8+LkqjYzx+IGXs50ougsor1HunlyUiLEmVA2rRUDyXZgbNNM2YcdyKd2EKZ/TWpaYTLwTw69nhkx8ZbbUhLcZqjK/26yYFVbjwn40I4phQFFXjTXPd7BcSxkXN+TQBYem0vtzDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdmvRJLs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f762de00fbso47658941fa.2
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2024 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726494917; x=1727099717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TnAR93o+K7zzH5nWKB/vrO+A6k82QdGsUv8h9VnrLk4=;
        b=jdmvRJLsJCJxVVKdgHF0DVDTx3zZE3kBbYdqDEZeTOdl4x+eK1MhPeTt3sGXGtxCLM
         jv9KHMZIiqD/9JCrUjruclHxsBQnjS2W66LerIe22dFe2qYQcQZe3zBYxWQeDjmaLuQM
         /7n7OsbySDH3MOjc3W0WzNJOBPeK/n74HhFnyyo0tIEYuUMtN1k9i/DTWIuZhAtasCe9
         KGr+41/+lVWziTSd/9QumbVt0c9UAH3/Sbzw92d179XG6jHONH9RUdvWWXGRAPH4E0Bz
         AmMv/1+z/HQ/dJLk0yZhFRv9SL+nvz09uUOxukbfGq1L8CaLZBhwQcJ/zh1wOLmeYtfa
         0jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726494917; x=1727099717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnAR93o+K7zzH5nWKB/vrO+A6k82QdGsUv8h9VnrLk4=;
        b=LlThi7tU9pvkp2prO7fHf8XDGdDMLEFHqG6YZGvce2TkS2Rdu8aS3kKUTxJ4sL16EW
         jztvWT9XumQYtXTNqYLZyoHUEgn0UGIyTWlx0dTMlYka06ZbG04OoNsiVzPTnkKCJLrB
         fbQFWvqgJzo0H/8y/CUnmz0DhNCZoi+M/l2Uf8jOjO8wk2VNXUuq0EIfOQgoCiWnbNQA
         kP1aJ1LxqKiW4K5y4WEx/che4TSVV40qR7/ptxKGpL0hw+Qk5ryC6RNU6g/NEOhe3q6V
         GfGHshSG2/aNbguVDK8NOS3OZjm6dYvqI8OA+v1EKWyAZFRXZyqbfeYmTGnNhmyWE06+
         yhSA==
X-Forwarded-Encrypted: i=1; AJvYcCV/3/eyCHnPi2UZSmu5ql3yxtVOlpaPWoUESVS1wf5T33UQQFw1veZI9hdyPgivN05wyJ2namlW+tJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjSraTaAu2r5B7GucNYexbw6vNu8fBLij+QdfB+2m78p4uIJv
	ekT21nsKkIV9GVbVWHgd3sUoH+W7axpLgRXsKyWHSnMGrhRf8MCGJgn2K6XXJDn34QZl946dPtJ
	4BZ9i7z8h6kjyjlLEixnLMc0Fwr85LS+dxD1M
X-Google-Smtp-Source: AGHT+IESKzBfl8rPNdiysY8g7h5xJa5N0rTSdQ0+gs1+b7V0l+3gMcjbyAmed0AAQW8lIUuMnSOAF7oIevPTu4bOqwI=
X-Received: by 2002:a05:651c:b22:b0:2f7:65b0:ff28 with SMTP id
 38308e7fff4ca-2f787f5098dmr80304861fa.39.1726494916930; Mon, 16 Sep 2024
 06:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000039fb2d05f3c7d0ed@google.com> <8e13233a-2eb6-6d92-e94f-b94db8b518ed@acm.org>
 <CACT4Y+ZvEjpX8a9VW4tS1YSP8RE6xjb8C9ae6PcSa0rr-q+62g@mail.gmail.com> <da2d3fb8-b4b0-457a-80fa-a3eae5c8e1fc@acm.org>
In-Reply-To: <da2d3fb8-b4b0-457a-80fa-a3eae5c8e1fc@acm.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 16 Sep 2024 15:55:05 +0200
Message-ID: <CACT4Y+bmJAKw8J=oJgp5gh_-Tz1e-VkgtvKF4QFGcD-Ovffm8Q@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_evict_ea_inode
To: Bart Van Assche <bvanassche@acm.org>
Cc: syzbot <syzbot+38e6635a03c83c76297a@syzkaller.appspotmail.com>, 
	adilger.kernel@dilger.ca, alim.akhtar@samsung.com, avri.altman@wdc.com, 
	beanhuo@micron.com, hdanton@sina.com, jejb@linux.ibm.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	wsa+renesas@sang-engineering.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 15:41, 'Bart Van Assche' via syzkaller
<syzkaller@googlegroups.com> wrote:
>
> On 9/16/24 6:28 AM, Dmitry Vyukov wrote:
> > On Fri, 3 Feb 2023 at 19:11, Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> On 2/3/23 00:53, syzbot wrote:
> >>> syzbot has bisected this issue to:
> >>>
> >>> commit 82ede9c19839079e7953a47895729852a440080c
> >>> Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>> Date:   Tue Jun 21 14:46:53 2022 +0000
> >>>
> >>>       scsi: ufs: core: Fix typos in error messages
> >>
> >> To the syzbot maintainers: I think this is a good example of a bisection
> >> result that is wrong. It is unlikely that fixing typos in kernel
> >> messages would affect whether or not the kernel hangs. Additionally, as
> >> far as I know, the systems used by syzbot (Google Compute Engine virtual
> >> machines) do trigger any code in the UFS driver.
> >
> > Hi Bart,
> >
> > syzbot has logic to detect commits that don't affect builds.
> > It hashes SHF_ALLOC vmlinux sections to check if the commit actually
> > has any effect on the binary:
> > https://github.com/google/syzkaller/blob/c673ca06b23cea94091ab496ef62c3513e434585/pkg/build/linux.go#L253-L286
> >
> > Bug CONFIG_UFS_FS is enabled on syzbot, it has some coverage for it,
> > and strings affect the binary (can actually be the root cause for
> > bugs). So I don't see what else can be done here automatically.
>
> CONFIG_UFS_FS controls whether or not the UFS filesystem is enabled
> (fs/ufs/). The UFS driver is unrelated to the UFS filesystem and is
> controlled by CONFIG_SCSI_UFSHCD. Support for the UFS driver has been
> added recently in Qemu. Does that mean that it should be possible to
> test the UFS driver with syzbot? See also
> https://patchew.org/QEMU/20230616065816epcms2p82787f1aeb410ec4b8ab6ffedb6edf4d2@epcms2p8/

Oh, I see. Added this example to the issue:
https://github.com/google/syzkaller/issues/2297#issuecomment-2352986387

I've tried to follow all guidelines from reproducible builds:
https://docs.kernel.org/kbuild/reproducible-builds.html

https://github.com/google/syzkaller/blob/c673ca06b23cea94091ab496ef62c3513e434585/pkg/build/linux.go#L165-L176
https://github.com/google/syzkaller/blob/c673ca06b23cea94091ab496ef62c3513e434585/pkg/build/linux.go#L85-L102

Yet this commit still somehow affected the build:
culprit signature:
c1512384fd0e6d2bd48b3a1ce2034eb5c0de195562eca27cd2c0c6ac58cd4863
parent  signature:
1f86ef314029ed6e1f240aae874259f4bb0f7978f8b38b29d6c184b82965b331

I've debugged and fixed some of these non-determinism bugs, but it
seems something is still broken (not sure if it's the compiler, or
kbuild, or how we do deterministic build).

