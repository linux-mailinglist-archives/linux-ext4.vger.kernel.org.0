Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7762F6B97F9
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCNO3X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCNO2z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 10:28:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25605AB091;
        Tue, 14 Mar 2023 07:28:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CA3BC1F895;
        Tue, 14 Mar 2023 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678804111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCcOdf1nnVpnfjTuGj3SsO3HX+7vkRPWu3fXpvS5WSM=;
        b=nycej6z55OjCsdvEj465+ZD+BukwJ3d2nouenddCzgQKfqdhY1W9oEyNp5DesjbxYi05IN
        lXASIsnRh9lOPcXq4fcHTLEnKvF3vDZ8F8a0X1UbQD/m+kl+y1/xJPiRVfdAT8cQBWXgsM
        RoMVg+nF3u2jQ8VhW2w7bodEgA0WbHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678804111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCcOdf1nnVpnfjTuGj3SsO3HX+7vkRPWu3fXpvS5WSM=;
        b=lZ0VxIKnvWRY4a5gJNE8inRQhtdLBw+khqGVDDbA0yLmLtiMvKXllXT13dTJqTFqBEq18g
        Y8MAwUszKBBPGlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B21A413A26;
        Tue, 14 Mar 2023 14:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZYhuK4+EEGQHHgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 14:28:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1FD8EA06FD; Tue, 14 Mar 2023 15:28:31 +0100 (CET)
Date:   Tue, 14 Mar 2023 15:28:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, tudor.ambarus@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 1/5] ext4: Fix reusing stale buffer heads from last
 failed mounting
Message-ID: <20230314142831.75ste5im66rx4mt3@quack3>
References: <20230313132021.672134-1-chengzhihao1@huawei.com>
 <20230313132021.672134-2-chengzhihao1@huawei.com>
 <20230314113342.74g2pfwe5y7b5poa@quack3>
 <b7d108d6-9e5a-d88a-305d-932e75098b09@huawei.com>
 <20230314121125.tnz22hckcaj46kp6@quack3>
 <f86584f6-3877-ff18-47a1-2efaa12d18b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f86584f6-3877-ff18-47a1-2efaa12d18b2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-03-23 20:31:43, Zhihao Cheng wrote:
> > On Tue 14-03-23 20:01:46, Zhihao Cheng wrote:
> > > 在 2023/3/14 19:33, Jan Kara 写道:
> > > Hi Jan,
> > > 
> > > > 
> > > > > @@ -1271,14 +1277,8 @@ static void ext4_put_super(struct super_block *sb)
> > > > >    	sync_blockdev(sb->s_bdev);
> > > > >    	invalidate_bdev(sb->s_bdev);
> > > 
> > > For journal in the inode case, journal bhs come from block device, which
> > > means buffers will be dropped after this line 'invalidate_bdev(sb->s_bdev)'
> > > being executed.
> > 
> > Right, I've missed that. But then why do you remove the sbi->s_journal_bdev
> > != sb->s_bdev condition below?
> > 
> 
> I think 'sbi->s_journal_bdev != sb->s_bdev' always becomes true if
> sbi->s_journal_bdev exists.

OK, fair point. But please move this cleanup into a separate commit with
this justification. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
