Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2A58D4DD
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiHIHwe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 03:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiHIHwd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 03:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249D121250
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660031552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ty4C1qW4zjAvsEqPnEFG1bo96cxh7oChwDx95BDpURk=;
        b=LjAwwVRseC2KFcgSon7TrygGTuFSBMcDu8grdb+ZTvswityGeZyLGqlX3TCO9chyN1h89X
        s4PgE1J2Pc2D8hTZPJe3bi5RPPV95DsoXfwszXnE3IejPEcgXfj3qwFMeLEy9Zuo6fZdPM
        Jeah1oIogX8enHnCrJmMsBRul0ei+e0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-qleXzlgFOO2n4l0lnagFyA-1; Tue, 09 Aug 2022 03:52:29 -0400
X-MC-Unique: qleXzlgFOO2n4l0lnagFyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84E4318E5381;
        Tue,  9 Aug 2022 07:52:28 +0000 (UTC)
Received: from fedora (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6133EC15BA3;
        Tue,  9 Aug 2022 07:52:27 +0000 (UTC)
Date:   Tue, 9 Aug 2022 09:52:25 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/ext4: replace ternary operator with min() and max()
Message-ID: <20220809075225.6gzzijxjjfp4s3lm@fedora>
References: <20220809061031.3646725-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809061031.3646725-1-13667453960@163.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 02:10:31PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> fs/ext4/extents.c:2631: WARNING opportunity for max().
> fs/ext4/extents.c:2632: WARNING opportunity for min().
> 
> min() and max() macro is defined in include/linux/minmax.h. It avoids
> multiple evaluations of the arguments when non-constant and performs
> strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  fs/ext4/extents.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..3a74d0961024 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2628,9 +2628,8 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
>  			  unwritten, ex_ee_len);
>  		path[depth].p_ext = ex;
>  
> -		a = ex_ee_block > start ? ex_ee_block : start;
> -		b = ex_ee_block+ex_ee_len - 1 < end ?
> -			ex_ee_block+ex_ee_len - 1 : end;
> +		a = max(ex_ee_block, start);
> +		b = min(ex_ee_block+ex_ee_len - 1, end);

You could add spaces around the + sign, but other than that the patch
looks good. Thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Also note that a quick grep on ext4 tree reveals that there are likely
many more opportunities for using min/max.

-Lukas

>  
>  		ext_debug(inode, "  border %u:%u\n", a, b);
>  
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 

