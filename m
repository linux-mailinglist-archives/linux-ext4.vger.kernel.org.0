Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF524528E
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Aug 2020 23:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHOVxD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Aug 2020 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgHOVwo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 15 Aug 2020 17:52:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01BC061786
        for <linux-ext4@vger.kernel.org>; Sat, 15 Aug 2020 14:52:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so6198219pgl.3
        for <linux-ext4@vger.kernel.org>; Sat, 15 Aug 2020 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fPxUMJMALXMpIOE9Xk0lijWbZi3c3rMOF9LmjUdFZgM=;
        b=fpqT6t3AGzOTN1JZGEn9Rjx1qqTkVy1BdpH6pwRkIRFVinq2k+at+oTyMhJoWxkVux
         sDkxdjh3vGunpQqpbWjmqzWzWEviEZoC8K3pfz5zvLj1QlXOlvLVUb4jaQn9XtP3qyWN
         OhufxFQMBoKxfaJwVkiGaY0BHT5d4eK+tFz+cSPAF+55Hxq9Pa7mvFezAgLfCoeJYKaT
         BKk4DtsS5o+P4sdSzQY9l4jf3O8uRmg4fI45jtV4ye1PyObP+IYYoZf+WMFitpBku1v6
         ncVjNfhBwxt26WFbUwHCncIDoQPOGO97S4ewOf28sCajHNPfLIZqiMJ8RRo1fFX0AR3T
         WRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fPxUMJMALXMpIOE9Xk0lijWbZi3c3rMOF9LmjUdFZgM=;
        b=kT9BSmnYKgtaWmAqpOOFmma3C2njPOgFe5f+AV0gZv3cSx6YvC679jU8dvCKPSDzsj
         tEsdzh0rREFqQetsL2gCSn9KusKtRKi9RwHHXRcnJiUaxYYteC+TpDz5AK4es6fNbjQf
         VbZFLCOsnRpyKaIU/PF9a+HOqxFb3bQbikHYE0IhdF40RRjJY2kITma69csKjpGxetFa
         Mg2DmEKexQ5LIrMiT8ggZkUydibzyE/yhdJX/xDLzw/x5wI7ABWiBlEi411MWzn0QGcw
         4+F3usmE/9d0khSdKvLLnqYv2OKQ0QXC86YEkHtFzpC5NkZVxFW8nzLYcMn+uUtFZB46
         m6JQ==
X-Gm-Message-State: AOAM531W6aHsNbsHAKgXE/BinwVMWwOOmTllSxs9AMSJUychloD+/8XE
        5fp0i8vUF6Q9yLnoE7F6b4NDapncj0A7H4xn
X-Google-Smtp-Source: ABdhPJwUYdPFkgI/+9r/ZFOI8za5x9onDGqZ0JGdXiTgo6t7dUnqkzsWBCX4sRL2RRDikXuVdtKIyQ==
X-Received: by 2002:a63:385a:: with SMTP id h26mr4915146pgn.238.1597528358649;
        Sat, 15 Aug 2020 14:52:38 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id p9sm12090918pjm.1.2020.08.15.14.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 14:52:37 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <50E63218-263D-40EB-97F2-4BBADE97A501@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_633F0657-28FA-4DC3-B398-901E13772EB3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 2/2] ext4: limit the length of per-inode prealloc list
Date:   Sat, 15 Aug 2020 15:52:48 -0600
In-Reply-To: <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
Cc:     brookxu <brookxu.cn@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
 <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_633F0657-28FA-4DC3-B398-901E13772EB3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 15, 2020, at 7:32 AM, Ritesh Harjani <riteshh@linux.ibm.com> =
wrote:
>=20
>=20
>=20
> On 8/7/20 2:14 PM, brookxu wrote:
>> In the scenario of writing sparse files, the Per-inode prealloc list =
may
>> be very long, resulting in high overhead for =
ext4_mb_use_preallocated().
>> To circumvent this problem, we limit the maximum length of per-inode
>> prealloc list to 512 and allow users to modify it.
>=20
> ok, so I looked at your algorithm again, below are few comments.
>=20
> @Andreas, please let me also know if you agree?
>=20
>=20
> 1. On every block allocation request in ext4_mb_new_blocks()
> you call for ext4_mb_trim_inode_pa() just to iterate over all the =
ei->prealloc_list to count the length of this list.
> This looks a costly and also since it uses the spin_lock()/unlock()
> (of pa->lock) for every pa in that list just to see if it's getting =
deleted.
> So if someone else in parallel is also allocating/freeing blocks from
> that pa, this could cause contention just to measure the length of =
list.
> I think maybe the better way would be to maintain an atomic counter
> instead of traversing the list every time. thoughts?

You are totally correct.  Definitely, walking the list to count how many
entries are present is very expensive and should be avoided.

> 2. In ext4_mb_release_context(), I think for LRU algo, we should be =
doing it like below. Thoughts?
>=20
> list_move(&pa->pa_inode_list, &ei->i_prealloc_list);

Right, the declaration for list_move() is:

/**
 * list_move - delete from one list and add as another's head
 * @list: the entry to move
 * @head: the head that will precede our entry
 */
static inline void list_move(struct list_head *list, struct list_head =
*head)
{
        __list_del_entry(list);
        list_add(list, head);
}

so the pa entry should be the first argument, and the inode list head =
second.

Ritesh, thanks for the thorough review.

Cheers, Andreas

> With your change I observe below behavior, and I think this is not
> intended right?
>=20
> <with your change i.e. list_move(&ei->i_prealloc_list, =
&pa->pa_inode_list)>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> #/run/perf# sudo perf script
>           a.out  5453 [000] 55399.979084: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde4008
>           a.out  5453 [000] 55405.213401: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde47e8
>           a.out  5453 [000] 55415.669280: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde4bd8
>           a.out  5453 [000] 55420.840979: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde43f8
>           a.out  5453 [000] 55420.841064: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde4bd8
>           a.out  5453 [000] 55420.841082: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde43f8
>           a.out  5453 [000] 55420.841280: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde4200
>           a.out  5453 [000] 55426.030955: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde43f8
>           a.out  5453 [000] 55426.031060: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde4200
>           a.out  5453 [000] 55426.031076: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde43f8
>           a.out  5453 [000] 55426.031334: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde49e0
>           a.out  5453 [000] 55431.279519: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff8889ebde43f8
>           a.out  5453 [000] 55431.279809: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde49e0
>           a.out  5453 [000] 55431.279831: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff8889ebde43f8
>=20
>=20
>=20
> <with list_move(&pa->pa_inode_list, &ei->i_prealloc_list)>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> root@qemu:/run/perf# sudo perf script
>           a.out  1646 [000]  1555.975990: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab008
>           a.out  1646 [000]  1563.509005: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab7e8
>           a.out  1646 [000]  1568.742938: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fabdd0
>           a.out  1646 [000]  1573.932029: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab5f0
>           a.out  1646 [000]  1573.932143: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fab7e8
>           a.out  1646 [000]  1573.932161: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fab008
>           a.out  1646 [000]  1579.289937: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab008
>           a.out  1646 [000]  1584.561934: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab9e0
>           a.out  1646 [000]  1584.562019: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fab5f0
>           a.out  1646 [000]  1584.562037: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fabdd0
>           a.out  1646 [000]  1589.822954: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fabdd0
>           a.out  1646 [000]  1595.006822: probe:ext4_mb_new_inode_pa: =
(ffffffff813c51c0) i_ino=3D0xe ac_pa=3D0xffff888977fab7e8
>           a.out  1646 [000]  1595.006880: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fab9e0
>           a.out  1646 [000]  1595.006892: =
probe:ext4_discard_preallocations_L99: (ffffffff813ce34b) i_ino=3D0xe =
pa=3D0xffff888977fab008
>=20
>=20
>=20
> -ritesh
>=20
>=20
>=20
>=20
>> After patching, we observed that the sys ratio of cpu has dropped, =
and
>> the system throughput has increased significantly. We created a =
process
>> to write the sparse file, and the running time of the process on the
>> fixed kernel was significantly reduced, as follows:
>> Running time on unfixed kernel=EF=BC=9A
>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>> real    0m2.051s
>> user    0m0.008s
>> sys     0m2.026s
>> Running time on fixed kernel=EF=BC=9A
>> [root@TENCENT64 ~]# time taskset 0x01 ./sparse /data1/sparce.dat
>> real    0m0.471s
>> user    0m0.004s
>> sys     0m0.395s
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>  fs/ext4/ext4.h              |  3 ++-
>>  fs/ext4/extents.c           | 10 ++++----
>>  fs/ext4/file.c              |  2 +-
>>  fs/ext4/indirect.c          |  2 +-
>>  fs/ext4/inode.c             |  6 ++---
>>  fs/ext4/ioctl.c             |  2 +-
>>  fs/ext4/mballoc.c           | 57 =
+++++++++++++++++++++++++++++++++++++++++----
>>  fs/ext4/mballoc.h           |  4 ++++
>>  fs/ext4/move_extent.c       |  4 ++--
>>  fs/ext4/super.c             |  2 +-
>>  fs/ext4/sysfs.c             |  2 ++
>>  include/trace/events/ext4.h | 14 ++++++-----
>>  12 files changed, 83 insertions(+), 25 deletions(-)
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 42f5060..68e0ebe 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1501,6 +1501,7 @@ struct ext4_sb_info {
>>  	unsigned int s_mb_stats;
>>  	unsigned int s_mb_order2_reqs;
>>  	unsigned int s_mb_group_prealloc;
>> +	unsigned int s_mb_max_inode_prealloc;
>>  	unsigned int s_max_dir_size_kb;
>>  	/* where last allocation was done - for stream allocation */
>>  	unsigned long s_mb_last_group;
>> @@ -2651,7 +2652,7 @@ extern int ext4_init_inode_table(struct =
super_block *sb,
>>  extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>>  				struct ext4_allocation_request *, int =
*);
>>  extern int ext4_mb_reserve_blocks(struct super_block *, int);
>> -extern void ext4_discard_preallocations(struct inode *);
>> +extern void ext4_discard_preallocations(struct inode *, unsigned =
int);
>>  extern int __init ext4_init_mballoc(void);
>>  extern void ext4_exit_mballoc(void);
>>  extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 221f240..a40f928 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode =
*inode, int *dropped)
>>  	 * i_mutex. So we can safely drop the i_data_sem here.
>>  	 */
>>  	BUG_ON(EXT4_JOURNAL(inode) =3D=3D NULL);
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>  	up_write(&EXT4_I(inode)->i_data_sem);
>>  	*dropped =3D 1;
>>  	return 0;
>> @@ -4272,7 +4272,7 @@ int ext4_ext_map_blocks(handle_t *handle, =
struct inode *inode,
>>  			 * not a good idea to call discard here =
directly,
>>  			 * but otherwise we'd need to call it every =
free().
>>  			 */
>> -			ext4_discard_preallocations(inode);
>> +			ext4_discard_preallocations(inode, 0);
>>  			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>>  				fb_flags =3D =
EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>>  			ext4_free_blocks(handle, inode, NULL, newblock,
>> @@ -5299,7 +5299,7 @@ static int ext4_collapse_range(struct inode =
*inode, loff_t offset, loff_t len)
>>  	}
>>    	down_write(&EXT4_I(inode)->i_data_sem);
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>    	ret =3D ext4_es_remove_extent(inode, punch_start,
>>  				    EXT_MAX_BLOCKS - punch_start);
>> @@ -5313,7 +5313,7 @@ static int ext4_collapse_range(struct inode =
*inode, loff_t offset, loff_t len)
>>  		up_write(&EXT4_I(inode)->i_data_sem);
>>  		goto out_stop;
>>  	}
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>    	ret =3D ext4_ext_shift_extents(inode, handle, punch_stop,
>>  				     punch_stop - punch_start, =
SHIFT_LEFT);
>> @@ -5445,7 +5445,7 @@ static int ext4_insert_range(struct inode =
*inode, loff_t offset, loff_t len)
>>  		goto out_stop;
>>    	down_write(&EXT4_I(inode)->i_data_sem);
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>    	path =3D ext4_find_extent(inode, offset_lblk, NULL, 0);
>>  	if (IS_ERR(path)) {
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 2a01e31..e3ab8ea 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -148,7 +148,7 @@ static int ext4_release_file(struct inode *inode, =
struct file *filp)
>>  		        !EXT4_I(inode)->i_reserved_data_blocks)
>>  	{
>>  		down_write(&EXT4_I(inode)->i_data_sem);
>> -		ext4_discard_preallocations(inode);
>> +		ext4_discard_preallocations(inode, 0);
>>  		up_write(&EXT4_I(inode)->i_data_sem);
>>  	}
>>  	if (is_dx(inode) && filp->private_data)
>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>> index be2b66e..ec6b930 100644
>> --- a/fs/ext4/indirect.c
>> +++ b/fs/ext4/indirect.c
>> @@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t =
*handle, struct inode *inode,
>>  	 * i_mutex. So we can safely drop the i_data_sem here.
>>  	 */
>>  	BUG_ON(EXT4_JOURNAL(inode) =3D=3D NULL);
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>  	up_write(&EXT4_I(inode)->i_data_sem);
>>  	*dropped =3D 1;
>>  	return 0;
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 10dd470..bb9e1cd 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -383,7 +383,7 @@ void ext4_da_update_reserve_space(struct inode =
*inode,
>>  	 */
>>  	if ((ei->i_reserved_data_blocks =3D=3D 0) &&
>>  	    !inode_is_open_for_write(inode))
>> -		ext4_discard_preallocations(inode);
>> +		ext4_discard_preallocations(inode, 0);
>>  }
>>    static int __check_block_validity(struct inode *inode, const char =
*func,
>> @@ -4056,7 +4056,7 @@ int ext4_punch_hole(struct inode *inode, loff_t =
offset, loff_t length)
>>  	if (stop_block > first_block) {
>>    		down_write(&EXT4_I(inode)->i_data_sem);
>> -		ext4_discard_preallocations(inode);
>> +		ext4_discard_preallocations(inode, 0);
>>    		ret =3D ext4_es_remove_extent(inode, first_block,
>>  					    stop_block - first_block);
>> @@ -4211,7 +4211,7 @@ int ext4_truncate(struct inode *inode)
>>    	down_write(&EXT4_I(inode)->i_data_sem);
>>  -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>    	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>  		err =3D ext4_ext_truncate(handle, inode);
>> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
>> index 999cf6a..a5fcc23 100644
>> --- a/fs/ext4/ioctl.c
>> +++ b/fs/ext4/ioctl.c
>> @@ -202,7 +202,7 @@ static long swap_inode_boot_loader(struct =
super_block *sb,
>>  	reset_inode_seed(inode);
>>  	reset_inode_seed(inode_bl);
>>  -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>    	err =3D ext4_mark_inode_dirty(handle, inode);
>>  	if (err < 0) {
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 4f21f34..28a139f 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2736,6 +2736,7 @@ int ext4_mb_init(struct super_block *sb)
>>  	sbi->s_mb_stats =3D MB_DEFAULT_STATS;
>>  	sbi->s_mb_stream_request =3D MB_DEFAULT_STREAM_THRESHOLD;
>>  	sbi->s_mb_order2_reqs =3D MB_DEFAULT_ORDER2_REQS;
>> +	sbi->s_mb_max_inode_prealloc =3D MB_DEFAULT_MAX_INODE_PREALLOC;
>>  	/*
>>  	 * The default group preallocation is 512, which for 4k block
>>  	 * sizes translates to 2 megabytes.  However for bigalloc file
>> @@ -4103,7 +4104,7 @@ static void ext4_mb_new_preallocation(struct =
ext4_allocation_context *ac)
>>   *
>>   * FIXME!! Make sure it is valid at all the call sites
>>   */
>> -void ext4_discard_preallocations(struct inode *inode)
>> +void ext4_discard_preallocations(struct inode *inode, unsigned int =
needed)
>>  {
>>  	struct ext4_inode_info *ei =3D EXT4_I(inode);
>>  	struct super_block *sb =3D inode->i_sb;
>> @@ -4121,15 +4122,18 @@ void ext4_discard_preallocations(struct inode =
*inode)
>>    	mb_debug(sb, "discard preallocation for inode %lu\n",
>>  		 inode->i_ino);
>> -	trace_ext4_discard_preallocations(inode);
>> +	trace_ext4_discard_preallocations(inode,  needed);
>>    	INIT_LIST_HEAD(&list);
>>  +	if (needed =3D=3D 0)
>> +		needed =3D UINT_MAX;
>> +
>>  repeat:
>>  	/* first, collect all pa's in the inode */
>>  	spin_lock(&ei->i_prealloc_lock);
>> -	while (!list_empty(&ei->i_prealloc_list)) {
>> -		pa =3D list_entry(ei->i_prealloc_list.next,
>> +	while (!list_empty(&ei->i_prealloc_list) && needed) {
>> +		pa =3D list_entry(ei->i_prealloc_list.prev,
>>  				struct ext4_prealloc_space, =
pa_inode_list);
>>  		BUG_ON(pa->pa_obj_lock !=3D &ei->i_prealloc_lock);
>>  		spin_lock(&pa->pa_lock);
>> @@ -4150,6 +4154,7 @@ void ext4_discard_preallocations(struct inode =
*inode)
>>  			spin_unlock(&pa->pa_lock);
>>  			list_del_rcu(&pa->pa_inode_list);
>>  			list_add(&pa->u.pa_tmp_list, &list);
>> +			needed--;
>>  			continue;
>>  		}
>>  @@ -4549,10 +4554,42 @@ static void ext4_mb_add_n_trim(struct =
ext4_allocation_context *ac)
>>  }
>>    /*
>> + * if per-inode prealloc list is too long, trim some PA
>> + */
>> +static void
>> +ext4_mb_trim_inode_pa(struct inode *inode)
>> +{
>> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
>> +	struct ext4_sb_info *sbi =3D EXT4_SB(inode->i_sb);
>> +	struct ext4_prealloc_space *pa;
>> +	int count =3D 0, delta;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(pa, &ei->i_prealloc_list, pa_inode_list) =
{
>> +		spin_lock(&pa->pa_lock);
>> +		if (pa->pa_deleted) {
>> +			spin_unlock(&pa->pa_lock);
>> +			continue;
>> +		}
>> +		count++;
>> +		spin_unlock(&pa->pa_lock);
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	delta =3D (sbi->s_mb_max_inode_prealloc >> 2) + 1;
>> +	if (count > sbi->s_mb_max_inode_prealloc + delta) {
>> +		count -=3D sbi->s_mb_max_inode_prealloc;
>> +		ext4_discard_preallocations(inode, count);
>> +	}
>> +}
>> +
>> +/*
>>   * release all resource we used in allocation
>>   */
>>  static int ext4_mb_release_context(struct ext4_allocation_context =
*ac)
>>  {
>> +	struct inode *inode =3D ac->ac_inode;
>> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
>>  	struct ext4_sb_info *sbi =3D EXT4_SB(ac->ac_sb);
>>  	struct ext4_prealloc_space *pa =3D ac->ac_pa;
>>  	if (pa) {
>> @@ -4578,6 +4615,17 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
>>  				ext4_mb_add_n_trim(ac);
>>  			}
>>  		}
>> +
>> +		if (pa->pa_type =3D=3D MB_INODE_PA) {
>> +			/*
>> +			 * treat per-inode prealloc list as a lru list, =
then try
>> +			 * to trim the least recently used PA.
>> +			 */
>> +			spin_lock(pa->pa_obj_lock);
>> +			list_move(&ei->i_prealloc_list, =
&pa->pa_inode_list);
>> +			spin_unlock(pa->pa_obj_lock);
>> +		}
>> +
>>  		ext4_mb_put_pa(ac, ac->ac_sb, pa);
>>  	}
>>  	if (ac->ac_bitmap_page)
>> @@ -4587,6 +4635,7 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
>>  	if (ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC)
>>  		mutex_unlock(&ac->ac_lg->lg_mutex);
>>  	ext4_mb_collect_stats(ac);
>> +	ext4_mb_trim_inode_pa(inode);
>>  	return 0;
>>  }
>>  diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index 6b4d17c..e75b474 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -73,6 +73,10 @@
>>   */
>>  #define MB_DEFAULT_GROUP_PREALLOC	512
>>  +/*
>> + * maximum length of inode prealloc list
>> + */
>> +#define MB_DEFAULT_MAX_INODE_PREALLOC	512
>>    struct ext4_free_data {
>>  	/* this links the free block information from sb_info */
>> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
>> index 1ed86fb..0d601b8 100644
>> --- a/fs/ext4/move_extent.c
>> +++ b/fs/ext4/move_extent.c
>> @@ -686,8 +686,8 @@
>>    out:
>>  	if (*moved_len) {
>> -		ext4_discard_preallocations(orig_inode);
>> -		ext4_discard_preallocations(donor_inode);
>> +		ext4_discard_preallocations(orig_inode, 0);
>> +		ext4_discard_preallocations(donor_inode, 0);
>>  	}
>>    	ext4_ext_drop_refs(path);
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 330957e..8ce61f3 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1216,7 +1216,7 @@ void ext4_clear_inode(struct inode *inode)
>>  {
>>  	invalidate_inode_buffers(inode);
>>  	clear_inode(inode);
>> -	ext4_discard_preallocations(inode);
>> +	ext4_discard_preallocations(inode, 0);
>>  	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>>  	dquot_drop(inode);
>>  	if (EXT4_I(inode)->jinode) {
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index 6c9fc9e..92f04e9 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -215,6 +215,7 @@ static ssize_t journal_task_show(struct =
ext4_sb_info *sbi, char *buf)
>>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
>>  EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
>> +EXT4_RW_ATTR_SBI_UI(mb_max_inode_prealloc, s_mb_max_inode_prealloc);
>>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
>>  EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, =
s_err_ratelimit_state.interval);
>> @@ -257,6 +258,7 @@ static ssize_t journal_task_show(struct =
ext4_sb_info *sbi, char *buf)
>>  	ATTR_LIST(mb_order2_req),
>>  	ATTR_LIST(mb_stream_req),
>>  	ATTR_LIST(mb_group_prealloc),
>> +	ATTR_LIST(mb_max_inode_prealloc),
>>  	ATTR_LIST(max_writeback_mb_bump),
>>  	ATTR_LIST(extent_max_zeroout_kb),
>>  	ATTR_LIST(trigger_fs_error),
>> diff --git a/include/trace/events/ext4.h =
b/include/trace/events/ext4.h
>> index cc41d69..61736d8 100644
>> --- a/include/trace/events/ext4.h
>> +++ b/include/trace/events/ext4.h
>> @@ -746,24 +746,26 @@
>>  );
>>    TRACE_EVENT(ext4_discard_preallocations,
>> -	TP_PROTO(struct inode *inode),
>> +	TP_PROTO(struct inode *inode, unsigned int needed),
>>  -	TP_ARGS(inode),
>> +	TP_ARGS(inode, needed),
>>    	TP_STRUCT__entry(
>> -		__field(	dev_t,	dev			)
>> -		__field(	ino_t,	ino			)
>> +		__field(	dev_t,		dev		)
>> +		__field(	ino_t,		ino		)
>> +		__field(	unsigned int,	needed		)
>>    	),
>>    	TP_fast_assign(
>>  		__entry->dev	=3D inode->i_sb->s_dev;
>>  		__entry->ino	=3D inode->i_ino;
>> +		__entry->needed	=3D needed;
>>  	),
>>  -	TP_printk("dev %d,%d ino %lu",
>> +	TP_printk("dev %d,%d ino %lu needed %u",
>>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> -		  (unsigned long) __entry->ino)
>> +		  (unsigned long) __entry->ino, __entry->needed)
>>  );
>>    TRACE_EVENT(ext4_mb_discard_preallocations,


Cheers, Andreas






--Apple-Mail=_633F0657-28FA-4DC3-B398-901E13772EB3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl84WTAACgkQcqXauRfM
H+CTSw/+J4zQj8bJ97V79Y+jwA1CnXgt2hZBPkuPbpLrObZedpVQC7x0oVAx9FSb
Hc1t4pJqvd2P+zRaYMeMbeKfOJfn6VA/Hc8t7fsCNhI2uEZNyB04tf1ySnx0VC6G
+HkHt1iEnM+HA7NJWlhCJ7oXSWnc3XV2pclyRXZUgd/h1q30xuCKCUDHVZLSjEBb
7BE5kHzbUWSD+0gV948SdMA7hRGZL+pXm+oMQ9nsGWKwak2VwG0LVYPoVqt0sBw2
/uEnLRNIRSDJUYYyLsi3sXVgoY7PrD9abqiNb6KvwwEch239J8coxTw0f3YnRHE6
c2d5HB9JFNiV20nvrBobQ017BLwAv5TcSFSc/j9aBodmqGzhLT0HrnJWPnc9KxcD
Mo13ol2KQAU2/7d01nru1BoMSN/rUy8pzde6v3Iu47+CcnYnmFcxZ2HfzdPkQ+PC
ju4ANNs6Gt4etHywGXzCu+uupRW7e8fFE4hxGWZPzAjASzG+bcbNGg/9RGZMHx4V
UebrlLkya5He0tCWQn0WYjWPFQtU19Z0mc2V4imM9KDaq5a+Oq7IZj97/yodecfw
qPM9ERq6f5B3R5QvR6uWYBqG3UOkAFIXX82t1mzsd60Wux9OXm7YWlHBfgunvnkQ
Pgrhjs56h8HzscP/OxIka8AZJ7vNcr+NHJoLKeOdYvRTHGEnzO0=
=bdfU
-----END PGP SIGNATURE-----

--Apple-Mail=_633F0657-28FA-4DC3-B398-901E13772EB3--
