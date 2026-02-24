Return-Path: <linux-ext4+bounces-13996-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLl5DI8FnmmhTAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13996-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 21:09:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C773118C483
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 21:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2564B30580BB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927D336EC0;
	Tue, 24 Feb 2026 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJcaled3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7753335064
	for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963781; cv=pass; b=lTZ6hTmvS/zGu3FzdzZyHqK0t9ngu82xGmL8+Yn4BGRDMYmolJup4wZrU9DOaTNvsjJIjzjukZytaO8aE4d2JMq3PW66fnFkzrgi+d71ucPAoHmKrsD+gaO+sBuiyE/F23H5f8OuFzHuU5/h/LmNboB76ZaWou21HDtjWyRpDJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963781; c=relaxed/simple;
	bh=2Cg/DXUaQemdS7si661sB6VqKVJNE0PpNQT4QAW402w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3YPXy7sB35cpNXvss1BqOQhilN4/mZlOJRW5x7KQJ/taNlkzu96GiQe/ZQH06+sgEm8Fra1QUGsgcdooagC+mC/j1yQ9S53MjBTqTyvtszbpuYmIfBkCjuo9GxWHGkJSV/5LZ+kncjR6SZi8DhYyDQunT0xwE/xaj08a8wO/Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJcaled3; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-505a1789a27so37951101cf.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 12:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771963779; cv=none;
        d=google.com; s=arc-20240605;
        b=fREoXltzU7I/oKxKZ6/VdsB0ZrrgZabBO6UN2XpfToRLkxzhNw2VZwArChTO3xlf/n
         W52Qb9hkjVRPdvEyNALX/pYfqkpRt5qN+dAGLuzHY5/L/9fVJzyC4w4djinpqYFJXUjS
         QzE16dV+31XA0hYoz+QxLDnKWddefvKydUJUgD5++BTACxWcX+iM4EwHRZHcZhgDF4rJ
         Q27C+/8tJQDEVw6ffhx6qWDpDqKHzJADfsguRkUbEY6PBUtN1x2rTkJgirAey9Nkcg9p
         cnlEPtmVp9zhHoOVJH8dNKRMwDKdSP5O2gIR/r9sa1Gl7lDYzUKrDQxOcZU/dtRX0Sgb
         XhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        fh=vqvsph5h4aBQ9oDXIPo5+gilMyPck8akEoo5TJ+xnIg=;
        b=QZPBRFAe7NstbBYEMElmTMFCzzmIEuAhLQgiSqqx79nz+Rp3NyE9pxAbUXVHUzei4u
         3XT/73kTQuHK3NlqCGG/b2nJ9uT1w4G/XPPs6A/GpKXrhgiSNd4hSuMYxq/mL1ZTpiKD
         2gqUnz8TwDXPZn7ov7VNpat6HZASsrfpM9VfpgIKboGGl4fTxL2oEFdboKa+YcAhTPSr
         O6pR/ddQ4Gwgxv0OkjZEA4lgjKuH7588BOem8722BiU8fdyEv6w7tNY/5wP0zRrGpF/c
         9Fg5oz8NRIzegkJd1H391NJKfBTS8KoFNrZ+7u6ymHz8EXod6cTClU7R+74cHdHkm2wL
         /iyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771963779; x=1772568579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=WJcaled3m4rBPyjQcD4YEGhqpMqXciFvxDGDqawJnXTo3PBfC4cw1nBi4+ors4LGz9
         aG0KN5kh9om+TTrTXXFwzDQMGjKIKgBItoEpOQ6c+VxTiS1pBfDZl79MTOYsVBuhEqub
         +Eoz1MvlXYTJFjP7a/rGvujL+ch/6wd/+kZ1YjUPlN7aySKajKYlkZScS28tEZifgG0v
         3cH1dwFvEYjQyn+jHiXRO6DgsQCjIFKWMvyhlDvY4iuXinDF374LYfwTQHctFEHLJ0jw
         RK2SmLpLnmRONJ7JyQYfpmPJuKbaLBpLNzphejagMtsuv4pf+Q7j3u3vwFhpHW7E2E0l
         GkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771963779; x=1772568579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DDHaOfhOlTVmBPRd/vHmXNqCBjvhgIixRlqQfkjm7g=;
        b=LY3YDwoc0QIJtb8PWPgoDcSD2e13TmTbikxd61zFtSeuZJA12UR+29ZK5E62dz+9ME
         NPaPBCdSmDF3IVbV4k+f5g3JUNr8th8YZqfJimT02qRlBIGvDrTjDSrsQ8c7ygq+PEiJ
         mgGxk44XT2Psu11LXfE6QZXRQlS3eYBLkvGzWGo/6G5lSiuEfL//pdmF6zLM5CqCNDW1
         qy7jH+1iLm9m20JTkGicaGRZGNlXu8hDjirnie7UGVd2BqLJpzglFz/C30nNdNvBrvCw
         JeBkkSf6Qt3smi7wF4plSmZy6sKTdSQ97fTTwSn31GwRYAutNnXzrR1p2UnHOn1n6mlM
         hFFA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LVDbaN1VIqaYIsp/IUuIY0gKIvy1UpLA1pwzS4gULjxGfStL2i8UuNchEVAKhbvISbLRUObxcHgR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBO46gUBPJ4AIPf/EWHCwQnBA+9KPwy6DxKLNLKqvV+hytaCt
	eTGuiO543l6+JMZwDBMoJ9E8X2RgbUJ/jtDK0rdPOgvOk06N9zifl3v/gWp9n78ddN1Wo2MKXOY
	31ti6S4cGWXLCkDplIauFTYRYMd22VEU=
X-Gm-Gg: AZuq6aJDwHNPEsYSrjRyvD+qUy643Zmn7D8MxumwaCVHZEI2x0jqjjPD5DHTU/8kAZ/
	Pphl5URCcTGj9DGAcmpdcVbIwN2Ly3J7oqSRg16uLhb84klDDYYFQg9CSKMP85PNsj88qFG/eIY
	C1WX4GiC4EOUCj9Yy5zxO/Gxy5A4fidEQG/r0Mbmrekv3+tpc9woqMnF86/tmBGgHPGK7sGTLNv
	oaThThxsM8YUOHWuXEo2rOcPQz0nLl7aczHK8Z9LoNYBdW6uL4K4QBWsa7fTk5XZ5CN9m8x7XxY
	UGkxAA==
X-Received: by 2002:ac8:5a05:0:b0:503:2d06:8e15 with SMTP id
 d75a77b69052e-5070bbd5fbbmr189408691cf.21.1771963778577; Tue, 24 Feb 2026
 12:09:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 12:09:27 -0800
X-Gm-Features: AaiRm51mgRlWbkXb6u9q8vdEfIKt7UeLJ2adO4XjFSbDCtDEImXRc2B_2FbsvY4
Message-ID: <CAJnrk1bEm=pe2M367CsbQNYyUEdXCVzAyboqqHnSCxx7fxZKZA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, stable@vger.kernel.org, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-13996-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C773118C483
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:06=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Makes sense to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/control.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 140bd5730d9984..073c2d8e4dfc7c 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -121,7 +121,7 @@ static ssize_t fuse_conn_max_background_write(struct =
file *file,
>                                               const char __user *buf,
>                                               size_t count, loff_t *ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         ssize_t ret;
>
>         ret =3D fuse_conn_limit_write(file, buf, count, ppos, &val,
> @@ -163,7 +163,7 @@ static ssize_t fuse_conn_congestion_threshold_write(s=
truct file *file,
>                                                     const char __user *bu=
f,
>                                                     size_t count, loff_t =
*ppos)
>  {
> -       unsigned val;
> +       unsigned val =3D 0;
>         struct fuse_conn *fc;
>         ssize_t ret;
>
>

