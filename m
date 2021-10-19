Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF87A433195
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 10:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhJSIzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 04:55:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSIzg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 04:55:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B7C2F21976;
        Tue, 19 Oct 2021 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634633602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNpsq4NsKdsuszVjnOWf6lOfRc7G2Uj70dG+9GIT678=;
        b=YoqhmWZJ86W4GQIb9BxQ9HFmaRfMGgp7ueky+L4VYRu345ZWaXx2zoPO41PrTZh3a6kq6h
        xvq5YXq/CfyeZsGYdsTGVip3sMfqwAD/+/GC3XbMg9hFxnrAQmkRoQlJ6/ueeyEhsHlDRH
        e+YZgpvCWB4ipZ39O6zAXa7fGXrx1jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634633602;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNpsq4NsKdsuszVjnOWf6lOfRc7G2Uj70dG+9GIT678=;
        b=80LI+dl7ODiu/mjq1eH2FqnDye4Pv5GPeqhnM4qcq3EWFTcwXtzMlLnXY1YywA/Ta5/x3Y
        hmDN1DN452ORZBCA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 66472A3B84;
        Tue, 19 Oct 2021 08:53:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2B12D1E0BE5; Tue, 19 Oct 2021 10:53:19 +0200 (CEST)
Date:   Tue, 19 Oct 2021 10:53:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v3 1/5] ext4: init 'seq' with the value which set
 in 'ext4_multi_mount_protect'
Message-ID: <20211019085319.GA3255@quack2.suse.cz>
References: <20211019064959.625557-1-yebin10@huawei.com>
 <20211019064959.625557-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019064959.625557-2-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-10-21 14:49:55, Ye Bin wrote:
> If two host have the same nodename, and seq start from 0, May cause the
> detection mechanism to fail.
> So init 'seq' with the value which set in 'ext4_multi_mount_protect' to
> accelerate conflict detection.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

...

> @@ -143,6 +143,7 @@ static int kmmpd(void *data)
>  	mmp_block = le64_to_cpu(es->s_mmp_block);
>  	mmp = (struct mmp_struct *)(bh->b_data);
>  	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
> +	seq = le32_to_cpu(mmp->mmp_seq);
>  	/*
>  	 * Start with the higher mmp_check_interval and reduce it if
>  	 * the MMP block is being updated on time.

Thanks for the patch. After discussing what MMP guards against and what it
does not protect, I don't think this change is actually needed. Under
normal conditions we expect kmmpd() to only write to MMP block, checking of
MMP block is done only in ext4_multi_mount_protect(). And for checking
there to trigger, using 'seq' starting from 1 in kmmpd is enough...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
