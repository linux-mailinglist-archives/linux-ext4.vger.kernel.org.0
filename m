Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD7533BBD
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiEYL3j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiEYL3i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 07:29:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355969CCA3;
        Wed, 25 May 2022 04:29:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E2162219A2;
        Wed, 25 May 2022 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653478175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOXMlcfKrkG1ML4XJusI4RGsH3zQ8lDiqGTODex4bVQ=;
        b=vVu5Y8RfOc2mljmTt3/FVrZbMqEHiHWMz0Vyq+bCn4kL1BGIvYWOIxCFP+9dcojJAKVfEP
        Zqq+TpvXQ292b8Cz2xV+KoJOmDtqLqgSbGOMuql+GXqWUJn6lo0rOsJLaKAX4AsqheiisY
        m4bvDa06mUcNrPpexDr6JJq8LAuUaiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653478175;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uOXMlcfKrkG1ML4XJusI4RGsH3zQ8lDiqGTODex4bVQ=;
        b=J48jGLDMs0fwKWFXKqmtzMKhLa9e4+5YZ0knn4E725uAI8jq/EViK0arzDPaFEgqSC7zGn
        1/bkRSIKvaQGD6CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42C9C2C142;
        Wed, 25 May 2022 11:29:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6F40DA0632; Wed, 25 May 2022 13:29:32 +0200 (CEST)
Date:   Wed, 25 May 2022 13:29:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220525112932.d3gi7nynygkirdpi@quack3.lan>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523094023.e3rnile4wh7uiich@quack3.lan>
 <3755e40b-f817-83df-b239-b0697976c272@huawei.com>
 <20220524093026.qhwyibhgg6ulsw6r@quack3.lan>
 <26962b95-1129-60c4-dbde-6fea44c514a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26962b95-1129-60c4-dbde-6fea44c514a6@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 24-05-22 21:44:31, Baokun Li wrote:
> 在 2022/5/24 17:30, Jan Kara 写道:
> > On Mon 23-05-22 21:04:16, libaokun (A) wrote:
> > > 在 2022/5/23 17:40, Jan Kara 写道:
> > > > On Sat 21-05-22 21:42:17, Baokun Li wrote:
> > > > > When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> > > > > "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> > > > > that the fe_logical is not in the allocated range.
> > > > > In this case, it should be bug_ON.
> > > > > 
> > > > > Fixes: dfe076c106f6 ("ext4: get rid of code duplication")
> > > > > Signed-off-by: Baokun Li<libaokun1@huawei.com>
> > > > I think this is actually wrong. The original condition checks whether
> > > > start + size does not overflow the used integer type. Your condition is
> > > > much stronger and I don't think it always has to be true. E.g. allocation
> > > > goal block (start variable) can be pushed to larger values by existing
> > > > preallocation or so.
> > > > 
> > > > 								Honza
> > > > 
> > > I think there are two reasons for this:
> > > 
> > > First of all, the code here is as follows.
> > > ```
> > >          size = end - start;
> > >          [...]
> > > if (start + size <= ac->ac_o_ex.fe_logical &&
> > >                          start > ac->ac_o_ex.fe_logical) {
> > >                  ext4_msg(ac->ac_sb, KERN_ERR,
> > >                           "start %lu, size %lu, fe_logical %lu",
> > >                           (unsigned long) start, (unsigned long) size,
> > >                           (unsigned long) ac->ac_o_ex.fe_logical);
> > > BUG();
> > > }
> > >          BUG_ON(size <= 0 || size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb));
> > > ```
> > > First of all, there is no need to compare with ac_o_ex.fe_logical if it is
> > > to determine whether there is an overflow.
> > > Because the previous logic guarantees start < = ac_o_ex.fe_logical, and
> > How does it guarantee that? The logic:
> > 
> >          if (ar->pleft && start <= ar->lleft) {
> >                  size -= ar->lleft + 1 - start;
> >                  start = ar->lleft + 1;
> >          }
> > 
> > can move 'start' to further blocks...
> This is not the case. According to the code of the preceding process,
> ar->pleft and ar->pright are assigned values in ext4_ext_map_blocks.
> ar->pleft is the first allocated block found to the left by map->m_lblk
> (that is, fe_logical),
> and ar->pright is the first allocated block found to the right.
> ar->lleft and ar->lright are logical block numbers, so there must be
> "ar->lleft < ac_o_ex.fe_logical < ar->lright".

Right, I've found that out after sending my previous email. Sorry for
confusion.

> > > Secondly, the following code flow also reflects this logic.
> > > 
> > >             ext4_mb_normalize_request
> > >              >>> start + size <= ac->ac_o_ex.fe_logical
> > >             ext4_mb_regular_allocator
> > >              ext4_mb_simple_scan_group
> > >               ext4_mb_use_best_found
> > >                ext4_mb_new_preallocation
> > >                 ext4_mb_new_inode_pa
> > >                  ext4_mb_use_inode_pa
> > >                   >>> set ac->ac_b_ex.fe_len <= 0
> > >             ext4_mb_mark_diskspace_used
> > >              >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
> > > 
> > > In ext4_mb_use_inode_pa, you have the following code.
> > > ```
> > > start = pa->pa_pstart + (ac->ac_o_ex.fe_logical - pa->pa_lstart);
> > > end = min(pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len), start + EXT4_C2B(sbi,
> > > ac->ac_o_ex.fe_len));
> > > len = EXT4_NUM_B2C(sbi, end - start);
> > > ac->ac_b_ex.fe_len = len;
> > > ```
> > > The starting position in ext4_mb_mark_diskspace_used will be assert.
> > > BUG_ON(ac->ac_b_ex.fe_len <= 0);
> > > When end == start + EXT4_C2B(sbi, ac->ac_o_ex.fe_len) is used, the value of
> > > end - start must be greater than 0.
> > > However, when end == pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) occurs, this
> > > bug_ON may be triggered.
> > > When this bug_ON is triggered, that is,
> > > 
> > > ac->ac_b_ex.fe_len <= 0
> > > end - start <= 0
> > > end <= start
> > > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) <= pa->pa_pstart +
> > > (ac->ac_o_ex.fe_logical - pa->pa_lstart)
> > > pa->pa_len <= ac->ac_o_ex.fe_logical - pa->pa_lstart
> > > pa->pa_lstart + pa->pa_len <= ac->ac_o_ex.fe_logical
> > > start + size <= ac->ac_o_ex.fe_logical
> > > 
> > > So I think that "&&" here should be changed to "||".
> > Sorry, I still disagree. After some more code reading I agree that
> > ac->ac_o_ex.fe_logical is the logical block where we want allocated blocks
> > to be placed in the inode so logical extent of allocated blocks should include
> > ac->ac_o_ex.fe_logical. But I would be reluctant to make assertion you
> > suggest unless we make sure ac->ac_o_ex.fe_logical in unallocated (in which
> > case we can also remove some other code from ext4_mb_normalize_request()).
> > 
> > 									Honza
> > 
> What codes are you referring to that can be deleted?

So I though the shifting of 'start' by lleft cannot happen but then I
realized that if 'start' got aligned down, it can now be lower than lleft
so the shifting is indeed needed. So all code is needed there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
