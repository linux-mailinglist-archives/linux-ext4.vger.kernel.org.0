Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABC63AC03
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiK1PPz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 10:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiK1PPy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 10:15:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8E15A28
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 07:15:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1FE61F8C8;
        Mon, 28 Nov 2022 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669648551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QVJSCj+0uRz/FYRihd854hgsDtwwRysXwXI7G+A4gk=;
        b=1oPrGNOE9L+VHujx37Wh9zEYcAF2GoQVRKlGMD4WutfAlEbtjIiZYjEaHVC0E5h1iUQZf3
        npZpOa+j/0xJwrKUvJeatr2dkSlLnmHNB/HPfKS+Vg95ndr4VlrDgRzI1H4ZzgOBhP86yO
        xLTFr7l688jHycdR3zA46V0PJYhcd5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669648551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QVJSCj+0uRz/FYRihd854hgsDtwwRysXwXI7G+A4gk=;
        b=Id+PNlVU1L6OX4xnLHMZ+gPWV9j2S7aFnHuTBtsaSGTpBffIuZydOuoAIaAsBggi7+6AUG
        6BzMXRAAmOBOE+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E299D13273;
        Mon, 28 Nov 2022 15:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4wRHN6fQhGMHQQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Nov 2022 15:15:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 59569A070F; Mon, 28 Nov 2022 16:15:51 +0100 (CET)
Date:   Mon, 28 Nov 2022 16:15:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: add barrier info if journal device write cache is
 not enabled
Message-ID: <20221128151551.fo6ct7nbozlqjvci@quack3>
References: <20221124135744.1488959-1-yi.zhang@huawei.com>
 <20221128101108.nslkglhz7pmflyoa@quack3>
 <02ab48e0-27d7-1a59-603a-34bd85bb2b68@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ab48e0-27d7-1a59-603a-34bd85bb2b68@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 28-11-22 21:01:07, Zhang Yi wrote:
> On 2022/11/28 18:11, Jan Kara wrote:
> > On Thu 24-11-22 21:57:44, Zhang Yi wrote:
> >> The block layer will check and suppress flush bio if the device write
> >> cache is not enabled, so the journal barrier will not go into effect
> >> even if uer specify 'barrier=1' mount option. It's dangerous if the
> >> write cache state is false negative, and we cannot distinguish such
> >> case easily. So just give an info and an inquire interface to let
> >> sysadmin know the barrier is suppressed for the case of write cache is
> >> not enabled.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Hum, so have you seen a situation when write cache information is incorrect
> > in the block layer? Does it happen often enough that it warrants extra
> > sysfs file?
> > 
> 
> Thanks for response. Yes, It often happens on some SCSI devices with RAID
> card, the disks below the RAID card enabled write cache, but the RAID driver
> declare the write cache was disabled when probing, and the RAID card seems
> cannot guarantee data writing back to disk medium on power failure. So the
> ext4 filesystem will probably be corrupted at the next startup. It's
> difficult to distinguish it's a hardware or an software problem.
> I am not familiar with the RAID card. So I don't know why the cache state
> is incorrect (maybe incorrect configured or firmware bug).

OK, thanks for info. I believe usually you're expected to disable write
cache on the disks themselves and leave caching to the RAID card. But I'm
not an expert here and it's a bit besides the point anyway ;)

> > After all you should be able to query what the block layer thinks about the
> > write cache - you definitely can for SCSI devices, I'm not sure about
> > others. So you can have a look there. Providing this info in the filesystem
> > seems like doing it in the wrong layer - I don't see anything jbd2/ext4
> > specific here...
> > 
> 
> Yes, the best way is to figure out the RAID card problem.
> This patch is not to aim to fix something in ext4. The reason why I want to add
> this in ext4 is just give a hint from the fs barrier's point of view, it show the
> barrier's running state at mount time, could help us to delimit the cache problem
> more easily when we found ext4 corruption after power failure. Before this patch,
> we could do that through SCSI probing info and /sys/block/sda/queue/write_cache
> (maybe some others?), it's not quite clear.
> 
>   [    2.520176] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> 
>   [root@localhost ~]# cat /sys/block/sda/queue/write_cache
>   write back

Yes. /sys/block/<device>/queue/write_cache is what you should query to find
whether barriers will be ignored or not. My point is - you need this for
ext4, now if you start using XFS filesystem you'd need similar patch for
XFS and then if you transition to btrfs you'd need this for btrfs as well
and all this duplication is there because you are querying through the
filesystem a property of the underlying block device. So why not ask the
block device directly?

I understand it may be more *convenient* to grab the information from the
filesystem given the infrastructure you have for gathering filesystem
information. But carrying around various sysfs files has its cost as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
