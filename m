Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EFB5F9F15
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJJNFR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 09:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJJNFN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 09:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470CF2FFEB
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665407104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNtMdWm65VKXDYsu7gJZSCkbMwJsOWFnzn/cKDTgMGk=;
        b=Cf8urhQsKprHLdfkcP22Aj+9dx8JjwutOQJCgez3xqBBPOtlKvgEeklh6ahojf98V8Lm/a
        jew+CEimPzyJRGlM9hNmXazCzHMVcZ4J+rAItDV8rW3z3Hpu8cE+6cEeuQ94JesUQeOHfJ
        OsLA0Q1txs4rfndRin9y+J3Bof0haog=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-YYcOpNvZMtCHMoeJd7E5ow-1; Mon, 10 Oct 2022 09:04:59 -0400
X-MC-Unique: YYcOpNvZMtCHMoeJd7E5ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05E0495D688;
        Mon, 10 Oct 2022 13:04:59 +0000 (UTC)
Received: from fedora (ovpn-195-46.brq.redhat.com [10.40.195.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1242DC210E;
        Mon, 10 Oct 2022 13:04:57 +0000 (UTC)
Date:   Mon, 10 Oct 2022 15:04:55 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH v2] misc/fsck.c: Processes may kill other processes.
Message-ID: <20221010130455.2e5th5sboluwn457@fedora>
References: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 10, 2022 at 04:56:58PM +0800, zhanchengbin wrote:
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.

Looks good thanks.

> 
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
                  ^^^
You can remove my Sob, but you can add

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> ---
> V1->V2:
>   Anything <= 0 is a bug and can have unexpected consequences if
> we actually call the kill(). So change inst->pid==-1 to inst->pid<=0.
> 
>  misc/fsck.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 4efe10ec..c56d1b00 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -546,6 +546,8 @@ static int kill_all(int signum)
>  	for (inst = instance_list; inst; inst = inst->next) {
>  		if (inst->flags & FLAG_DONE)
>  			continue;
> +		if (inst->pid <= 0)
> +			continue;
>  		kill(inst->pid, signum);
>  		n++;
>  	}
> -- 
> 2.27.0
> 

