Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97926D8EC2
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Apr 2023 07:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjDFFSr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Apr 2023 01:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFSq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Apr 2023 01:18:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F50B0
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 22:18:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3365ISTw017297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 01:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1680758309; bh=bMh1mSJgCOHZluWx1RkIQocgEFB0N3X3uoQyct8sWjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QjdoudQsfNHmhXGe2J+uKQzblHoUMUS4tQg1Xitwj/K4K05hLWUFxda+JiqGQw6p5
         j+SBxqBcJUIo8StbfaKBlvygM/W9faMl/7+eURjfjzmWLfM5nrzchPfcILsWx7u1Bt
         D0s9cq9PwI6TwWP0lIucdW5D1hTIqwIU1T/rxC1AnoA4JLLaLb7UwCSTxXEnCHEE1o
         oXi4TxwAmb6GqVpvLc9eNO4wNrJhMctb8bC+QxU0ba0Q3HxfkCoAYUnDrcLOgWpGJF
         JkcAIyGGiESF1gO4SonuidWw4EriVnQifRtL8M67qPe2+5qWQDU+2mQtOpBgWw5+2N
         DGYoW3UcZbbdA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C0F2515C3ACE; Thu,  6 Apr 2023 01:18:27 -0400 (EDT)
Date:   Thu, 6 Apr 2023 01:18:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/20] ext4: set goal start correctly in
 ext4_mb_normalize_request
Message-ID: <20230406051827.GA149620@mit.edu>
References: <20230303172120.3800725-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303172120.3800725-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 04, 2023 at 01:21:01AM +0800, Kemeng Shi wrote:
> We need to set ac_g_ex to notify the goal start used in
> ext4_mb_find_by_goal. Set ac_g_ex instead of ac_f_ex in
> ext4_mb_normalize_request.
> Besides we should assure goal start is in range [first_data_block,
> blocks_count) as ext4_mb_initialize_context does.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/mballoc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..36cd545f5ab4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3993,6 +3993,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  				struct ext4_allocation_request *ar)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_super_block *es = sbi->s_es;
>  	int bsbits, max;
>  	ext4_lblk_t end;
>  	loff_t size, start_off;
> @@ -4188,18 +4189,20 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
>  
>  	/* define goal start in order to merge */
> -	if (ar->pright && (ar->lright == (start + size))) {
> +	if (ar->pright && (ar->lright == (start + size)) &&
> +	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {
>  		/* merge to the right */

I had to ammend this commit to add this check:

 	/* define goal start in order to merge */
 	if (ar->pright && (ar->lright == (start + size)) &&
+	    ar->pright >= size &&
 	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {

Without this check, it's possible for ar->pright - size to go negative
(well, underflow since it's an unsigned value).  This will later
trigger a BUG_ON, which was easily reproduced via:

   kvm-xfstests -c ext4/ext3conv generic/231

Cheers,

							- Ted
