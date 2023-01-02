Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9CE65B816
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 00:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjABXKs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 18:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjABXKZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 18:10:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644785FC8;
        Mon,  2 Jan 2023 15:10:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25FAEB80D75;
        Mon,  2 Jan 2023 23:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA08C433D2;
        Mon,  2 Jan 2023 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672701021;
        bh=0h8+dL3kuY+2uz/66HOqNJxasThm2glF0SGEUSb4u9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NF+fI+4DpV5EeociW1pncfDK3l1bffYN8tJRGxlg8WuvZB2aWDTwk2hoy5rSvE3/p
         4EMlWhoTj4ZsfhZ745vL+9NhJLysKTt0b5RHbtzMcTBxSdfsx0xIE2lGXeWkyOcDAR
         938n+0A5XCc2Ie55IGZBxq28Bqe2uKbWVceRrWtCRKVWcuChntJJYSndGwJelQMM6/
         P73LaarJ60MFM9bXzVw3WIIruLJlL8avXKL2d2VmUATWZpgs0w9xYyspnwGdlfC67t
         MpaR6opfB2tKedFYEyyOGH+a3C9FB476xR1uFHz6z/eTSLx+/t7owtq1NEkydXAEEe
         T26tFjus1KdOg==
Date:   Mon, 2 Jan 2023 15:10:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Verify extent header in ext4_find_extent()
Message-ID: <Y7NkW86aVcksg3i9@sol.localdomain>
References: <20230102145833.2758-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102145833.2758-1-syoshida@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 02, 2023 at 02:58:33PM +0000, Shigeru Yoshida wrote:
> syzbot reported use-after-free in ext4_find_extent() [1].  If there is
> a corrupted file system, this can cause invalid memory access.
> 
> This patch fixes the issue by verifying extent header.
> 
> Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=cd95cb722bfa1234ac4c78345c8953ee2e7170d0 [1]
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  fs/ext4/extents.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..79bfa583ab1d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -901,6 +901,9 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  		ret = -EFSCORRUPTED;
>  		goto err;
>  	}
> +	ret = ext4_ext_check(inode, eh, depth, 0);
> +	if (ret)
> +		goto err;

This patch probably does not address the root cause of the problem.  Please see
the discussion on the very similar patch
https://lore.kernel.org/linux-ext4/20221230062931.2344157-1-tudor.ambarus@linaro.org/T/#u

- Eric
