Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5B5F9A0D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiJJHf6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJJHfk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 03:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A46BD4F
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665386940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yGHAxr3mVA+vcN45KyLOwqZpMifu62QDb5EHFrMont0=;
        b=dWdrcnk3GqNg7ziRzm1ZV38qHtxNlDkGcEHe5aZVeP4L5GvEKCuqSiavzZ8fX53gUF9GcD
        fxAzm2SrwCNwt2dduSOqA56iSHqZhJvYXhE5LoPk4ITmFByAU4PE7U/V/AzNSpnwPCHdYT
        BCyFNVgtskaIwMgUv5LXrpho2a0pqKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-cHUbfYkQPp-gaQBsvy6kwA-1; Mon, 10 Oct 2022 03:17:30 -0400
X-MC-Unique: cHUbfYkQPp-gaQBsvy6kwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 836713804061;
        Mon, 10 Oct 2022 07:17:29 +0000 (UTC)
Received: from fedora (unknown [10.40.193.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9323E40FF706;
        Mon, 10 Oct 2022 07:17:27 +0000 (UTC)
Date:   Mon, 10 Oct 2022 09:17:25 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] misc/fsck.c: Processes may kill other processes.
Message-ID: <20221010071725.ghflyqxj7poqlwtq@fedora>
References: <01783b8c-2a39-73ec-c537-cc1df82643e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01783b8c-2a39-73ec-c537-cc1df82643e2@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 08, 2022 at 11:05:48AM +0800, zhanchengbin wrote:
> If run the fsck -N command, processes don't execute, just show what
> would be done. However, the pid whose value is -1 is added to the
> instance_list list in the execute function,if the kill_all function
> is called later, kill(-1, signum) is executed, Signals are sent to
> all processes except the number one process and itself. Other
> processes will be killed if they use the default signal processing
> function.
> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  misc/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..faf7789d 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>  	for (inst = instance_list; inst; inst = inst->next) {
>  		if (inst->flags & FLAG_DONE)
>  			continue;
> +		if (inst->pid == -1)
> +			continue;

That works, but I think we can afford to be a little defensive here.
Anything <= 0 is a bug and can have unexpected consequences if we
actually call the kill().

		if (inst->pid <= 0)
			continue;


Also as Darrick pointed out we need to send the patch to util-linux
(disk-utils/fsck.c) as well if you haven't already.

-Lukas


>  		kill(inst->pid, signum);
>  		n++;
>  	}
> -- 
> 2.27.0
> 

