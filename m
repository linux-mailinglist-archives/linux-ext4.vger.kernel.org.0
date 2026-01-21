Return-Path: <linux-ext4+bounces-13172-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GN5PMmRkcWmaGgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13172-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 00:42:28 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8002A5FA0B
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9364F9C91
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D22C41C316;
	Wed, 21 Jan 2026 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEIKGBP9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41744D01B
	for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038938; cv=pass; b=f8rcwaLsuq5WYnZi8NuldkBq+wWgIKvbco+R7sAGZND96uyUppPNv0lwZc5UtNhqZ5+meoS3FPeEgxQ23sZRDnn2NZQCKTr3KlG+PjokVU+OKhv1av1RbtpuMz3Sb0zKNt6ppbEolgsbYnCb3FEOLgvI2cropA2OYrCg/5P8QCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038938; c=relaxed/simple;
	bh=NaTKyq5VkzOTCRmo8nr8BGBetqVP4yjqj8tN65X96uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrUioGPCUQ3kt019iiKq8DtEfoyNrvveXdimMOU9yAgKsivmJegyhcIxSxaYpAPXG8pVblxRW4LOQsEEPi5yL/5qfxyV+sLyT9iPfpWHvRHv5lrYj5ztDERSWx7zn+9CKw2F62GYsBeFYK4E82rB9sk0R6A3kyhtAlN0pobwXjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEIKGBP9; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8947404b367so4651286d6.3
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 15:42:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769038935; cv=none;
        d=google.com; s=arc-20240605;
        b=Li6DlnGSDRWOciE22ys/hvUeP+0BK7wanlBrU4KUiWWEUo44154LL4tzvZCJFZdlts
         CEt0nU77Y9y19oCgbhemB56/hnrUvZixvLKiMC/6OjfLmV02HouVDEaqgJZHSLc/ph3M
         aFkeHZG74M32z7qvuNdB8wMqkPeu3VzqpOweKtGjkrv6okbmTys56C+x1U+UXn4Vi93r
         9a6XzRHJPeraX+NYEEx5ECHuEpChuuqwrk49Pr0bW4CsheuOuCWZcXYF01SjzFqO7chv
         fuwl92IMkvNpd3uis+dihU5FptYmo/SrG7fZEQMB2TaxwGwRMbyZXBpHMmiflbW35Yhu
         P5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8n5XD3PZjttgwPt/rt0vooOLLxPdBxF33z2m3JCcJlk=;
        fh=j/4W051hyo7qofWtPq7Ry5L3DZOAOeQ5QGe3RU7yIWU=;
        b=S+8mttjDQTJsGusHnOkIwTwpWiP/9dlvZwaftP6VE1pbvngZxRNt34iQCtfh9yzmtT
         WsSqvq/ZX07wnLLTrBHbD/8EnFYOyqCDt6BfiuEawf0ydZcmOSLrkPfPabdNUHsFtlsY
         Labv+Tvm09NDuctidzOI2SeizRb0DT/AhKbJ76B93O4UbxaHMJdX5J+zhGXbNOCbtsEN
         w8Pum8hTMSbEVlGPHBWGJvLqAygpVfI6kYLxgZWx6t+EAeLvPTegdiNhJz4ox90pmlZr
         85YVqs7SfTEgwjDf6VN76V8WFYmJdvgs2mWM1/95ToQh3BKErcfsQf4XWPuqH809Rtbs
         X5PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769038935; x=1769643735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n5XD3PZjttgwPt/rt0vooOLLxPdBxF33z2m3JCcJlk=;
        b=TEIKGBP9eQM4Q6Qb+2/GEBaDUpSaid/l86i1lRfdVeSmmwxBc224Q9ibXB9v+DFOnp
         /oR5NdcIl5gXQ2tgQ6jslSCWA8rCDeTLdCbB9SPSwfOcnmaTpYQNAI/PwRafxwkaGs3m
         SBAvITeH8qYRni5G3F1lcZGNnQOj5FOuoHSFKIQXHKrat7R2PYbMW0lp7ed7I7Rdpz/G
         KBantufeGyYhOgr/FniIbPIz4fVsdXbLXi9U2XSEhA8lb2GHXuWa3cSCFHI1YBbrSn9i
         xXxomrcMYhvw3z9VMBIY0IauW5bXLsB7tH+VrJFxGXz/rHcsJ6NAjvGrJn96Cy4sP75G
         c90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769038935; x=1769643735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8n5XD3PZjttgwPt/rt0vooOLLxPdBxF33z2m3JCcJlk=;
        b=BXIQQj0UFK7cmrzbhoCu3e1/IYQw4hls4bQavBkZCZF18FPH48v6Vm37JkoyZTzqz6
         9XaWhuydOuLde9Dpo12KibUt+KF/e0t+ppKgGka40w9KjJ1wv3nnBSnOtlKNEubpawmE
         OYDGzcCQcG5J0bf2nRyyi2GzY7+wwexY975HKGzhJxXbrNqb9vCIFdIySRh7Ojq0KaC5
         nX8tUbyWBHlu45n0u27UMOmVORNsbZ/21qDzdbBcjUtJKbmrE8SdfKb5zb2pYdqu1b8h
         QclHRsfSvvxsu4JBadYK3O79EzDkyADJtufq9V1wQVfOAJef4yZ+S9Lq7xl7Jq7Z/gS1
         QGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjqMqne7ALb3AF6dQAPrDqe0STSABpdFnG1tAtdMQANMU0i26GPO0cmDt5+PbhnYV6WAjwOX4mjiYn@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvWy3HpKIGElI5bMU5WoKJr9HhaLRSlNGLPYpQZivfaeRzRlG
	pMWbt/0tL1LHRZRo7PKbN5s+wPKwysS7Qo2pdO1YhNP3qICKy/2pqxq5T4KVV7YoPAKo17dR6ak
	ILVFHLv5haYqGJUl2/QORF5Eb3NtnZq4=
X-Gm-Gg: AZuq6aJ9nYpJAgLc641uHdqPerWOH28OszLwZFFPESLVYgpyqL6oAo4QnZ2Oh6Xbh0+
	eGLc9GYgsQH4ZP7lVJhvy27Slp57OZt3m44kkgzZW+XTQr2es9m5VaBbqhcv7G1Qfyz9Y+9PrdB
	5WMJ861v70qEAqdTW3nKVopFX7TWBLsaJvGxNrYm+hFsT+5AXrYhVbqLwwVJtKRWmY+CFHM8Dxs
	FOMqJgmjUnk1YvugKY4j8LGPTD/Q1/G3IEpwIA7m8AqPw7cFmriBJnTUhHGoCrvV/eYIA==
X-Received: by 2002:a05:622a:610:b0:501:43fa:5446 with SMTP id
 d75a77b69052e-502a1616155mr280431581cf.28.1769038935025; Wed, 21 Jan 2026
 15:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810415.1424854.10373764649459618752.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 15:42:04 -0800
X-Gm-Features: AZwV_QhXxgPzK9FjAzVOh1GxOGmma5GkeIupvYSwP2v45y0Zq1NcRdljOFdC9J4
Message-ID: <CAJnrk1ZUbuAER90xbagWnBZ9dWKkdUAqVRa1vmZ5BtL_o=TnnA@mail.gmail.com>
Subject: Re: [PATCH 03/31] fuse: make debugging configurable at runtime
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13172-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8002A5FA0B
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:45=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Use static keys so that we can configure debugging assertions and dmesg
> warnings at runtime.  By default this is turned off so the cost is
> merely scanning a nop sled.  However, fuse server developers can turn
> it on for their debugging systems.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h     |    8 +++++
>  fs/fuse/iomap_i.h    |   16 ++++++++--
>  fs/fuse/Kconfig      |   15 +++++++++
>  fs/fuse/file_iomap.c |   81 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c      |    7 ++++
>  5 files changed, 124 insertions(+), 3 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 45be59df7ae592..61fb65f3604d61 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1691,6 +1691,14 @@ extern void fuse_sysctl_unregister(void);
>  #define fuse_sysctl_unregister()       do { } while (0)
>  #endif /* CONFIG_SYSCTL */
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> +int fuse_iomap_sysfs_init(struct kobject *kobj);
> +void fuse_iomap_sysfs_cleanup(struct kobject *kobj);
> +#else
> +# define fuse_iomap_sysfs_init(...)            (0)
> +# define fuse_iomap_sysfs_cleanup(...)         ((void)0)
> +#endif
> +
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>  bool fuse_iomap_enabled(void);
>
> diff --git a/fs/fuse/iomap_i.h b/fs/fuse/iomap_i.h
> index 6d9ce9c0f40a04..3615ec76c0dec0 100644
> --- a/fs/fuse/iomap_i.h
> +++ b/fs/fuse/iomap_i.h
> @@ -6,19 +6,29 @@
>  #ifndef _FS_FUSE_IOMAP_I_H
>  #define _FS_FUSE_IOMAP_I_H
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
> +#else
> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
> +#endif
> +
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> -# define ASSERT(condition) do {                                         =
       \
> +# define ASSERT(condition) \
> +while (static_branch_unlikely(&fuse_iomap_debug)) {                    \
>         int __cond =3D !!(condition);                                    =
 \
>         if (unlikely(!__cond))                                          \
>                 trace_fuse_iomap_assert(__func__, __LINE__, #condition); =
\
>         WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condit=
ion, __func__, __LINE__); \
> -} while (0)
> +       break;                                                          \
> +}
>  # define BAD_DATA(condition) ({                                         =
       \
>         int __cond =3D !!(condition);                                    =
 \
>         if (unlikely(__cond))                                           \
>                 trace_fuse_iomap_bad_data(__func__, __LINE__, #condition)=
; \
> -       WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, _=
_func__, __LINE__); \
> +       if (static_branch_unlikely(&fuse_iomap_debug))                  \
> +               WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #cond=
ition, __func__, __LINE__); \
> +       unlikely(__cond);                                                =
               \
>  })
>  #else
>  # define ASSERT(condition)
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 934d48076a010c..bb867afe6e867c 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
>           Enable debugging assertions for the fuse iomap code paths and l=
ogging
>           of bad iomap file mapping data being sent to the kernel.
>
> +         Say N here if you don't want any debugging code code compiled i=
n at
> +         all.
> +
> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
> +       bool "Debug FUSE file IO over iomap at boot time"
> +       default n
> +       depends on FUSE_IOMAP_DEBUG
> +       help
> +         At boot time, enable debugging assertions for the fuse iomap co=
de
> +         paths and warnings about bad iomap file mapping data.  This ena=
bles
> +         fuse server authors to control debugging at runtime even on a
> +         distribution kernel while avoiding most of the overhead on prod=
uction
> +         systems.  The setting can be changed at runtime via
> +         /sys/fs/fuse/iomap/debug.
> +
>  config FUSE_IO_URING
>         bool "FUSE communication over io-uring"
>         default y
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index a88f5d8d2bce15..b6fc70068c5542 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -8,6 +8,12 @@
>  #include "fuse_trace.h"
>  #include "iomap_i.h"
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_DEFAULT)
> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> +#else
> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> +#endif
> +
>  static bool __read_mostly enable_iomap =3D
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_BY_DEFAULT)
>         true;
> @@ -17,6 +23,81 @@ static bool __read_mostly enable_iomap =3D
>  module_param(enable_iomap, bool, 0644);
>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
>
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> +static struct kobject *iomap_kobj;
> +
> +static ssize_t fuse_iomap_debug_show(struct kobject *kobject,
> +                                    struct kobj_attribute *a, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", !!static_key_enabled(&fuse_iomap_d=
ebug));
> +}
> +
> +static ssize_t fuse_iomap_debug_store(struct kobject *kobject,
> +                                     struct kobj_attribute *a,
> +                                     const char *buf, size_t count)
> +{
> +       int ret;
> +       int val;
> +
> +       ret =3D kstrtoint(buf, 0, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val < 0 || val > 1)
> +               return -EINVAL;
> +
> +       if (val)
> +               static_branch_enable(&fuse_iomap_debug);
> +       else
> +               static_branch_disable(&fuse_iomap_debug);
> +
> +       return count;
> +}
> +
> +#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)                  \
> +{                                                                      \
> +       .attr   =3D { .name =3D __stringify(_name), .mode =3D _mode },   =
     \
> +       .show   =3D _show,                                               =
 \
> +       .store  =3D _store,                                              =
 \
> +}
> +
> +#define FUSE_ATTR_RW(_name, _show, _store)                     \
> +       static struct kobj_attribute fuse_attr_##_name =3D        \
> +                       __INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> +
> +#define FUSE_ATTR_PTR(_name)                                   \
> +       (&fuse_attr_##_name.attr)
> +
> +FUSE_ATTR_RW(debug, fuse_iomap_debug_show, fuse_iomap_debug_store);
> +
> +static const struct attribute *fuse_iomap_attrs[] =3D {
> +       FUSE_ATTR_PTR(debug),
> +       NULL,
> +};
> +
> +int fuse_iomap_sysfs_init(struct kobject *fuse_kobj)
> +{
> +       int error;
> +
> +       iomap_kobj =3D kobject_create_and_add("iomap", fuse_kobj);
> +       if (!iomap_kobj)
> +               return -ENOMEM;
> +
> +       error =3D sysfs_create_files(iomap_kobj, fuse_iomap_attrs);
> +       if (error) {
> +               kobject_put(iomap_kobj);
> +               return error;
> +       }
> +
> +       return 0;
> +}
> +
> +void fuse_iomap_sysfs_cleanup(struct kobject *fuse_kobj)
> +{

Is sysfs_remove_files() also needed here?

> +       kobject_put(iomap_kobj);
> +}
> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> +
>  bool fuse_iomap_enabled(void)
>  {
>         /* Don't let anyone touch iomap until the end of the patchset. */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1eea8dc6e723c6..eec711302a4a13 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -2277,8 +2277,14 @@ static int fuse_sysfs_init(void)
>         if (err)
>                 goto out_fuse_unregister;
>
> +       err =3D fuse_iomap_sysfs_init(fuse_kobj);
> +       if (err)
> +               goto out_fuse_connections;
> +
>         return 0;
>
> + out_fuse_connections:
> +       sysfs_remove_mount_point(fuse_kobj, "connections");
>   out_fuse_unregister:
>         kobject_put(fuse_kobj);
>   out_err:
> @@ -2287,6 +2293,7 @@ static int fuse_sysfs_init(void)
>
>  static void fuse_sysfs_cleanup(void)
>  {
> +       fuse_iomap_sysfs_cleanup(fuse_kobj);
>         sysfs_remove_mount_point(fuse_kobj, "connections");
>         kobject_put(fuse_kobj);
>  }
>
Could you explain why it's better that this goes through sysfs than
through a module param?

Thanks,
Joanne

