Return-Path: <linux-ext4+bounces-11420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E965C2D744
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8253E4EE4A3
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FD31AF3C;
	Mon,  3 Nov 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNEgOYxM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04C26F293
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190441; cv=none; b=UqLesKWRlR4Y3/RQOUHMAGAX7UisVw+BWmnO36ob0PxDxfLTcLW36ZiLtLbLhHf7aSoNt9dOEN+4aWw12O4fU0vAai2OoNrzMnnu9nm92y0pklHPjrz74IMH6kh8YH0GqJegalhW64P3nVmNK364OrRXYwB2OaKVsE1hGJdemXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190441; c=relaxed/simple;
	bh=qx1IrR7YaPSQc3QASmv2Wmj5LENFPTuLb4StCUOUioA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0c49U11FUiK3iS7UgPotLK0vl5Tt8oTQZuX0wuRnx0pDj41giZwExgoB8DEgzs213EH22cjL060ticepFNH+aeAFrNZlVtOdz5KivmE/zPp/CRNEgbw9Q5NcM0JQM2TL5mBUapSfFh1s9ELJKcKb/A7NqTTE0zjBsejh4YEET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNEgOYxM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eba67d4b1bso47772281cf.1
        for <linux-ext4@vger.kernel.org>; Mon, 03 Nov 2025 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190438; x=1762795238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyIz3/BkJyRtRJY6wtkuwzOA6rYMVQpaNWa2nRa8kCU=;
        b=LNEgOYxMJiO/A9f0ghl7oGHkKhboKoPcq5VnSqqBEo9Upo5KhRfD7zMm/QdENygtXb
         Yqeix3ETsWKwbKupuZIoz4mORKjImIIW5sHcqk/3VdBqd6/IdbaaaKi0Ix79MEjLBFX5
         WOiIxIg4QlcRutsEwOMEwO9dNVo8hlKIgp5DF6z0SdT3hdZ9HDMAorxfo6EdN5S66J28
         bwTdbOrOADQJDI2Xh4hRRw+dUoaYPRWi5lG/NGVmqVla/B1vaNyhW1eF4LCo7Fq8b3ZT
         9JdUgGbR7ozxLko1wLCbbQlCkZCgouEyUwskWRajoI/bOaLQk4AueNig/r1REDnjpC+D
         J0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190438; x=1762795238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyIz3/BkJyRtRJY6wtkuwzOA6rYMVQpaNWa2nRa8kCU=;
        b=BrMEZglBSJk1TTz11hVVpMUh6rJZuURMgy29+KM0fMHsWCm0tdcwbc+JgWpsaoW5EZ
         FYpwNZ0ouFhX4mxrdyzfEP76EeVay+D2MxIAH13HkC5KPTMY31eCf7eEy/GAOhurBJcu
         e5AHDMOiLuZ6Wsenm7OKLm4eWubcnCPlczHwsV4h+EgD6KE4xZTrNAxh3osPS26q9j05
         Ui06DnoOYxSnsLaftKqOv0sUoxiq933Zgr4XwN8SczeWASiJ6bR7Cu//xtmZp4i1T5x+
         /17AEYo05/oI3F+TtWCn5QX9Oop4GvU9y8/kkfdfvp//SBtyvHv1Xhj5RtnYc4y3bXca
         WTKA==
X-Forwarded-Encrypted: i=1; AJvYcCUuv+cKSze/kdOFnJHYBErbg8G/I5wgZnw3EEyQUtdDw2DPDTHcSvm3n00F8FzEoHKU7VsnezPLV4y8@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFbmEJ9EMDo3j5A9C1llvqVlVDeXBi/UPla/qSNBCFFb4Ne+Q
	WEwR6MbVBhmnbI8Yq2CylK4ThhxcJY51PoAq1LPz/XWxfUX1VR+2QgWvSXmDs2UhCRvbiLueA3d
	99ks/wa5QhW3dHDb6AOTeXTGaMQJvx9Di8A==
X-Gm-Gg: ASbGnctn45zBK32jfQYsM5eea2TQgcjC2g+bW7E8u6/fRZuWGSrwvf5ekWm3gLAqZO6
	HqwCIqY2I/w6XiIqrW8KZhm3DLeT6DwrM9Vi7x7ag3YBHbdZ7FfrueUN9SGbrNxtGWdzbZMa23f
	vpkxr0yHqeLZWmVzfEcrS3bu9WNETIoXnnRmDxL5YOGsZBZt+ucaPb/i2KMofyvclJ39DaBl9UW
	V2BJiZIk8zQfbPe1mkwDQKX+m/VmMlO+H++R9EmIPPfT3ZFyZBvm0sU7KD9YeEaIYP+LalrlTE4
	xyYunS/qYpumSPvsYqtQzG70rvx8WCWc
X-Google-Smtp-Source: AGHT+IHLQ0bXfp4gZvWiK7TAFswc3LueEvPqojqdTFSSKfDL+ukjZorwZdmTpBq0M2uT1HInQJ/7B8R8DJo9Ip1qm7E=
X-Received: by 2002:a05:622a:1146:b0:4ec:f9a1:17bc with SMTP id
 d75a77b69052e-4ed30d5e0d6mr184905631cf.5.1762190437695; Mon, 03 Nov 2025
 09:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Nov 2025 09:20:26 -0800
X-Gm-Features: AWmQ_blB9dk_y5n-nuZ5dmfPMTs9HUjqvHt_tGIXFsDsz2_PIhaA9xmedebxQYU
Message-ID: <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> generic/488 fails with fuse2fs in the following fashion:
>
> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is in=
consistent
> (see /var/tmp/fstests/generic/488.full for details)
>
> This test opens a large number of files, unlinks them (which really just
> renames them to fuse hidden files), closes the program, unmounts the
> filesystem, and runs fsck to check that there aren't any inconsistencies
> in the filesystem.
>
> Unfortunately, the 488.full file shows that there are a lot of hidden
> files left over in the filesystem, with incorrect link counts.  Tracing
> fuse_request_* shows that there are a large number of FUSE_RELEASE
> commands that are queued up on behalf of the unlinked files at the time
> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> aborted, the fuse server would have responded to the RELEASE commands by
> removing the hidden files; instead they stick around.
>
> For upper-level fuse servers that don't use fuseblk mode this isn't a
> problem because libfuse responds to the connection going down by pruning
> its inode cache and calling the fuse server's ->release for any open
> files before calling the server's ->destroy function.
>
> For fuseblk servers this is a problem, however, because the kernel sends
> FUSE_DESTROY to the fuse server, and the fuse server has to close the
> block device before returning.  This means that the kernel must flush
> all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.
>
> Create a function to push all the background requests to the queue and
> then wait for the number of pending events to hit zero, and call this
> before sending FUSE_DESTROY.  That way, all the pending events are
> processed by the fuse server and we don't end up with a corrupt
> filesystem.
>
> Note that we use a wait_event_timeout() loop to cause the process to
> schedule at least once per second to avoid a "task blocked" warning:
>
> INFO: task umount:1279 blocked for more than 20 seconds.
>       Not tainted 6.17.0-rc7-xfsx #rc7
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
> task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690
>
> Earlier in the threads about this patch there was a (self-inflicted)
> dispute as to whether it was necessary to call touch_softlockup_watchdog
> in the loop body.  Because the process goes to sleep, it's not necessary
> to touch the softlockup watchdog because we're not preventing another
> process from being scheduled on a CPU.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    5 +++++
>  fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
>  fs/fuse/inode.c  |   11 ++++++++++-
>  3 files changed, 50 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c2f2a48156d6c5..aaa8574fd72775 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>
> +/**
> + * Flush all pending requests and wait for them.
> + */
> +void fuse_flush_requests_and_wait(struct fuse_conn *fc);
> +
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 132f38619d7072..ecc0a5304c59d1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/splice.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> +#include <linux/nmi.h>
>
>  #include "fuse_trace.h"
>
> @@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
>         }
>  }
>
> +/*
> + * Flush all pending requests and wait for them.  Only call this functio=
n when
> + * it is no longer possible for other threads to add requests.
> + */
> +void fuse_flush_requests_and_wait(struct fuse_conn *fc)
> +{
> +       spin_lock(&fc->lock);

Do we need to grab the fc lock? fc->connected is protected under the
bg_lock, afaict from fuse_abort_conn().

> +       if (!fc->connected) {
> +               spin_unlock(&fc->lock);
> +               return;
> +       }
> +
> +       /* Push all the background requests to the queue. */
> +       spin_lock(&fc->bg_lock);
> +       fc->blocked =3D 0;
> +       fc->max_background =3D UINT_MAX;
> +       flush_bg_queue(fc);
> +       spin_unlock(&fc->bg_lock);
> +       spin_unlock(&fc->lock);
> +
> +       /*
> +        * Wait for all pending fuse requests to complete or abort.  The =
fuse
> +        * server could take a significant amount of time to complete a
> +        * request, so run this in a loop with a short timeout so that we=
 don't
> +        * trip the soft lockup detector.
> +        */
> +       smp_mb();
> +       while (wait_event_timeout(fc->blocked_waitq,
> +                       !fc->connected || atomic_read(&fc->num_waiting) =
=3D=3D 0,
> +                       HZ) =3D=3D 0) {
> +               /* empty */
> +       }

I'm wondering if it's necessary to wait here for all the pending
requests to complete or abort? We are already guaranteeing that the
background requests get sent before we issue the FUSE_DESTROY, so it
seems to me like this is already enough and we could skip the wait
because the server should make sure it completes the prior requests
it's received before it executes the destruction logic.

Thanks,
Joanne

> +}
> +
>  /*
>   * Abort all requests.
>   *
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index d1babf56f25470..d048d634ef46f5 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -2094,8 +2094,17 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>  {
>         struct fuse_conn *fc =3D fm->fc;
>
> -       if (fc->destroy)
> +       if (fc->destroy) {
> +               /*
> +                * Flush all pending requests (most of which will be
> +                * FUSE_RELEASE) before sending FUSE_DESTROY, because the=
 fuse
> +                * server must close the filesystem before replying to th=
e
> +                * destroy message, because unmount is about to release i=
ts
> +                * O_EXCL hold on the block device.
> +                */
> +               fuse_flush_requests_and_wait(fc);
>                 fuse_send_destroy(fm);
> +       }
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
>

