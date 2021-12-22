Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9747CF12
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Dec 2021 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbhLVJT7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Dec 2021 04:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30461 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243866AbhLVJT6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Dec 2021 04:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640164798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HW6P5aqMvgJy6ygBO3Phm4zEMTRrHSBikFoLdf1Jgbg=;
        b=cMzj7gW1NCDqWmQ+gwn3AuLxIyuQmBtB3KbxCcJDsVwoGnU/zQJqkWHIaidwITw/JhZ5Zu
        hXpjqykClsEhgsetNeQZYZXmR8SFqvK6R2clTIAS5hVvvHeQFLf8Y7uQgC4XWrfjFwXQvV
        ycoWffII9F/WKwzXy5hYIBDbiMMInrM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-3ZvPHLPpNqSh_bo4KCMVUQ-1; Wed, 22 Dec 2021 04:19:54 -0500
X-MC-Unique: 3ZvPHLPpNqSh_bo4KCMVUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763611800D50;
        Wed, 22 Dec 2021 09:19:53 +0000 (UTC)
Received: from work (unknown [10.40.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAC5357BE;
        Wed, 22 Dec 2021 09:19:51 +0000 (UTC)
Date:   Wed, 22 Dec 2021 10:19:47 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     yebin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix remount with 'abort' option isn't
 effective
Message-ID: <20211222091947.chmg6mcetocrmygd@work>
References: <20211221123214.2410593-1-yebin10@huawei.com>
 <20211221144305.nlryh7q2cgdbpmi5@work>
 <61C27A0E.9050900@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61C27A0E.9050900@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 22, 2021 at 09:06:22AM +0800, yebin wrote:
> 
> 
> On 2021/12/21 22:43, Lukas Czerner wrote:
> > Hi,
> > 
> > nice catch. This is a bug indeed. However I am currently in a process of
> > changing the ctx_set/clear/test_ helpers because currently it generates
> > functions that are unused.
> > 
> > While I am at it I can just create a custom ctx_set_mount_flags()
> > helper that would behave as expected so that we won't have to specify
> > "1 < EXT4_MF_FS_ABORTED" which is not really obvious and hence error
> > prone.
> Actually, I fixed the first version as follows:

Allright, this looks better.

> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b72d989b77fb..199920ffc7d3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2049,8 +2049,8 @@ struct ext4_fs_context {
>  	unsigned int	mask_s_mount_opt;
>  	unsigned int	vals_s_mount_opt2;
>  	unsigned int	mask_s_mount_opt2;
> -	unsigned int	vals_s_mount_flags;
> -	unsigned int	mask_s_mount_flags;
> +	unsigned long	vals_s_mount_flags;
> +	unsigned long	mask_s_mount_flags;
>  	unsigned int	opt_flags;	/* MOPT flags */
>  	unsigned int	spec;
>  	u32		s_max_batch_time;
> @@ -2166,7 +2166,12 @@ static inline bool ctx_test_##name(struct ext4_fs_context *ctx, int flag)\
>  EXT4_SET_CTX(flags);
>  EXT4_SET_CTX(mount_opt);
>  EXT4_SET_CTX(mount_opt2);
> -EXT4_SET_CTX(mount_flags);
> +
> +static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int bit)

Maybe ctx_set_mount_flag since you can't really set more than one this
way?

> +{
> +	set_bit(bit, &ctx->mask_s_mount_flags);
> +	set_bit(bit, &ctx->vals_s_mount_flags);
> +}
> 
> 
> I think 'mask_s_mount_flags' is useless now.

So how would we know what flags have changed ? Sure, there is currently
no need to clear the flag but that can come in future and once it does
we'll only need to create a clear helper, the rest will be ready.
I'd rather keep it.

-Lukas

> > 
> > My plan is to send my patch set including this one tomorrow, will that
> > be fine with you ?
> > 
> > -Lukas
> > 
> > On Tue, Dec 21, 2021 at 08:32:14PM +0800, Ye Bin wrote:
> > > We test remount with 'abort' option as follows:
> > > [root@localhost home]# mount  /dev/sda test
> > > [root@localhost home]# mount | grep test
> > > /dev/sda on /home/test type ext4 (rw,relatime)
> > > [root@localhost home]# mount -o remount,abort test
> > > [root@localhost home]# mount | grep test
> > > /dev/sda on /home/test type ext4 (rw,relatime)
> > > 
> > > Obviously, remount 'abort' option isn't effective.
> > > After 6e47a3cc68fc commit we process abort option with 'ctx_set_mount_flags':
> > > static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int flag)
> > > {
> > > 	ctx->mask_s_mount_flags |= flag;
> > > 	ctx->vals_s_mount_flags |= flag;
> > > }
> > > 
> > > But we test 'abort' option with 'ext4_test_mount_flag':
> > > static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
> > > {
> > >          return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
> > > }
> > > 
> > > To solve this issue, pass (1 <<  EXT4_MF_FS_ABORTED) to 'ctx_set_mount_flags'.
> > > 
> > > Fixes:6e47a3cc68fc("ext4: get rid of super block and sbi from handle_mount_ops()")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/ext4/super.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index b72d989b77fb..071b7b3c5678 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -2236,7 +2236,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > >   			 param->key);
> > >   		return 0;
> > >   	case Opt_abort:
> > > -		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
> > > +		ctx_set_mount_flags(ctx, 1 << EXT4_MF_FS_ABORTED);
> > >   		return 0;
> > >   	case Opt_i_version:
> > >   		ctx_set_flags(ctx, SB_I_VERSION);
> > > -- 
> > > 2.31.1
> > > 
> > .
> > 
> 

