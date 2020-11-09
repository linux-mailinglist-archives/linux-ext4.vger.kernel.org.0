Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B32AC4EA
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgKITYF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 14:24:05 -0500
Received: from sandeen.net ([63.231.237.45]:51000 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbgKITYF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 14:24:05 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id CAC242AF5;
        Mon,  9 Nov 2020 13:23:51 -0600 (CST)
To:     Michal Suchanek <msuchanek@suse.de>, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
References: <cover.1604948373.git.msuchanek@suse.de>
 <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 1/2] xfs: show the dax option in mount options.
Message-ID: <5e266714-5598-c413-6129-d0a9913ca5b9@sandeen.net>
Date:   Mon, 9 Nov 2020 13:24:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <f9f7ba25e97dacd92c09eb3ee6a4aca8b4f72b00.1604948373.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/9/20 1:10 PM, Michal Suchanek wrote:
> xfs accepts both dax and dax_enum but shows only dax_enum. Show both
> options.

Should probably indicate why this is needed in the changelog.

> Fixes: 8d6c3446ec23 ("fs/xfs: Make DAX mount option a tri-state")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

This seems ok to me.  I wanted to make sure that "mount -o dax,dax=always"
was accepted properly, because a remount looks to /proc/mounts for existing
options and re-uses what it finds.  It does seem to work correctly.

It's a little weird to emit 2 equivalent options when only one was given, but if
legacy apps rely on finding a bare "dax," then I guess it seems harmless enough...

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e3e229e52512..a3b00003840d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -163,7 +163,7 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax,dax=always" },
>  		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
>  		{ 0, NULL }
>  	};
> 
