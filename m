Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5175622C4B6
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 14:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXMEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jul 2020 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMEy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jul 2020 08:04:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC992C0619D3
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 05:04:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so9718804ljl.3
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jul 2020 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hTnq/pehl+LkT0RLtMU8McDacOcZL7DUguXoxJ6L88s=;
        b=d7vhTluvMPzOftKE6UHZrM+snWdYn3hJ69x+m0L5wkfLqo4MTIbMaWBOkrT3jy/cAC
         Px4Tqds2tydELZf+25zZmMnyYnaKDR5ztP70q71K//DHynuJmqzpNMFwQmI1N4ICA7WH
         eqyUrzzKWe1pKakmJDXPeEYy4SVlkDuw4RAwkeQnMsWe0ZYm0pxj0RzpSlCzdV+wpnxj
         WsUDqTvLuaxa34grvshgJojgOs57Z+bmDdxVAvnwBhNHDTUCm9Z7RJ6ingZcg/4X9f24
         qKbFs4xEM24piJmijepHRUVTjdplM5KzWGLDfbfFy7R2+vL4SDfc4fDNojeG9oiF1bvv
         AppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hTnq/pehl+LkT0RLtMU8McDacOcZL7DUguXoxJ6L88s=;
        b=pOdLvqd3lIX+Lo7GcBoeBrwNEF0fgtvVcyjy6v3Cdn6BBxtOVM6HjHA2nC2y546WJu
         GtHK8JFPbxAWWf/MHkMc5a0DHVLuT2fC0lduo1TF6MV9hWVbdEvS3mam/LgUCtiBFXyd
         Lxe7Syv71ZNBbmynsEtqWN0/JYl3FMiDw4DJ5g5X8WwbfRnFKAtqdVbLE49hNbnFsP64
         PIymb4Kx0CuKJyt/gihpQovrK61EigZKcRGLVZjGn3XfvWQ0/H56bWkysCm2x76k67XC
         9YTeQHEALA9zAFb8PNSWqW98bNMCcQgb+jaEMB8KgF8WYeAzyOCH3uxxN1oOmHLj3xpD
         D4qA==
X-Gm-Message-State: AOAM530scG/frD9FSbmnzMzdjNYvpNb4fI/9J0d6F0qboPVRRb/cxxeu
        Z5TkUkWjOV26KXDrjpnYnik=
X-Google-Smtp-Source: ABdhPJy/jNQSfLAlcdTojn3K5Z9F0UTi1WgCD2nzeCiNZwh9PP5hR2hBC+FfgIi6ftv0ZoeA/WiSvw==
X-Received: by 2002:a2e:8542:: with SMTP id u2mr4088842ljj.154.1595592292356;
        Fri, 24 Jul 2020 05:04:52 -0700 (PDT)
Received: from [192.168.1.192] ([195.245.244.36])
        by smtp.gmail.com with ESMTPSA id x24sm204780ljh.21.2020.07.24.05.04.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 05:04:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 3/4] ext4: indicate via a block bitmap read is prefetched
 via a tracepoint
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20200717155352.1053040-4-tytso@mit.edu>
Date:   Fri, 24 Jul 2020 15:04:49 +0300
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <749F3FF2-1DC8-408C-8B7E-7CD3110919CC@gmail.com>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-4-tytso@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I have used this tracepoint for verifying other patches in the series. =
Useful. The patch looks good.

Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

> On 17 Jul 2020, at 18:53, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Modify the ext4_read_block_bitmap_load tracepoint so that it tells us
> whether a block bitmap is being prefetched.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> fs/ext4/balloc.c            |  2 +-
> include/trace/events/ext4.h | 24 ++++++++++++++++++++----
> 2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index aaa9ec5212c8..5a2f8837200c 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -494,7 +494,7 @@ ext4_read_block_bitmap_nowait(struct super_block =
*sb, ext4_group_t block_group,
> 	 * submit the buffer_head for reading
> 	 */
> 	set_buffer_new(bh);
> -	trace_ext4_read_block_bitmap_load(sb, block_group);
> +	trace_ext4_read_block_bitmap_load(sb, block_group, =
ignore_locked);
> 	bh->b_end_io =3D ext4_end_bitmap_read;
> 	get_bh(bh);
> 	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc41d692ae8e..cbcd2e1a608d 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1312,18 +1312,34 @@ DEFINE_EVENT(ext4__bitmap_load, =
ext4_mb_buddy_bitmap_load,
> 	TP_ARGS(sb, group)
> );
>=20
> -DEFINE_EVENT(ext4__bitmap_load, ext4_read_block_bitmap_load,
> +DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
>=20
> 	TP_PROTO(struct super_block *sb, unsigned long group),
>=20
> 	TP_ARGS(sb, group)
> );
>=20
> -DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
> +TRACE_EVENT(ext4_read_block_bitmap_load,
> +	TP_PROTO(struct super_block *sb, unsigned long group, bool =
prefetch),
>=20
> -	TP_PROTO(struct super_block *sb, unsigned long group),
> +	TP_ARGS(sb, group, prefetch),
>=20
> -	TP_ARGS(sb, group)
> +	TP_STRUCT__entry(
> +		__field(	dev_t,	dev			)
> +		__field(	__u32,	group			)
> +		__field(	bool,	prefetch		)
> +
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	=3D sb->s_dev;
> +		__entry->group	=3D group;
> +		__entry->prefetch =3D prefetch;
> +	),
> +
> +	TP_printk("dev %d,%d group %u prefetch %d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->group, __entry->prefetch)
> );
>=20
> TRACE_EVENT(ext4_direct_IO_enter,
> --=20
> 2.24.1
>=20

