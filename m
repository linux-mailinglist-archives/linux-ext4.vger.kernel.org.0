Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9498947C1BD
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Dec 2021 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhLUOnT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Dec 2021 09:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235585AbhLUOnR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Dec 2021 09:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640097797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=au6VllE/GeLnsIb0itQOsWjmnN2qcl/Ccot7HKnDawM=;
        b=ZMz8pvTBbb9aXjSWRO1l7XgSOKkfQ2v4Eb3x2YBItD51QHheHsnhpOtkFx5Y0jeO4MrjZD
        XUXZXYkNop0lI5EDPIcAS+IrMBmU8FmMnMJg5OzgFKSydRJ0r23voyyIL1I21vN/eaW+u8
        l2nJaZIT/PhPEtsbIh9L1FWHkzwTCIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-jGu1uFrkOtqmCNivb9aHFQ-1; Tue, 21 Dec 2021 09:43:14 -0500
X-MC-Unique: jGu1uFrkOtqmCNivb9aHFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325D464141;
        Tue, 21 Dec 2021 14:43:12 +0000 (UTC)
Received: from work (unknown [10.40.194.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A60395DF37;
        Tue, 21 Dec 2021 14:43:10 +0000 (UTC)
Date:   Tue, 21 Dec 2021 15:43:05 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix remount with 'abort' option isn't
 effective
Message-ID: <20211221144305.nlryh7q2cgdbpmi5@work>
References: <20211221123214.2410593-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221123214.2410593-1-yebin10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

nice catch. This is a bug indeed. However I am currently in a process of
changing the ctx_set/clear/test_ helpers because currently it generates
functions that are unused.

While I am at it I can just create a custom ctx_set_mount_flags()
helper that would behave as expected so that we won't have to specify
"1 < EXT4_MF_FS_ABORTED" which is not really obvious and hence error
prone.

My plan is to send my patch set including this one tomorrow, will that
be fine with you ?

-Lukas

On Tue, Dec 21, 2021 at 08:32:14PM +0800, Ye Bin wrote:
> We test remount with 'abort' option as follows:
> [root@localhost home]# mount  /dev/sda test
> [root@localhost home]# mount | grep test
> /dev/sda on /home/test type ext4 (rw,relatime)
> [root@localhost home]# mount -o remount,abort test
> [root@localhost home]# mount | grep test
> /dev/sda on /home/test type ext4 (rw,relatime)
> 
> Obviously, remount 'abort' option isn't effective.
> After 6e47a3cc68fc commit we process abort option with 'ctx_set_mount_flags':
> static inline void ctx_set_mount_flags(struct ext4_fs_context *ctx, int flag)
> {
> 	ctx->mask_s_mount_flags |= flag;
> 	ctx->vals_s_mount_flags |= flag;
> }
> 
> But we test 'abort' option with 'ext4_test_mount_flag':
> static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
> {
>         return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
> }
> 
> To solve this issue, pass (1 <<  EXT4_MF_FS_ABORTED) to 'ctx_set_mount_flags'.
> 
> Fixes:6e47a3cc68fc("ext4: get rid of super block and sbi from handle_mount_ops()")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b72d989b77fb..071b7b3c5678 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2236,7 +2236,7 @@ static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			 param->key);
>  		return 0;
>  	case Opt_abort:
> -		ctx_set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
> +		ctx_set_mount_flags(ctx, 1 << EXT4_MF_FS_ABORTED);
>  		return 0;
>  	case Opt_i_version:
>  		ctx_set_flags(ctx, SB_I_VERSION);
> -- 
> 2.31.1
> 

