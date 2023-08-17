Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7377F843
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351637AbjHQOEN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351678AbjHQODq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 10:03:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA32D71
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 07:03:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HE3T2c018128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692281010; bh=yLQkg9fYxfjEgbacxnWLuMof6HdNp3fGqNYnwsXsDK8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=RgvMy+BEbbBZO2mbkCOcYz8MKDPX1hdJnDY/dMQPpTJa2CzU/a0FtHwHj4PXsFH5t
         9ztfuvLqfO0v1ob/+NYtWvonCLltveJeLDTEYC5ZV73qnzeH8Ptm3RHqxxhgLb67pQ
         aqD4wlbonSlVBxI5228sanjzcp+tQe2BIIKcPFmZ2YNJNnZgL5YNxxQwKMfpwfxhkH
         fWEucD2IomI8W5+a0xxNrkL5DbChUs7+k2uQ+jzb+KWQmHLwcBZuaqAVEvjZ7+i4H8
         7amFi8M/3KB/w9rgaH3QsoxWjubzSkP1jT9rD9xRNzm5anPlKvwJ0BuJNC82JauiIG
         whrFL7YIJ6pCg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E825615C0501; Thu, 17 Aug 2023 10:03:28 -0400 (EDT)
Date:   Thu, 17 Aug 2023 10:03:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
Message-ID: <20230817140328.GY2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
 <20230816034543.GS2247938@mit.edu>
 <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 17, 2023 at 11:38:34AM +0800, Kemeng Shi wrote:
> 
> 
> on 8/16/2023 11:45 AM, Theodore Ts'o wrote:
> > On Thu, Jun 29, 2023 at 08:00:42PM +0800, Kemeng Shi wrote:
> >> In add_new_gdb_meta_bg, we assume that group could be non first
> >> group in meta block group as we call ext4_meta_bg_first_block_no
> >> to get first block of meta block group rather than call
> >> ext4_group_first_block_no for passed group directly. Then ext4_bg_has_super
> >> should be called with first group in meta group rather than new added
> >> group. Or we can call ext4_group_first_block_no instead of
> >> ext4_meta_bg_first_block_no to assume only first group of
> >> meta group will be passed.
> >> Either way, ext4_meta_bg_first_block_no will be useless and
> >> could be removed.
> > 
> > Unfortunately, I spent more time trying to understand the commit
> > description than the C code.  Perhaps this might be a better way of
> > describing the situation?
> > 
> Sorry for my poor language again, :( I will try to improve this.
> > The ext4_new descs() function calls ext4_meta_bg_first_block_no() with
> > the group paramter when the group is the first group of a meta_bg
> > (e.g., when (group % EXT4_DESC_PER_BLOCK) is zero.  So we can simplify
> > things a bit by removing ext4_meta_bg_first_block_no() and an open
> > coding its logic.
> > 
> > Does this make more sense to tou?
> > 
> This patch tries to correct gdbblock calculation in add_new_gdb_meta_bg
> in case group from caller is not the first group of meta_bg which is
> supposed to be handled by add_new_gdb_meta_bg.
> We should call ext4_bg_has_super with first group in meta_bg instead
> of group which could be non first group in meta_bg to calculate gdb
> of meta_bg.
> Fortunately, the only caller ext4_add_new_descs always call
> add_new_gdb_meta_bg with first group of meta_bg and no real issue
> will happen.

To be clear, this doesn't have a functional change given how the code
is going to be used, right?  It's really more of a cleanup with a goal
of making the code easier to understand.  If so, we should make this
explicit at the beginning of the commit description, as opposed to
putting it at the end.

In journalism this is referred to as "burying the lede"[1], where the
"lede" the most important/key piece of information.  In general, it is
desirable not to "bury the lede".  That is, the most important
information, including why people should care, and what this is doing,
at the beginning of the commit description (or article in the case of
journalsm).

[1] https://www.masterclass.com/articles/bury-the-lede-explained

					- Ted
