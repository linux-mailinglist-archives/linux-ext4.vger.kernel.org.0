Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACB28C5A7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJMA2F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA2E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:28:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A3C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so19037523edq.4
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTdog/D5e1DaxcgMI8me0Y7w9qcii2CBaTE9Zb6Bzos=;
        b=nfbO28icrm2gJpgHEgBt18rpD5T67HO1J97a3mkUTmsj8yZ29USblBO8Q+0TlT8/+u
         /bdsQpdoX/q/HwX4mjqiRDK+FmskRQSUn57gfp0hZajYKDLr3J7SD8t4JtRGacYvXIKh
         mAXxwf4KxFPNPC+So9XCmtX4lSHWBjOXTVdBR3ABXy8ilYxWIMwAKQgKbxBi9nI2FfA5
         EQlyr1dsL4QEMKOY9zV+n8iQO2HgiKkMV85BO7H67fkcgFk7GOCBD1YobxWCPP1UUc6R
         Nr36xrcLLyZXs4fxzjSQaOjKEO3LoOTC17HVdYwvGTIl3DbNEcQn2MrgVo7oHp/u4Vaz
         nfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTdog/D5e1DaxcgMI8me0Y7w9qcii2CBaTE9Zb6Bzos=;
        b=Hyk1772QRGDUU9mn3x8s8QZlwzkOFk8MI/UlOaeCV19z60Mop3Znz5H+1yklI7SbeW
         FDx/peHfipLO9SuXC6+QfCM2AC7i2Un31Pd/RH/YGkyB0OHUHyq4SYd4aEgzuQ07GIH/
         yAiAnDxm9rmC22lj+6PhfC5bCA+KjAxD8ew4TKKRrLzzYDo+qtDzQ6y2NPE3i29JxD+T
         e+Q7tBqM9JqI46k+eBOQRqQFo3umPpvumZLsJkMERneBZz5i8gwDX7pg6JHg7whFoAPy
         A9du0K8WLMgMxflxDhZK7ehWs2lPIZIA2v5xuKcCfKsnGas/bQ4pX16iQWM+OaAQKGeI
         jxhQ==
X-Gm-Message-State: AOAM531LoKTRTRztz0+JSaRWezPuHWc6CHEveZeP6OIP/pLZrFN++7Fv
        FTw7WiPzUWbj2Ro2TVtxdO50+7YI+FjkSAV1gN6RawjraI4=
X-Google-Smtp-Source: ABdhPJy/dCYPFM/V68JRpn1igy+r/eZchKdT87ohp2zLj/V7UhonJiKqk4no36mLy1E8BNczGrNBeC7hQT8qOMQB58g=
X-Received: by 2002:a05:6402:3184:: with SMTP id di4mr17447922edb.362.1602548882947;
 Mon, 12 Oct 2020 17:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-8-harshadshirwadkar@gmail.com> <dcf720bd-8644-3001-75b4-d845a2495f72@linux.ibm.com>
In-Reply-To: <dcf720bd-8644-3001-75b4-d845a2495f72@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:27:50 -0700
Message-ID: <CAD+ocbwubpAmWRH9m-Kex1yMtdL3OU=aoV1W_8b4Kp0frG+BGA@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] ext4: fast commit recovery path
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Replies inlined (also I have stripped down the original inlined patch
to make this more readable).

On Fri, Oct 9, 2020 at 10:14 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> > +/* Replay add range tag */
> > +static int ext4_fc_replay_add_range(struct super_block *sb,
> > +                             struct ext4_fc_tl *tl)
> > +{
> > +     struct ext4_fc_add_range *fc_add_ex;
> > +     struct ext4_extent newex, *ex;
> > +     struct inode *inode;
> > +     ext4_lblk_t start, cur;
> > +     int remaining, len;
> > +     ext4_fsblk_t start_pblk;
> > +     struct ext4_map_blocks map;
> > +     struct ext4_ext_path *path = NULL;
> > +     int ret;
> > +
> > +     fc_add_ex = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
> > +     ex = (struct ext4_extent *)&fc_add_ex->fc_ex;
> > +
> > +     trace_ext4_fc_replay(sb, EXT4_FC_TAG_ADD_RANGE,
> > +             le32_to_cpu(fc_add_ex->fc_ino), le32_to_cpu(ex->ee_block),
> > +             ext4_ext_get_actual_len(ex));
> > +
> > +     inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
> > +                             EXT4_IGET_NORMAL);
> > +     if (IS_ERR_OR_NULL(inode)) {
> > +             jbd_debug(1, "Inode not found.");
> > +             return 0;
> > +     }
> > +
> > +     ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > +
> > +     start = le32_to_cpu(ex->ee_block);
> > +     start_pblk = ext4_ext_pblock(ex);
> > +     len = ext4_ext_get_actual_len(ex);
> > +
> > +     cur = start;
> > +     remaining = len;
> > +     jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
> > +               start, start_pblk, len, ext4_ext_is_unwritten(ex),
> > +               inode->i_ino);
> > +
> > +     while (remaining > 0) {
> > +             map.m_lblk = cur;
> > +             map.m_len = remaining;
> > +             map.m_pblk = 0;
> > +             ret = ext4_map_blocks(NULL, inode, &map, 0);
> > +
> > +             if (ret < 0) {
> > +                     iput(inode);
> > +                     return 0;
> > +             }
> > +
> > +             if (ret == 0) {
> > +                     /* Range not mapped */
> > +                     path = ext4_find_extent(inode, cur, NULL, 0);
> > +                     if (!path)
> > +                             continue;
> > +                     memset(&newex, 0, sizeof(newex));
> > +                     newex.ee_block = cpu_to_le32(cur);
> > +                     ext4_ext_store_pblock(
> > +                             &newex, start_pblk + cur - start);
> > +                     newex.ee_len = cpu_to_le16(map.m_len);
> > +                     if (ext4_ext_is_unwritten(ex))
> > +                             ext4_ext_mark_unwritten(&newex);
> > +                     down_write(&EXT4_I(inode)->i_data_sem);
> > +                     ret = ext4_ext_insert_extent(
> > +                             NULL, inode, &path, &newex, 0);
> > +                     up_write((&EXT4_I(inode)->i_data_sem));
> > +                     ext4_ext_drop_refs(path);
> > +                     kfree(path);
> > +                     if (ret) {
> > +                             iput(inode);
> > +                             return 0;
> > +                     }
> > +                     goto next;
> > +             }
> > +
> > +             if (start_pblk + cur - start != map.m_pblk) { > +                       /* Logical to physical mapping changed */
>
>
> Sorry I am not sure if I understand this correctly. Can we pls put more
> comments on when and how can this condition happen?
> I am sure I am mising something.
Sorry, I realized that the code is rather a bit too cryptic, I'll add
more comments in V10 here to explain what's going on. This condition
can happen in following scenario:
- fallocate insert range on file f at offset 4k, length 8k
- write on this range
- sync
- fallocate remove range
- fallocate insert range again. At this point, lblk -> pblk mapping of
the range would have changed from last sync. Calling fsync at this
point would just result in "ADD_RANGE" tag with the newly added
mapping.
In this particular scenario, the recovery code would hit this
condition. Does that make sense?
>
> Also what about if the mapping changed and the start pblk is differen
> but it's still an overlapping mapping?
> Do we take care of that case here? why I ask this, because we are
> clearing the block bitmaps for map.m_len below.
We record the inode that is being modified by "ADD_RANGE" /
"DEL_RANGE" operation. The case of overlapping ranges gets handled by
"ext4_fc_set_bitmaps_and_counters" which is called at the end of the
replay which traverses all the ranges in modified inodes and makes
sure that all the blocks that are there in an inode are marked in use.
>
> > +                     ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
> > +                                     ext4_ext_is_unwritten(ex),
> > +                                     start_pblk + cur - start);
> > +                     if (ret) {
> > +                             iput(inode);
> > +                             return 0;
> > +                     }
> > +                     ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> > +                     goto next;
> > +             }
> > +
> > +             /* Range is mapped and needs a state change */
> > +             jbd_debug(1, "Converting from %d to %d %lld",
> > +                             map.m_flags & EXT4_MAP_UNWRITTEN,
> > +                     ext4_ext_is_unwritten(ex), map.m_pblk);
> > +             ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
> > +                                     ext4_ext_is_unwritten(ex), map.m_pblk);
> > +             if (ret) {
> > +                     iput(inode);
> > +                     return 0;
> > +             }
> > +             /*
> > +              * We may have split the extent tree while toggling the state.
> > +              * Try to shrink the exten tree now.
>
> s/exten/extent
Ack
>
> > +             return "TAG_TAIL";
> > +     case EXT4_FC_TAG_HEAD:
> > +             return "TAG_HEAD";
> > +     default:
> > +             return "TAG_ERROR";
> > +     }
> > +}
> > +
> > +void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>
> static ?
Ack
>
> > +static int ext4_fc_replay_scan(journal_t *journal,
> > +                             struct buffer_head *bh, int off,
> > +                             tid_t expected_tid)
> > +{
> > +     struct super_block *sb = journal->j_private;
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_fc_replay_state *state;
> > +     int ret = JBD2_FC_REPLAY_CONTINUE;
> > +     struct ext4_fc_add_range *ext;
> > +     struct ext4_fc_tl *tl;
> > +     struct ext4_fc_tail *tail;
> > +     __u8 *start, *end;
> > +     struct ext4_fc_head *head;
> > +     struct ext4_extent *ex;
> > +
> > +     state = &sbi->s_fc_replay_state;
> > +
> > +     start = (u8 *)bh->b_data;
> > +     end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
> > +
> > +     if (state->fc_replay_expected_off == 0) {
> > +             state->fc_cur_tag = 0;
> > +             state->fc_replay_num_tags = 0;
> > +             state->fc_crc = 0;
> > +             state->fc_regions = NULL;
> > +             state->fc_regions_valid = state->fc_regions_used =
> > +                     state->fc_regions_size = 0;
> > +             /* Check if we can stop early */
> > +             if (le16_to_cpu(((struct ext4_fc_tl *)start)->fc_tag)
> > +                     != EXT4_FC_TAG_HEAD)
> > +                     return 0;
> > +     }
> > +
> > +     if (off != state->fc_replay_expected_off) {
> > +             ret = -EFSCORRUPTED;
> > +             goto out_err;
> > +     }
> > +
> > +     state->fc_replay_expected_off++;
> > +     fc_for_each_tl(start, end, tl) {
> > +             jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
> > +                       tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
> > +             switch (le16_to_cpu(tl->fc_tag)) {
> > +             case EXT4_FC_TAG_ADD_RANGE:
> > +                     ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
> > +                     ex = (struct ext4_extent *)&ext->fc_ex;
> > +                     ret = ext4_fc_record_regions(sb,
> > +                             le32_to_cpu(ext->fc_ino),
> > +                             le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
> > +                             ext4_ext_get_actual_len(ex));
> > +                     if (ret < 0)
> > +                             break;
> > +                     ret = JBD2_FC_REPLAY_CONTINUE;
> > +                     fallthrough;
> > +             case EXT4_FC_TAG_DEL_RANGE:
> > +             case EXT4_FC_TAG_LINK:
> > +             case EXT4_FC_TAG_UNLINK:
> > +             case EXT4_FC_TAG_CREAT:
> > +             case EXT4_FC_TAG_INODE_FULL:
> > +             case EXT4_FC_TAG_INODE_PARTIAL:
> > +             case EXT4_FC_TAG_PAD:
> > +                     state->fc_cur_tag++;
> > +                     state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> > +                                     sizeof(*tl) + ext4_fc_tag_len(tl));
> > +                     break;
> > +             case EXT4_FC_TAG_TAIL:
> > +                     state->fc_cur_tag++;
> > +                     tail = (struct ext4_fc_tail *)ext4_fc_tag_val(tl);
> > +                     state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> > +                                             sizeof(*tl) +
> > +                                             offsetof(struct ext4_fc_tail,
> > +                                             fc_crc));
> > +                     if (le32_to_cpu(tail->fc_tid) == expected_tid &&
> > +                             le32_to_cpu(tail->fc_crc) == state->fc_crc) {
> > +                             state->fc_replay_num_tags = state->fc_cur_tag;
> > +                             state->fc_regions_valid =
> > +                                     state->fc_regions_used;
> > +                     } else {
> > +                             ret = state->fc_replay_num_tags ?
> > +                                     JBD2_FC_REPLAY_STOP : -EFSBADCRC;
> > +                     }
> > +                     state->fc_crc = 0;
> > +                     break;
> > +             case EXT4_FC_TAG_HEAD:
> > +                     head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
> > +                     if (le32_to_cpu(head->fc_features) &
> > +                             ~EXT4_FC_SUPPORTED_FEATURES) {
> > +                             ret = -EOPNOTSUPP;
> > +                             break;
> > +                     }
> > +                     if (le32_to_cpu(head->fc_tid) != expected_tid) {
> > +                             ret = JBD2_FC_REPLAY_STOP;
> > +                             break;
> > +                     }
> > +                     state->fc_cur_tag++;
> > +                     state->fc_crc = ext4_chksum(sbi, state->fc_crc, tl,
> > +                                     sizeof(*tl) + ext4_fc_tag_len(tl));
>
>
> why do we need to calculate state->fc_crc for HEAD?
> I don't see we comparing this anywhere right? anything I missed?
Since head is the first tag in the fc area, CRC is first calculated
here. This CRC is modified after every tag found in the FC area, until
we reach a valid tail at which point, the CRC calculated till now is
verified against the CRC found in the tail tag itself.

FC area would look something like:
[HEAD][T1][T2][T3][TAIL1][T4][T5][T6][TAIL2]

For every commit operation, a tail gets written. That's why we see
multiple tails in FC area. In this example, CRC stored in Tail1 is
calculated as CRC(head, T1, T2, T3, Tail1). Similarly, CRC in tail2 is
CRC(T4, T5, T6, Tail2). In the scan phase, we maintain
fc_state->fc_crc as a running CRC until we find a valid tail. Once a
valid tail is found, the calculated CRC is compared against the CRC
found in the tail.
>
> > +int ext4_mark_inode_used(struct super_block *sb, int ino)
> > +{
> > +     unsigned long max_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count);
> > +     struct buffer_head *inode_bitmap_bh = NULL, *group_desc_bh = NULL;
> > +     struct ext4_group_desc *gdp;
> > +     ext4_group_t group;
> > +     int bit;
> > +     int err = -EFSCORRUPTED;
> > +
> > +     if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
> > +             goto out;
> > +
> > +     group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
> > +     bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
> > +     inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
> > +     if (IS_ERR(inode_bitmap_bh))
> > +             return PTR_ERR(inode_bitmap_bh);
> > +
> > +     if (ext4_test_bit(bit, inode_bitmap_bh->b_data)) {
> > +             err = 0;
> > +             goto out;
> > +     }
> > +
> > +     gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
> > +     if (!gdp || !group_desc_bh) {
> > +             err = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     ext4_set_bit(bit, inode_bitmap_bh->b_data);
> > +
> > +     BUFFER_TRACE(inode_bitmap_bh, "call ext4_handle_dirty_metadata");
> > +     err = ext4_handle_dirty_metadata(NULL, NULL, inode_bitmap_bh);
> > +     if (err) {
> > +             ext4_std_error(sb, err);
> > +             goto out;
> > +     }
> > +     sync_dirty_buffer(inode_bitmap_bh);
>
> Shouldn't we handle error from sync_dirty_buffer()?
Yeah that would be good. I'll do that.
>
> > +     BUFFER_TRACE(group_desc_bh, "get_write_access");
>
> The above BUFFER_TRACE() is not correct. We should remove it from here.
Ack, will do.
> > +/*
> > + * Idempotent helper for Ext4 fast commit replay path to set the state of
> > + * blocks in bitmaps and update counters.
> > + */
> > +void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> > +                     int len, int state)
> > +{
> > +     struct buffer_head *bitmap_bh = NULL;
> > +     struct ext4_group_desc *gdp;
> > +     struct buffer_head *gdp_bh;
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     ext4_group_t group;
> > +     ext4_fsblk_t cluster;
>
> I guess we never use this variable cluster. We can as well drop it.
Yeah, sorry for this, Ill clean it up in V10.

Thanks,
Harshad
>
> -ritesh
>
