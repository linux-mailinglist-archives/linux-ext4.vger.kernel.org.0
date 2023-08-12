Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED88D779EDD
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Aug 2023 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjHLKTc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Aug 2023 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHLKTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Aug 2023 06:19:32 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB3510F5
        for <linux-ext4@vger.kernel.org>; Sat, 12 Aug 2023 03:19:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RNGqQ4JGPz4f3jLw
        for <linux-ext4@vger.kernel.org>; Sat, 12 Aug 2023 18:19:30 +0800 (CST)
Received: from [10.174.179.189] (unknown [10.174.179.189])
        by APP4 (Coremail) with SMTP id gCh0CgB3VKeWXNdkXUIfAg--.15974S2;
        Sat, 12 Aug 2023 18:19:30 +0800 (CST)
Message-ID: <0d787a93-9795-3a92-14fc-822d19b9d682@huaweicloud.com>
Date:   Sat, 12 Aug 2023 18:19:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] ext4: Adds helpers functions for s_mount_state
Content-Language: en-US
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     wubo40@huawei.com
References: <1691565092-11124-1-git-send-email-wubo@huaweicloud.com>
From:   Wu Bo <wubo@huaweicloud.com>
In-Reply-To: <1691565092-11124-1-git-send-email-wubo@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3VKeWXNdkXUIfAg--.15974S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW3Xr1UAr4kJF4fXF47Arb_yoW3uF4fpr
        s8Ar15Wr48Z3Wv9F4xGF4UXFnaqw10kay2gryS9F1rJFZxXw1fKFn3tFyjyF17KrW8ur12
        q3Wjkr4qkw4Yga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwMKuUUUUU
X-CM-SenderInfo: pzxe0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/8/9 15:11, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
>
> This patch adds helpers functions for s_mount_state.
>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>   fs/ext4/balloc.c         |  2 +-
>   fs/ext4/ext4.h           | 14 ++++++++++++++
>   fs/ext4/ext4_jbd2.c      |  2 +-
>   fs/ext4/extents_status.c | 16 ++++++++--------
>   fs/ext4/fast_commit.c    |  6 +++---
>   fs/ext4/ialloc.c         | 14 +++++++-------
>   fs/ext4/inode.c          | 12 ++++++------
>   fs/ext4/mballoc.c        |  8 ++++----
>   fs/ext4/namei.c          |  4 ++--
>   fs/ext4/orphan.c         |  7 ++++---
>   fs/ext4/resize.c         |  4 ++--
>   fs/ext4/super.c          | 20 ++++++++++----------
>   12 files changed, 62 insertions(+), 47 deletions(-)
>
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 1f72f977c6db..9baa88cacbe0 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -402,7 +402,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
>   	ext4_fsblk_t	blk;
>   	struct ext4_group_info *grp;
>   
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>   		return 0;
>   
>   	grp = ext4_get_group_info(sb, block_group);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 0a2d55faa095..5b1995986704 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1817,6 +1817,20 @@ static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
>   	return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
>   }
>   
> +static inline void ext4_set_mount_state(struct super_block *sb, int state)
> +{
> +	EXT4_SB(sb)->s_mount_state |= state;
> +}
> +
> +static inline void ext4_clear_mount_state(struct super_block *sb, int state)
> +{
> +	EXT4_SB(sb)->s_mount_state &= ~state;
> +}
> +
> +static inline int ext4_test_mount_state(struct super_block *sb, int state)
> +{
> +	return EXT4_SB(sb)->s_mount_state & state;
> +}
>   
>   /*
>    * Simulate_fail codes
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 77f318ec8abb..6ba75ae2c188 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -106,7 +106,7 @@ handle_t *__ext4_journal_start_sb(struct inode *inode,
>   		return ERR_PTR(err);
>   
>   	journal = EXT4_SB(sb)->s_journal;
> -	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
> +	if (!journal || ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>   		return ext4_get_nojournal();
>   	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
>   				   GFP_NOFS, type, line);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 9b5b8951afb4..b37b9c29c9fa 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -309,7 +309,7 @@ void ext4_es_find_extent_range(struct inode *inode,
>   			       ext4_lblk_t lblk, ext4_lblk_t end,
>   			       struct extent_status *es)
>   {
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return;
>   
>   	trace_ext4_es_find_extent_range_enter(inode, lblk);
> @@ -362,7 +362,7 @@ bool ext4_es_scan_range(struct inode *inode,
>   {
>   	bool ret;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return false;
>   
>   	read_lock(&EXT4_I(inode)->i_es_lock);
> @@ -408,7 +408,7 @@ bool ext4_es_scan_clu(struct inode *inode,
>   {
>   	bool ret;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return false;
>   
>   	read_lock(&EXT4_I(inode)->i_es_lock);
> @@ -842,7 +842,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct extent_status *es1 = NULL;
>   	struct extent_status *es2 = NULL;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return;
>   
>   	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
> @@ -917,7 +917,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct extent_status newes;
>   	ext4_lblk_t end = lblk + len - 1;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return;
>   
>   	newes.es_lblk = lblk;
> @@ -955,7 +955,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>   	struct rb_node *node;
>   	int found = 0;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return 0;
>   
>   	trace_ext4_es_lookup_extent_enter(inode, lblk);
> @@ -1468,7 +1468,7 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>   	int reserved = 0;
>   	struct extent_status *es = NULL;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return;
>   
>   	trace_ext4_es_remove_extent(inode, lblk, len);
> @@ -2024,7 +2024,7 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>   	struct extent_status *es1 = NULL;
>   	struct extent_status *es2 = NULL;
>   
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(inode->i_sb, EXT4_FC_REPLAY))
>   		return;
>   
>   	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b06de728b3b6..023e13ec9fdc 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -232,7 +232,7 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
>   static bool ext4_fc_disabled(struct super_block *sb)
>   {
>   	return (!test_opt2(sb, JOURNAL_FAST_COMMIT) ||
> -		(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY));
> +		ext4_test_mount_state(sb, EXT4_FC_REPLAY));
>   }
>   
>   /*
> @@ -1975,7 +1975,7 @@ void ext4_fc_replay_cleanup(struct super_block *sb)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   
> -	sbi->s_mount_state &= ~EXT4_FC_REPLAY;
> +	ext4_clear_mount_state(sb, EXT4_FC_REPLAY);
>   	kfree(sbi->s_fc_replay_state.fc_regions);
>   	kfree(sbi->s_fc_replay_state.fc_modified_inodes);
>   }
> @@ -2165,7 +2165,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
>   
>   	if (state->fc_current_pass != pass) {
>   		state->fc_current_pass = pass;
> -		sbi->s_mount_state |= EXT4_FC_REPLAY;
> +		ext4_set_mount_state(sb, EXT4_FC_REPLAY);
>   	}
>   	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
>   		ext4_debug("Replay stops\n");
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 754f961cd9fd..09ec20b2e761 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -84,7 +84,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
>   	ext4_fsblk_t	blk;
>   	struct ext4_group_info *grp;
>   
> -	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (ext4_test_mount_state(sb, EXT4_FC_REPLAY))
>   		return 0;
>   
>   	grp = ext4_get_group_info(sb, block_group);
> @@ -291,7 +291,7 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
>   		bitmap_bh = NULL;
>   		goto error_return;
>   	}
> -	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +	if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>   		grp = ext4_get_group_info(sb, block_group);
>   		if (!grp || unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
>   			fatal = -EFSCORRUPTED;
> @@ -1040,7 +1040,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>   		if (ext4_free_inodes_count(sb, gdp) == 0)
>   			goto next_group;
>   
> -		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +		if (!ext4_test_mount_state(sb, EXT4_FC_REPLAY)) {
>   			grp = ext4_get_group_info(sb, group);
>   			/*
>   			 * Skip groups with already-known suspicious inode
> @@ -1053,7 +1053,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>   		brelse(inode_bitmap_bh);
>   		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
>   		/* Skip groups with suspicious inode tables */
> -		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
> +		if (((ext4_test_mount_state(sb, EXT4_FC_REPLAY))
dangerous,    missing "!",   V2 patch fix it

