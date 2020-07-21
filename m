Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD47227D28
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgGUKgj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 06:36:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgGUKgj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 06:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595327798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wNLTyq4CpvRxfwpZ7DWeVCxVXN2jeU61gKBPmKrIpo=;
        b=CSxTGIBDV+PVIBS6G/KzA1rH4FmYzpV22ub5VdZmZdzfDB5VSmPxAMZPNhWdb+qbZ0Hkn6
        udPACqQpviYaloOD+Kyzw/v1CqjjqJbGgkt96Q+ZWwyFRPn7c8dnqBAfd+YSwQwE/4XPay
        +3bFWV9i6NJGte1766zp2acOUNhAIvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-sXosijhgPfCD6Z-EO_SBTA-1; Tue, 21 Jul 2020 06:36:35 -0400
X-MC-Unique: sXosijhgPfCD6Z-EO_SBTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40376100AA23;
        Tue, 21 Jul 2020 10:36:34 +0000 (UTC)
Received: from work (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A97B6FECD;
        Tue, 21 Jul 2020 10:36:31 +0000 (UTC)
Date:   Tue, 21 Jul 2020 12:36:28 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 1/4] ext4: Handle error of ext4_setup_system_zone() on
 remount
Message-ID: <20200721101802.e6xl2oewirqmxcjr@work>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715131812.7243-2-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 15, 2020 at 03:18:09PM +0200, Jan Kara wrote:
> ext4_setup_system_zone() can fail. Handle the failure in ext4_remount().
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..8e055ec57a2c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5653,7 +5653,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  		ext4_register_li_request(sb, first_not_zeroed);
>  	}
>  
> -	ext4_setup_system_zone(sb);
> +	err = ext4_setup_system_zone(sb);
> +	if (err)
> +		goto restore_opts;
> +

Thanks Jan, this looks good. But while you're at it, ext4_remount is
missing ext4_release_system_zone() and so it we want to enable block_validity
on remount and it fails after ext4_setup_system_zone() we wont release
it. This *I think* means that we would end up with block_validity
enabled without user knowing about it ?

-Lukas

>  	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
>  		err = ext4_commit_super(sb, 1);
>  		if (err)
> -- 
> 2.16.4
> 

