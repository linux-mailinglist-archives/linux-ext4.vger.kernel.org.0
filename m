Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C881F42532A
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 14:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbhJGMiT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 08:38:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60206 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbhJGMiQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 08:38:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A50F9224BC;
        Thu,  7 Oct 2021 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633610181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfFzQoEMYvNpAxWFsSLEIIfLiOs8s7LZec/pTkzymhE=;
        b=FU9Gv8YoAPFtMDHYnaA6JR1w3tFjOvf0qacmAnKFYwQPN/V8DatS5VmmCo4dMvU2zXPvkj
        ZQo+GUPeG5DhxN2+SNv01iPsbCv9dEb/4iJTIvIZlieGxDWK1cqanLXxngBykNTaaRLjZO
        gC4+3vmOeloSkIK84XKiVE9s7dbVYYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633610181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cfFzQoEMYvNpAxWFsSLEIIfLiOs8s7LZec/pTkzymhE=;
        b=8T/EzUFX//I/O2qX7W8fki3tI6vNqWXcqAqprtIZoucnEcDIGLoC0ASZEPlWnNE6Fs57pU
        Jv0JV+RSCN7dtpAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 8F51DA3BD0;
        Thu,  7 Oct 2021 12:36:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6F6451F2C96; Thu,  7 Oct 2021 14:36:21 +0200 (CEST)
Date:   Thu, 7 Oct 2021 14:36:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 3/6] ext4: compare to local seq and nodename
 when check conflict
Message-ID: <20211007123621.GH12712@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-4-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911090059.1876456-4-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-09-21 17:00:56, Ye Bin wrote:
> As mmp and check_mmp is point to the same data, so there will never
> detect conflict.
> To solve this issue just compare to local data.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Good spotting! Just one nit below.

> ---
>  fs/ext4/mmp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index c781b09a78c9..4433fe7e9e86 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -154,6 +154,7 @@ static int kmmpd(void *data)
>  	unsigned long last_update_time;
>  	unsigned long last_check_time;
>  	unsigned long diff;
> +	char nodename[64];

Perhaps define a constant for the length of nodename and use it here as
well as in the declaration of mmp_struct->mmp_nodename?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
