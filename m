Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1FA197CCD
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgC3NYv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 09:24:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23435 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgC3NYv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 09:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585574690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I/Hh4W02U1ZLlFVNLJDLPaXkyOgDWxld3LqAnE72Nw4=;
        b=QDJ3lRMgLRTqtLdLHUKr5w6fapxO5O1/VHy8zE4AMyeTbNcClEz+6R6wQVa5LyRxCbd5Wm
        2tD+hxEytOM5sSx5GsaD0Z2DrFv7Xa7QKdFPN04tBymweigCJ+buYEiCzXIhX2bI+BiE9b
        Qe2zsfWS00kna/ELLO4gFU/vm4rzTDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-ITCv08rbPHme5lFtUYoQOQ-1; Mon, 30 Mar 2020 09:24:45 -0400
X-MC-Unique: ITCv08rbPHme5lFtUYoQOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D77791005509;
        Mon, 30 Mar 2020 13:24:44 +0000 (UTC)
Received: from work (unknown [10.40.192.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF0A48;
        Mon, 30 Mar 2020 13:24:43 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:24:40 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2fs: Fix error checking in dx_link()
Message-ID: <20200330132440.4kwdwhgsrsnif6ju@work>
References: <20200330090932.29445-1-jack@suse.cz>
 <20200330090932.29445-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330090932.29445-2-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 30, 2020 at 11:09:31AM +0200, Jan Kara wrote:
> dx_lookup() uses errcode_t return values. As such anything non-zero is
> an error, not values less than zero. Fix the error checking to avoid
> crashes on corrupted filesystems.

Looks good, thanks.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  lib/ext2fs/link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
> index 6f523aee718c..7b5bb022117c 100644
> --- a/lib/ext2fs/link.c
> +++ b/lib/ext2fs/link.c
> @@ -571,7 +571,7 @@ static errcode_t dx_link(ext2_filsys fs, ext2_ino_t dir,
>  	dx_info.namelen = strlen(name);
>  again:
>  	retval = dx_lookup(fs, dir, diri, &dx_info);
> -	if (retval < 0)
> +	if (retval)
>  		goto free_buf;
>  
>  	retval = add_dirent_to_buf(fs,
> -- 
> 2.16.4
> 

