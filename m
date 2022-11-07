Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9305261FC73
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiKGSAR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiKGR7v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 12:59:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C72A979;
        Mon,  7 Nov 2022 09:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF1FB81614;
        Mon,  7 Nov 2022 17:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D1FC433B5;
        Mon,  7 Nov 2022 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667843781;
        bh=ZvL2SvtXE64bNOxyjKwcULAZARPmSKUdp63Db30oirg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBeUdztn9sHxvNsgWQfovmFSno8CtLLbEzI/cLd+0RDyW2W+qe5jT79Azqc39pnpr
         FaJtkX+T4V5x+FEx7Tf/zWzO4+OlF9YxcJBJklqg62qsvYMJTS21DbBvUpOqO431kQ
         CcbJqpU+yw0mhWjbvZx3AD3+M92PKyEPSUIlFZFWI6iKFjoIDSwZI+3bqye5SWJQ1+
         6ojP23RTjkv4vzlwm4bkkSK0zmnli6uqnLlYtPkpMpWKjmpG/8AuAsFHpN5mqhe6tV
         aIEXJyNLQXWt+wVROZWAhqL1JdYLb3O0LsMDcPTwZqDpIZbx8uBIJqs+yzboM07Zjs
         7nCv6wfyDMsiw==
Date:   Mon, 7 Nov 2022 09:56:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
Message-ID: <Y2lGu/QTIWNpzFI3@sol.localdomain>
References: <00000000000058d01705ecddccb0@google.com>
 <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 07, 2022 at 10:46:13AM +0100, 'Alexander Potapenko' via syzkaller-bugs wrote:
>    ext4: initialize fsdata in pagecache_write()
> 
>     When aops->write_begin() does not initialize fsdata, KMSAN reports
>     an error passing the latter to aops->write_end().
> 
>     Fix this by unconditionally initializing fsdata.
> 
>     Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
>     Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
>     Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 3c640bd7ecaeb..30e3b65798b50 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode,
> const void *buf, size_t count,
>                 size_t n = min_t(size_t, count,
>                                  PAGE_SIZE - offset_in_page(pos));
>                 struct page *page;
> -               void *fsdata;
> +               void *fsdata = NULL;
>                 int res;
> 
>                 res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);

Are you sure that KMSAN should be reporting this?  The uninitialized value is
passed as a function parameter, but it's never actually used.

Anyway, this patch doesn't hurt, I suppose.  Can please you send it out as a
formal patch to linux-ext4?  It would be easy for people to miss this patch
buried in this thread.  Also, can you please send a patch to linux-f2fs-devel
for the same code in fs/f2fs/verity.c?

Thanks!

- Eric
