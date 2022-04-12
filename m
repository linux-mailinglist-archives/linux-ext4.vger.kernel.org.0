Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A404FE57E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiDLQEA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDLQEA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 12:04:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D94E3AE
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 09:01:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 237BB1F43E3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649779301;
        bh=UmlI0ov6iXSmCIfRCqDAvCY7sRzc+oGQlKSZMdiln+Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Q2STFlVjvq+ku1t6e7DttaNVvdpzSsrBULgBg+tzLjS6+OX6OIsUN3cSFX8bhvXhC
         wBNuqOqxr96RxKVUlO8jFk9KX42v3Ek3kPUBZ9BsE6hJNsHEL2XCrxPIdsb48Jpcq5
         EZQLyDmRPM9tJH5jGKjaFb6/7AZMQJvgSKPP9LiASALeZdci+PXdg6xaxlKjHz0xOu
         6wrOBq3BtbM+uiwpvNiLy0QJLfj3H+0oYz99iw0OVY3KAMSEckc/sf1SCukZ9oZ785
         ADK5Nk+GXMznl2lgCwxvVL/6PsVGRvg+aiiLKX5ALzbCJDoSA18Qs3B89o7l7Yf5sO
         YdPUHKUsave0g==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yukuai3@huawei.com>,
        <yebin10@huawei.com>, <liuzhiqiang26@huawei.com>,
        <liangyun2@huawei.com>
Subject: Re: [RFC PATCH] ext4: add unmount filesystem message
Organization: Collabora
References: <20220412145320.2669897-1-yi.zhang@huawei.com>
Date:   Tue, 12 Apr 2022 12:01:37 -0400
In-Reply-To: <20220412145320.2669897-1-yi.zhang@huawei.com> (Zhang Yi's
        message of "Tue, 12 Apr 2022 22:53:20 +0800")
Message-ID: <87pmlmcmu6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Zhang Yi <yi.zhang@huawei.com> writes:

> Now that we have kernel message at mount time, system administrator
> could acquire the mount time, device and options easily. But we don't
> have corresponding unmounting message at umount time, so we cannot know
> if someone umount a filesystem easily. Some of the modern filesystems
> (e.g. xfs) have the umounting kernel message, so add one for ext4
> filesystem for convenience.
>
>  EXT4-fs (sdb): mounted filesystem with ordered data mode. Quota mode: none.
>  EXT4-fs (sdb): unmounting filesystem.

I don't think sysadmins should be relying on the kernel log for this,
since the information can easily be overwritten by new messages there.
Is there a reason why you can't just monitor /proc/self/mountinfo?

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c..bdecf62f4b55 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1199,6 +1199,9 @@ static void ext4_put_super(struct super_block *sb)
>  	int aborted = 0;
>  	int i, err;
>  
> +	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs unmount"))
> +		ext4_msg(sb, KERN_INFO, "unmounting filesystem.");
> +
>  	ext4_unregister_li_request(sb);
>  	ext4_quota_off_umount(sb);

-- 
Gabriel Krisman Bertazi
