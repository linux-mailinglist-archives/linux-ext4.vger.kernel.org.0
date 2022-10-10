Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA5B5FA0C4
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJJO62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJJO6H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 10:58:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9A74CD7
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 07:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02484B80C90
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDB1C433D6;
        Mon, 10 Oct 2022 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665413837;
        bh=xiSHqu+Yq6V1t4rTQ0v2ZquPscVGf30SjcHdk4O0WQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNfa+gO9r/57T6FqVLCHMJ3dIE+gl7AGIWKYoO1D8P9ilJrRaRTU1cVFZrjoxIHs+
         7zpqfJhvBFdbIn5gWCprO/fb166JTHvT8rn6Zn35RW6QzvrMDInfIqkDoUK8kt4jW2
         ILxuQ5rdLeFNhRCSm9yV5+tBZ7ghIbikdg8W0gDUBb9aeqgS/Yrl6rSCZfiKiHBIOG
         xWYyZZ7/XYXiV1gia+qx3Ad8sY1Emia7XDw0qFv1Qf/m+vP46rD22qINaKQiPhOT2o
         E6h8+Z2seyDvnhBGqA0hYzrA8acrOXa+JM9CeeLAnK1XDoF0OkhavCzvDTrALsFSe+
         1xOYB7+5exvkg==
Date:   Mon, 10 Oct 2022 07:57:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>, liuzhiqiang26@huawei.com,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH v2] misc/fsck.c: Processes may kill other processes.
Message-ID: <Y0QyzHbcnBrUBlkP@magnolia>
References: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 10, 2022 at 04:56:58PM +0800, zhanchengbin wrote:
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Ted: Perhaps it's time to retire fsck.c in the e2fsprogs distribution?

--D

> ---
> V1->V2:
>   Anything <= 0 is a bug and can have unexpected consequences if
> we actually call the kill(). So change inst->pid==-1 to inst->pid<=0.
> 
>  misc/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..c56d1b00 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>  	for (inst = instance_list; inst; inst = inst->next) {
>  		if (inst->flags & FLAG_DONE)
>  			continue;
> +		if (inst->pid <= 0)
> +			continue;
>  		kill(inst->pid, signum);
>  		n++;
>  	}
> -- 
> 2.27.0
> 
