Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA524255BC2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 15:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgH1N6V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgH1N6B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Aug 2020 09:58:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CA0C061264
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 06:58:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so914933iln.1
        for <linux-ext4@vger.kernel.org>; Fri, 28 Aug 2020 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BAPX7WAZiuHAPDnvK96bPsfTOnnFR06n+SX7zkRFi10=;
        b=c/6uW8531oF1moAS+RfqeGiSUFy2xZHjeR2He0Zm+y+wVIlgqGTnkH/JQcCzeqAzSz
         6cDIIu4olfVJIA69xkjTw5T7Jh4mMgw16flO/hwiGJGqszIgwc7ectUeLEhm0J3GRxcq
         kewaJRhNBEKA52UOlzxa5LLQVxUoKOuD+hqkW8shP5BnJ+fImaUoKPLH7KMfxAhd4a62
         k41sTA6day9XmsnvLphRDB+gNBYdAVzX943ggFsTOlsISLxiUB+5WHvzZk0vOOWCnZH0
         Wyy65xTRh6xM480gZH52DBqWJXWDKSfgY/vtYPTuJjVbb1uBtzavrQDkmNWQKU96tXn0
         B1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BAPX7WAZiuHAPDnvK96bPsfTOnnFR06n+SX7zkRFi10=;
        b=HXeu2/KHlHlQMOeWBsGvrxt6uoA7xnlH99kca7zPRGXXpZoreZGbGc/juFEnbW+z9u
         3w3WjDFOAsaKIxyIzv4f+8jXM9nn3j6w7/9XhwcIkNEqens3iGH303yX4c1h/xMUeB34
         Z4vKDZrn0Ip9Hh8YQPlOc+10IE2HcbWEsmH58slXRW3X6v5rkkdOSHVRZa5gf4ePNx1K
         ZJ3uFvPVAF3ZaQU3+JTjes3AUE6NQLXRWRHRBYyIrVvVFr//zIJL4ky1rhGjinyP6/5/
         s4lLz+N3So52BSg0oF4IJSJG/ZbgoFeZnjuhPyl/PLJfkNFFVnYdyTif0PzwOxGszrEh
         XctQ==
X-Gm-Message-State: AOAM5332ft9+ONGN3mnUinSfEU59J6xu+CU5DcD9Nrk33AjtRLrq7BHe
        kma0OPf0oG6QDfruVkou+YU=
X-Google-Smtp-Source: ABdhPJyani+0H3+h/0Wrzpu4uwMrLA1qswx8lstpaGquAKEU6ULBF2kUbOOszPLZD6oXID31dzZ0Vw==
X-Received: by 2002:a92:c60f:: with SMTP id p15mr1510887ilm.173.1598623078180;
        Fri, 28 Aug 2020 06:57:58 -0700 (PDT)
Received: from artems-mbp.vpn.cray.com (chippewa-nat.cray.com. [136.162.34.1])
        by smtp.gmail.com with ESMTPSA id r3sm596543iov.22.2020.08.28.06.57.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 06:57:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 6/9] ext4: add memory usage tracker for freespace trees
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20200819073104.1141705-7-harshadshirwadkar@gmail.com>
Date:   Fri, 28 Aug 2020 16:57:52 +0300
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, lyx1209@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7D72C5D-4C26-4D93-A369-818C87FCF228@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
 <20200819073104.1141705-7-harshadshirwadkar@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3445.104.15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Harshad,

Thank you for these useful patches. I am still reviewing them. This one =
looks good for me, but one place looks strange. See bellow.=20

> On 19 Aug 2020, at 10:31, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Freespace trees can occupy a lot of memory with as the fragmentation
> increases. This patch adds a sysfs file to monitor the memory usage of
> the freespace tree allocator. Also, added a sysfs config to control
> maximum memory that the allocator can use. If the allocator exceeds
> this threshold, file system enters "FRSP_MEM_CRUNCH" state. The next
> patch in the series performs LRU eviction when this state is reached.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4.h    |  8 ++++++++
> fs/ext4/mballoc.c | 20 ++++++++++++++++++++
> fs/ext4/mballoc.h |  4 ++++
> fs/ext4/sysfs.c   | 11 +++++++++++
> 4 files changed, 43 insertions(+)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8cfe089ebea6..45fc3b230357 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1206,6 +1206,12 @@ struct ext4_inode_info {
> 						    * allocator off)
> 						    */
>=20
> +#define EXT4_MOUNT2_FRSP_MEM_CRUNCH	0x00000040 /*
> +						    * Freespace tree =
allocator
> +						    * is in a tight =
memory
> +						    * situation.
> +						    */
> +
> #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &=3D \
> 						~EXT4_MOUNT_##opt
> #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |=3D \
> @@ -1589,6 +1595,8 @@ struct ext4_sb_info {
> 	atomic_t s_mb_num_frsp_trees_cached;
> 	struct list_head s_mb_uncached_trees;
> 	u32 s_mb_frsp_cache_aggression;
> +	atomic_t s_mb_num_fragments;
> +	u32 s_mb_frsp_mem_limit;
>=20
> 	/* workqueue for reserved extent conversions (buffered io) */
> 	struct workqueue_struct *rsv_conversion_wq;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index fa027b626abe..aada6838cafd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -869,6 +869,7 @@ void ext4_mb_frsp_print_tree_len(struct =
super_block *sb,
> static struct ext4_frsp_node *ext4_mb_frsp_alloc_node(struct =
super_block *sb)
> {
> 	struct ext4_frsp_node *node;
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>=20
> 	node =3D kmem_cache_alloc(ext4_freespace_node_cachep, GFP_NOFS);
> 	if (!node)
> @@ -877,13 +878,31 @@ static struct ext4_frsp_node =
*ext4_mb_frsp_alloc_node(struct super_block *sb)
> 	RB_CLEAR_NODE(&node->frsp_node);
> 	RB_CLEAR_NODE(&node->frsp_len_node);
>=20
> +	atomic_inc(&sbi->s_mb_num_fragments);
> +
> +	if (sbi->s_mb_frsp_mem_limit &&
> +		atomic_read(&sbi->s_mb_num_fragments) >
> +		EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
> +		set_opt2(sb, FRSP_MEM_CRUNCH);
> +	else
> +		clear_opt2(sb, FRSP_MEM_CRUNCH);
> +
> +

Why FRSP_MEM_CRUNCH is cleared here? Are any cases when a node =
allocating can reduce fragments numbers?

> 	return node;
> }
>=20
> static void ext4_mb_frsp_free_node(struct super_block *sb,
> 		struct ext4_frsp_node *node)
> {
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +
> 	kmem_cache_free(ext4_freespace_node_cachep, node);
> +	atomic_dec(&sbi->s_mb_num_fragments);
> +
> +	if (!sbi->s_mb_frsp_mem_limit ||
> +		atomic_read(&sbi->s_mb_num_fragments) <
> +		EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(sb))
> +		clear_opt2(sb, FRSP_MEM_CRUNCH);
> }

If there are some reasons to clear FRSP_MEM_CRUNCH in =
ext4_mb_frsp_alloc_node, should we also set FRSP_MEM_CRUNCH here?

>=20
> /* Evict a tree from memory */
> @@ -1607,6 +1626,7 @@ int ext4_mb_init_freespace_trees(struct =
super_block *sb)
> 	}
> 	rwlock_init(&sbi->s_mb_frsp_lock);
> 	atomic_set(&sbi->s_mb_num_frsp_trees_cached, 0);
> +	atomic_set(&sbi->s_mb_num_fragments, 0);
>=20
> 	return 0;
> }
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index ac65f7eac611..08cac358324d 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -88,6 +88,10 @@ struct ext4_frsp_node {
> 	struct rb_node frsp_node;
> 	struct rb_node frsp_len_node;
> };
> +
> +#define EXT4_FRSP_MEM_LIMIT_TO_NUM_NODES(__sb)				=
\
> +	((sbi->s_mb_frsp_mem_limit / sizeof(struct ext4_frsp_node)))
> +
> struct ext4_free_data {
> 	/* this links the free block information from sb_info */
> 	struct list_head		efd_list;
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 31e0db726d21..d23cb51635c3 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -8,6 +8,7 @@
>  *
>  */
>=20
> +#include "mballoc.h"
> #include <linux/time.h>
> #include <linux/fs.h>
> #include <linux/seq_file.h>
> @@ -24,6 +25,7 @@ typedef enum {
> 	attr_session_write_kbytes,
> 	attr_lifetime_write_kbytes,
> 	attr_reserved_clusters,
> +	attr_frsp_tree_usage,
> 	attr_inode_readahead,
> 	attr_trigger_test_error,
> 	attr_first_error_time,
> @@ -205,6 +207,7 @@ EXT4_ATTR_FUNC(delayed_allocation_blocks, 0444);
> EXT4_ATTR_FUNC(session_write_kbytes, 0444);
> EXT4_ATTR_FUNC(lifetime_write_kbytes, 0444);
> EXT4_ATTR_FUNC(reserved_clusters, 0644);
> +EXT4_ATTR_FUNC(frsp_tree_usage, 0444);
>=20
> EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
> 		 ext4_sb_info, s_inode_readahead_blks);
> @@ -242,6 +245,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
> EXT4_ATTR(journal_task, 0444, journal_task);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> +EXT4_RW_ATTR_SBI_UI(mb_frsp_max_mem, s_mb_frsp_mem_limit);
>=20
> static unsigned int old_bump_val =3D 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -251,6 +255,7 @@ static struct attribute *ext4_attrs[] =3D {
> 	ATTR_LIST(session_write_kbytes),
> 	ATTR_LIST(lifetime_write_kbytes),
> 	ATTR_LIST(reserved_clusters),
> +	ATTR_LIST(frsp_tree_usage),
> 	ATTR_LIST(inode_readahead_blks),
> 	ATTR_LIST(inode_goal),
> 	ATTR_LIST(mb_stats),
> @@ -287,6 +292,7 @@ static struct attribute *ext4_attrs[] =3D {
> #endif
> 	ATTR_LIST(mb_prefetch),
> 	ATTR_LIST(mb_prefetch_limit),
> +	ATTR_LIST(mb_frsp_max_mem),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
> @@ -369,6 +375,11 @@ static ssize_t ext4_attr_show(struct kobject =
*kobj,
> 		return snprintf(buf, PAGE_SIZE, "%llu\n",
> 				(unsigned long long)
> 				atomic64_read(&sbi->s_resv_clusters));
> +	case attr_frsp_tree_usage:
> +		return snprintf(buf, PAGE_SIZE, "%llu\n",
> +				(unsigned long long)
> +				atomic_read(&sbi->s_mb_num_fragments) *
> +				sizeof(struct ext4_frsp_node));
> 	case attr_inode_readahead:
> 	case attr_pointer_ui:
> 		if (!ptr)
> --=20
> 2.28.0.220.ged08abb693-goog
>=20

Best regards,
Artem Blagodarenko.


