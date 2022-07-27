Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882525829F7
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiG0Pss (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiG0Pss (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 11:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1566491DF
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658936926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WCR8CshQrDJrTivFHyPO/Qbh0s6ufg9ofF7ywFD6wSs=;
        b=Qfeob4IdAUVoS5UTI/fbyCZ07DmTlsof7z2JuRshpLxpQ4ye3uXUbWMwYoLZcB/IH1yPJu
        qDQcLGj738tdCcEDElCoClumk5HWmrYEHR+8y+7Wmkxg+CXxzrbmHkK6Mld1oJfi3UJ1fO
        l+mQSWZOhrnG0S32ZNCMa0iiwpmcpcw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-yYTqVLktMsiNl_hkAYqbIQ-1; Wed, 27 Jul 2022 11:48:42 -0400
X-MC-Unique: yYTqVLktMsiNl_hkAYqbIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29EEF3802B88;
        Wed, 27 Jul 2022 15:48:42 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0182940315E;
        Wed, 27 Jul 2022 15:48:40 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, "Dave Chinner" <david@fromorbit.com>,
        "Lukas Czerner" <lczerner@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] ext4: unconditionally enable the i_version counter
Date:   Wed, 27 Jul 2022 11:48:39 -0400
Message-ID: <ED900EEF-31D1-4A14-A97C-02D3120ABC2A@redhat.com>
In-Reply-To: <20220727143734.71612-1-jlayton@kernel.org>
References: <20220727143734.71612-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 27 Jul 2022, at 10:37, Jeff Layton wrote:

> The original i_version implementation was pretty expensive, requiring 
> a
> log flush on every change. Because of this, it was gated behind a 
> mount
> option (implemented via the MS_I_VERSION mountoption flag).
>
> Commit ae5e165d855d (fs: new API for handling inode->i_version) made 
> the
> i_version flag much less expensive, so there is no longer a 
> performance
> penalty from enabling it. xfs and btrfs already enable it
> unconditionally when the on-disk format can support it.
>
> Have ext4 ignore the SB_I_VERSION flag, and just enable it
> unconditionally. While we're in here, remove the handling of
> Opt_i_version as well, since we're almost to 5.20 anyway.
>
> Ideally, we'd couple this change with a way to disable the i_version
> counter (just in case), but the way the iversion mount option was
> implemented makes that difficult to do. We'd need to add a new mount
> option altogether or do something with tune2fs. That's probably best
> left to later patches if it turns out to be needed.
>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ext4/inode.c |  5 ++---
>  fs/ext4/super.c | 13 ++++---------
>  2 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..c785c0b72116 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5411,7 +5411,7 @@ int ext4_setattr(struct user_namespace 
> *mnt_userns, struct dentry *dentry,
>  			return -EINVAL;
>  		}
>
> -		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
> +		if (attr->ia_size != inode->i_size)
>  			inode_inc_iversion(inode);
>
>  		if (shrink) {
> @@ -5717,8 +5717,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  	}
>  	ext4_fc_track_inode(handle, inode);
>
> -	if (IS_I_VERSION(inode))
> -		inode_inc_iversion(inode);
> +	inode_inc_iversion(inode);
>
>  	/* the do_update_inode consumes one bh->b_count */
>  	get_bh(iloc->bh);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 845f2f8aee5f..4b06f394d7d1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1585,7 +1585,7 @@ enum {
>  	Opt_inlinecrypt,
>  	Opt_usrjquota, Opt_grpjquota, Opt_quota,
>  	Opt_noquota, Opt_barrier, Opt_nobarrier, Opt_err,
> -	Opt_usrquota, Opt_grpquota, Opt_prjquota, Opt_i_version,
> +	Opt_usrquota, Opt_grpquota, Opt_prjquota,
>  	Opt_dax, Opt_dax_always, Opt_dax_inode, Opt_dax_never,
>  	Opt_stripe, Opt_delalloc, Opt_nodelalloc, Opt_warn_on_error,
>  	Opt_nowarn_on_error, Opt_mblk_io_submit, Opt_debug_want_extra_isize,
> @@ -1694,7 +1694,6 @@ static const struct fs_parameter_spec 
> ext4_param_specs[] = {
>  	fsparam_flag	("barrier",		Opt_barrier),
>  	fsparam_u32	("barrier",		Opt_barrier),
>  	fsparam_flag	("nobarrier",		Opt_nobarrier),
> -	fsparam_flag	("i_version",		Opt_i_version),

We've got to keep the parameter, I think, else we'll break existing 
setups
with the i_version mount option.

Ben

