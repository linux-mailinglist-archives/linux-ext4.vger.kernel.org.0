Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54359863D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Aug 2022 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbiHROoH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Aug 2022 10:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245381AbiHROoG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Aug 2022 10:44:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F54F22530;
        Thu, 18 Aug 2022 07:44:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so2078983pjl.0;
        Thu, 18 Aug 2022 07:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hlpW/CO7H6NvrG2GXZz8IdJx7qCZAqxqT3oKxPM+efw=;
        b=OtCOZ8ESeSBTMxJjVrBGyOhSi7nXb+i38jofK/NOhG8WeeBotc5KBgrlMeY2XH0Ns3
         FZdTpIdPXk7SxrHA+03mF+AOjJTb1Xdg83migq7NOrF0DQ6Bpyn/2V+xnO5BnNsl7ljn
         RmnsoHBEeOivzuiAcsVwZhxDQH7xr6i+USl60nnQVK3UReq2+fJ7kG1ndJDyX2CrV47I
         QrCo2FuayipXVDCnuvVzb7FFnyrMf6gEYlMJrW4oXSfIxUH3TpnhPJE3Q8D43bcFfX16
         tDzuUYUZKJ1DeiaPJKsd3Mc4K7p2Cp2bSkBIuRnlrsSiyDRE3vn8/OehlN8+jalSRq7r
         8knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hlpW/CO7H6NvrG2GXZz8IdJx7qCZAqxqT3oKxPM+efw=;
        b=pSrAAfkmp+Pxxj/i2fq6X3tWnIx9wXInzICskrSWp8TbHGpDcjlyRjgs9dtSE+eevp
         Fk5YeBzU6K4DwtoT+KRPNabYZTdnwaAHAW3rqVCp6IHvl6dcfmU4bEdj4PMaedqLuja3
         v0hKXFc9/uBjdNY4xlTMdseqn6vkrvW33RkQv7AWNacoV6m6s7AD81E+njyWqb/H+L7E
         NdiaYkg0PVhyRCZc9gMND0B+P2WG2fdwXHDgeyyLpLYDlLGiUMcAGhGmLjWrl3SMYf8Y
         Y3NOd3R3JwlqXIM3Qn2+hnfMwbuSaz86auXRjQVnx8krVbKb2tF6Qh9IV6Em2A/cQCNY
         X7Zg==
X-Gm-Message-State: ACgBeo0HzqW0C91RlMgqz42CMw4HNd0u/z8LNYUx5uvYB32S99GyYqwD
        LkU11d0hsX3/TMh6ftvz9OI=
X-Google-Smtp-Source: AA6agR6nDZ44ixSdLRa6qoob1IIY2XXV0QypQwscD0QMmzeklaqGvewZHHRMwprzPL6BwRyyM+y7LA==
X-Received: by 2002:a17:90b:180b:b0:1f5:160c:a652 with SMTP id lw11-20020a17090b180b00b001f5160ca652mr3434352pjb.235.1660833840826;
        Thu, 18 Aug 2022 07:44:00 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0016dcc381bbasm1483272plr.144.2022.08.18.07.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:44:00 -0700 (PDT)
Date:   Thu, 18 Aug 2022 20:13:53 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, lczerner@redhat.com,
        enwlinux@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817143138.7krkxzoa3skruiyx@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/08/17 04:31PM, Jan Kara wrote:
> On Wed 17-08-22 21:27:01, Baokun Li wrote:
> > In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
> > and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.
> >
> > In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
> > the function returns -ENOMEM.
> >
> > In __getblk_slow, if the return value of grow_buffers is less than 0,
> > the function returns NULL.
> >
> > When the three processes are connected in series like the following stack,
> > an infinite loop may occur:
> >
> > do_writepages					<--- keep retrying
> >  ext4_writepages
> >   mpage_map_and_submit_extent
> >    mpage_map_one_extent
> >     ext4_map_blocks
> >      ext4_ext_map_blocks
> >       ext4_ext_handle_unwritten_extents
> >        ext4_ext_convert_to_initialized
> >         ext4_split_extent
> >          ext4_split_extent_at
> >           __ext4_ext_dirty
> >            __ext4_mark_inode_dirty
> >             ext4_reserve_inode_write
> >              ext4_get_inode_loc
> >               __ext4_get_inode_loc		<--- return -ENOMEM
> >                sb_getblk
> >                 __getblk_gfp
> >                  __getblk_slow			<--- return NULL
> >                   grow_buffers
> >                    grow_dev_page		<--- return -ENXIO
> >                     ret = (block < end_block) ? 1 : -ENXIO;
> >
> > In this issue, bg_inode_table_hi is overwritten as an incorrect value.
> > As a result, `block < end_block` cannot be met in grow_dev_page.
> > Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
> > keeps retrying. As a result, the writeback process is in the D state due
> > to an infinite loop.
> >
> > Add a check on inode table block in the __ext4_get_inode_loc function by
> > referring to ext4_read_inode_bitmap to avoid this infinite loop.
> >
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
>
> Thanks for the fixes. Normally, we check that inode table is fine in
> ext4_check_descriptors() (and those checks are much stricter) so it seems
> unnecessary to check it again here. I understand that in your case it was
> resize that corrupted the group descriptor after the filesystem was mounted
> which is nasty but there's much more metadata that can be corrupted like
> this and it's infeasible to check each metadata block before we use it.
>
> IMHO a proper fix to this class of issues would be for sb_getblk() to
> return proper error so that we can distinguish ENOMEM from other errors.
> But that will be a larger undertaking...
>

Hi Jan,

How about adding a wrapper around sb_getblk() which will do the basic block
bound checks for ext4. Then we can carefully convert all the callers of
sb_getblk() in ext4 to call ext4_sb_getblk().

ext4_sb_getblk() will then return either of below -
1. ERR_PTR(-EFSCORRUPTED)
2. NULL
3. struct buffer_head*

It's caller can then implement the proper error handling.

Folding a small patch to implement the simple bound check. Is this the right
approach?

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Date: Thu, 18 Aug 2022 07:53:58 -0500
Subject: [RFC] ext4: Add ext4_sb_getblk() wrapper for block bounds checking

We might need more bounds checking on the block before calling sb_getblk().
This helper does that and if it is not valid then returns ERR_PTR(-EFSCORRUPTED)
Later we will need to carefully convert the callers to use ext4_sb_getblk()
instead of sb_getblk().
For e.g. __ext4_get_inode_loc()

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/block_validity.c |  4 +---
 fs/ext4/ext4.h           | 12 ++++++++++++
 fs/ext4/super.c          |  9 +++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 5504f72bbbbe..69347fab7c38 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -301,9 +301,7 @@ int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
 	struct rb_node *n;
 	int ret = 1;

-	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
-	    (start_blk + count < start_blk) ||
-	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
+	if (!ext4_sb_block_valid_fastcheck(sbi->s_es, start_blk, count))
 		return 0;

 	/*
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9bca5565547b..79d0e45185d3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3072,6 +3072,8 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, blk_opf_t op_flags);
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
+extern struct buffer_head *ext4_sb_getblk(struct super_block *sb,
+					  sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 				bh_end_io_t *end_io);
 extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
@@ -3358,6 +3360,16 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
 	return 1 << sbi->s_log_groups_per_flex;
 }

+static inline bool ext4_sb_block_valid_fastcheck(struct ext4_super_block *es,
+					sector_t start_blk, unsigned int count)
+{
+	if ((start_blk <= le32_to_cpu(es->s_first_data_block)) ||
+	    (start_blk + count < start_blk) ||
+	    (start_blk + count > ext4_blocks_count(es)))
+		return false;
+	return true;
+}
+
 #define ext4_std_error(sb, errno)				\
 do {								\
 	if ((errno))						\
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..5b29272ad9a9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -269,6 +269,15 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 	}
 }

+struct buffer_head *ext4_sb_getblk(struct super_block *sb, sector_t block)
+{
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+
+	if (!ext4_sb_block_valid_fastcheck(es, block, 1))
+		return ERR_PTR(-EFSCORRUPTED);
+	return sb_getblk(sb, block);
+}
+
 static int ext4_verify_csum_type(struct super_block *sb,
 				 struct ext4_super_block *es)
 {
--
2.25.1

-ritesh



> 								Honza
>
> > ---
> >  fs/ext4/inode.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 601214453c3a..5e171879fa23 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4466,9 +4466,17 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
> >  	inodes_per_block = EXT4_SB(sb)->s_inodes_per_block;
> >  	inode_offset = ((ino - 1) %
> >  			EXT4_INODES_PER_GROUP(sb));
> > -	block = ext4_inode_table(sb, gdp) + (inode_offset / inodes_per_block);
> >  	iloc->offset = (inode_offset % inodes_per_block) * EXT4_INODE_SIZE(sb);
> >
> > +	block = ext4_inode_table(sb, gdp);
> > +	if ((block <= le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) ||
> > +	    (block >= ext4_blocks_count(EXT4_SB(sb)->s_es))) {
> > +		ext4_error(sb, "Invalid inode table block %llu in "
> > +			   "block_group %u", block, iloc->block_group);
> > +		return -EFSCORRUPTED;
> > +	}
> > +	block += (inode_offset / inodes_per_block);
> > +
> >  	bh = sb_getblk(sb, block);
> >  	if (unlikely(!bh))
> >  		return -ENOMEM;
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
