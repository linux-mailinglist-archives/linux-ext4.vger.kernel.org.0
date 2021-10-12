Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852EB42A043
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJLItb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 04:49:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44740 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhJLIta (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 04:49:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 06FDC21FAC;
        Tue, 12 Oct 2021 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634028448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1H9U6FZdTMLg0N90m1o6mLcfzhK9dGZJ71HH3rnxZXg=;
        b=0/zM0CyoZVl6slnTaJ8guNPB+tPsoONS7QulTscas9O52uPAXO/P74CbsWP6t2QmZ7mjOO
        yBZpDuJIxKjau+7DqC/wiDQHzCCsiKS6PC+H65k4MeQXd5+eUxAsntyZlpbAaEWU9QSDTM
        oywsMOL8YPr5OEbwctdoXT9pOv6SWcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634028448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1H9U6FZdTMLg0N90m1o6mLcfzhK9dGZJ71HH3rnxZXg=;
        b=h8hk2o8uMmL2kEjW6zhLNDHLdNKBvDKi6YGFFxAt1TRLJ5hZGHwS3eOSgSX+grWXVS3mrl
        9NiPp+YqvMfqakCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id ADE23A3B95;
        Tue, 12 Oct 2021 08:47:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 760561E1409; Tue, 12 Oct 2021 10:47:27 +0200 (CEST)
Date:   Tue, 12 Oct 2021 10:47:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Message-ID: <20211012084727.GF9697@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz>
 <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <615FAF27.8070000@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 08-10-21 10:38:31, yebin wrote:
> On 2021/10/8 9:56, yebin wrote:
> > On 2021/10/7 20:31, Jan Kara wrote:
> > > On Sat 11-09-21 17:00:55, Ye Bin wrote:
> > > > kmmpd:
> > > > ...
> > > >      diff = jiffies - last_update_time;
> > > >      if (diff > mmp_check_interval * HZ) {
> > > > ...
> > > > As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
> > > > than 'mmp_update_interval', so there will never trigger detection.
> > > > Introduce last_check_time record previous check time.
> > > > 
> > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > I think the check is there only for the case where write_mmp_block() +
> > > sleep took longer than mmp_check_interval. I agree that should rarely
> > > happen but on a really busy system it is possible and in that case
> > > we would
> > > miss updating mmp block for too long and so another node could have
> > > started
> > > using the filesystem. I actually don't see a reason why kmmpd should be
> > > checking the block each mmp_check_interval as you do -
> > > mmp_check_interval
> > > is just for ext4_multi_mount_protect() to know how long it should wait
> > > before considering mmp block stale... Am I missing something?
> > > 
> > >                                 Honza
> > I'm sorry, I didn't understand the detection mechanism here before. Now
> > I understand
> > the detection mechanism here.
> > As you said, it's just an abnormal protection. There's really no problem.
> > 
> Yeah, i did test as following steps
> hostA                        hostB
>    mount
>      ext4_multi_mount_protect  -> seq == EXT4_MMP_SEQ_CLEAN
>         delay 5s after label "skip" so hostB will see seq is
> EXT4_MMP_SEQ_CLEAN
>                        mount
>                        ext4_multi_mount_protect -> seq == EXT4_MMP_SEQ_CLEAN
>                                run  kmmpd
>     run kmmpd
> 
> Actually，in this  situation kmmpd will not detect  confliction.
> In ext4_multi_mount_protect function we write mmp data first and wait
> 'wait_time * HZ'  seconds,
> read mmp data do check. Most of the time, If 'wait_time' is zero, it can pass
> check.

But how can be wait_time zero? As far as I'm reading the code, wait_time
must be at least EXT4_MMP_MIN_CHECK_INTERVAL...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
