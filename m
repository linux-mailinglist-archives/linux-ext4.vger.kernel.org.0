Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E3200207
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 08:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFSGld (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 02:41:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22172 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgFSGld (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Jun 2020 02:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592548891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHo0v39omm+I5Al+J8jMDPRd9NyZ03Vu0S8PHLO7kc8=;
        b=b/yuxQj8wSeiZi3eCp6acNPRM8FyNRqXZe+yLFZm/n1lvy8ZVUNKmXcKNfrxxrHFOvJVvD
        T3dxrSblxqCNDH2EHzY29cSMwYpaXjlA7UEzt7GqQtDpUXkSzswswK0I9YxxXiFti4kMGL
        NsMY+Zp6drrgE0XOz+A9Ls23K2RdpgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-XGVHbCYbPtWOXMIiitcW0A-1; Fri, 19 Jun 2020 02:41:29 -0400
X-MC-Unique: XGVHbCYbPtWOXMIiitcW0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 122C7107ACCA
        for <linux-ext4@vger.kernel.org>; Fri, 19 Jun 2020 06:41:29 +0000 (UTC)
Received: from work (unknown [10.40.192.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54A6E60CCC;
        Fri, 19 Jun 2020 06:41:25 +0000 (UTC)
Date:   Fri, 19 Jun 2020 08:41:22 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
Message-ID: <20200619064122.vj346xptid5viogv@work>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 17, 2020 at 02:19:04PM -0500, Eric Sandeen wrote:
> If for any reason a directory passed to do_split() does not have enough
> active entries to exceed half the size of the block, we can end up
> iterating over all "count" entries without finding a split point.
> 
> In this case, count == move, and split will be zero, and we will
> attempt a negative index into map[].
> 
> Guard against this by detecting this case, and falling back to
> split-to-half-of-count instead; in this case we will still have
> plenty of space (> half blocksize) in each split block.
> 
> Fixes: ef2b02d3e617 ("ext34: ensure do_split leaves enough free space in both blocks")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a8aca4772aaa..8b60881f07ee 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1858,7 +1858,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  			     blocksize, hinfo, map);
>  	map -= count;
>  	dx_sort_map(map, count);
> -	/* Split the existing block in the middle, size-wise */
> +	/* Ensure that neither split block is over half full */
>  	size = 0;
>  	move = 0;
>  	for (i = count-1; i >= 0; i--) {
> @@ -1868,8 +1868,18 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  		size += map[i].size;
>  		move++;
>  	}
> -	/* map index at which we will split */
> -	split = count - move;
> +	/*
> +	 * map index at which we will split
> +	 *
> +	 * If the sum of active entries didn't exceed half the block size, just
> +	 * split it in half by count; each resulting block will have at least
> +	 * half the space free.
> +	 */
> +	if (i > 0)
> +		split = count - move;
> +	else
> +		split = count/2;

Won't we have exactly the same problem as we did before your commit
ef2b02d3e617cb0400eedf2668f86215e1b0e6af ? Since we do not know how much
space we actually moved we might have not made enough space for the new
entry ?

Also since we have the move == count when the problem appears then it's
clear that we never hit the condition

1865 →       →       /* is more than half of this entry in 2nd half of the block? */
1866 →       →       if (size + map[i].size/2 > blocksize/2)
1867 →       →       →       break;

in the loop. This is surprising but it means the the entries must have
gaps between them that are small enough that we can't fit the entry
right in ? Should not we try to compact it before splitting, or is it
the case that this should have been done somewhere else ?

If we really want ot be fair and we want to split it right in the middle
of the entries size-wise then we need to keep track of of sum of the
entries and decide based on that, not blocksize/2. But maybe the problem
could be solved by compacting the entries together because the condition
seems to rely on that.

-Lukas

> +
>  	hash2 = map[split].hash;
>  	continued = hash2 == map[split - 1].hash;
>  	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
> 
> 

