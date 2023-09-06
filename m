Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0925A7932D5
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 02:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbjIFALa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjIFALa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 20:11:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCB6CC7
        for <linux-ext4@vger.kernel.org>; Tue,  5 Sep 2023 17:11:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so457819866b.2
        for <linux-ext4@vger.kernel.org>; Tue, 05 Sep 2023 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693959083; x=1694563883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOpkQuwHKNsJ+QFciur7/CDzGjaMLA2yXfKVYcYb5q8=;
        b=EPYENxXXJYckwT9hoFO5idyEd/XfqAjLfSF/eP9J/DaQs18l+0jJaJsYEszZLGHqlL
         QIBjSnIB3TaXzXPvidoBHCuWh71B+jCnthP+j3O3H9gYSLqhtRIvbrwujD0MKc5c1F9s
         hhARtf7BFJXyBfpsVsZw7yBtpWOMJZo1uFGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693959083; x=1694563883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOpkQuwHKNsJ+QFciur7/CDzGjaMLA2yXfKVYcYb5q8=;
        b=ZvtJHECSOYf/PBoERUTjSUOMlMioTRJInMv4BfSyw1xiAG74rVDx1+9QFikt2cSVfH
         4PXrdbilBqpYZ6Ub0dnDhfBJd446+A4/zB6OGTKQpFx04fx3YhV66ME9YUgFa9or+OZY
         HiFVLYmfvllWRd+siserCZmoQ+tHtt0t/42Soh6FZEqkGVL/xq9ULE6qdquXo3fd63+D
         M2oad3gTIVmqZa30Z6O6yJl3ez3LJBYPYsOgMdXNdv62WjhJIFHKp5hpFTC4HDp77EB2
         p7zRZWoLHXl6sgXbT+6vXO2AuD6ZLflY1m2VmtMwMr4o8TwbhEuOwJRJYv+A2n7tbTMp
         986Q==
X-Gm-Message-State: AOJu0Yy8AFalN14p52SWK4p+/5MhdFgDzCBYtWbBl4i9M3jpfUb6AlOm
        yqvZoj9d77qlg0nD7h9PXJDO0BT3uaV88abESLM5ZffnuSvIyUGd
X-Google-Smtp-Source: AGHT+IH4jYHxYCWzhkFBX16ZSdvrhaayYjELxa6ULzDEZiDjaLy403Vh0eQgeAp258BNVSqvq6j2gVP0a8t8rPdvN4o=
X-Received: by 2002:a17:907:2bf3:b0:9a1:af6f:e375 with SMTP id
 gv51-20020a1709072bf300b009a1af6fe375mr949444ejc.35.1693959083241; Tue, 05
 Sep 2023 17:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com> <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com> <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com> <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
In-Reply-To: <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Tue, 5 Sep 2023 17:11:12 -0700
Message-ID: <CAG9=OMPseMM32t32R2nHJqa7F+NLVUow7Ucn+yNdnrrNEFqNRg@mail.gmail.com>
Subject: Re: [PATCH V2 7/7] ext4: get discard out of jbd2 commit kthread contex
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I noticed a "regression" with this patch series on ChromiumOS: on a
ext4 filesystem (mounted with -o discard) on a thinly provisioned
block device (dm-thin/loopback on a sparse file), deletion of a large
file (O(10GB) or more) immediately followed by an unmount results in
the discards to the file's extents getting dropped with umount(). This
prevents space from getting reclaimed by the underlying
thin-provisioning layer (dm-thinpool/lower filesystem), even on
subsequent mounts of the filesystem (eg. after a reboot).

Currently, the only way to 'reclaim' this space into a thinpool is to
run fstrim on dm-thin filesystems on every mount: should the dropped
discard requests for newly freed blocks be requeued on subsequent
mounts of the filesystem?

Best
Sarthak

On Wed, May 26, 2021 at 1:44=E2=80=AFAM Wang Jianchao <jianchao.wan9@gmail.=
com> wrote:
>
> Right now, discard is issued and waited to be completed in jbd2
> commit kthread context after the logs are committed. When large
> amount of files are deleted and discard is flooding, jbd2 commit
> kthread can be blocked for long time. Then all of the metadata
> operations can be blocked to wait the log space.
>
> One case is the page fault path with read mm->mmap_sem held, which
> wants to update the file time but has to wait for the log space.
> When other threads in the task wants to do mmap, then write mmap_sem
> is blocked. Finally all of the following read mmap_sem requirements
> are blocked, even the ps command which need to read the /proc/pid/
> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
> used to be blocked for 5 mins.
>
> This patch frees the blocks back to buddy after commit and then do
> discard in a async kworker context in fstrim fashion, namely,
>  - mark blocks to be discarded as used if they have not been allocated
>  - do discard
>  - mark them free
> After this, jbd2 commit kthread won't be blocked any more by discard
> and we won't get NOSPC even if the discard is slow or throttled.
>
> Link: https://marc.info/?l=3Dlinux-kernel&m=3D162143690731901&w=3D2
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> ---
>  fs/ext4/ext4.h    |   2 +
>  fs/ext4/mballoc.c | 162 +++++++++++++++++++++++++++++++++---------------=
------
>  fs/ext4/mballoc.h |   3 -
>  3 files changed, 101 insertions(+), 66 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5c5c8e4..2e48c88 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1526,6 +1526,7 @@ struct ext4_sb_info {
>         unsigned int *s_mb_maxs;
>         unsigned int s_group_info_size;
>         atomic_t s_mb_free_pending;
> +       struct work_struct s_discard_work;
>
>         /* tunables */
>         unsigned long s_stripe;
> @@ -3306,6 +3307,7 @@ struct ext4_group_info {
>         unsigned long   bb_check_counter;
>  #endif
>         struct rb_root  bb_free_root;
> +       struct rb_root  bb_discard_root;
>         ext4_grpblk_t   bb_first_free;  /* first free block */
>         ext4_grpblk_t   bb_free;        /* total free blocks */
>         ext4_grpblk_t   bb_fragments;   /* nr of freespace fragments */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 15715e7..feea439 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -332,6 +332,7 @@
>  static struct kmem_cache *ext4_pspace_cachep;
>  static struct kmem_cache *ext4_ac_cachep;
>  static struct kmem_cache *ext4_free_data_cachep;
> +static struct workqueue_struct *ext4_discard_wq;
>
>  /* We create slab caches for groupinfo data structures based on the
>   * superblock block size.  There will be one per mounted filesystem for
> @@ -355,7 +356,10 @@ static inline struct ext4_free_data *efd_entry(struc=
t rb_node *n)
>         return rb_entry_safe(n, struct ext4_free_data, efd_node);
>  }
>  static int ext4_insert_free_data(struct rb_root *root, struct ext4_free_=
data *nfd);
> -
> +static int ext4_try_to_trim_range(struct super_block *sb,
> +               struct ext4_buddy *e4b, ext4_grpblk_t start,
> +               ext4_grpblk_t max, ext4_grpblk_t minblocks);
> +static void ext4_discard_work(struct work_struct *work);
>  /*
>   * The algorithm using this percpu seq counter goes below:
>   * 1. We sample the percpu discard_pa_seq counter before trying for bloc=
k
> @@ -2657,6 +2661,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, e=
xt4_group_t group,
>         INIT_LIST_HEAD(&meta_group_info[i]->bb_prealloc_list);
>         init_rwsem(&meta_group_info[i]->alloc_sem);
>         meta_group_info[i]->bb_free_root =3D RB_ROOT;
> +       meta_group_info[i]->bb_discard_root =3D RB_ROOT;
>         meta_group_info[i]->bb_largest_free_order =3D -1;  /* uninit */
>
>         mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
> @@ -2857,6 +2862,7 @@ int ext4_mb_init(struct super_block *sb)
>         spin_lock_init(&sbi->s_md_lock);
>         spin_lock_init(&sbi->s_bal_lock);
>         atomic_set(&sbi->s_mb_free_pending, 0);
> +       INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
>
>         sbi->s_mb_max_to_scan =3D MB_DEFAULT_MAX_TO_SCAN;
>         sbi->s_mb_min_to_scan =3D MB_DEFAULT_MIN_TO_SCAN;
> @@ -2949,6 +2955,15 @@ int ext4_mb_release(struct super_block *sb)
>         struct kmem_cache *cachep =3D get_groupinfo_cache(sb->s_blocksize=
_bits);
>         int count;
>
> +       if (test_opt(sb, DISCARD)) {
> +               /*
> +                * wait the discard work to drain all of ext4_free_data
> +                */
> +               queue_work(ext4_discard_wq, &sbi->s_discard_work);
> +               flush_work(&sbi->s_discard_work);
> +       }
> +
> +       queue_work(ext4_discard_wq, &sbi->s_discard_work);
>         if (sbi->s_group_info) {
>                 for (i =3D 0; i < ngroups; i++) {
>                         cond_resched();
> @@ -3024,30 +3039,77 @@ static inline int ext4_issue_discard(struct super=
_block *sb,
>                 return sb_issue_discard(sb, discard_block, count, GFP_NOF=
S, 0);
>  }
>
> -static void ext4_free_data_in_buddy(struct super_block *sb,
> -                                   struct ext4_free_data *entry)
> +static void ext4_discard_work(struct work_struct *work)
>  {
> +       struct ext4_sb_info *sbi =3D container_of(work,
> +                       struct ext4_sb_info, s_discard_work);
> +       struct super_block *sb =3D sbi->s_sb;
> +       ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> +       struct ext4_group_info *grp;
> +       struct ext4_free_data *fd, *nfd;
>         struct ext4_buddy e4b;
> -       struct ext4_group_info *db;
> -       int err, count =3D 0, count2 =3D 0;
> +       int i, err;
> +
> +       for (i =3D 0; i < ngroups; i++) {
> +               grp =3D ext4_get_group_info(sb, i);
> +               if (RB_EMPTY_ROOT(&grp->bb_discard_root))
> +                       continue;
>
> -       mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
> -                entry->efd_count, entry->efd_group, entry);
> +               err =3D ext4_mb_load_buddy(sb, i, &e4b);
> +               if (err) {
> +                       ext4_warning(sb, "Error %d loading buddy informat=
ion for %u",
> +                                       err, i);
> +                       continue;
> +               }
>
> -       err =3D ext4_mb_load_buddy(sb, entry->efd_group, &e4b);
> -       /* we expect to find existing buddy because it's pinned */
> -       BUG_ON(err !=3D 0);
> +               ext4_lock_group(sb, i);
> +               rbtree_postorder_for_each_entry_safe(fd, nfd,
> +                               &grp->bb_discard_root, efd_node) {
> +                       rb_erase(&fd->efd_node, &grp->bb_discard_root);
> +                       /*
> +                        * If filesystem is umounting, give up the discar=
d
> +                        */
> +                       if (sb->s_flags & SB_ACTIVE)
> +                               ext4_try_to_trim_range(sb, &e4b, fd->efd_=
start_cluster,
> +                                               fd->efd_start_cluster + f=
d->efd_count - 1, 1);
> +                       kmem_cache_free(ext4_free_data_cachep, fd);
> +               }
> +               ext4_unlock_group(sb, i);
> +               ext4_mb_unload_buddy(&e4b);
> +       }
> +}
>
> -       atomic_sub(entry->efd_count, &EXT4_SB(sb)->s_mb_free_pending);
> +static int ext4_free_data_in_buddy(struct super_block *sb,
> +               ext4_group_t group, tid_t commit_tid)
> +{
> +       struct ext4_buddy e4b;
> +       struct ext4_group_info *db;
> +       struct ext4_free_data *fd, *nfd;
> +       int cnt, nr_fd;
>
> +       /* we expect to find existing buddy because it's pinned */
> +       BUG_ON(ext4_mb_load_buddy(sb, group, &e4b));
>         db =3D e4b.bd_info;
> -       /* there are blocks to put in buddy to make them really free */
> -       count +=3D entry->efd_count;
> -       count2++;
> -       ext4_lock_group(sb, entry->efd_group);
> -       /* Take it out of per group rb tree */
> -       rb_erase(&entry->efd_node, &(db->bb_free_root));
> -       mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_c=
ount);
> +       cnt =3D 0;
> +       nr_fd =3D 0;
> +       ext4_lock_group(sb, group);
> +       rbtree_postorder_for_each_entry_safe(fd, nfd,
> +                       &db->bb_free_root, efd_node) {
> +               if (fd->efd_tid !=3D commit_tid)
> +                       continue;
> +
> +               mb_debug(sb, "gonna free %u blocks in group %u (0x%p):",
> +                        fd->efd_count, fd->efd_group, fd);
> +               atomic_sub(fd->efd_count, &EXT4_SB(sb)->s_mb_free_pending=
);
> +               cnt +=3D fd->efd_count;
> +               nr_fd++;
> +               rb_erase(&fd->efd_node, &db->bb_free_root);
> +               mb_free_blocks(NULL, &e4b, fd->efd_start_cluster, fd->efd=
_count);
> +               if (test_opt(sb, DISCARD))
> +                       ext4_insert_free_data(&db->bb_discard_root, fd);
> +               else
> +                       kmem_cache_free(ext4_free_data_cachep, fd);
> +       }
>
>         /*
>          * Clear the trimmed flag for the group so that the next
> @@ -3055,22 +3117,22 @@ static void ext4_free_data_in_buddy(struct super_=
block *sb,
>          * If the volume is mounted with -o discard, online discard
>          * is supported and the free blocks will be trimmed online.
>          */
> -       if (!test_opt(sb, DISCARD))
> +       if (!test_opt(sb, DISCARD) && cnt)
>                 EXT4_MB_GRP_CLEAR_TRIMMED(db);
>
> -       if (!db->bb_free_root.rb_node) {
> +       if (RB_EMPTY_ROOT(&db->bb_free_root) && cnt) {
>                 /* No more items in the per group rb tree
>                  * balance refcounts from ext4_mb_free_metadata()
>                  */
>                 put_page(e4b.bd_buddy_page);
>                 put_page(e4b.bd_bitmap_page);
>         }
> -       ext4_unlock_group(sb, entry->efd_group);
> -       kmem_cache_free(ext4_free_data_cachep, entry);
> +       ext4_unlock_group(sb, group);
>         ext4_mb_unload_buddy(&e4b);
>
> -       mb_debug(sb, "freed %d blocks in %d structures\n", count,
> -                count2);
> +       mb_debug(sb, "freed %d blocks in %d structures\n", cnt, nr_fd);
> +
> +       return nr_fd;
>  }
>
>  /*
> @@ -3081,52 +3143,21 @@ void ext4_process_freed_data(struct super_block *=
sb, tid_t commit_tid)
>  {
>         struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>         ext4_group_t ngroups =3D ext4_get_groups_count(sb);
> -       struct ext4_free_data *fd, *nfd;
>         struct ext4_group_info *grp;
> -       struct bio *discard_bio =3D NULL;
> -       struct list_head freed_data_list;
> -       int err, i;
> +       int i, nr;
>
>         if (!atomic_read(&sbi->s_mb_free_pending))
>                 return;
>
> -       INIT_LIST_HEAD(&freed_data_list);
> -       for (i =3D 0; i < ngroups; i++) {
> +       for (i =3D 0, nr =3D 0; i < ngroups; i++) {
>                 grp =3D ext4_get_group_info(sb, i);
> -               ext4_lock_group(sb, i);
> -               rbtree_postorder_for_each_entry_safe(fd, nfd,
> -                               &grp->bb_free_root, efd_node) {
> -                       if (fd->efd_tid !=3D commit_tid)
> -                               continue;
> -                       INIT_LIST_HEAD(&fd->efd_list);
> -                       list_add_tail(&fd->efd_list, &freed_data_list);
> -               }
> -               ext4_unlock_group(sb, i);
> -       }
> -
> -       if (test_opt(sb, DISCARD)) {
> -               list_for_each_entry(fd, &freed_data_list, efd_list) {
> -                       err =3D ext4_issue_discard(sb, fd->efd_group,
> -                                                fd->efd_start_cluster,
> -                                                fd->efd_count,
> -                                                &discard_bio);
> -                       if (err && err !=3D -EOPNOTSUPP) {
> -                               ext4_msg(sb, KERN_WARNING, "discard reque=
st in"
> -                                        " group:%d block:%d count:%d fai=
led"
> -                                        " with %d", fd->efd_group,
> -                                        fd->efd_start_cluster, fd->efd_c=
ount, err);
> -                       } else if (err =3D=3D -EOPNOTSUPP)
> -                               break;
> -               }
> -
> -               if (discard_bio) {
> -                       submit_bio_wait(discard_bio);
> -                       bio_put(discard_bio);
> -               }
> +               if (RB_EMPTY_ROOT(&grp->bb_free_root))
> +                       continue;
> +               nr +=3D ext4_free_data_in_buddy(sb, i, commit_tid);
>         }
>
> -       list_for_each_entry_safe(fd, nfd, &freed_data_list, efd_list)
> -               ext4_free_data_in_buddy(sb, fd);
> +       if (nr && test_opt(sb, DISCARD))
> +               queue_work(ext4_discard_wq, &sbi->s_discard_work);
>  }
>
>  int __init ext4_init_mballoc(void)
> @@ -3146,8 +3177,13 @@ int __init ext4_init_mballoc(void)
>         if (ext4_free_data_cachep =3D=3D NULL)
>                 goto out_ac_free;
>
> -       return 0;
> +       ext4_discard_wq =3D alloc_workqueue("ext4discard", WQ_UNBOUND, 0)=
;
> +       if (!ext4_discard_wq)
> +               goto out_free_data;
>
> +       return 0;
> +out_free_data:
> +       kmem_cache_destroy(ext4_free_data_cachep);
>  out_ac_free:
>         kmem_cache_destroy(ext4_ac_cachep);
>  out_pa_free:
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index e75b474..d76286b 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -79,9 +79,6 @@
>  #define MB_DEFAULT_MAX_INODE_PREALLOC  512
>
>  struct ext4_free_data {
> -       /* this links the free block information from sb_info */
> -       struct list_head                efd_list;
> -
>         /* this links the free block information from group_info */
>         struct rb_node                  efd_node;
>
> --
> 1.8.3.1
