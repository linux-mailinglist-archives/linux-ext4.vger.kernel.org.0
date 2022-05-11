Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B0522E53
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 10:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiEKI1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbiEKI1G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 04:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02B765469D
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652257623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cql7hWPMpwkxr2WZ63RnHCoEyq5kNLOgvXpNPmzbk1w=;
        b=T5yxDdYRv1vA9bf3QbPExNuyyzFRKgOtXfrNVBkx0KOO+3AvzXXbRyHxYnGxyuPdGpE/+V
        RhorvSaaaEOYFhYq96uMUabvglr/xkxObxUsKHr/14XFLklXra+549HqFLEAy2KpKcgWlQ
        farkcMJzr3dlK1mBd9DYoWsAwlvb7zM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-uUAJ_SBVNFmDrRLw2nkpqQ-1; Wed, 11 May 2022 04:27:00 -0400
X-MC-Unique: uUAJ_SBVNFmDrRLw2nkpqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21267800882;
        Wed, 11 May 2022 08:27:00 +0000 (UTC)
Received: from fedora (unknown [10.40.194.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 717591460E2C;
        Wed, 11 May 2022 08:26:59 +0000 (UTC)
Date:   Wed, 11 May 2022 10:26:57 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: reject the 'commit' option on ext2 filesystems
Message-ID: <20220511082657.paviz6qq5aj7i7ti@fedora>
References: <20220510183232.172615-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510183232.172615-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 10, 2022 at 11:32:32AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'commit' option is only applicable for ext3 and ext4 filesystems,
> and has never been accepted by the ext2 filesystem driver, so the ext4
> driver shouldn't allow it on ext2 filesystems.
> 
> This fixes a failure in xfstest ext4/053.
> 
> Fixes: 8dc0aa8cf0f7 ("ext4: check incompatible mount options while mounting ext2/3")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Good catch, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1847b46af8083..69d67724df24f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1913,6 +1913,7 @@ static const struct mount_opts {
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_warn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_SET},
>  	{Opt_nowarn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_CLEAR},
> +	{Opt_commit, 0, MOPT_NO_EXT2},
>  	{Opt_nojournal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_journal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
> 
> base-commit: 23e3d7f7061f8682c751c46512718f47580ad8f0
> -- 
> 2.36.1
> 

