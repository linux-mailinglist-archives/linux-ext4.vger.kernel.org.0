Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A35632868
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 16:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiKUPkw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiKUPkv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 10:40:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9A84B98C
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 07:40:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4590921AB1;
        Mon, 21 Nov 2022 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669045249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcfepNWTvOXysC6fXh1QuniRbBFvGDhnqa0/pAPOEmM=;
        b=I1moyzKYxqa7I+rF1PEQm+i74T7vzz3f429x0FZduxIRrqFjV5IZq0+ocehYa71byKhj8F
        7wi6K6BDsvvJh4SNRv/QuKFwKPMUZMBhDYu886L0hNr4ckTkInMjAy8JaGohbK/qoK005w
        BnG36AN2Dl5DcDrD7Dlc+6yCnnPRNEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669045249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcfepNWTvOXysC6fXh1QuniRbBFvGDhnqa0/pAPOEmM=;
        b=8Wp/z2Psux05Y3bk7hc+b/5cHGO6RgsNwblTAl4FeoqI4hFeEpqAhTLlGB7IOYNeF6iioZ
        sUvRMDH21PgSTDCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 371521376E;
        Mon, 21 Nov 2022 15:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7z5oDQGce2MWRwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 15:40:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C2A36A070A; Mon, 21 Nov 2022 16:40:48 +0100 (CET)
Date:   Mon, 21 Nov 2022 16:40:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Jan Kara <jack@suse.cz>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221121154048.iccqmx7zajhxh4aq@quack3>
References: <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
 <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111142424.vwt4khbtfzd5foiy@quack3>
 <20221111151029.GA27244@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221111155238.GA32201@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221121133559.srie6oy47udavj52@quack3>
 <20221121150018.tq63ot6qja3mfhpw@quack3>
 <a98303db-85df-a64d-d672-c16d1e0d8b49@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98303db-85df-a64d-d672-c16d1e0d8b49@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-11-22 16:18:09, Thorsten Leemhuis wrote:
> On 21.11.22 16:00, Jan Kara wrote:
> > OK, attached patch fixes the deadlock for me. Can you test whether it fixes
> > the problem for you as well? Thanks!
> 
> Jan, many thx for taking care of this. There is one small thing to
> improve, please add the following tags to your patch:
> 
> Link:
> https://lore.kernel.org/r/c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com/
 
Good point. Thanks, added!

> Not sure, maybe a reported-by for Syzbot would be good as well, see:
> https://lore.kernel.org/linux-ext4/000000000000892a3005e5b5d96c@google.com/

The syzbot report is actually unrelated. So far I think that the bisection
that landed guys on the same commit as syzbot was just luck or maybe change
in timing that made the problem easier to reproduce. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
