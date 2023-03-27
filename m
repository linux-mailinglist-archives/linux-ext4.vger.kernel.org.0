Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF026CA479
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC0MrZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjC0MrY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 08:47:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEB4696;
        Mon, 27 Mar 2023 05:47:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2019F1F8B4;
        Mon, 27 Mar 2023 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679921221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmRlEne1LMoHe+e9ITUe63CYSu8QMKeN09sNHSFxHeQ=;
        b=urx9K4QGDqyN1ljNkgIljqxqdNBNLyKAINaYyXOZB5y/T8nC/m+4/RDTRK14zEmyjm64y4
        JAXCfY4rZn9FKTrraY91HwOPQPt+1BGefow4Kl3Hhybjb55H/5AjGtYu88768jWtmj231B
        R8WuGWwb6leNBHY3ZyQd46Gf+rBXai8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679921221;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmRlEne1LMoHe+e9ITUe63CYSu8QMKeN09sNHSFxHeQ=;
        b=xRG61SZDAbtXSdob4O+UzqYWufHJUkXnaoebPyGKCEMRd5pi+ghoWKhC/6kB687JtOm3hl
        Nmm1v+YRQkGadlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ABA913329;
        Mon, 27 Mar 2023 12:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SZibAkWQIWRMWAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 12:47:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E3F5A071C; Mon, 27 Mar 2023 14:47:00 +0200 (CEST)
Date:   Mon, 27 Mar 2023 14:47:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: only update i_reserved_data_blocks on successful
 block allocation
Message-ID: <20230327124700.mnldh4sosp3ptbls@quack3>
References: <20230325063443.1839558-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325063443.1839558-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 25-03-23 14:34:43, Baokun Li wrote:
> In our fault injection test, we create an ext4 file, migrate it to
> non-extent based file, then punch a hole and finally trigger a WARN_ON
> in the ext4_da_update_reserve_space():
> 
> EXT4-fs warning (device sda): ext4_da_update_reserve_space:369:
> ino 14, used 11 with only 10 reserved data blocks
> 
> When writing back a non-extent based file, if we enable delalloc, the
> number of reserved blocks will be subtracted from the number of blocks
> mapped by ext4_ind_map_blocks(), and the extent status tree will be
> updated. We update the extent status tree by first removing the old
> extent_status and then inserting the new extent_status. If the block range
> we remove happens to be in an extent, then we need to allocate another
> extent_status with ext4_es_alloc_extent().
> 
>        use old    to remove   to add new
>     |----------|------------|------------|
>               old extent_status
> 
> The problem is that the allocation of a new extent_status failed due to a
> fault injection, and __es_shrink() did not get free memory, resulting in
> a return of -ENOMEM. Then do_writepages() retries after receiving -ENOMEM,
> we map to the same extent again, and the number of reserved blocks is again
> subtracted from the number of blocks in that extent. Since the blocks in
> the same extent are subtracted twice, we end up triggering WARN_ON at
> ext4_da_update_reserve_space() because used > ei->i_reserved_data_blocks.

Hum, but this second call to ext4_map_blocks() should find already allocated
blocks in the indirect block and thus should not be subtracting
ei->i_reserved_data_blocks for the second time. What am I missing?

								Honza

> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
