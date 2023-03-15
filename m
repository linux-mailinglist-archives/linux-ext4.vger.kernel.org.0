Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53EA6BBAF1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCORcZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjCORcX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 13:32:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA987B126
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 10:32:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4679F219D0;
        Wed, 15 Mar 2023 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678901538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq1rBa/2A5PWux0l8/D1GY4qskfm5Wgjlx7ASX4mnBs=;
        b=YCzumb7zFh/mANJ0pdKB0Bw7BFLUaQb+Hbyf7DBbhbXQNKxbSUctGrwh/gIzHXFOe4Y2av
        A48Fkjg5vqv27Z7jILe7DC4AEMyqqByDXvUv+ddIxOu/svwbXz7S+QC1UdrMwOWMMyUdl5
        k4zM2xWsGzhe0S5BIh1wDUDibB9kdQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678901538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cq1rBa/2A5PWux0l8/D1GY4qskfm5Wgjlx7ASX4mnBs=;
        b=cBZPxOMLfjynOCdfEPNeOxmIOZvhJL+yzGoWnY/VAzz7bBLNE6SckwCBUlJJQwC4ifFpGR
        ghSUR5+ac2U8WJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 312B413A00;
        Wed, 15 Mar 2023 17:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aVPzCyIBEmTWKgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 15 Mar 2023 17:32:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 955AFA06FD; Wed, 15 Mar 2023 18:32:17 +0100 (CET)
Date:   Wed, 15 Mar 2023 18:32:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20230315173217.to44byhvg6baf7ai@quack3>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
 <Y45eV/nA2tj8C94W@mit.edu>
 <20230112150708.y2ws5q3wu2xxow3p@quack3>
 <ea6a88c7-5603-af1d-e775-0857fc605224@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea6a88c7-5603-af1d-e775-0857fc605224@icdsoft.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-03-23 13:27:11, Ivan Zahariev wrote:
> On 12.1.2023 г. 17:07, Jan Kara wrote:
> > So after a bit of thought I agree that the commit 5c48a7df91499 ("ext4: fix
> > an use-after-free issue about data=journal writeback mode") is broken. The
> > problem is when we unlock the page in __ext4_journalled_writepage() anybody
> > else can come, writeout the page, and reclaim page buffers (due to memory
> > pressure). Previously, bh references were preventing the buffer reclaim to
> > happen but now there's nothing to prevent it.
> > 
> > My rewrite of data=journal writeback path fixes this problem as a
> > side-effect but perhaps we need a quickfix for stable kernels? Something
> > like attached patch?
> > 
> > 								Honza
> 
> Do you consider this patch production ready?

Ah, the patch has likely fallen through the cracks because I waited for
some reply and then forgot about it and Ted likely missed it inside the
thread. But yes I consider the patch safe to test on production machines -
at least it has passed testing with fstests on my test VM without any
visible issues.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
