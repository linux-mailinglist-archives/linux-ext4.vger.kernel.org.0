Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19B6FB0D0
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjEHNBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 09:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjEHNBg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 09:01:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9533A5CF
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 06:01:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C003221FBF;
        Mon,  8 May 2023 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683550892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHMAqZuaFd3LimKgcftvbLRB2BK6HNxJUf8juJpgGnw=;
        b=PMUr0nve5b1BEB5dOVg5LZ5fJYnl6R3b1+1fkUQ98NW7ljTT1v0OW/KS7kUGS8LHHOxVQD
        RKwIqlGqrQHDAYWpW9NRfH42Gt9xGh/mQgUXUeLZoyG0r699CTlkV2N2rGM7L1rvsHf24h
        1ehb+K18Vv4VkXLKcLn9sGNJzzdcoiI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683550892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHMAqZuaFd3LimKgcftvbLRB2BK6HNxJUf8juJpgGnw=;
        b=4WutXT59g8orC157mO+sF5m4XsOro8woWqBX3SDcTiNrEgih4CJV/uqiNHVUAGSCwCeVoj
        6Nn+HBd+5LNrkGDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94BE4139F8;
        Mon,  8 May 2023 13:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ArpHJKzyWGS9XQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 08 May 2023 13:01:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65CBDA06C5; Sun,  7 May 2023 20:18:16 +0200 (CEST)
Date:   Sun, 7 May 2023 20:18:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ext4: allow ext4_get_group_info() to fail
Message-ID: <20230507181816.tsnqhzgajftcbsz5@quack3>
References: <20230430154311.579720-1-tytso@mit.edu>
 <20230430154311.579720-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430154311.579720-2-tytso@mit.edu>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 30-04-23 11:43:10, Theodore Ts'o wrote:
> Previously, ext4_get_group_info() would treat an invalid group number
> as BUG(), since in theory it should never happen.  However, if a
> malicious attaker (or fuzzer) modifies the superblock via the block
> device while it is the file system is mounted, it is possible for
> s_first_data_block to get set to a very large number.  In that case,
> when calculating the block group of some block number (such as the
> starting block of a preallocation region), could result in an
> underflow and very large block group number.  Then the BUG_ON check in
> ext4_get_group_info() would fire, resutling in a denial of service
> attack that can be triggered by root or someone with write access to
> the block device.
> 
> For a quality of implementation perspective, it's best that even if
> the system administrator does something that they shouldn't, that it
> will not trigger a BUG.  So instead of BUG'ing, ext4_get_group_info()
> will call ext4_error and return NULL.  We also add fallback code in
> all of the callers of ext4_get_group_info() that it might NULL.
> 
> Also, since ext4_get_group_info() was already borderline to be an
> inline function, un-inline it.  The results in a next reduction of the
> compiled text size of ext4 by roughly 2k.
> 
> Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

The patch looks good except for one small problem already found by Julia:

> @@ -2578,7 +2595,7 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>  		gdp = ext4_get_group_desc(sb, group, NULL);
>  		grp = ext4_get_group_info(sb, group);
>  
> -		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> +		if (grp && grp && EXT4_MB_GRP_NEED_INIT(grp) &&
		    ^^^ one of these should be gdp.

With this fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
