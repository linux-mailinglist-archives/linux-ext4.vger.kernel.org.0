Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A36AE5A1
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjCGP60 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 10:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjCGP5v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 10:57:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0530C94754
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 07:56:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g3so54286519eda.1
        for <linux-ext4@vger.kernel.org>; Tue, 07 Mar 2023 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678204594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hf01G5AjyxZoBZL3gsdbHoFfhTX/K7xRHJCGj6YLdK8=;
        b=CCKq5CSuDEMbV3f82zH1ALfM8Cxvhs0RVe3vuuz0f1DwwNeftlHI6jn0udwtKbkaqq
         k3Ev1tUa0z7MOuBtoeMllIJCc36UmG/q7jLnfmS7iMQrD7mnlRc0vZfZ+ITvalGMJaAo
         LycxyNZ6ckpRUv32JJLyU/BAyvP9zMXmGlY+i291qFyEauyl4Ig7QGws5zYkTcTP+F7x
         UHyA2Uf8nUv4rZLvSr6gpTmFZzdxWJ4I1EbKpYphmwgIGl0AdE9ZJ985vDxtEcX8RkMm
         bmhFsVwQceCMeNT7qAYBXn7SKjaMAl+tXbCtYD2mMd/e01UF2gwq83SueyGRxDIAumOq
         pdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678204594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hf01G5AjyxZoBZL3gsdbHoFfhTX/K7xRHJCGj6YLdK8=;
        b=QnaeKF5UzKND69VT5JzKAx7MiWQJGIg44qE+E0zybyJMP/BThhCIbNnHB4xJl2yvJz
         Ma/PCMXJuqYf6rpobRdu21Ro/yAEczuF4ZFKkiI4LPeTKaGQ5xMEbADrhlthiBhgpsG1
         q+MutqJwLPPkrubXVkr6Zpe465SnYm69i6II0mPOL0/G0htBJZxwNKX60OEhAOCTVMek
         etAmRbPFrkiYcGY6v8jIYL30V5aVRrGkauR2zSZ5Lx1m+Hh1N7dJSYyZJdd/jwRJf9Zz
         5AW2QLP19/BELK6QnJdxglYEIC9zS6ca18sOc2oaFvH4l9ihV4S7QymwV2f0pugIJVH0
         bM4Q==
X-Gm-Message-State: AO0yUKXNIDJR4vkyo8qn8zpLhDZrEtOXmZhKH/2nwA6AODK4Q8VW9u1N
        x20eJEriylVW+ypY0TWgLWlmb8anpqA=
X-Google-Smtp-Source: AK7set+YO2wiK3dl2Je6XnzeROylbuuC+2ycsenMixFW3syVIK4t9DT8BJFaXqL3tQbjCDN0SaZhcQ==
X-Received: by 2002:a17:906:99d4:b0:8ed:5aac:6973 with SMTP id s20-20020a17090699d400b008ed5aac6973mr14838898ejn.35.1678204594676;
        Tue, 07 Mar 2023 07:56:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709063b5800b008cda6560404sm6251285ejf.193.2023.03.07.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:56:34 -0800 (PST)
Date:   Tue, 7 Mar 2023 18:56:28 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: Fix possible corruption when moving a directory
Message-ID: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan Kara,

The patch 0813299c586b: "ext4: Fix possible corruption when moving a
directory" from Jan 26, 2023, leads to the following Smatch static
checker warning:

	fs/ext4/namei.c:4017 ext4_rename()
	error: double unlocked '&old.inode->i_rwsem' (orig line 3882)

fs/ext4/namei.c
    3766 static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
    3767                        struct dentry *old_dentry, struct inode *new_dir,
    3768                        struct dentry *new_dentry, unsigned int flags)
    3769 {
    3770         handle_t *handle = NULL;
    3771         struct ext4_renament old = {
    3772                 .dir = old_dir,
    3773                 .dentry = old_dentry,
    3774                 .inode = d_inode(old_dentry),
    3775         };
    3776         struct ext4_renament new = {
    3777                 .dir = new_dir,
    3778                 .dentry = new_dentry,
    3779                 .inode = d_inode(new_dentry),
    3780         };
    3781         int force_reread;
    3782         int retval;
    3783         struct inode *whiteout = NULL;
    3784         int credits;
    3785         u8 old_file_type;
    3786 
    3787         if (new.inode && new.inode->i_nlink == 0) {
    3788                 EXT4_ERROR_INODE(new.inode,
    3789                                  "target of rename is already freed");
    3790                 return -EFSCORRUPTED;
    3791         }
    3792 
    3793         if ((ext4_test_inode_flag(new_dir, EXT4_INODE_PROJINHERIT)) &&
    3794             (!projid_eq(EXT4_I(new_dir)->i_projid,
    3795                         EXT4_I(old_dentry->d_inode)->i_projid)))
    3796                 return -EXDEV;
    3797 
    3798         retval = dquot_initialize(old.dir);
    3799         if (retval)
    3800                 return retval;
    3801         retval = dquot_initialize(old.inode);
    3802         if (retval)
    3803                 return retval;
    3804         retval = dquot_initialize(new.dir);
    3805         if (retval)
    3806                 return retval;
    3807 
    3808         /* Initialize quotas before so that eventual writes go
    3809          * in separate transaction */
    3810         if (new.inode) {
    3811                 retval = dquot_initialize(new.inode);
    3812                 if (retval)
    3813                         return retval;
    3814         }
    3815 
    3816         old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
    3817         if (IS_ERR(old.bh))
    3818                 return PTR_ERR(old.bh);
    3819         /*
    3820          *  Check for inode number is _not_ due to possible IO errors.
    3821          *  We might rmdir the source, keep it as pwd of some process
    3822          *  and merrily kill the link to whatever was created under the
    3823          *  same name. Goodbye sticky bit ;-<
    3824          */
    3825         retval = -ENOENT;
    3826         if (!old.bh || le32_to_cpu(old.de->inode) != old.inode->i_ino)
    3827                 goto release_bh;
    3828 
    3829         new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
    3830                                  &new.de, &new.inlined);
    3831         if (IS_ERR(new.bh)) {
    3832                 retval = PTR_ERR(new.bh);
    3833                 new.bh = NULL;
    3834                 goto release_bh;
    3835         }
    3836         if (new.bh) {
    3837                 if (!new.inode) {
    3838                         brelse(new.bh);
    3839                         new.bh = NULL;
    3840                 }
    3841         }
    3842         if (new.inode && !test_opt(new.dir->i_sb, NO_AUTO_DA_ALLOC))
    3843                 ext4_alloc_da_blocks(old.inode);
    3844 
    3845         credits = (2 * EXT4_DATA_TRANS_BLOCKS(old.dir->i_sb) +
    3846                    EXT4_INDEX_EXTRA_TRANS_BLOCKS + 2);
    3847         if (!(flags & RENAME_WHITEOUT)) {
    3848                 handle = ext4_journal_start(old.dir, EXT4_HT_DIR, credits);
    3849                 if (IS_ERR(handle)) {
    3850                         retval = PTR_ERR(handle);
    3851                         goto release_bh;
    3852                 }
    3853         } else {
    3854                 whiteout = ext4_whiteout_for_rename(idmap, &old, credits, &handle);
    3855                 if (IS_ERR(whiteout)) {
    3856                         retval = PTR_ERR(whiteout);
    3857                         goto release_bh;
    3858                 }
    3859         }
    3860 
    3861         old_file_type = old.de->file_type;
    3862         if (IS_DIRSYNC(old.dir) || IS_DIRSYNC(new.dir))
    3863                 ext4_handle_sync(handle);
    3864 
    3865         if (S_ISDIR(old.inode->i_mode)) {
    3866                 if (new.inode) {
    3867                         retval = -ENOTEMPTY;
    3868                         if (!ext4_empty_dir(new.inode))
    3869                                 goto end_rename;
    3870                 } else {
    3871                         retval = -EMLINK;
    3872                         if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
    3873                                 goto end_rename;
    3874                 }
    3875                 /*
    3876                  * We need to protect against old.inode directory getting
    3877                  * converted from inline directory format into a normal one.
    3878                  */
    3879                 inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
    3880                 retval = ext4_rename_dir_prepare(handle, &old);
    3881                 if (retval) {
    3882                         inode_unlock(old.inode);

The issue here is that ext4_rename_dir_prepare() sets old.dir_bh and
then returns -EFSCORRUPTED.  It results in an unlock here and then again
after the goto.

    3883                         goto end_rename;
    3884                 }
    3885         }
    3886         /*
    3887          * If we're renaming a file within an inline_data dir and adding or
    3888          * setting the new dirent causes a conversion from inline_data to
    3889          * extents/blockmap, we need to force the dirent delete code to
    3890          * re-read the directory, or else we end up trying to delete a dirent
    3891          * from what is now the extent tree root (or a block map).
    3892          */
    3893         force_reread = (new.dir->i_ino == old.dir->i_ino &&
    3894                         ext4_test_inode_flag(new.dir, EXT4_INODE_INLINE_DATA));
    3895 
    3896         if (whiteout) {
    3897                 /*
    3898                  * Do this before adding a new entry, so the old entry is sure
    3899                  * to be still pointing to the valid old entry.
    3900                  */
    3901                 retval = ext4_setent(handle, &old, whiteout->i_ino,
    3902                                      EXT4_FT_CHRDEV);
    3903                 if (retval)
    3904                         goto end_rename;
    3905                 retval = ext4_mark_inode_dirty(handle, whiteout);
    3906                 if (unlikely(retval))
    3907                         goto end_rename;
    3908 
    3909         }
    3910         if (!new.bh) {
    3911                 retval = ext4_add_entry(handle, new.dentry, old.inode);
    3912                 if (retval)
    3913                         goto end_rename;
    3914         } else {
    3915                 retval = ext4_setent(handle, &new,
    3916                                      old.inode->i_ino, old_file_type);
    3917                 if (retval)
    3918                         goto end_rename;
    3919         }
    3920         if (force_reread)
    3921                 force_reread = !ext4_test_inode_flag(new.dir,
    3922                                                      EXT4_INODE_INLINE_DATA);
    3923 
    3924         /*
    3925          * Like most other Unix systems, set the ctime for inodes on a
    3926          * rename.
    3927          */
    3928         old.inode->i_ctime = current_time(old.inode);
    3929         retval = ext4_mark_inode_dirty(handle, old.inode);
    3930         if (unlikely(retval))
    3931                 goto end_rename;
    3932 
    3933         if (!whiteout) {
    3934                 /*
    3935                  * ok, that's it
    3936                  */
    3937                 ext4_rename_delete(handle, &old, force_reread);
    3938         }
    3939 
    3940         if (new.inode) {
    3941                 ext4_dec_count(new.inode);
    3942                 new.inode->i_ctime = current_time(new.inode);
    3943         }
    3944         old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
    3945         ext4_update_dx_flag(old.dir);
    3946         if (old.dir_bh) {
    3947                 retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);
    3948                 if (retval)
    3949                         goto end_rename;
    3950 
    3951                 ext4_dec_count(old.dir);
    3952                 if (new.inode) {
    3953                         /* checked ext4_empty_dir above, can't have another
    3954                          * parent, ext4_dec_count() won't work for many-linked
    3955                          * dirs */
    3956                         clear_nlink(new.inode);
    3957                 } else {
    3958                         ext4_inc_count(new.dir);
    3959                         ext4_update_dx_flag(new.dir);
    3960                         retval = ext4_mark_inode_dirty(handle, new.dir);
    3961                         if (unlikely(retval))
    3962                                 goto end_rename;
    3963                 }
    3964         }
    3965         retval = ext4_mark_inode_dirty(handle, old.dir);
    3966         if (unlikely(retval))
    3967                 goto end_rename;
    3968 
    3969         if (S_ISDIR(old.inode->i_mode)) {
    3970                 /*
    3971                  * We disable fast commits here that's because the
    3972                  * replay code is not yet capable of changing dot dot
    3973                  * dirents in directories.
    3974                  */
    3975                 ext4_fc_mark_ineligible(old.inode->i_sb,
    3976                         EXT4_FC_REASON_RENAME_DIR, handle);
    3977         } else {
    3978                 struct super_block *sb = old.inode->i_sb;
    3979 
    3980                 if (new.inode)
    3981                         ext4_fc_track_unlink(handle, new.dentry);
    3982                 if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
    3983                     !(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
    3984                     !(ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE))) {
    3985                         __ext4_fc_track_link(handle, old.inode, new.dentry);
    3986                         __ext4_fc_track_unlink(handle, old.inode, old.dentry);
    3987                         if (whiteout)
    3988                                 __ext4_fc_track_create(handle, whiteout,
    3989                                                        old.dentry);
    3990                 }
    3991         }
    3992 
    3993         if (new.inode) {
    3994                 retval = ext4_mark_inode_dirty(handle, new.inode);
    3995                 if (unlikely(retval))
    3996                         goto end_rename;
    3997                 if (!new.inode->i_nlink)
    3998                         ext4_orphan_add(handle, new.inode);
    3999         }
    4000         retval = 0;
    4001 
    4002 end_rename:
    4003         if (whiteout) {
    4004                 if (retval) {
    4005                         ext4_resetent(handle, &old,
    4006                                       old.inode->i_ino, old_file_type);
    4007                         drop_nlink(whiteout);
    4008                         ext4_orphan_add(handle, whiteout);
    4009                 }
    4010                 unlock_new_inode(whiteout);
    4011                 ext4_journal_stop(handle);
    4012                 iput(whiteout);
    4013         } else {
    4014                 ext4_journal_stop(handle);
    4015         }
    4016         if (old.dir_bh)
--> 4017                 inode_unlock(old.inode);
    4018 release_bh:
    4019         brelse(old.dir_bh);
    4020         brelse(old.bh);
    4021         brelse(new.bh);
    4022         return retval;
    4023 }

regards,
dan carpenter
