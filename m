Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D647AAED7
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjIVJyx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 05:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjIVJyo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 05:54:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1256F7
        for <linux-ext4@vger.kernel.org>; Fri, 22 Sep 2023 02:54:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59AD11F45B;
        Fri, 22 Sep 2023 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695376477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRdT+n7Ceqf/U3w6tSMxaHw4NSmYryluxKCWa6dHsy8=;
        b=HRHLiHLRTk7atI6bdMfYadCyVxHD5dEzxS71B3xAn+Fk+dnNhc6ru8VLWdNvBA5nTUvLjJ
        8DUgAVp7dSYQyCTxlePEkqHDtEagh1/XPcdiqx5xdXhZYeRCfCOcNOxx8zgoNDVhoxHWr9
        IPZL/bpqxw8d1hoJhi54rOz0KLFAtRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695376477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kRdT+n7Ceqf/U3w6tSMxaHw4NSmYryluxKCWa6dHsy8=;
        b=zjYeXKafW+ZDLrqoBN1q1FJu56wwlcqfVOZPAaibZLoUz8CU/Xo57PEcG0aAIjIL1KOJNF
        7fXp/oPaURp0WXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A5B913478;
        Fri, 22 Sep 2023 09:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5rkjEl1kDWU0agAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 22 Sep 2023 09:54:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF01EA06B0; Fri, 22 Sep 2023 11:54:36 +0200 (CEST)
Date:   Fri, 22 Sep 2023 11:54:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mathieu Othacehe <othacehe@gnu.org>
Cc:     Marcus Hoffmann <marcus.hoffmann@othermo.de>, tytso@mit.edu,
        famzah@icdsoft.com, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20230922095436.r2rkry6nj7m5lvm6@quack3>
References: <20230315185711.GB3024297@mit.edu>
 <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
 <87r0mt41yv.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0mt41yv.fsf@gnu.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Wed 20-09-23 11:40:24, Mathieu Othacehe wrote:
> I also encountered that specific issue while migrating from 4.14 to 5.15
> with data=journal. The proposed patch fixes the issue for me. The 6.1
> branch seems to be affected as well. Would it be an option to have that
> patch applied to stable branches?

Well, Greg is rather reluctant to merge into stable tree patches that were
not included upstream. But with a good reason he could do that. I guess the
easiest is to try - take the backported fix and officially submit it to
stable@vger.kernel.org with the explanation why you are submitting
non-upstream patch - in particular that upstream solution is some 14
patch series.

Alternative solution is to backport and test the upstream solution:
bd159398a2d2 ("jdb2: Don't refuse invalidation of already invalidated buffers")
d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
265e72efa99f ("ext4: Keep pages with journalled data dirty")
5e1bdea6391d ("ext4: Clear dirty bit from pages without data to write")
1f1a55f0bf06 ("ext4: Commit transaction before writing back pages in data=journal mode")
e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
c000dfec7e88 ("ext4: Drop special handling of journalled data from extent shifting operations")
783ae448b7a2 ("ext4: Fix special handling of journalled data from extent zeroing")
56c2a0e3d90d ("ext4: Drop special handling of journalled data from ext4_evict_inode()")
7c375870fdc5 ("ext4: Drop special handling of journalled data from ext4_quota_on()")
951cafa6b80e ("ext4: Simplify handling of journalled data in ext4_bmap()")
ab382539adcb ("ext4: Update comment in mpage_prepare_extent_to_map()")
d0ab8368c175 ("Revert "ext4: Fix warnings when freezing filesystem with journaled data"")
1077b2d53ef5 ("ext4: fix fsync for non-directories")

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
