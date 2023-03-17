Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE86BE7FD
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 12:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCQLZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 07:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQLZi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 07:25:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBA58C5AA
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 04:25:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3AE081FDDE;
        Fri, 17 Mar 2023 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679052329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWG+Yn5EAQxzdh2xDZYpvdlnWCphXvTLSc2lBNlF3b4=;
        b=HN3gdng9O2oxG8BCnEjOLaPeZJECYZjEqNTn2U2UukRydeAizDCEGsjruyq3/C0cKjzZjB
        qhZh5BaCaMfSnbSS+4XIjOkT0OVbuNJwtWY7Uc2G44U7CDOyC+5LlfkGsTgy2S2bEZkxmA
        3HTtOyAKBlNGsjgBhp0Ho5qIYKJm574=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679052329;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWG+Yn5EAQxzdh2xDZYpvdlnWCphXvTLSc2lBNlF3b4=;
        b=UpOAL8dyObsfBmOFjpfYutrPUMzJZ8mQH5jP0HF3QEGtfNSfoT0kJjoSVEUoSOK3HrBcz7
        ZLgxMiBiUSs8bMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CBC713428;
        Fri, 17 Mar 2023 11:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3KX+BilOFGQVEQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 17 Mar 2023 11:25:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 523A3A06FD; Fri, 17 Mar 2023 12:25:28 +0100 (CET)
Date:   Fri, 17 Mar 2023 12:25:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huaweicloud.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 1/2] jbd2: continue to record log between each mount
Message-ID: <20230317112528.cig7fczuoezn23wy@quack3>
References: <20230314140522.3266591-1-yi.zhang@huaweicloud.com>
 <20230314140522.3266591-2-yi.zhang@huaweicloud.com>
 <20230315094826.okdarxaapjyqmlhq@quack3>
 <8c4ff3ab-4af2-58ed-4d08-3050c044f445@huawei.com>
 <20230315172817.egezft3msc5z4omm@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315172817.egezft3msc5z4omm@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-03-23 18:28:17, Jan Kara wrote:
> On Wed 15-03-23 20:37:32, Zhang Yi wrote:
> > On 2023/3/15 17:48, Jan Kara wrote:
> > > On Tue 14-03-23 22:05:21, Zhang Yi wrote:
> > >> From: Zhang Yi <yi.zhang@huawei.com>
> > >>
> > >> For a newly mounted file system, the journal committing thread always
> > >> record new transactions from the start of the journal area, no matter
> > >> whether the journal was clean or just has been recovered. So the logdump
> > >> code in debugfs cannot dump continuous logs between each mount, it is
> > >> disadvantageous to analysis corrupted file system image and locate the
> > >> file system inconsistency bugs.
> > >>
> > >> If we get a corrupted file system in the running products and want to
> > >> find out what has happened, besides lookup the system log, one effective
> > >> way is to backtrack the journal log. But we may not always run e2fsck
> > >> before each mount and the default fsck -a mode also cannot always
> > >> checkout all inconsistencies, so it could left over some inconsistencies
> > >> into the next mount until we detect it. Finally, transactions in the
> > >> journal may probably discontinuous and some relatively new transactions
> > >> has been covered, it becomes hard to analyse. If we could record
> > >> transactions continuously between each mount, we could acquire more
> > >> useful info from the journal. Like this:
> > >>
> > >>  |Previous mount checkpointed/recovered logs|Current mount logs         |
> > >>  |{------}{---}{--------} ... {------}| ... |{======}{========}...000000|
> > >>
> > >> And yes the journal area is limited and cannot record everything, the
> > >> problematic transaction may also be covered even if we do this, but
> > >> this is still useful for fuzzy tests and short-running products.
> > >>
> > >> This patch save the head blocknr in the superblock after flushing the
> > >> journal or unmounting the file system, let the next mount could continue
> > >> to record new transaction behind it. This change is backward compatible
> > >> because the old kernel does not care about the head blocknr of the
> > >> journal. It is also fine if we mount a clean old image without valid
> > >> head blocknr, we fail back to set it to s_first just like before.
> > >> Finally, for the case of mount an unclean file system, we could also get
> > >> the journal head easily after scanning/replaying the journal, it will
> > >> continue to record new transaction after the recovered transactions.
> > >>
> > >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > > 
> > > I like this implementation! I even think we could perhaps make ext4 always
> > > behave this way to not increase size of the test matrix. Or do you see any
> > > downside to this option?
> > > 
> > 
> > Thanks for your suggestion. Indeed, I don't find any side effect on this
> > option both in theory and in the actual use tests on ext4, I added a new
> > option was just from the safe point of view and let user could disable it if
> > they don't want it. I also prefer to make ext4 always behave this way.:)
> > 
> > I would like to keep the JBD2_CYCLE_RECORD flag(ocfs2 also use jbd2, I don't
> > want to disturb it until it needs), remove EXT4_MOUNT2_JOURNAL_CYCLE_RECORD
> > and always set JBD2_CYCLE_RECORD on ext4 in patch 2 in the next iteration.
> 
> Yes, that makes sense.

FWIW yesterday I'v spoken with Ted and he also agrees that we don't need
ext4 mount option for this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
