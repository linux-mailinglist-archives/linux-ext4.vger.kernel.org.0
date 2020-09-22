Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D982E274223
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 14:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVMhX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 08:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgIVMhW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Sep 2020 08:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600778242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbJIeaMcHovwFLiJWIncDJGH5vBRRBCCZzx0OXgoQAs=;
        b=OZuftph0ZxvHKvcaV6yPTtTfgSxYcAjbD1EPAgBsV2WmkkoukDrxva9hc0EVEqWxqAKcAl
        7cR4JbT0IAdS+zOfFE3Udr89bYcvnOvC5GnS29ITHhqiL3RMF+loCH4orMOo/s0bx2K+20
        BfbaahJ7WPvhPLx6wKUNP/aBM/AOxgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-96NhK09-N8OVXlCXo0bjtA-1; Tue, 22 Sep 2020 08:37:20 -0400
X-MC-Unique: 96NhK09-N8OVXlCXo0bjtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3B4425D9
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 12:37:19 +0000 (UTC)
Received: from work (unknown [10.40.195.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B961B5C1A3
        for <linux-ext4@vger.kernel.org>; Tue, 22 Sep 2020 12:37:18 +0000 (UTC)
Date:   Tue, 22 Sep 2020 14:37:14 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/4] e2fsck: remove unused variable 'new_array'
Message-ID: <20200922123714.utoryl2xprw5mqae@work>
References: <20200605081442.13428-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 05, 2020 at 10:14:39AM +0200, Lukas Czerner wrote:
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  e2fsck/rehash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index 1616d07a..b356b92d 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -109,7 +109,7 @@ static int fill_dir_block(ext2_filsys fs,
>  			  void *priv_data)
>  {
>  	struct fill_dir_struct	*fd = (struct fill_dir_struct *) priv_data;
> -	struct hash_entry 	*new_array, *ent;
> +	struct hash_entry 	*ent;
>  	struct ext2_dir_entry 	*dirent;
>  	char			*dir;
>  	unsigned int		offset, dir_offset, rec_len, name_len;
> -- 
> 2.21.3
> 

Ehm, ping ?

-Lukas

