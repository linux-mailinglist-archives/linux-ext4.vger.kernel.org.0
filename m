Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC7D5B17D9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIHI5U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHI5U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:57:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF1BF756A
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:57:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC87F1F8A3;
        Thu,  8 Sep 2022 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662627437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obl0mTcf7xhT0XStiytJVYagY1eGg64RuTPV72/pNOo=;
        b=wPsdN3eNtdUTcCyAWBuD/YTG/dZhHTUpmOAwdbx8sM95T3PzdX8N9i71q1b6dTbpwYcJRJ
        CvBL6eZpUSSa3b2xoEzoUp1izuYBu1BaqDpuv/Mp2ZdU8OSRuqB9x4Jzt+Ic6vecMEGZ8E
        k0fskYYP5f4g7NF3ClBLB3Ke+pQgKj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662627437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=obl0mTcf7xhT0XStiytJVYagY1eGg64RuTPV72/pNOo=;
        b=SW81Khjh20Tc+GRypl/i6RETa56n2PRC3pUa4nd/qKHjjWkSfH7RYQpZByzXI1Tx/OZY8C
        jeLD29bSXTUKtNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBF9C1322C;
        Thu,  8 Sep 2022 08:57:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FLrDMW2uGWMcOgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 08:57:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 39B35A067E; Thu,  8 Sep 2022 10:57:17 +0200 (CEST)
Date:   Thu, 8 Sep 2022 10:57:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Avoid unnecessary spreading of allocations
 among groups
Message-ID: <20220908085717.2kln432koqxbz3ja@quack3>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-2-jack@suse.cz>
 <20220907180507.3byq5uts42e6dpkn@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907180507.3byq5uts42e6dpkn@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-09-22 23:35:07, Ritesh Harjani (IBM) wrote:
> On 22/09/06 05:29PM, Jan Kara wrote:
> > mb_set_largest_free_order() updates lists containing groups with largest
> > chunk of free space of given order. The way it updates it leads to
> > always moving the group to the tail of the list. Thus allocations
> > looking for free space of given order effectively end up cycling through
> > all groups (and due to initialization in last to first order). This
> > spreads allocations among block groups which reduces performance for
> > rotating disks or low-end flash media. Change
> > mb_set_largest_free_order() to only update lists if the order of the
> > largest free chunk in the group changed.
> 
> Nice and clear explaination. Thanks :)
> 
> This change also looks good to me.
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for review!

> One other thought to further optimize - 
> Will it make a difference if rather then adding the group to the tail of the list, 
> we add that group to the head of sbi->s_mb_largest_free_orders[new_order]. 
> 
> This is because this group is the latest from where blocks were allocated/freed,
> and hence the next allocation should first try from this group in order to keep 
> the files/extents blocks close to each other? 
> (That sometimes might help with disk firmware to avoid doing discards if the freed 
> block can be reused?)
> 
> Or does goal block will always cover that case by default and we might never
> require this? Maybe in a case of a new file within the same directory where 
> the goal group has no free blocks, but the last group attempted should be 
> retried first?

So I was also wondering about this somewhat. I think that goal group will
take care of keeping file data together so head/tail insertion should not
matter too much for one file. Maybe if the allocation comes from a
different inode, then the head/tail insertion matters but then it is not
certain whether the allocation is actually related and what its order is
(depending on that we might prefer same / different group) so I've decided
to just keep things as they are. I agree it might be interesting to
investigate and experiment with various workloads and see whether the
head/tail insertion makes a difference for some workload but I think it's a
separate project.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
