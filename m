Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED46CA27D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjC0LeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjC0LeH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 07:34:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2714234
        for <linux-ext4@vger.kernel.org>; Mon, 27 Mar 2023 04:34:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C535F21C1F;
        Mon, 27 Mar 2023 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679916844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soOCBSXgwuQIO94Aa0Vd7JR6Ybem+69nvxCKcBYHcyA=;
        b=20OK//ZpMd8A0KfiOC0LRaXB3+XlW/BP1jDrv0K1X63obe7bgMQctQbnC2XyzuS0S2plLi
        xbbd5uNeuo17VacMu4yg7dGCFlNLomngLnyfStE82crHU+ThIsXDtnBBoHW+y2pypiHwzm
        8iwAUaYk9ISgQ1a5NpBZ4Xi+mbwEyx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679916844;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=soOCBSXgwuQIO94Aa0Vd7JR6Ybem+69nvxCKcBYHcyA=;
        b=22sEPB4iEH2C8RWKNYkK1mJKHYK2eg1+mt4TrnGOR8Z0qkpbhiXW72tLprxVV3DFyJdo31
        YdKWWuqS1zgI+6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD9FD13482;
        Mon, 27 Mar 2023 11:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tylbKix/IWRLLAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 11:34:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CD4EBA071C; Mon, 27 Mar 2023 13:34:03 +0200 (CEST)
Date:   Mon, 27 Mar 2023 13:34:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Chung-Chiang Cheng <cccheng@synology.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, kernel@cccheng.net,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
Message-ID: <20230327113403.25iafutxorqezugs@quack3>
References: <20230324092907.1341457-1-cccheng@synology.com>
 <20230327092914.mzizhh52izbvjhhv@quack3>
 <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHuHWt=LaNBwNy-1RY2-OZ4zGKEgTBfZZGWoQJSjL3ADbRRCoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 27-03-23 18:28:55, Chung-Chiang Cheng wrote:
> On Mon, Mar 27, 2023 at 5:29 PM Jan Kara <jack@suse.cz> wrote:
> >
> > As Zhang Yi already noted in his review, this is expected at least with
> > data=writeback mount option. With data=ordered this should not happen
> > though as the commit of the transaction with i_disksize update will wait
> > for page writeback to complete (this is exactly the reason why data=ordered
> > exists after all). Are you able to observe this problem with data=ordered
> > mount option?
> >
> >                                                                 Honza
> 
> It's a pity that this issue also occurs with data=ordered due to delayed
> allocation being enabled by default. If delayed allocation were disabled,
> it would not be as easy to reproduce.

Ah, ok. With data=ordered and expanding within the last block, you are
right you can see zeros at the end of the file after a crash. We were
discussing this in the past already but decided not to improve this because
the fix would have performance cost we didn't want to impose on users.

> This is because if data is written to the end of a file and the block is
> allocated, the new i_disksize will be immediately committed to the journal
> at ext4_da_write_end(), but the writeback procedure is not yet triggered.
> By default, ext4 commits the journal every 5 seconds, but a dirty page may
> not be written back until 30 seconds later. This is not a short time window,
> and any improper shutdown during this time may lead to the issue :(

Yeah, I agree. The time window is not small. What we could do and what
could even bring some performance benefit is if we moved the i_disksize
update from ext4_da_write_end() to ext4_do_writepages(). Currently we do
the i_disksize update only in mpage_map_and_submit_extent() but we could
add a similar logic when exiting from ext4_do_writepages() to update
i_disksize for written back pages beyond i_disksize which didn't need block
allocation. *Except* there is a problem that we couldn't do this i_disksize
update when the pages are written from jbd2 during ordered data writeback
(we cannot start transaction in that context). And this is nasty because
we will completely loose the i_disksize update. We could handle it by
redirtying the tail page in this case but it gets a bit ugly...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
