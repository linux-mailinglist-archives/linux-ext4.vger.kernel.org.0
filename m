Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C45E76C6A8
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjHBHWT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjHBHWM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 03:22:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528362D63
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 00:21:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso4017322a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 02 Aug 2023 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1690960910; x=1691565710;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uESsRXjIgfbwvlDD4xBr1qcjW2IHbMPRoRALboZz0Cs=;
        b=TS5kparmwAhB25lGTkSd/zvHgRDp7CBIi+I4uq5B5KV23Ax3n6m0rixzoiK/lthTlR
         DHcNgl48JgbkcrRduLv8+fzOgRAeF1UQ0p0oN8dDc0Z/e0A75hl8ieEBmdnfrjxhsQED
         KNv6UKcnoxhAjqAim7WwkrSysy7adTM9Tyu9cjgsRdRhmsLPwjMahYrbEn1/v/zan9s9
         dTtcLnggQGDjwk3CO1qVPgNonAjSFO0FJaNQUNG1C0jRTRI2kYX8FBd3XU8AuZ0rIEzq
         SwqYT+gz0b8IH2jVuiYmVhWJevsnsEhBmKzKz7RcIH/giUVGi1I9e4gWrVyK3YsRw6Qq
         rFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960910; x=1691565710;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uESsRXjIgfbwvlDD4xBr1qcjW2IHbMPRoRALboZz0Cs=;
        b=kYAkINSzd/qfiTu4gla0Kc2/UFNNOALkly47CtgnY3dkIw8Ar3n12MipHofZAOKLvo
         zoeBmtP0RohB0pbx0QB3EpKfOUwS18QmLctSW5iv0j9WZbQzEVc9cmgPmNsw5cgg+C6w
         3vjKJ4SN2csQPLp9Y7up2yrLNXryMd0C0MOfagmS4dDOoaaXIZ9Xt5ixzQVhHtoNLH4e
         v0yqzgbQPfgy/8swTTVoCA4TNTNUwn+8TKfxn2mfj/boO1AM33r3TO9CEIHVBuvr8QYZ
         v0OXT7VuQs8oyNDnmSHKv8GqrLVK9UPW/RwpRS2DhzO95/oumoCmXHfZ8l4+KP9OtAnq
         Kprw==
X-Gm-Message-State: ABy/qLbhNdQpeuYPWKEIJs/lJSSjs94iXNwZ23/OOKkLXgRoKMFJHf1O
        aijuaylJZPpaXiQ5x2VPit+c5eTctASsF2pXUbs=
X-Google-Smtp-Source: APBJJlH12NuLABp5Bk1lQiiMMv85//yxuaT4kYhk1Kx1iatIp7UrRowkTr+lmiC82wf83U1yLrhJeg==
X-Received: by 2002:a17:90a:6745:b0:25d:eca9:1621 with SMTP id c5-20020a17090a674500b0025deca91621mr12563292pjm.6.1690960910034;
        Wed, 02 Aug 2023 00:21:50 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a4400b0025c2c398d33sm582183pjl.39.2023.08.02.00.21.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Aug 2023 00:21:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D2BD8CBF-D60C-44C8-A026-730C5BF4DE72@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4DB91FD0-FE3F-4B88-9214-53CE2D5FF6A8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: use rb-tree to track EA reference counts
Date:   Wed, 2 Aug 2023 01:21:46 -0600
In-Reply-To: <20230801045357.1034819-1-dongyangli@ddn.com>
Cc:     linux-ext4@vger.kernel.org
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230801045357.1034819-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4DB91FD0-FE3F-4B88-9214-53CE2D5FF6A8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 31, 2023, at 10:53 PM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> Using the sorted array to track the EA blocks and their refs is
> not scalable. When the file system has a huge number of EA blocks
> reporting wrong ref, pass1 scanning could not be finished within
> a reasonable time, as 95%+ of CPU time is spent in memmove() when
> trying to enlarge the the sorted array.
>=20
> On a file system with 20 million EA blocks on an NVMe device, pass1
> time taken:
> without patch:
> time: 2014.78/1838.70/19.91
> with patch:
> time: 45.17/20.17/20.19
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/e2fsck.h      |   3 +-
> e2fsck/ea_refcount.c | 286 +++++++++++++++----------------------------
> e2fsck/pass1.c       |  14 +--
> 3 files changed, 102 insertions(+), 201 deletions(-)
>=20
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 3f2dc3084..bc2490c9d 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -533,7 +533,7 @@ extern struct dx_dir_info =
*e2fsck_dx_dir_info_iter(e2fsck_t ctx,
> typedef __u64 ea_key_t;
> typedef __u64 ea_value_t;
>=20
> -extern errcode_t ea_refcount_create(size_t size, ext2_refcount_t =
*ret);
> +extern errcode_t ea_refcount_create(ext2_refcount_t *ret);
> extern void ea_refcount_free(ext2_refcount_t refcount);
> extern errcode_t ea_refcount_fetch(ext2_refcount_t refcount, ea_key_t =
ea_key,
> 				   ea_value_t *ret);
> @@ -543,7 +543,6 @@ extern errcode_t =
ea_refcount_decrement(ext2_refcount_t refcount,
> 				       ea_key_t ea_key, ea_value_t =
*ret);
> extern errcode_t ea_refcount_store(ext2_refcount_t refcount, ea_key_t =
ea_key,
> 				   ea_value_t count);
> -extern size_t ext2fs_get_refcount_size(ext2_refcount_t refcount);
> extern void ea_refcount_intr_begin(ext2_refcount_t refcount);
> extern ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
> 				      ea_value_t *ret);
> diff --git a/e2fsck/ea_refcount.c b/e2fsck/ea_refcount.c
> index 7154b47c3..fb8b009f1 100644
> --- a/e2fsck/ea_refcount.c
> +++ b/e2fsck/ea_refcount.c
> @@ -16,193 +16,100 @@
> #undef ENABLE_NLS
> #endif
> #include "e2fsck.h"
> +#include "ext2fs/rbtree.h"
>=20
> /*
>  * The strategy we use for keeping track of EA refcounts is as
> - * follows.  We keep a sorted array of first EA blocks and its
> - * reference counts.  Once the refcount has dropped to zero, it is
> - * removed from the array to save memory space.  Once the EA block is
> + * follows.  We keep the first EA blocks and its reference counts
> + * in the rb-tree.  Once the refcount has dropped to zero, it is
> + * removed from the rb-tree to save memory space.  Once the EA block =
is
>  * checked, its bit is set in the block_ea_map bitmap.
>  */
> struct ea_refcount_el {
> +	struct rb_node	node;
> 	/* ea_key could either be an inode number or block number. */
> 	ea_key_t	ea_key;
> 	ea_value_t	ea_value;
> };
>=20
> struct ea_refcount {
> -	size_t		count;
> -	size_t		size;
> -	size_t		cursor;
> -	struct ea_refcount_el	*list;
> +	struct rb_root	root;
> +	struct rb_node	*cursor;
> };
>=20
> void ea_refcount_free(ext2_refcount_t refcount)
> {
> +	struct ea_refcount_el *el;
> +	struct rb_node *node, *next;
> +
> 	if (!refcount)
> 		return;
>=20
> -	if (refcount->list)
> -		ext2fs_free_mem(&refcount->list);
> +	for (node =3D ext2fs_rb_first(&refcount->root); node; node =3D =
next) {
> +		next =3D ext2fs_rb_next(node);
> +		el =3D ext2fs_rb_entry(node, struct ea_refcount_el, =
node);
> +		ext2fs_rb_erase(node, &refcount->root);
> +		ext2fs_free_mem(&el);
> +	}
> 	ext2fs_free_mem(&refcount);
> }
>=20
> -errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret)
> +errcode_t ea_refcount_create(ext2_refcount_t *ret)
> {
> 	ext2_refcount_t	refcount;
> 	errcode_t	retval;
> -	size_t		bytes;
>=20
> 	retval =3D ext2fs_get_memzero(sizeof(struct ea_refcount), =
&refcount);
> 	if (retval)
> 		return retval;
> -
> -	if (!size)
> -		size =3D 500;
> -	refcount->size =3D size;
> -	bytes =3D size * sizeof(struct ea_refcount_el);
> -#ifdef DEBUG
> -	printf("Refcount allocated %zu entries, %zu bytes.\n",
> -	       refcount->size, bytes);
> -#endif
> -	retval =3D ext2fs_get_memzero(bytes, &refcount->list);
> -	if (retval)
> -		goto errout;
> -
> -	refcount->count =3D 0;
> -	refcount->cursor =3D 0;
> +	refcount->root =3D RB_ROOT;
>=20
> 	*ret =3D refcount;
> 	return 0;
> -
> -errout:
> -	ea_refcount_free(refcount);
> -	return(retval);
> -}
> -
> -/*
> - * collapse_refcount() --- go through the refcount array, and get rid
> - * of any count =3D=3D zero entries
> - */
> -static void refcount_collapse(ext2_refcount_t refcount)
> -{
> -	unsigned int	i, j;
> -	struct ea_refcount_el	*list;
> -
> -	list =3D refcount->list;
> -	for (i =3D 0, j =3D 0; i < refcount->count; i++) {
> -		if (list[i].ea_value) {
> -			if (i !=3D j)
> -				list[j] =3D list[i];
> -			j++;
> -		}
> -	}
> -#if defined(DEBUG) || defined(TEST_PROGRAM)
> -	printf("Refcount_collapse: size was %zu, now %d\n",
> -	       refcount->count, j);
> -#endif
> -	refcount->count =3D j;
> -}
> -
> -
> -/*
> - * insert_refcount_el() --- Insert a new entry into the sorted list =
at a
> - * 	specified position.
> - */
> -static struct ea_refcount_el *insert_refcount_el(ext2_refcount_t =
refcount,
> -						 ea_key_t ea_key, int =
pos)
> -{
> -	struct ea_refcount_el 	*el;
> -	errcode_t		retval;
> -	size_t			new_size =3D 0;
> -	int			num;
> -
> -	if (refcount->count >=3D refcount->size) {
> -		new_size =3D refcount->size + 100;
> -#ifdef DEBUG
> -		printf("Reallocating refcount %d entries...\n", =
new_size);
> -#endif
> -		retval =3D ext2fs_resize_mem((size_t) refcount->size *
> -					   sizeof(struct =
ea_refcount_el),
> -					   (size_t) new_size *
> -					   sizeof(struct =
ea_refcount_el),
> -					   &refcount->list);
> -		if (retval)
> -			return 0;
> -		refcount->size =3D new_size;
> -	}
> -	num =3D (int) refcount->count - pos;
> -	if (num < 0)
> -		return 0;	/* should never happen */
> -	if (num) {
> -		memmove(&refcount->list[pos+1], &refcount->list[pos],
> -			sizeof(struct ea_refcount_el) * num);
> -	}
> -	refcount->count++;
> -	el =3D &refcount->list[pos];
> -	el->ea_key =3D ea_key;
> -	el->ea_value =3D 0;
> -	return el;
> }
>=20
> -
> /*
>  * get_refcount_el() --- given an block number, try to find refcount
> - * 	information in the sorted list.  If the create flag is set,
> - * 	and we can't find an entry, create one in the sorted list.
> + * 	information in the rb-tree.  If the create flag is set,
> + * 	and we can't find an entry, create and add it to rb-tree.
>  */
> static struct ea_refcount_el *get_refcount_el(ext2_refcount_t =
refcount,
> 					      ea_key_t ea_key, int =
create)
> {
> -	int	low, high, mid;
> +	struct rb_node		**node;
> +	struct rb_node		*parent =3D NULL;
> +	struct ea_refcount_el	*el;
> +	errcode_t		retval;
>=20
> -	if (!refcount || !refcount->list)
> -		return 0;
> -retry:
> -	low =3D 0;
> -	high =3D (int) refcount->count-1;
> -	if (create && ((refcount->count =3D=3D 0) ||
> -		       (ea_key > refcount->list[high].ea_key))) {
> -		if (refcount->count >=3D refcount->size)
> -			refcount_collapse(refcount);
> -
> -		return insert_refcount_el(refcount, ea_key,
> -					  (unsigned) refcount->count);
> -	}
> -	if (refcount->count =3D=3D 0)
> +	if (!refcount)
> 		return 0;
>=20
> -	if (refcount->cursor >=3D refcount->count)
> -		refcount->cursor =3D 0;
> -	if (ea_key =3D=3D refcount->list[refcount->cursor].ea_key)
> -		return &refcount->list[refcount->cursor++];
> -#ifdef DEBUG
> -	printf("Non-cursor get_refcount_el: %u\n", ea_key);
> -#endif
> -	while (low <=3D high) {
> -		mid =3D (low+high)/2;
> -		if (ea_key =3D=3D refcount->list[mid].ea_key) {
> -			refcount->cursor =3D mid+1;
> -			return &refcount->list[mid];
> -		}
> -		if (ea_key < refcount->list[mid].ea_key)
> -			high =3D mid-1;
> +	node =3D &refcount->root.rb_node;
> +	while (*node) {
> +		el =3D ext2fs_rb_entry(*node, struct ea_refcount_el, =
node);
> +
> +		parent =3D *node;
> +		if (ea_key < el->ea_key)
> +			node =3D &(*node)->rb_left;
> +		else if (ea_key > el->ea_key)
> +			node =3D &(*node)->rb_right;
> 		else
> -			low =3D mid+1;
> -	}
> -	/*
> -	 * If we need to create a new entry, it should be right at
> -	 * low (where high will be left at low-1).
> -	 */
> -	if (create) {
> -		if (refcount->count >=3D refcount->size) {
> -			refcount_collapse(refcount);
> -			if (refcount->count < refcount->size)
> -				goto retry;
> -		}
> -		return insert_refcount_el(refcount, ea_key, low);
> +			return el;
> 	}
> -	return 0;
> +
> +	if (!create)
> +		return 0;
> +
> +	retval =3D ext2fs_get_memzero(sizeof(struct ea_refcount_el), =
&el);
> +	if (retval)
> +		return 0;
> +
> +	el->ea_key =3D ea_key;
> +	el->ea_value =3D 0;
> +	ext2fs_rb_link_node(&el->node, parent, node);
> +	ext2fs_rb_insert_color(&el->node, &refcount->root);
> +
> +	return el;
> }
>=20
> errcode_t ea_refcount_fetch(ext2_refcount_t refcount, ea_key_t ea_key,
> @@ -240,13 +147,18 @@ errcode_t ea_refcount_decrement(ext2_refcount_t =
refcount, ea_key_t ea_key,
> 	struct ea_refcount_el	*el;
>=20
> 	el =3D get_refcount_el(refcount, ea_key, 0);
> -	if (!el || el->ea_value =3D=3D 0)
> +	if (!el)
> 		return EXT2_ET_INVALID_ARGUMENT;
>=20
> 	el->ea_value--;
>=20
> 	if (ret)
> 		*ret =3D el->ea_value;
> +
> +	if (el->ea_value =3D=3D 0) {
> +		ext2fs_rb_erase(&el->node, &refcount->root);
> +		ext2fs_free_mem(&el);
> +	}
> 	return 0;
> }
>=20
> @@ -262,17 +174,13 @@ errcode_t ea_refcount_store(ext2_refcount_t =
refcount, ea_key_t ea_key,
> 	if (!el)
> 		return ea_value ? EXT2_ET_NO_MEMORY : 0;
> 	el->ea_value =3D ea_value;
> +	if (el->ea_value =3D=3D 0) {
> +		ext2fs_rb_erase(&el->node, &refcount->root);
> +		ext2fs_free_mem(&el);
> +	}
> 	return 0;
> }
>=20
> -size_t ext2fs_get_refcount_size(ext2_refcount_t refcount)
> -{
> -	if (!refcount)
> -		return 0;
> -
> -	return refcount->size;
> -}
> -
> void ea_refcount_intr_begin(ext2_refcount_t refcount)
> {
> 	refcount->cursor =3D 0;
> @@ -281,19 +189,23 @@ void ea_refcount_intr_begin(ext2_refcount_t =
refcount)
> ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
> 				ea_value_t *ret)
> {
> -	struct ea_refcount_el	*list;
> -
> -	while (1) {
> -		if (refcount->cursor >=3D refcount->count)
> -			return 0;
> -		list =3D refcount->list;
> -		if (list[refcount->cursor].ea_value) {
> -			if (ret)
> -				*ret =3D =
list[refcount->cursor].ea_value;
> -			return list[refcount->cursor++].ea_key;
> -		}
> -		refcount->cursor++;
> +	struct ea_refcount_el	*el;
> +	struct rb_node		*node =3D refcount->cursor;
> +
> +	if (node =3D=3D NULL)
> +		node =3D ext2fs_rb_first(&refcount->root);
> +	else
> +		node =3D ext2fs_rb_next(node);
> +
> +	if (node) {
> +		refcount->cursor =3D node;
> +		el =3D ext2fs_rb_entry(node, struct ea_refcount_el, =
node);
> +		if (ret)
> +			*ret =3D el->ea_value;
> +		return el->ea_key;
> 	}
> +
> +	return 0;
> }
>=20
>=20
> @@ -301,26 +213,28 @@ ea_key_t ea_refcount_intr_next(ext2_refcount_t =
refcount,
>=20
> errcode_t ea_refcount_validate(ext2_refcount_t refcount, FILE *out)
> {
> -	errcode_t	ret =3D 0;
> -	int		i;
> +	struct ea_refcount_el	*el;
> +	struct rb_node		*node;
> +	ea_key_t		prev;
> +	int			prev_valid =3D 0;
> 	const char *bad =3D "bad refcount";
>=20
> -	if (refcount->count > refcount->size) {
> -		fprintf(out, "%s: count > size\n", bad);
> -		return EXT2_ET_INVALID_ARGUMENT;
> -	}
> -	for (i=3D1; i < refcount->count; i++) {
> -		if (refcount->list[i-1].ea_key >=3D =
refcount->list[i].ea_key) {
> +	for (node =3D ext2fs_rb_first(&refcount->root); node !=3D NULL;
> +	     node =3D ext2fs_rb_next(node)) {
> +		el =3D ext2fs_rb_entry(node, struct ea_refcount_el, =
node);
> +		if (prev_valid && prev >=3D el->ea_key) {
> 			fprintf(out,
> -				"%s: list[%d].ea_key=3D%llu, =
list[%d].ea_key=3D%llu\n",
> -				bad, i-1,
> -				(unsigned long long) =
refcount->list[i-1].ea_key,
> -				i,
> -				(unsigned long long) =
refcount->list[i].ea_key);
> -			ret =3D EXT2_ET_INVALID_ARGUMENT;
> +				"%s: prev.ea_key=3D%llu, =
curr.ea_key=3D%llu\n",
> +				bad,
> +				(unsigned long long) prev,
> +				(unsigned long long) el->ea_key);
> +			return EXT2_ET_INVALID_ARGUMENT;
> 		}
> +		prev =3D el->ea_key;
> +		prev_valid =3D 1;
> 	}
> -	return ret;
> +
> +	return 0;
> }
>=20
> #define BCODE_END	0
> @@ -332,10 +246,9 @@ errcode_t ea_refcount_validate(ext2_refcount_t =
refcount, FILE *out)
> #define BCODE_FETCH	6
> #define BCODE_VALIDATE	7
> #define BCODE_LIST	8
> -#define BCODE_COLLAPSE 9
>=20
> int bcode_program[] =3D {
> -	BCODE_CREATE, 5,
> +	BCODE_CREATE,
> 	BCODE_STORE, 3, 3,
> 	BCODE_STORE, 4, 4,
> 	BCODE_STORE, 1, 1,
> @@ -362,7 +275,6 @@ int bcode_program[] =3D {
> 	BCODE_FETCH, 30,
> 	BCODE_DECR, 2,
> 	BCODE_DECR, 2,
> -	BCODE_COLLAPSE,
> 	BCODE_LIST,
> 	BCODE_VALIDATE,
> 	BCODE_FREE,
> @@ -373,7 +285,6 @@ int main(int argc, char **argv)
> {
> 	int	i =3D 0;
> 	ext2_refcount_t refcount;
> -	size_t		size;
> 	ea_key_t	ea_key;
> 	ea_value_t	arg;
> 	errcode_t	retval;
> @@ -383,15 +294,13 @@ int main(int argc, char **argv)
> 		case BCODE_END:
> 			exit(0);
> 		case BCODE_CREATE:
> -			size =3D bcode_program[i++];
> -			retval =3D ea_refcount_create(size, &refcount);
> +			retval =3D ea_refcount_create(&refcount);
> 			if (retval) {
> 				com_err("ea_refcount_create", retval,
> -					"while creating size %zu", =
size);
> +					"while creating refcount");
> 				exit(1);
> 			} else
> -				printf("Creating refcount with size =
%zu\n",
> -				       size);
> +				printf("Creating refcount\n");
> 			break;
> 		case BCODE_FREE:
> 			ea_refcount_free(refcount);
> @@ -465,9 +374,6 @@ int main(int argc, char **argv)
> 				       (unsigned long long) arg);
> 			}
> 			break;
> -		case BCODE_COLLAPSE:
> -			refcount_collapse(refcount);
> -			break;
> 		}
>=20
> 	}
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index a341c72ac..27364cd73 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -398,8 +398,7 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct =
problem_context *pctx,
> 		if (!entry->e_value_inum)
> 			goto next;
> 		if (!ctx->ea_inode_refs) {
> -			pctx->errcode =3D ea_refcount_create(0,
> -							   =
&ctx->ea_inode_refs);
> +			pctx->errcode =3D =
ea_refcount_create(&ctx->ea_inode_refs);
> 			if (pctx->errcode) {
> 				pctx->num =3D 4;
> 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, =
pctx);
> @@ -2475,7 +2474,7 @@ static int check_ext_attr(e2fsck_t ctx, struct =
problem_context *pctx,
>=20
> 	/* Create the EA refcount structure if necessary */
> 	if (!ctx->refcount) {
> -		pctx->errcode =3D ea_refcount_create(0, &ctx->refcount);
> +		pctx->errcode =3D ea_refcount_create(&ctx->refcount);
> 		if (pctx->errcode) {
> 			pctx->num =3D 1;
> 			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
> @@ -2509,8 +2508,7 @@ static int check_ext_attr(e2fsck_t ctx, struct =
problem_context *pctx,
> 			return 1;
> 		/* Ooops, this EA was referenced more than it stated */
> 		if (!ctx->refcount_extra) {
> -			pctx->errcode =3D ea_refcount_create(0,
> -					   &ctx->refcount_extra);
> +			pctx->errcode =3D =
ea_refcount_create(&ctx->refcount_extra);
> 			if (pctx->errcode) {
> 				pctx->num =3D 2;
> 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, =
pctx);
> @@ -2651,8 +2649,7 @@ static int check_ext_attr(e2fsck_t ctx, struct =
problem_context *pctx,
>=20
> 	if (quota_blocks !=3D EXT2FS_C2B(fs, 1U)) {
> 		if (!ctx->ea_block_quota_blocks) {
> -			pctx->errcode =3D ea_refcount_create(0,
> -						=
&ctx->ea_block_quota_blocks);
> +			pctx->errcode =3D =
ea_refcount_create(&ctx->ea_block_quota_blocks);
> 			if (pctx->errcode) {
> 				pctx->num =3D 3;
> 				goto refcount_fail;
> @@ -2664,8 +2661,7 @@ static int check_ext_attr(e2fsck_t ctx, struct =
problem_context *pctx,
>=20
> 	if (quota_inodes) {
> 		if (!ctx->ea_block_quota_inodes) {
> -			pctx->errcode =3D ea_refcount_create(0,
> -						=
&ctx->ea_block_quota_inodes);
> +			pctx->errcode =3D =
ea_refcount_create(&ctx->ea_block_quota_inodes);
> 			if (pctx->errcode) {
> 				pctx->num =3D 4;
> refcount_fail:
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_4DB91FD0-FE3F-4B88-9214-53CE2D5FF6A8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTKBAoACgkQcqXauRfM
H+C1zg/+K3KHjscn8KtAY2iSiht+A1gAXVrbJGiLJ7tGTFZPPDjFLfXELFGPOz3V
5gtH0FKj5EujNQ9Yi+s4njlnzoVgR7aMq1B6HCl05nS2JMNn+S6gov+8iB3ZCvZE
9OZBOixNlNjqj8t5wFP2SWL1YU633UQgzLSJZDI3jVJvZFRv2HQYRiOzHv1JvJV3
XaXDchLWXqsYhIK2CuUxPwzkMeWoKM30I5HtwkaCsZFv8WMJFENKyVbppEZ59h/X
PYPurI5s4HZUS5CWtbkeW+VOoyLhDcOi34bS8aEkuq//BkBDKnt22KR7E8o/07cH
+t4GCqxZ9Sy90LBD7fWmVhLXLzFm9VrfcarkuC+ZeNapgraKMbj7GkCth1LeZAga
0ucscXgPogl4ivUCVEZKxjSpayCPTBKeK8RtQyFZMMJo31FxNPmumu4uoDM19IDX
gn0dIvSMBOfd/OFtqrzCQaYRJNju8aCNR0S8EXlY/N4FoShKQSfSixgVQP3GI2ch
konybx96k35l0Q6/fo5lQMomYGhYsmDmPdgWkAk8gLiy/Lkf/UPH/KQsV1mHBom0
jf0mnF+sCFErvAgAc8FP9DpEW2sq4rFUzFRvTZ4Szf7D4z1mYAIObsHiSXb75Ey6
leQ+ZAOq6tF98DACgTNMKsN/P+VKkFc+co6g9FX5Q9hCQyEse2c=
=kzfC
-----END PGP SIGNATURE-----

--Apple-Mail=_4DB91FD0-FE3F-4B88-9214-53CE2D5FF6A8--
