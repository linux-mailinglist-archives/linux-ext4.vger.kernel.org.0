Return-Path: <linux-ext4+bounces-13993-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDLDLA/9nWmeSwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13993-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 20:33:35 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3B718C1D7
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 20:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7D5430475A4
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D82D372D;
	Tue, 24 Feb 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFQ6BWez"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C223B61E
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961606; cv=pass; b=jqGrGvBzHgc2E3RcDzBP+TlYWw1eyP9I2QTx0MM6OTWS6M3AtyXz0ZzJf64aQLmqCCmIaU0Fp25PTnLctk4u7suZcTGlvMXHdkVO8KE8bcgfipMqZ84JhCIKM31kq9irZBU4T0C1v84dEW9MoUZXa87zrAu+qlPWkQP2pLx5JfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961606; c=relaxed/simple;
	bh=Qi3E8lxAiasJoxhjDairTt0suuDxo1NvocxikjcwkxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=obXrVcR8JD1XJIMH7e+xiII/xZrNtCldboTPd5JU4/bIR94L+bhbZvEf2DK5+pNCHEepark3xgRlQzosukb3jf9YEndqz1GL9uXEYyyha+/Cio9z1fVIXQprulw55Hk0tUH/Je7/Y2Z5DiqJ7+Vg2VCBbI3e9fYeQ5ZwclULzOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFQ6BWez; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a321cc53so67643281cf.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 11:33:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961604; cv=none;
        d=google.com; s=arc-20240605;
        b=VplCuIkeFYGildLJKk0RLQiyF5hgRQI+xQe1acSXhGPh2yFFWLFHUlT4eApy41o4Pz
         nAyKGkRpMZChnaL4pIyQYFuqGl5zgRzBzaO7sUCK9d8zmlLVmBMV3SThdctQozS4zY1R
         Qyb2dczNCDzPiLEXNbNbBwiJf1mQPt80BqXZZ9IhcA8T40OX4uV6Pze5yNt3T6NB8NsB
         YHFodnT8SZc+mrnkM+qINPFglYLGQNvSQF6QOKTMqhDmGprh6WWKyst37rY5nctjqAVU
         hFfxrQ+gIwirgP0CWxLnRUGWjCPPv7GmU6B4LubLBoZZCvPJIPnxs4UJSsc06OnkBBIj
         isfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        fh=EY5emnqznGwivFykoUZYCfT+4ibO1psKGE0TfW+UqVU=;
        b=BB9XwiN4dMQ8aR+p3BlAA+6AYZBNbyB3CeEdePmkopuG2MiIP/0AN02koGyB7i9HYv
         7A9vVxr+FZ+lH9ZEcZUmYWL1sOprTKF/RiYcYht6csE/h8uqM44osDpa/P1UkDKIAG0U
         LUyCqFcORfWwYVzDjBuK8wetCcZaLxq1ljNhapNX3RmcdlAsj9tjfosiN1AUfPupKj6i
         KaaiaDCFaBvEQ9WY0uF7R5EFBBpgcDrfB6CpBt+p7KszF4+2NWiuKUNO1JbbaFVxnXaZ
         Uj/sOqAcklV73TnXHWhaeVBft78zBL/JZx39hInQZhV8WdTtJSj142thKrEfIBqDeUtf
         CpFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961604; x=1772566404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        b=JFQ6BWeziykqAsXWvcGXh2Ym5Zg74nB2GmuM+cvwITUZkMXD4nGijTLw3eQ+WNFW2H
         EnVVTMYuUnR9wJj3cCFOP8wRpm/Mt7pjiWYm4Wfvye1pxzmStIE3of+HnyxOfFQNfj6C
         BgWmTDzwmagG+PzcLRHp31r+Sstu1goidE1TAOmt9FIpwC5jeyoYnkmoolbvNJl4/IsW
         EOsnp+9qNBc+iyE5g8ZEnw7Y/E3O8G5UNwAGAaoruskTJefHJ2VWkg6Ap3PZzAZfkPQW
         KQBADLt4JPid+79bWQXsP7ma1qs3040ZRqFc/yxetxIfbpFLw6OlKuwIlU6QZlId9vNB
         YDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961604; x=1772566404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpmiCKHcBcH02P89/1LkI481lYphcfAkiuIQq/g8bh0=;
        b=q0XlvlSgAwQCzN6A2chIihAphY8XjWduHBhP0sys5QBeHwhIrz2UgEnC+Fg/kvQYhq
         Bc3rj6TR+7tW81ob5WBj1qEZSDpSM02tbfDT7etZAJwV3Da5/tBo9PAZQCPAP/PKnlRi
         A4C3N8X9BWl/BmpZVjgCjN94bCD7ERusup5hGyFRwW1/MC+KlEGLVLKuOdD+pxv2LlFD
         iWYbuKHyq156wmrB+lfkvKMZlbTRXpfMAPb/f7uC25tQrOIX6Qdca9jLR8oWWuFJF5UM
         RDZDvPXLvTaxyIB0rS+GgtNBX11JtOcu4YuJ9QxNgrOrswIR4QuHRYE740GB4UCsOnqn
         vxfw==
X-Forwarded-Encrypted: i=1; AJvYcCWh966oeAeLsNM9Ss1dCF4ZTJMXWVmjoJPONpy6/usdaG3H+O/rtJK+cSzKmMB+32lFOL4yQmhSLGrA@vger.kernel.org
X-Gm-Message-State: AOJu0YzgyqCAnPed3JgK92Jn1VzSCkZIT/Bt9SBT6RPhDqhCAu5+YjmU
	DdryE0crFUDKxERfp3hT9wg7/FyLLZq5vNlFypPFfx4CygJ11tFNasYsYXnBt4v8JiYb5rTG2aj
	uo5E43GGg2vRCJ5gdoRJFdn9XNmPg83MSN5Iy
X-Gm-Gg: AZuq6aKvdoYCPU7lJJiZpC7j04KDmTH34kl40e3p8UEiksVF3beY6mTZDlpxOeTCwp5
	MqE1Pyep7SthuveEtL9sv0NwnZymIHIiellHwziI+MbBISKD0Y+0vDLewDPbAItDpl+QHznCwHD
	JphL5Usl18smsz3IqAxfeLjsr4JfP5cmeqE1PUOHgWn0NiV+j8NawmCExGEgjgLgTlHeOkGbLJT
	hIZ4RAIrKdCZOZkpdfr+bLWRTtRnoYjEd+dvhpR6w2e1F2OlVSV8Ycf6DeMC3mTEfow27yYrEpe
	6u+9czrsGwJyzRqa
X-Received: by 2002:a05:622a:164d:b0:4ee:2721:9ebd with SMTP id
 d75a77b69052e-5070bc737a6mr173920921cf.45.1771961603601; Tue, 24 Feb 2026
 11:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733133.3935219.4620873208351971726.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 11:33:12 -0800
X-Gm-Features: AaiRm50-VsLD_zmLLD3udHzp2NCTKRbMnT9y8JS0gqm_pLEzk3Fb9cwmor2ZxsM
Message-ID: <CAJnrk1ZZ=1jF4DUF-NyedLP-BJM_5d3s0zfD4oHGyR51PM9E7Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending FUSE_RELEASE requests before
 sending FUSE_DESTROY
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bpf@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13993-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD3B718C1D7
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
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
> FUSE_DESTROY to the fuse server, and the fuse server has to write all of
> its pending changes to the block device before replying to the DESTROY
> request because the kernel releases its O_EXCL hold on the block device.
> This means that the kernel must flush all pending FUSE_RELEASE requests
> before issuing FUSE_DESTROY.
>
> For fuse-iomap servers this will also be a problem because iomap servers
> are expected to release all exclusively-held resources before unmount
> returns from the kernel.
>
> Create a function to push all the background requests to the queue
> before sending FUSE_DESTROY.  That way, all the pending file release
> events are processed by the fuse server before it tears itself down, and
> we don't end up with a corrupt filesystem.
>
> Note that multithreaded fuse servers will need to track the number of
> open files and defer a FUSE_DESTROY request until that number reaches
> zero.  An earlier version of this patch made the kernel wait for the
> RELEASE acknowledgements before sending DESTROY, but the kernel people
> weren't comfortable with adding blocking waits to unmount.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Overall LGTM, left a few comments below

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/fuse_i.h |    5 +++++
>  fs/fuse/dev.c    |   19 +++++++++++++++++++
>  fs/fuse/inode.c  |   12 +++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d15e..1d4beca5c7018d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1287,6 +1287,11 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>
> +/**
> + * Flush all pending requests but do not wait for them.
> + */

nit: /*  */ comment style

> +void fuse_flush_requests(struct fuse_conn *fc);
> +
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170d4..ac9d7a7b3f5e68 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -24,6 +24,7 @@
>  #include <linux/splice.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> +#include <linux/nmi.h>

I don't think you meant to add this?

>
>  #include "fuse_trace.h"
>
> @@ -2430,6 +2431,24 @@ static void end_polls(struct fuse_conn *fc)
>         }
>  }
>
> +/*
> + * Flush all pending requests and wait for them.  Only call this functio=
n when

I think you meant "don't wait" for them?
> + * it is no longer possible for other threads to add requests.
> + */
> +void fuse_flush_requests(struct fuse_conn *fc)
> +{
> +       spin_lock(&fc->lock);
> +       spin_lock(&fc->bg_lock);
> +       if (fc->connected) {
> +               /* Push all the background requests to the queue. */
> +               fc->blocked =3D 0;
> +               fc->max_background =3D UINT_MAX;
> +               flush_bg_queue(fc);
> +       }
> +       spin_unlock(&fc->bg_lock);
> +       spin_unlock(&fc->lock);
> +}
> +
>  /*
>   * Abort all requests.
>   *
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e57b8af06be93e..58c3351b467221 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -2086,8 +2086,18 @@ void fuse_conn_destroy(struct fuse_mount *fm)
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
> +                * O_EXCL hold on the block device.  We don't wait, so li=
bfuse
> +                * has to do that for us.

nit: imo the "because the fuse server must close the filesystem before
replying to the destroy message, because..." part is confusing. Even
if that weren't true, the pending requests would still have to be sent
before the destroy, no? i think it would be less confusing if that
part of the paragraph was removed. I think it might be better to
remove the "we don't wait, so libfuse has to do that for us" part too
or rewording it to something like "flushed requests are sent before
the FUSE_DESTROY. Userspace is responsible for ensuring flushed
requests are handled before replying to the FUSE_DESTROY".

Thanks,
Joanne

> +                */
> +               fuse_flush_requests(fc);
>                 fuse_send_destroy(fm);
> +       }
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
>

