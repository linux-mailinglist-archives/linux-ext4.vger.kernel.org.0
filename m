Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7345B17EF
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIHJD2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHJD1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:03:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA99FD23D
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:03:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D576133E62;
        Thu,  8 Sep 2022 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662627804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48LcsDgjIxYPdPBigHvE+EJ2px8jIb3sWmT1t4vPf98=;
        b=ax/qnY9O2vEVxqdJuizzYUYjQ48kdTK5JLyVzCYI8OQJ1btYD2gHekTFaCf0aqc+UBWmgW
        epm/B2O3HflAP9HbUc+bs/NiIkzUFYlF8OC3hL0LHp4w2Jlh6+3I9Mvi91dKrG42sSJGHf
        hvZiL43SIqDJDd1aSIuu+ZLvT6sHDGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662627804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=48LcsDgjIxYPdPBigHvE+EJ2px8jIb3sWmT1t4vPf98=;
        b=gVAob4V2LRV8ypoVH2F+ONgAbWSIooJtTAo0If7lbn88/ZwTwQ+d+lHWO9SQvrY/Hi7u7Q
        YhQWJMqe4wh5UpCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAD5B1322C;
        Thu,  8 Sep 2022 09:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s3uaLdyvGWPjPAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:03:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F0B23A067E; Thu,  8 Sep 2022 11:03:23 +0200 (CEST)
Date:   Thu, 8 Sep 2022 11:03:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <20220908090323.e4enzh5ahxxw64ic@quack3>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-5-jack@suse.cz>
 <YxmoBpQdRqh/e4ol@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxmoBpQdRqh/e4ol@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-09-22 13:59:58, Ojaswin Mujoo wrote:
> Hi Jan,
> 
> On Tue, Sep 06, 2022 at 05:29:11PM +0200, Jan Kara wrote:
> >  
> >  ** snip **
> >  /*
> >   * Choose next group by traversing average fragment size tree. Updates *new_cr
> Maybe we can change this to "average fragment size list of suitable
> order"

Right. Fixed. Thanks for catching this.

> > - * if cr lvel needs an update. Sets EXT4_MB_SEARCH_NEXT_LINEAR to indicate that
> > - * the linear search should continue for one iteration since there's lock
> > - * contention on the rb tree lock.
> > + * if cr level needs an update. 
> >   */
> >  static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
> >  		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> >  {
> >  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> > -	int avg_fragment_size, best_so_far;
> > -	struct rb_node *node, *found;
> > -	struct ext4_group_info *grp;
> 
> Other than that, this patch along with the updated mb_structs_summary
> proc file change looks good to me.

Thanks for review & testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
