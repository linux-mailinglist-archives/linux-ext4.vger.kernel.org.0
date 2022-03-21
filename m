Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C00B4E2A39
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbiCUOOx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351262AbiCUOKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 10:10:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B316F061
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 07:06:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EDDB210E2;
        Mon, 21 Mar 2022 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647871581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6kfUSHigNFp47MyL0GAHesqzazPfSGpZmi+Qk1a6W0=;
        b=3K9Z+AwvKXQe63VIaavuILVrJYjnm6SBZlKvRHcbQz+bK7uCqP6l+BsqesoMfd+8oPhVa+
        hsLmeRNiCsR5l0UnIpcQNGX4qETXWGv53nZTaOLkQgXctYlJOhWs8gPKYrc2I2DtBHIIo6
        S0vFTF5lDTx/MpBFbJD02NUdYl2Hoxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647871581;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6kfUSHigNFp47MyL0GAHesqzazPfSGpZmi+Qk1a6W0=;
        b=/vcg1T9qzuUMnzoF9bWNiayf/UjHKf3CNqU7tnka/U6Wx+6NFveKSt4kRDs56D/FSBL2Ro
        qxLW3qTG20BbheCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F08D6A3B99;
        Mon, 21 Mar 2022 14:06:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F429A0610; Mon, 21 Mar 2022 15:06:17 +0100 (CET)
Date:   Mon, 21 Mar 2022 15:06:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 2/5] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20220321140617.wc2ohrorqny4leyc@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-3-harshads@google.com>
 <20220309101426.qumxztpd4weqzrcs@quack3.lan>
 <CAD+ocbyM9HdZwpB_NzKAiJTsZ78gZ_4Hsk3c21tL4ZetapqcFg@mail.gmail.com>
 <CAD+ocbzGsf3=2OK5MD_MyF=SyV63q1Z7Vg5VtkaE5FzmZ7_qqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzGsf3=2OK5MD_MyF=SyV63q1Z7Vg5VtkaE5FzmZ7_qqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry for delayed reply, I've got dragged into other things and somewhat
forgot about this...

On Fri 11-03-22 00:25:48, harshad shirwadkar wrote:
> Hmm, after removing ext4_fc_track_inode() from ext4_journal_start(), I
> see one deadlock - there are some places in code where
> ext4_mark_inode_dirty gets called while holding i_data_sem. Commit
> path requires i_data_sem to commit inode data (via ext4_map_blocks).
> So, if an inode is being committed, ext4_mark_inode_dirty may start
> waiting for the inode to commit while holding i_data_sem and the
> commit path may wait on i_data_sem.

Indeed, that is a problem.

> The right way to fix this is to
> call ext4_fc_track_inode in such places before acquiring i_data_sem in
> write mode. But that would mean we sprinkle code with more
> ext4_fc_track_inode() calls which is something that I preferably
> wanted to avoid.

So I agree calling ext4_fc_track_inode() from ext4_reserve_inode_write()
isn't going to fly as is. We need to find a better way of doing things.

> This makes me wonder though, for fast commits, is it a terrible idea
> to extend the meaning of ext4_journal_start() from "start a new
> handle" to "start a new handle with an intention to modify the passed
> inode"? Most of the handles modify only one inode, and for other
> places where we do modify multiple inodes, ext4_reserve_inode_write()
> would ensure that those inodes are tracked as well.

Well but to avoid deadlocks like you've described above you would have to
start tracking inode with explicit ext4_fc_track_inode() calls before
grabbing i_data_sem. ext4_reserve_inode_write() would be only useful for an
assertion check that indeed the inode is already tracked.

> All of the
> existing places where inode gets modified after grabbing i_data_sem,
> i_data_sem is grabbed only after starting the handle. This would take
> care of the deadlock mentioned above and similar deadlocks. Another
> advantage with doing this is that developers wouldn't need to worry
> about adding explicit ext4_fc_track_inode() calls for future changes.

Well, at least for the simple case where only one inode is modified. But I
agree that's a majority.

> If we decide to do this, we would need to do a thorough code review to
> ensure that the above rule is followed everywhere. But note that
> ext4_fc_track_inode() is idempotent, so it doesn't matter if this
> function gets called multiple times in the same handle. So to avoid
> breaking fast commits, we can be super careful and in the first
> version, we can have ext4_fc_track_range() calls in
> ext4_reserve_inode_dirty(), ext4_journal_start(), inline.c and in
> handles where i_data_sem gets acquired in write mode. We can then
> carefully evaluate each code path and remove redundant
> ext4_fc_track_range() calls.

As I wrote above, if we go this path, I'd be for ext4_fc_track_inode()
calls in ext4_journal_start() and then adding explicit calls to
ext4_fc_track_inode() where additionally needed and have only assertion
checks in ext4_reserve_inode_dirty() and other places which modify inode
metadata, to catch places which need explicit calls to
ext4_fc_track_inode(). That way we won't have any hidden deadlocks in the
code waiting to happen.

I have also another proposal for consideration how we could handle this.
Mostly branstorming now: We could also drop the need for fastcommit code to
acquire i_data_sem during commit. We could use just information in extent
status tree to provide block mapping for the fastcommit code (that does not
need i_data_sem). The only thing is we'd need to make sure modified extents
from the status tree are not evicted from memory before the appropriate
transaction commits so that they are available for appropriate fastcommit -
for that we'd probably need to add TID of the transaction that last
modified an extent and add check into the shrinker to avoid shrinking
uncommitted extents. As a bonus, we could now add to fastcommit only
extents with appropriate TID and thus save on extent logging for sparsely
modified inode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
