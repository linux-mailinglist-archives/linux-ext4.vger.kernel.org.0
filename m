Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96927804EA
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjHRDoN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 23:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357759AbjHRDoB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 23:44:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770E358E
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 20:43:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I3hUQd025964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 23:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692330212; bh=6qFJq0mymitaeOHznSmVbaME+4I05RZS378bdsMEjRI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=avEIlt8u4S8hH7Rl+FY2stU7xmBiE8yxVd/K87wzK4TuNtDMrl0zwMpkKSnvXGtdI
         1s1RFaLBa+dzjW0O+nqFkwAmjDSGqYiDaBsLRllHZsOkJ9FRtazxzc582i5zWKG+w6
         0PFHx1a+qiP5VCkkNIWKZjjYxDWsabAutQlIcdrxHtmLzPgn7sSg/2Ct0cS9yWnPDZ
         KTJByPb2q+pPm4cvY5n+9z4ZXOT9a4R6698qfy6yUhgAyvafLVeNvMI0jsdOdnsoe3
         Gb/zY1EZej+FYUCZhxkUJTQsPjVnKyQUIooCyj8p5d8fuxcQROX73v9advNIf1O8Ny
         XVrBGtmmYe7QA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 154E215C0501; Thu, 17 Aug 2023 23:43:30 -0400 (EDT)
Date:   Thu, 17 Aug 2023 23:43:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Fengnan Chang <changfengnan@bytedance.com>
Cc:     adilger.kernel@dilger.ca, guoqing.jiang@linux.dev,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3] ext4: improve trim efficiency
Message-ID: <20230818034330.GE3464136@mit.edu>
References: <20230725121848.26865-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725121848.26865-1-changfengnan@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 25, 2023 at 08:18:48PM +0800, Fengnan Chang wrote:
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.

Thanks for the patch.  A few things that I'd like to see changed.

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..b75ca1df0d30 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>   * be called with under the group lock.
>   */
>  static int ext4_trim_extent(struct super_block *sb,
> -		int start, int count, struct ext4_buddy *e4b)
> +		int start, int count, bool noalloc, struct ext4_buddy *e4b,
> +		struct bio **biop, struct ext4_free_data **entryp)

The function ext4_trim_extent() is used in one place, by
ext4_try_to_trim_range().  So instead of adding the new parameters
noalloc and extryp...

> @@ -6812,9 +6813,16 @@ __acquires(bitlock)
>  	 */
>  	mb_mark_used(e4b, &ex);
>  	ext4_unlock_group(sb, group);
> -	ret = ext4_issue_discard(sb, group, start, count, NULL);
> +	ret = ext4_issue_discard(sb, group, start, count, biop);
> +	if (!ret && !noalloc) {
> +		struct ext4_free_data *entry = kmem_cache_alloc(ext4_free_data_cachep,
> +				GFP_NOFS|__GFP_NOFAIL);
> +		entry->efd_start_cluster = start;
> +		entry->efd_count = count;
> +		*entryp  = entry;
> +	}
> +

... I think it might be better to move the allocation and
initialization the ext4_free_data structure to ext4_trim_extent()'s
caller.

In the current patch, we are adding the entry to the linked list, and
we actually *use* the linked list in ext4_try_to_trim_range().  By
move the code which allocates the entry to the same place, we
eliminate some extra variables added to the ext4_trim_extent()
function, and it makes the code easier to read.

In fact, given that ext4_trim_extent() is used only once by its
caller, we could just inline the code (which isn't actually all that
much) into ext4_Try_to_trim_range().  That would eliminate the need
for the __acquires(bitlock) and __release(bitlock) sparse annotations,
as well as the "assert_spin_locked()".

That also keeps the mb_mark_used() and mb_free_blocks() calls in the
same function, which again improves code readability.

Thanks,

						- Ted
