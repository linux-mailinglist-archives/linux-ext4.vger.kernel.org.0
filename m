Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E537CF872
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 14:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbjJSMLa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbjJSMLS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 08:11:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568F10E2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Oct 2023 05:11:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD9FA21A78;
        Thu, 19 Oct 2023 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697717458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhtXMv6Cv6xvV2k/OkFzS3BpOpkLlRqD4tPhIw5ugUM=;
        b=D2C0pFggyqT7te2/+pSZLbyEaE3HFacuxWXrdBvMLd2g6qZpkGKSZwjjONr3zbjd2gMQz8
        AisgZlaAWm+zfoBdRqhCyMjEN3Tm1tvcQ5cL+dahvo4vDWo0jm/Z0kRm4RjV1GXXhM/sh9
        BsNtyMjzCrsP5cY6pMx7EPjxG6O58os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697717458;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lhtXMv6Cv6xvV2k/OkFzS3BpOpkLlRqD4tPhIw5ugUM=;
        b=soyX+qVKzg8+ZkGrFrYVkgZM4YFcJf2XQod10f9ZOiebxTzEsh6xqwuG+eOcUo3deYzbfW
        OyJ1F//0+C63CCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A945139C2;
        Thu, 19 Oct 2023 12:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZeZCItIcMWWTNQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 12:10:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE2D0A06B0; Thu, 19 Oct 2023 14:10:57 +0200 (CEST)
Date:   Thu, 19 Oct 2023 14:10:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Joseph Qi <jiangqi903@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v3] ext4: Properly sync file size update after O_SYNC
 direct IO
Message-ID: <20231019121057.rbvfwgyw4dluk3zj@quack3>
References: <20231013121350.26872-1-jack@suse.cz>
 <f04981be-5dac-c1e9-36a7-762c6bcf4d32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04981be-5dac-c1e9-36a7-762c6bcf4d32@gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.05
X-Spamd-Result: default: False [-5.05 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-2.95)[99.78%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[suse.cz,mit.edu,vger.kernel.org,gmail.com,linux.alibaba.com,fromorbit.com]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-10-23 14:45:49, Joseph Qi wrote:
> On 10/13/23 8:13 PM, Jan Kara wrote:
> > Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> > sync file size update and thus if we crash at unfortunate moment, the
> > file can have smaller size although O_SYNC IO has reported successful
> > completion. The problem happens because update of on-disk inode size is
> > handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> > dio_complete() in particular) has returned and generic_file_sync() gets
> > called by dio_complete(). Fix the problem by handling on-disk inode size
> > update directly in our ->end_io completion handler.
> > 
> > References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> > Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > CC: stable@vger.kernel.org
> > Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Tested with the reproducer after applying to 6.6-rc5,
> Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Thanks for testing!

> BTW, once backported to older kernel like 5.10, it seems that it depends
> on the following commit:
> 936e114a245b iomap: update ki_pos a little later in iomap_dio_complete
> 
> Otherwise, it will fail the following xfstests cases:
> generic/091 generic/094 generic/225 generic/263 generic/311 generic/617

That is kind of curious because that commit should not influence how the
ext4 fix behaves. It only influences what is in iocb->ki_pos when we are
invalidating pagecache pages...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
