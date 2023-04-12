Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2856DF226
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDLKqU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDLKqF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 06:46:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017626EBA
        for <linux-ext4@vger.kernel.org>; Wed, 12 Apr 2023 03:45:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E30321904;
        Wed, 12 Apr 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681296347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gV7aw4GNKVTfmkWJMPKS2hW4fsH8yzXTs9XZO+krCN8=;
        b=J0RResVIYpOlCAGeHkGK1iMtpbFx46idG37PN77biFcRV+XUCNsnOs2P2XyYVkChU8Pt0F
        AHNT0Dhpw1JNW63tGRUmt/6hqRZZnGthDVbgIN9PH9vwwh+K3YBW5h4qVLrOypHvgN9484
        j6SWEyK2ANM8T3Zff0HQ3EmDG+PYn58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681296347;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gV7aw4GNKVTfmkWJMPKS2hW4fsH8yzXTs9XZO+krCN8=;
        b=zuQoW9iT7uTZAXeUqb41dLCgZWnp5JeFNlmP0lSyQ3qq+QFxB2WMXCF2fiRPFhk0JVB3nX
        5yglq1QUOo6bSyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F939132C7;
        Wed, 12 Apr 2023 10:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Tz2ItuLNmTfIgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 10:45:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 13D6CA0732; Wed, 12 Apr 2023 12:45:47 +0200 (CEST)
Date:   Wed, 12 Apr 2023 12:45:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, yi.zhang@huawei.com,
        jack@suse.cz, sunjunchao <sunjunchao@yanrongyun.com>
Subject: Re: [PATCH] ext4: remove BUG_ON which will be triggered in race
 scenario
Message-ID: <20230412104547.7uaqukrrhvxuy5xi@quack3>
References: <20230412074737.5769-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412074737.5769-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 12-04-23 00:47:37, JunChao Sun wrote:
> From: sunjunchao <sunjunchao@yanrongyun.com>
> 
> There is a BUG_ON statement which will be triggered in the
> following scenario, let's remove it.
> 
> thread0                                         thread1
> ext4_write_begin(inode0)
>     ->ext4_try_to_write_inline_data()
>         written some bits successfully
> ext4_write_end(inode0)
>     ->ext4_write_inline_data_end()
>                                             ext4_write_begin(inode0)
>                                                 ->ext4_try_to_write_inline_data()
>                                                     ->ext4_convert_inline_data_to_extent()
>                                                         ->ext4_write_lock_xattr()
>                                                             ->ext4_destroy_inline_data_nolock()
>                                                                 ->ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>                                                         ->ext4_write_unlock_xattr()
>         ->ext4_write_lock_xattr()
>         ->BUG_ON(!ext4_has_inline_data()) will be triggered
> 
> The problematic logic is that ext4_write_end() test ext4_has_inline_data()
> without holding xattr_sem, and ext4_write_inline_data_end() test it again using
> a BUG_ON() with holding xattr_sem.

Were you able to actually hit this? Because inode->i_rwsem should be
protecting us from races like this so I don't think the above described
scenario can happen.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
