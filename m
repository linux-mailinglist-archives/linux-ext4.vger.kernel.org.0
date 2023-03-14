Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59156B92BF
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjCNMLm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 08:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCNMLj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 08:11:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6153136CD;
        Tue, 14 Mar 2023 05:11:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E53921F40;
        Tue, 14 Mar 2023 12:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678795886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2dHuFPNx3KCvvsboJ162WK1k4dyig5+4Y9mV/1pyXo=;
        b=GYkqm4rYsXwWrs4MCP4gre2izmaNULMmpVlaRo8TWt30K/brTSjQZokav8SNL4xtZ/LBmo
        ZAzOV3nLyzCInw92hzbeKdZqui7SC7sx+tODdJke7Eeggv7TpAj95dkAm5ibbjpGjb5N/V
        QMKB9YC8XOy0o4S0aFJT0mK49YfnYk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678795886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2dHuFPNx3KCvvsboJ162WK1k4dyig5+4Y9mV/1pyXo=;
        b=IJa08WT6+jbTyaV/Z3al53p/eRMy4hVeUExX3gyNYa+KDurAbDT9RmbhnaQ79AWRLrkO2U
        a8E7CDFb40gStOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3835113A26;
        Tue, 14 Mar 2023 12:11:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k6qoDW5kEGT1TAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 12:11:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91E25A06FD; Tue, 14 Mar 2023 13:11:25 +0100 (CET)
Date:   Tue, 14 Mar 2023 13:11:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, tudor.ambarus@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 1/5] ext4: Fix reusing stale buffer heads from last
 failed mounting
Message-ID: <20230314121125.tnz22hckcaj46kp6@quack3>
References: <20230313132021.672134-1-chengzhihao1@huawei.com>
 <20230313132021.672134-2-chengzhihao1@huawei.com>
 <20230314113342.74g2pfwe5y7b5poa@quack3>
 <b7d108d6-9e5a-d88a-305d-932e75098b09@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7d108d6-9e5a-d88a-305d-932e75098b09@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-03-23 20:01:46, Zhihao Cheng wrote:
> 在 2023/3/14 19:33, Jan Kara 写道:
> Hi Jan,
> 
> > 
> > > @@ -1271,14 +1277,8 @@ static void ext4_put_super(struct super_block *sb)
> > >   	sync_blockdev(sb->s_bdev);
> > >   	invalidate_bdev(sb->s_bdev);
> 
> For journal in the inode case, journal bhs come from block device, which
> means buffers will be dropped after this line 'invalidate_bdev(sb->s_bdev)'
> being executed.

Right, I've missed that. But then why do you remove the sbi->s_journal_bdev
!= sb->s_bdev condition below?

> > > -	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
> > > -		/*
> > > -		 * Invalidate the journal device's buffers.  We don't want them
> > > -		 * floating about in memory - the physical journal device may
> > > -		 * hotswapped, and it breaks the `ro-after' testing code.
> > > -		 */
> > > +	if (sbi->s_journal_bdev) {
> > >   		sync_blockdev(sbi->s_journal_bdev);
> > > -		invalidate_bdev(sbi->s_journal_bdev);
> > >   		ext4_blkdev_remove(sbi);
> > >   	}
> >  > Hum, but this will invalidate bhs only if journal is stored on a block
> > device. If journal is in the inode (the common case), we won't invalidate
> > anything (sbi->s_journal_bdev is NULL) and the same problem can happen?
> > 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
