Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9172B632
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 05:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFLDtT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 23:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLDtT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 23:49:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41821C5
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 20:49:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35C3n0se011111
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 23:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686541742; bh=KhD4Msyd18EQd1OxIDdgg+9jv++6WRUuUwScaItWa4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kNct1Myoj6tmYW5wxfZebiqaZQjLsqehDYRKuHi+afMGgRFB+a6PnAT2Vveg9M8j1
         oHcc3BIv8+KE6vo9n61sVQF5QI5d7S2pLIlPW3YwaWwt6zkAooVGJ6VBvwWupl7K16
         R3Z3+bETZZ/ecuQmEG0njC0WFXpm5yf7k0f1guk8/5VQFlUQ3pMb1VhWrvliZ39sW9
         6dg1f+yrUXTbMxuQ9MnduEzkvPiupMpWdZp72sXoh97j1DQ76T102fNO5YXjbpSYuE
         eUK7TgcyI/MaxA/gmeZiQD22FhA+u4mYNeWNDgWDWt2d709u6+0WT906jzMH/TE+AN
         POSIfMXYLHwJA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AA7AB15C00B0; Sun, 11 Jun 2023 23:49:00 -0400 (EDT)
Date:   Sun, 11 Jun 2023 23:49:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
Message-ID: <20230612034900.GI1436857@mit.edu>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-14-shikemeng@huaweicloud.com>
 <20230611050532.GE1436857@mit.edu>
 <cd236fdb-c48c-69b0-10a3-3df8a34f0a6e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd236fdb-c48c-69b0-10a3-3df8a34f0a6e@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 12, 2023 at 10:24:55AM +0800, Kemeng Shi wrote:

> Hi ted, sorry for this issue. This patch added a WARN_ON for case that we free block
> to uninitialized block group which should be invalid.
> We can simply remove the WARN_ON to allow free on uninitialized block group as old
> way for emergency fix and I will find out why we free blocks to uninitialized block
> group in fast commit code path and is it a valid behavior.

What I've done for now in the dev branch was to drop patches 12
through 19 of this patch series.  That seemed to be a good break
point, and I wanted to make sure we had something working so we can
start doing a lot more intesive testing on the patches so far.

Also, that way, when you resend the last 8 patches in the patch
series, we can make sure they get a proper review as opposed to making
changes on the fly.

The current contents of the dev branch are:

% git log --reverse --oneline origin..dev
40fa8be3852f ext4: kill unused function ext4_journalled_write_inline_data
a030569c34be ext4: Change remaining tracepoints to use folio
d1ffc6fb5ded ext4: Make mpage_journal_page_buffers use folio
5ac99c22fa84 ext4: Make ext4_write_inline_data_end() use folio
d578dfc510cf ext4: Call fsverity_verify_folio()
30f0bd64ed09 ext4: fix wrong unit use in ext4_mb_normalize_request
b9dc976cc348 ext4: fix unit mismatch in ext4_mb_new_blocks_simple
9afc5e21107a ext4: fix wrong unit use in ext4_mb_find_by_goal
860f86ccff6e ext4: treat stripe in block unit
710c384f1536 ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
f242d8a98a6f ext4: remove ext4_block_group and ext4_block_group_offset declaration
5b859728b98b ext4: try all groups in ext4_mb_new_blocks_simple
ea7bbd168135 ext4: get block from bh before pass it to ext4_free_blocks_simple in ext4_free_blocks
757d9100a5d1 ext4: remove unsed parameter and unnecessary forward declaration of ext4_mb_new_blocks_simple
5d62e6da25f5 ext4: fix wrong unit use in ext4_mb_clear_bb
993d22f0a250 ext4: fix wrong unit use in ext4_mb_new_blocks
bf4f2aa4844a ext4: mballoc: Remove useless setting of ac_criteria
743f4dd07bf9 ext4: Remove unused extern variables declaration
bc40109767b3 ext4: Convert mballoc cr (criteria) to enum
52e3814a1342 ext4: Add per CR extent scanned counter
a15c09da1255 ext4: Add counter to track successful allocation of goal length
26cbe38f0275 ext4: Avoid scanning smaller extents in BG during CR1
9c8f8195852c ext4: Don't skip prefetching BLOCK_UNINIT groups
cd303d98b9b5 ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs
ea639ce794e5 ext4: Abstract out logic to search average fragment list
b080c84db854 ext4: Add allocation criteria 1.5 (CR1_5)
3a08f7ac3bfa ext4: Give symbolic names to mballoc criterias
d14b5d0b1373 ext4: only update i_reserved_data_blocks on successful block allocation
b352d1f09a20 ext4: add a new helper to check if es must be kept
579c020ea7b7 ext4: factor out __es_alloc_extent() and __es_free_extent()
f4ddcde91d00 ext4: use pre-allocated es in __es_insert_extent()
e77481862663 ext4: use pre-allocated es in __es_remove_extent()
28774513875c ext4: using nofail preallocation in ext4_es_remove_extent()
e109a1db5b09 ext4: using nofail preallocation in ext4_es_insert_delayed_block()
14d876070f03 ext4: using nofail preallocation in ext4_es_insert_extent()
2af6f615b18b ext4: make ext4_es_remove_extent() return void
0ee9cccd1971 ext4: make ext4_es_insert_delayed_block() return void
7a7c285c485d ext4: make ext4_es_insert_extent() return void
9d1c6dea1aa3 ext4: make ext4_zeroout_es() return void
2e3f4cdef544 ext4: clean up mballoc criteria comments
acef67482edf ext4: allow concurrent unaligned dio overwrites
63bc068f0d1a ext4: Fix reusing stale buffer heads from last failed mounting
3a57c2f88be3 ext4: ext4_put_super: Remove redundant checking for 'sbi->s_journal_bdev'
6b960d2155f9 jbd2: remove unused feature macros
4b049709e652 jbd2: switch to check format version in superblock directly
d9eafe0afafa jbd2: factor out journal initialization from journal_get_superblock()
6eecd1f4c7ef jbd2: remove j_format_version
431ca11fafd3 jbd2: continue to record log between each mount
2ea31402649c ext4: add journal cycled recording support
a228f0e153f6 ext4: update doc about journal superblock description
f9c45d83f4da ext4: turning quotas off if mount failed after enable quotas
5404e4738054 ext4: refactoring to use the unified helper ext4_quotas_off()
d3ab1bca26b4 jbd2: recheck chechpointing non-dirty buffer
7b0cfe40a991 jbd2: remove t_checkpoint_io_list
e86f802ab8d4 jbd2: remove journal_clean_one_cp_list()
e8ece5c78f36 jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint
cdffaad9649e jbd2: fix a race when checking checkpoint buffer busy
11761ed6026e jbd2: remove __journal_try_to_free_buffer()

Cheers,

					- Ted
