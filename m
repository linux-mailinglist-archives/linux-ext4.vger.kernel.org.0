Return-Path: <linux-ext4+bounces-13169-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIWVEtw4cWnKfQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13169-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 21:36:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E285D613
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 21:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B83B876D23D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457B43B8BC2;
	Wed, 21 Jan 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CowJ//K4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F1347FE3
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024082; cv=pass; b=GGSSacFxV7IsdDy7ouWrSL0edSOAhK6tHXo9hebTqEThVfRq8YkJ1OmaF7N7HlXpRE0lN9nIU0OR2TuhD6PHzuGJS2YfbW6GwDAZvoneyL5K5GcwsspPBQcyYzZfG5ZusPOyqHGvQ62v3IualuHmrNwEkIeOsiwUs2moVml3K0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024082; c=relaxed/simple;
	bh=gsH1ea58+/cZBv+IXHMAC9Ni3RiwIlGpLpcqvYzF/i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oU6rRKDKTikqfmbDq2D/u45mjNp5cY5nUfJg1ljlBUK5NZko67yGqDcPPmO8p3vVLE87t0KWoENeVZAv5cMJPI+Cr31oEqNNv2A+iMgn6nFSV9Ef0OGOMY5e2MhlETmo4hqhrJEGsBerJQ3NNd5+nHgD1yvoYyUJMQb7vS8oeCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CowJ//K4; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50150bc7731so2307781cf.1
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 11:34:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769024075; cv=none;
        d=google.com; s=arc-20240605;
        b=WEKWtpGVcL38WIMOi0uKamlTGEhKxmDefuqGu1coM8yGGZm47ZyBbTyK/hZY5U6i9k
         gUDel9jX22VEkkyrGdNd2naOGbGmjmqWvPG/KKHeOzsyAnYZlTib2A0CGmGsDxR94RM9
         wI94Ql0mTqt0/idTE4HdjCstmgSK3B/3dAGarWsyMoRJjpSvvr2+VcyaLPtO1eXsgdc+
         x2HolAVWR5FYA6B+v5ocovTFecRXBF2Hr08QwGuOJjyUhcjXNiAkJzIZzqwKoiA63t2v
         MCOYTNwi1Pmf+5fsDOYfkD2bUbQj8/nW9YzGV8UCUFbJW3ZwC6cnr2PKwu6rcYaxiJMZ
         sbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2hxSEcYQBTUa7cTn1xrwUBlsAiXmSHnpjbfKh7hNOY=;
        fh=YrjpGQPetHCmDWxMYL7i8DBWYEyZKFB/HfTBiaQXnYU=;
        b=Pa4KbEGd9tGFt06isNa80ZP9xdfvfdkB+mfVpbQ+8EWD+RvFdjZAVMTkKAdtEp4ZnJ
         GVzra+Y2X36U6n1+U7oLUa5nBnoFIlBhykf8pmpoI9dug9HuBjBownwJYjbVq/CizkOL
         sw9H1utEZf4B65EFXlCaE8EbQ2SEPLzm6h/R3XD7cByqRFq3nbVqwgM+vDQ7UA0Pvm8X
         u6+FjayrDFKs6gkgt51tMlJsK6XD7+Vd50b7pyV8MRZy1Dlj+8smTWd6GHo5PAEI5Zym
         JEHUr4gvhDRNq0p+AQcpIOYwbJhlsKnWS6Zdo55I8amj8g3y4BFdFWa+lQy1jQA4c17L
         1n4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769024075; x=1769628875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2hxSEcYQBTUa7cTn1xrwUBlsAiXmSHnpjbfKh7hNOY=;
        b=CowJ//K4WnvjYVNSaPRwNV48OlEV/XLkJYODHwLWeLqmN816aw88uT7yso1mm9p16d
         fMXF7ds513P5GvTXZhbIPiOlVG/QcVXLzCPuwNEvu5noF4OphRMgtRcDIm75ySfX/B2b
         AqteBMV56A/uoHC20qf2JZYnAaPdriiJzpWChKZC56BTHUR2J2Wdlo/U06kcJFKC+Hzq
         QUZnuHETQ5fh1ZSwfT+nxmKL2xvIOvDi48/fmhaEVfEPeVd8H4scS9VKWm3f2kHjkc4Y
         ZcP+U1RC7fbU76ZafIJrNvx4iD87C4nFHomI8kxsWvcUaVs9z/symy6bd4W873lNiY2x
         LigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024075; x=1769628875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2hxSEcYQBTUa7cTn1xrwUBlsAiXmSHnpjbfKh7hNOY=;
        b=RP1OntOdSS1wKglcgy/SSNUe4cE2/k20hbEfr1ApivHL4ddMXLxUUbIFQYZPRpMCPo
         le2+YbSGfZkB5SfxoAbuy5LnrT6YkpB/9PFQAPgrMGIHn/FZbJUl8QlKhpvKNHb7+oR8
         p8rmctBmS0GN5NOxWvnFV+1vCqpyG4gAH8G78u013O+J+j+Y88DSTQPNg8BfGQZPTt5r
         LHX/jmCJK/inX1/dQ+Bpt8r/I1r4ctaxm2mwHQTLikeGBmcDoVUH6CryxG72KE9HJfP0
         KlZPhRbdjUgiGgdLb4Ga+obIWHFOJQN7bimGM0f2Y7bQhF59B7MI/pgWrPKPh74zFDDU
         ynWg==
X-Forwarded-Encrypted: i=1; AJvYcCVYQhrCY1EqfnHcNWUoljLzGFTGKNba2ivqSSCJXAkc+BQurIIDOUN7ga8847QnwfpVcGVH4WhXKS73@vger.kernel.org
X-Gm-Message-State: AOJu0YzKl+4dDTaDzJHY4ouz3R2L0jVdBzm+lGgNDePrz9jLobMwWGBF
	ZtUPGHP9GV0oLWVnxnxpO/w/iMsrV3ZQWph44YWK/Jbo2RF0i8F9472GnR1zEdmQ4nWpgvHq2MI
	hWy/C/NpCteLnasV+Q6y9nRW2cxtITd8=
X-Gm-Gg: AZuq6aKlF9BnpN6BdHlP3v0t9jlGoAbHyDu4vZZ6DYzjDhF1nWEuACn6G29XXcIrJhc
	qdloBm3jbIDKkpiXrc4yp+D6Fbn5hNrFBL1QkU4KczUV1gBfLYWZMz0oG8O7U0Hy/TPQp4P3L//
	Qt7S18iKhEcnjgjOgQQ+fuktUfnl8NcOT+EBWtAnzHhtEkcwTOeHDLfeLOtl6uZd/sQ4UoEfbHZ
	y+UzbYcrAz3NB7NbvwTVzGCT6M4KnPk728vmxxHHjwLwyG9BiFTTmwvpjb+8nz5GEwy5w==
X-Received: by 2002:a05:622a:107:b0:502:9f2b:1b2f with SMTP id
 d75a77b69052e-502a1fac5c0mr265950691cf.78.1769024075247; Wed, 21 Jan 2026
 11:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 11:34:24 -0800
X-Gm-Features: AZwV_Qh7OW7JEgyXUEriMksHjJMqCvqhJa9vaXyBEU3l3Z_TOv6ywRSBdzXmaU8
Message-ID: <CAJnrk1ZOLNytBdVqvWiHbwA0rE0KCVt09SmHFZ3pp_tffg+iaQ@mail.gmail.com>
Subject: Re: [PATCH 01/31] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13169-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 31E285D613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Oct 28, 2025 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   22 ++
>  fs/fuse/iomap_i.h         |   36 ++++
>  include/uapi/linux/fuse.h |   90 +++++++++
>  fs/fuse/Kconfig           |   32 +++
>  fs/fuse/Makefile          |    1
>  fs/fuse/file_iomap.c      |  434 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |    8 +
>  7 files changed, 621 insertions(+), 2 deletions(-)
>  create mode 100644 fs/fuse/iomap_i.h
>  create mode 100644 fs/fuse/file_iomap.c
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7c7d255d817f1e..45be59df7ae592 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -929,6 +929,9 @@ struct fuse_conn {
>         /* Is synchronous FUSE_INIT allowed? */
>         unsigned int sync_init:1;
>
> +       /* Enable fs/iomap for file operations */
> +       unsigned int iomap:1;
> +
>         /* Use io_uring for communication */
>         unsigned int io_uring;
>
> @@ -1053,12 +1056,17 @@ static inline struct fuse_mount *get_fuse_mount_s=
uper(struct super_block *sb)
>         return sb->s_fs_info;
>  }
>
> +static inline const struct fuse_mount *get_fuse_mount_super_c(const stru=
ct super_block *sb)
> +{
> +       return sb->s_fs_info;
> +}

I'm not seeing this getting used anywhere - did you mean to remove this?

> +
>  static inline struct fuse_conn *get_fuse_conn_super(struct super_block *=
sb)
>  {
>         return get_fuse_mount_super(sb)->fc;
>  }
>
> -static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
> +static inline struct fuse_mount *get_fuse_mount(const struct inode *inod=
e)
>  {
>         return get_fuse_mount_super(inode->i_sb);
>  }
> @@ -1683,4 +1691,16 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()       do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP)
> +bool fuse_iomap_enabled(void);
> +
> +static inline bool fuse_has_iomap(const struct inode *inode)
> +{
> +       return get_fuse_conn(inode)->iomap;
> +}
> +#else
> +# define fuse_iomap_enabled(...)               (false)
> +# define fuse_has_iomap(...)                   (false)
> +#endif
> +
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/iomap_i.h b/fs/fuse/iomap_i.h
> new file mode 100644
> index 00000000000000..d773f728579d1d
> --- /dev/null
> +++ b/fs/fuse/iomap_i.h
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + */
> +#ifndef _FS_FUSE_IOMAP_I_H
> +#define _FS_FUSE_IOMAP_I_H
> +
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP)
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> +# define ASSERT(condition) do {                                         =
       \
> +       int __cond =3D !!(condition);                                    =
 \
> +       WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condit=
ion, __func__, __LINE__); \
> +} while (0)
> +# define BAD_DATA(condition) ({                                         =
       \
> +       int __cond =3D !!(condition);                                    =
 \
> +       WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, _=
_func__, __LINE__); \
> +})
> +#else
> +# define ASSERT(condition)
> +# define BAD_DATA(condition) ({                                         =
       \
> +       int __cond =3D !!(condition);                                    =
 \
> +       unlikely(__cond);                                               \
> +})
> +#endif /* CONFIG_FUSE_IOMAP_DEBUG */
> +
> +enum fuse_iomap_iodir {
> +       READ_MAPPING,
> +       WRITE_MAPPING,
> +};
> +
> +#define EFSCORRUPTED   EUCLEAN
> +
> +#endif /* CONFIG_FUSE_IOMAP */
> +
> +#endif /* _FS_FUSE_IOMAP_I_H */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 18713cfaf09171..7d709cf12b41a7 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,9 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.99

Should this be changed to something like 7.46 now that this patch is
submitted for merging into the tree?

> + *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operat=
ions
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -275,7 +278,7 @@
>  #define FUSE_KERNEL_VERSION 7
>
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 45
> +#define FUSE_KERNEL_MINOR_VERSION 99

Same question here

>
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -448,6 +451,7 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *                      init_out.request_timeout contains the timeout (i=
n secs)
> + * FUSE_IOMAP: Client supports iomap for regular file operations.
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -495,6 +499,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP       (1ULL << 40)
>  #define FUSE_OVER_IO_URING     (1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT   (1ULL << 42)
> +#define FUSE_IOMAP             (1ULL << 43)
>
>  /**
>   * CUSE INIT request/reply flags
> @@ -664,6 +669,9 @@ enum fuse_opcode {
>         FUSE_STATX              =3D 52,
>         FUSE_COPY_FILE_RANGE_64 =3D 53,
>
> +       FUSE_IOMAP_BEGIN        =3D 4094,
> +       FUSE_IOMAP_END          =3D 4095,
> +
>         /* CUSE specific operations */
>         CUSE_INIT               =3D 4096,
>
> @@ -1314,4 +1322,84 @@ struct fuse_uring_cmd_req {
>         uint8_t padding[6];
>  };
>
> +/* mapping types; see corresponding IOMAP_TYPE_ */
> +#define FUSE_IOMAP_TYPE_HOLE           (0)
> +#define FUSE_IOMAP_TYPE_DELALLOC       (1)
> +#define FUSE_IOMAP_TYPE_MAPPED         (2)
> +#define FUSE_IOMAP_TYPE_UNWRITTEN      (3)
> +#define FUSE_IOMAP_TYPE_INLINE         (4)
> +
> +/* fuse-specific mapping type indicating that writes use the read mappin=
g */
> +#define FUSE_IOMAP_TYPE_PURE_OVERWRITE (255)
> +
> +#define FUSE_IOMAP_DEV_NULL            (0U)    /* null device cookie */
> +
> +/* mapping flags passed back from iomap_begin; see corresponding IOMAP_F=
_ */
> +#define FUSE_IOMAP_F_NEW               (1U << 0)
> +#define FUSE_IOMAP_F_DIRTY             (1U << 1)
> +#define FUSE_IOMAP_F_SHARED            (1U << 2)
> +#define FUSE_IOMAP_F_MERGED            (1U << 3)
> +#define FUSE_IOMAP_F_BOUNDARY          (1U << 4)
> +#define FUSE_IOMAP_F_ANON_WRITE                (1U << 5)
> +#define FUSE_IOMAP_F_ATOMIC_BIO                (1U << 6)

Do you think it makes sense to have the fuse iomap constants mirror
the in-kernel iomap ones? Maybe I'm mistaken but it seems like the
fuse iomap capabilities won't diverge too much from fs/iomap ones? I
like that if they're mirrored, then it makes it simpler instead of
needing to convert back and forth.

> +
> +/* fuse-specific mapping flag asking for ->iomap_end call */
> +#define FUSE_IOMAP_F_WANT_IOMAP_END    (1U << 7)
> +
> +/* mapping flags passed to iomap_end */
> +#define FUSE_IOMAP_F_SIZE_CHANGED      (1U << 8)
> +#define FUSE_IOMAP_F_STALE             (1U << 9)
> +
> +/* operation flags from iomap; see corresponding IOMAP_* */
> +#define FUSE_IOMAP_OP_WRITE            (1U << 0)
> +#define FUSE_IOMAP_OP_ZERO             (1U << 1)
> +#define FUSE_IOMAP_OP_REPORT           (1U << 2)
> +#define FUSE_IOMAP_OP_FAULT            (1U << 3)
> +#define FUSE_IOMAP_OP_DIRECT           (1U << 4)
> +#define FUSE_IOMAP_OP_NOWAIT           (1U << 5)
> +#define FUSE_IOMAP_OP_OVERWRITE_ONLY   (1U << 6)
> +#define FUSE_IOMAP_OP_UNSHARE          (1U << 7)
> +#define FUSE_IOMAP_OP_DAX              (1U << 8)
> +#define FUSE_IOMAP_OP_ATOMIC           (1U << 9)
> +#define FUSE_IOMAP_OP_DONTCACHE                (1U << 10)
> +
> +#define FUSE_IOMAP_NULL_ADDR           (-1ULL) /* addr is not valid */
> +
> +struct fuse_iomap_io {
> +       uint64_t offset;        /* file offset of mapping, bytes */
> +       uint64_t length;        /* length of mapping, bytes */
> +       uint64_t addr;          /* disk offset of mapping, bytes */
> +       uint16_t type;          /* FUSE_IOMAP_TYPE_* */
> +       uint16_t flags;         /* FUSE_IOMAP_F_* */
> +       uint32_t dev;           /* device cookie */

Do you think it's a good idea to add a reserved field here in case we
end up needing it in the future?
> +};
> +
> +struct fuse_iomap_begin_in {
> +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> +       uint32_t reserved;      /* zero */
> +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> +       uint64_t pos;           /* file position, in bytes */
> +       uint64_t count;         /* operation length, in bytes */
> +};
> +
> +struct fuse_iomap_begin_out {
> +       /* read file data from here */
> +       struct fuse_iomap_io    read;
> +
> +       /* write file data to here, if applicable */
> +       struct fuse_iomap_io    write;

Same question here
> +};
> +
> +struct fuse_iomap_end_in {
> +       uint32_t opflags;       /* FUSE_IOMAP_OP_* */
> +       uint32_t reserved;      /* zero */
> +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> +       uint64_t pos;           /* file position, in bytes */
> +       uint64_t count;         /* operation length, in bytes */
> +       int64_t written;        /* bytes processed */

On the fs/iomap side, I see that written is passed through by
iomap_iter() to ->iomap_end through 'ssize_t advanced' but it's not
clear to me why advanced needs to be signed. I think it used to also
represent the error status, but it looks like now that's represented
through iter->status and 'advanced' strictly reflects the number of
bytes written. As such, do you think it makes sense to change
'advanced' to loff_t and have written be uint64_t instead?

> +
> +       /* mapping that the kernel acted upon */
> +       struct fuse_iomap_io    map;
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 290d1c09e0b924..934d48076a010c 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -69,6 +69,38 @@ config FUSE_PASSTHROUGH
>  config FUSE_BACKING
>         bool
>
> +config FUSE_IOMAP
> +       bool "FUSE file IO over iomap"
> +       default y
> +       depends on FUSE_FS
> +       depends on BLOCK
> +       select FS_IOMAP
> +       help
> +         Enable fuse servers to operate the regular file I/O path throug=
h
> +         the fs-iomap library in the kernel.  This enables higher perfor=
mance
> +         userspace filesystems by keeping the performance critical parts=
 in
> +         the kernel while delegating the difficult metadata parsing part=
s to
> +         an easily-contained userspace program.
> +
> +         This feature is considered EXPERIMENTAL.  Use with caution!
> +
> +         If unsure, say N.
> +
> +config FUSE_IOMAP_BY_DEFAULT
> +       bool "FUSE file I/O over iomap by default"
> +       default n
> +       depends on FUSE_IOMAP
> +       help
> +         Enable sending FUSE file I/O over iomap by default.

I'm not really sure what the general linux preference is for adding
new configs, but assuming it errs towards less configs than more, imo
it seems easy enough to just set the enable_iomap module param to true
manually instead of needing this config for it, especially since the
param only needs to be set once.

> +
> +config FUSE_IOMAP_DEBUG
> +       bool "Debug FUSE file IO over iomap"
> +       default y
> +       depends on FUSE_IOMAP
> +       help
> +         Enable debugging assertions for the fuse iomap code paths and l=
ogging
> +         of bad iomap file mapping data being sent to the kernel.

I'm wondering if it makes sense to make this a general FUSE_DEBUG
config so we can reuse this more generally

> +
>  config FUSE_IO_URING
>         bool "FUSE communication over io-uring"
>         default y
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 46041228e5be2c..27be39317701d6 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -18,5 +18,6 @@ fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
>  fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
>  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> +fuse-$(CONFIG_FUSE_IOMAP) +=3D file_iomap.o
>
>  virtiofs-y :=3D virtio_fs.o
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> new file mode 100644
> index 00000000000000..d564d60d0f1779
> --- /dev/null
> +++ b/fs/fuse/file_iomap.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Oracle.  All Rights Reserved.
> + * Author: Darrick J. Wong <djwong@kernel.org>
> + */
> +#include <linux/iomap.h>
> +#include "fuse_i.h"
> +#include "fuse_trace.h"
> +#include "iomap_i.h"
> +
> +static bool __read_mostly enable_iomap =3D
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
> +       true;
> +#else
> +       false;
> +#endif
> +module_param(enable_iomap, bool, 0644);
> +MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> +
> +bool fuse_iomap_enabled(void)
> +{
> +       /* Don't let anyone touch iomap until the end of the patchset. */
> +       return false;
> +
> +       /*
> +        * There are fears that a fuse+iomap server could somehow DoS the
> +        * system by doing things like going out to lunch during a writeb=
ack
> +        * related iomap request.  Only allow iomap access if the fuse se=
rver
> +        * has rawio capabilities since those processes can mess things u=
p
> +        * quite well even without our help.
> +        */
> +       return enable_iomap && has_capability_noaudit(current, CAP_SYS_RA=
WIO);
> +}
> +
> +/* Convert IOMAP_* mapping types to FUSE_IOMAP_TYPE_* */
> +#define XMAP(word) \
> +       case IOMAP_##word: \
> +               return FUSE_IOMAP_TYPE_##word
> +static inline uint16_t fuse_iomap_type_to_server(uint16_t iomap_type)
> +{
> +       switch (iomap_type) {
> +       XMAP(HOLE);
> +       XMAP(DELALLOC);
> +       XMAP(MAPPED);
> +       XMAP(UNWRITTEN);
> +       XMAP(INLINE);
> +       default:
> +               ASSERT(0);
> +       }
> +       return 0;
> +}
> +#undef XMAP
> +
> +/* Convert FUSE_IOMAP_TYPE_* to IOMAP_* mapping types */
> +#define XMAP(word) \
> +       case FUSE_IOMAP_TYPE_##word: \
> +               return IOMAP_##word
> +static inline uint16_t fuse_iomap_type_from_server(uint16_t fuse_type)
> +{
> +       switch (fuse_type) {
> +       XMAP(HOLE);
> +       XMAP(DELALLOC);
> +       XMAP(MAPPED);
> +       XMAP(UNWRITTEN);
> +       XMAP(INLINE);
> +       default:
> +               ASSERT(0);
> +       }
> +       return 0;
> +}
> +#undef XMAP
> +
> +/* Validate FUSE_IOMAP_TYPE_* */
> +static inline bool fuse_iomap_check_type(uint16_t fuse_type)
> +{
> +       switch (fuse_type) {
> +       case FUSE_IOMAP_TYPE_HOLE:
> +       case FUSE_IOMAP_TYPE_DELALLOC:
> +       case FUSE_IOMAP_TYPE_MAPPED:
> +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> +       case FUSE_IOMAP_TYPE_INLINE:
> +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +#define FUSE_IOMAP_F_ALL (FUSE_IOMAP_F_NEW | \
> +                         FUSE_IOMAP_F_DIRTY | \
> +                         FUSE_IOMAP_F_SHARED | \
> +                         FUSE_IOMAP_F_MERGED | \
> +                         FUSE_IOMAP_F_BOUNDARY | \
> +                         FUSE_IOMAP_F_ANON_WRITE | \
> +                         FUSE_IOMAP_F_ATOMIC_BIO | \
> +                         FUSE_IOMAP_F_WANT_IOMAP_END)
> +
> +static inline bool fuse_iomap_check_flags(uint16_t flags)
> +{
> +       return (flags & ~FUSE_IOMAP_F_ALL) =3D=3D 0;
> +}
> +
> +/* Convert IOMAP_F_* mapping state flags to FUSE_IOMAP_F_* */
> +#define XMAP(word) \
> +       if (iomap_f_flags & IOMAP_F_##word) \
> +               ret |=3D FUSE_IOMAP_F_##word
> +#define YMAP(iword, oword) \
> +       if (iomap_f_flags & IOMAP_F_##iword) \
> +               ret |=3D FUSE_IOMAP_F_##oword
> +static inline uint16_t fuse_iomap_flags_to_server(uint16_t iomap_f_flags=
)
> +{
> +       uint16_t ret =3D 0;
> +
> +       XMAP(NEW);
> +       XMAP(DIRTY);
> +       XMAP(SHARED);
> +       XMAP(MERGED);
> +       XMAP(BOUNDARY);
> +       XMAP(ANON_WRITE);
> +       XMAP(ATOMIC_BIO);
> +       YMAP(PRIVATE, WANT_IOMAP_END);
> +
> +       XMAP(SIZE_CHANGED);
> +       XMAP(STALE);
> +
> +       return ret;
> +}
> +#undef YMAP
> +#undef XMAP
> +
> +/* Convert FUSE_IOMAP_F_* to IOMAP_F_* mapping state flags */
> +#define XMAP(word) \
> +       if (fuse_f_flags & FUSE_IOMAP_F_##word) \
> +               ret |=3D IOMAP_F_##word
> +#define YMAP(iword, oword) \
> +       if (fuse_f_flags & FUSE_IOMAP_F_##iword) \
> +               ret |=3D IOMAP_F_##oword
> +static inline uint16_t fuse_iomap_flags_from_server(uint16_t fuse_f_flag=
s)
> +{
> +       uint16_t ret =3D 0;
> +
> +       XMAP(NEW);
> +       XMAP(DIRTY);
> +       XMAP(SHARED);
> +       XMAP(MERGED);
> +       XMAP(BOUNDARY);
> +       XMAP(ANON_WRITE);
> +       XMAP(ATOMIC_BIO);
> +       YMAP(WANT_IOMAP_END, PRIVATE);
> +
> +       return ret;
> +}
> +#undef YMAP
> +#undef XMAP
> +
> +/* Convert IOMAP_* operation flags to FUSE_IOMAP_OP_* */
> +#define XMAP(word) \
> +       if (iomap_op_flags & IOMAP_##word) \
> +               ret |=3D FUSE_IOMAP_OP_##word
> +static inline uint32_t fuse_iomap_op_to_server(unsigned iomap_op_flags)
> +{
> +       uint32_t ret =3D 0;
> +
> +       XMAP(WRITE);
> +       XMAP(ZERO);
> +       XMAP(REPORT);
> +       XMAP(FAULT);
> +       XMAP(DIRECT);
> +       XMAP(NOWAIT);
> +       XMAP(OVERWRITE_ONLY);
> +       XMAP(UNSHARE);
> +       XMAP(DAX);
> +       XMAP(ATOMIC);
> +       XMAP(DONTCACHE);
> +
> +       return ret;
> +}
> +#undef XMAP
> +
> +/* Validate an iomap mapping. */
> +static inline bool fuse_iomap_check_mapping(const struct inode *inode,
> +                                           const struct fuse_iomap_io *m=
ap,
> +                                           enum fuse_iomap_iodir iodir)
> +{
> +       const unsigned int blocksize =3D i_blocksize(inode);
> +       uint64_t end;
> +
> +       /* Type and flags must be known */
> +       if (BAD_DATA(!fuse_iomap_check_type(map->type)))
> +               return false;
> +       if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
> +               return false;
> +
> +       /* No zero-length mappings */
> +       if (BAD_DATA(map->length =3D=3D 0))
> +               return false;
> +
> +       /* File range must be aligned to blocksize */
> +       if (BAD_DATA(!IS_ALIGNED(map->offset, blocksize)))
> +               return false;
> +       if (BAD_DATA(!IS_ALIGNED(map->length, blocksize)))
> +               return false;
> +
> +       /* No overflows in the file range */
> +       if (BAD_DATA(check_add_overflow(map->offset, map->length, &end)))
> +               return false;
> +
> +       /* File range cannot start past maxbytes */
> +       if (BAD_DATA(map->offset >=3D inode->i_sb->s_maxbytes))
> +               return false;
> +
> +       switch (map->type) {
> +       case FUSE_IOMAP_TYPE_MAPPED:
> +       case FUSE_IOMAP_TYPE_UNWRITTEN:
> +               /* Mappings backed by space must have a device/addr */
> +               if (BAD_DATA(map->dev =3D=3D FUSE_IOMAP_DEV_NULL))
> +                       return false;
> +               if (BAD_DATA(map->addr =3D=3D FUSE_IOMAP_NULL_ADDR))
> +                       return false;
> +               break;
> +       case FUSE_IOMAP_TYPE_DELALLOC:
> +       case FUSE_IOMAP_TYPE_HOLE:
> +       case FUSE_IOMAP_TYPE_INLINE:
> +               /* Mappings not backed by space cannot have a device addr=
. */
> +               if (BAD_DATA(map->dev !=3D FUSE_IOMAP_DEV_NULL))
> +                       return false;
> +               if (BAD_DATA(map->addr !=3D FUSE_IOMAP_NULL_ADDR))
> +                       return false;
> +               break;
> +       case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
> +               /* "Pure overwrite" only allowed for write mapping */
> +               if (BAD_DATA(iodir !=3D WRITE_MAPPING))
> +                       return false;
> +               break;
> +       default:
> +               /* should have been caught already */
> +               ASSERT(0);
> +               return false;
> +       }
> +
> +       /* XXX: we don't support devices yet */

> +       if (BAD_DATA(map->dev !=3D FUSE_IOMAP_DEV_NULL))
> +               return false;
> +
> +       /* No overflows in the device range, if supplied */
> +       if (map->addr !=3D FUSE_IOMAP_NULL_ADDR &&
> +           BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
> +               return false;
> +
> +       return true;
> +}
> +
> +/* Convert a mapping from the server into something the kernel can use *=
/
> +static inline void fuse_iomap_from_server(struct inode *inode,

Maybe worth adding a const in front of struct inode?

> +                                         struct iomap *iomap,
> +                                         const struct fuse_iomap_io *fma=
p)
> +{
> +       iomap->addr =3D fmap->addr;
> +       iomap->offset =3D fmap->offset;
> +       iomap->length =3D fmap->length;
> +       iomap->type =3D fuse_iomap_type_from_server(fmap->type);
> +       iomap->flags =3D fuse_iomap_flags_from_server(fmap->flags);
> +       iomap->bdev =3D inode->i_sb->s_bdev; /* XXX */
> +}
> +
> +/* Convert a mapping from the kernel into something the server can use *=
/
> +static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
> +                                       const struct iomap *iomap)
> +{
> +       fmap->addr =3D FUSE_IOMAP_NULL_ADDR; /* XXX */
> +       fmap->offset =3D iomap->offset;
> +       fmap->length =3D iomap->length;
> +       fmap->type =3D fuse_iomap_type_to_server(iomap->type);
> +       fmap->flags =3D fuse_iomap_flags_to_server(iomap->flags);
> +       fmap->dev =3D FUSE_IOMAP_DEV_NULL; /* XXX */

AFAICT, this only gets used for sending the FUSE_IOMAP_END request. Is
passing the iomap->addr to fmap->addr and inode->i_sb->s_bdev to
fmap->dev not useful to the server here?

Also, did you mean to leave in the /* XXX */ comments?

> +}
> +
> +/* Check the incoming _begin mappings to make sure they're not nonsense.=
 */
> +static inline int
> +fuse_iomap_begin_validate(const struct inode *inode,
> +                         unsigned opflags, loff_t pos,
> +                         const struct fuse_iomap_begin_out *outarg)
> +{
> +       /* Make sure the mappings aren't garbage */
> +       if (!fuse_iomap_check_mapping(inode, &outarg->read, READ_MAPPING)=
)
> +               return -EFSCORRUPTED;
> +
> +       if (!fuse_iomap_check_mapping(inode, &outarg->write, WRITE_MAPPIN=
G))
> +               return -EFSCORRUPTED;
> +
> +       /*
> +        * Must have returned a mapping for at least the first byte in th=
e
> +        * range.  The main mapping check already validated that the leng=
th
> +        * is nonzero and there is no overflow in computing end.
> +        */
> +       if (BAD_DATA(outarg->read.offset > pos))
> +               return -EFSCORRUPTED;
> +       if (BAD_DATA(outarg->write.offset > pos))
> +               return -EFSCORRUPTED;
> +
> +       if (BAD_DATA(outarg->read.offset + outarg->read.length <=3D pos))
> +               return -EFSCORRUPTED;
> +       if (BAD_DATA(outarg->write.offset + outarg->write.length <=3D pos=
))
> +               return -EFSCORRUPTED;
> +
> +       return 0;
> +}
> +
> +static inline bool fuse_is_iomap_file_write(unsigned int opflags)
> +{
> +       return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
> +}
> +
> +static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t coun=
t,
> +                           unsigned opflags, struct iomap *iomap,
> +                           struct iomap *srcmap)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_iomap_begin_in inarg =3D {
> +               .attr_ino =3D fi->orig_ino,
> +               .opflags =3D fuse_iomap_op_to_server(opflags),
> +               .pos =3D pos,
> +               .count =3D count,
> +       };
> +       struct fuse_iomap_begin_out outarg =3D { };
> +       struct fuse_mount *fm =3D get_fuse_mount(inode);
> +       FUSE_ARGS(args);
> +       int err;
> +
> +       args.opcode =3D FUSE_IOMAP_BEGIN;
> +       args.nodeid =3D get_node_id(inode);
> +       args.in_numargs =3D 1;
> +       args.in_args[0].size =3D sizeof(inarg);
> +       args.in_args[0].value =3D &inarg;
> +       args.out_numargs =3D 1;
> +       args.out_args[0].size =3D sizeof(outarg);
> +       args.out_args[0].value =3D &outarg;
> +       err =3D fuse_simple_request(fm, &args);
> +       if (err)
> +               return err;
> +
> +       err =3D fuse_iomap_begin_validate(inode, opflags, pos, &outarg);
> +       if (err)
> +               return err;
> +
> +       if (fuse_is_iomap_file_write(opflags) &&
> +           outarg.write.type !=3D FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
> +               /*
> +                * For an out of place write, we must supply the write ma=
pping
> +                * via @iomap, and the read mapping via @srcmap.
> +                */
> +               fuse_iomap_from_server(inode, iomap, &outarg.write);
> +               fuse_iomap_from_server(inode, srcmap, &outarg.read);
> +       } else {
> +               /*
> +                * For everything else (reads, reporting, and pure overwr=
ites),
> +                * we can return the sole mapping through @iomap and leav=
e
> +                * @srcmap unchanged from its default (HOLE).
> +                */
> +               fuse_iomap_from_server(inode, iomap, &outarg.read);
> +       }
> +
> +       return 0;
> +}
> +
> +/* Decide if we send FUSE_IOMAP_END to the fuse server */
> +static bool fuse_should_send_iomap_end(const struct iomap *iomap,
> +                                      unsigned int opflags, loff_t count=
,
> +                                      ssize_t written)
> +{
> +       /* fuse server demanded an iomap_end call. */
> +       if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
> +               return true;
> +
> +       /* Reads and reporting should never affect the filesystem metadat=
a */
> +       if (!fuse_is_iomap_file_write(opflags))
> +               return false;
> +
> +       /* Appending writes get an iomap_end call */
> +       if (iomap->flags & IOMAP_F_SIZE_CHANGED)
> +               return true;
> +
> +       /* Short writes get an iomap_end call to clean up delalloc */
> +       return written < count;
> +}
> +
> +static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
> +                         ssize_t written, unsigned opflags,
> +                         struct iomap *iomap)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_mount *fm =3D get_fuse_mount(inode);
> +       int err =3D 0;
> +
> +       if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
> +               struct fuse_iomap_end_in inarg =3D {
> +                       .opflags =3D fuse_iomap_op_to_server(opflags),
> +                       .attr_ino =3D fi->orig_ino,
> +                       .pos =3D pos,
> +                       .count =3D count,
> +                       .written =3D written,
> +               };
> +               FUSE_ARGS(args);
> +
> +               fuse_iomap_to_server(&inarg.map, iomap);
> +
> +               args.opcode =3D FUSE_IOMAP_END;
> +               args.nodeid =3D get_node_id(inode);

Just curious about this - does it make sense to set args.force here
for this opcode? It seems like it serves the same sort of purpose a
flush request (which sets args.force) does?

> +               args.in_numargs =3D 1;
> +               args.in_args[0].size =3D sizeof(inarg);
> +               args.in_args[0].value =3D &inarg;
> +               err =3D fuse_simple_request(fm, &args);
> +               switch (err) {
> +               case -ENOSYS:
> +                       /*
> +                        * libfuse returns ENOSYS for servers that don't
> +                        * implement iomap_end
> +                        */
> +                       err =3D 0;
> +                       break;
> +               case 0:
> +                       break;

Is this case 0 needed separately from the default case?

Thanks,
Joanne

> +               default:
> +                       break;
> +               }
> +       }
> +
> +       return err;
> +}
> +
> +const struct iomap_ops fuse_iomap_ops =3D {
> +       .iomap_begin            =3D fuse_iomap_begin,
> +       .iomap_end              =3D fuse_iomap_end,
> +};
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 0cac7164afa298..1eea8dc6e723c6 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1457,6 +1457,12 @@ static void process_init_reply(struct fuse_mount *=
fm, struct fuse_args *args,
>
>                         if (flags & FUSE_REQUEST_TIMEOUT)
>                                 timeout =3D arg->request_timeout;
> +
> +                       if ((flags & FUSE_IOMAP) && fuse_iomap_enabled())=
 {
> +                               fc->iomap =3D 1;
> +                               pr_warn(
> + "EXPERIMENTAL iomap feature enabled.  Use at your own risk!");
> +                       }
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
>                         fc->no_lock =3D 1;
> @@ -1525,6 +1531,8 @@ static struct fuse_init_args *fuse_new_init(struct =
fuse_mount *fm)
>          */
>         if (fuse_uring_enabled())
>                 flags |=3D FUSE_OVER_IO_URING;
> +       if (fuse_iomap_enabled())
> +               flags |=3D FUSE_IOMAP;
>
>         ia->in.flags =3D flags;
>         ia->in.flags2 =3D flags >> 32;
>

