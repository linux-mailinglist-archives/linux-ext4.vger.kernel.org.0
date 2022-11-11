Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BED625406
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiKKGrC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 01:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKGrB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 01:47:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13D6C72A;
        Thu, 10 Nov 2022 22:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1onRt5K4sGNiVDTE/QX0/atvlrk7w1JHQuZmkOO66kQ=; b=vC8iWiMJ2a6yfnZdsjfrg1mvIi
        4DzCFy0syaX81b0Y9rRyTc3hWyeqM6nX/8jppj9cG9exiNofjc4t3hKBPX4JuYYM44o5IhmcNfECu
        OZ3cha1vIjTfct0dafj/ZMdzxWuwTr2CVhs2v/BWitAl1zqCj8jHfWVHiJT+bVWtABYeQBA4+CMCE
        FUQHbg9vaM8PXGLZgQDN1uoKsahOsQD00vIW4wS1KMx+47JaKI+8nLERxw5pJhUckG4hUSl7BtMXT
        9jvOLMuQs9k8XQMnAp1UpguzyiHaM2FAhzGzqAlIzoxtBoE7zHM7RABhFtxQahrcmxkpuZxNmPSO3
        lB79wDoA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otNoP-00Dd20-HG; Fri, 11 Nov 2022 06:46:49 +0000
Message-ID: <482cff27-2364-acbb-576c-e1d16d18334a@infradead.org>
Date:   Thu, 10 Nov 2022 22:46:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] ext2: Fix some kernel-doc warnings
Content-Language: en-US
To:     Bo Liu <liubo03@inspur.com>, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111064352.2866-1-liubo03@inspur.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221111064352.2866-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/10/22 22:43, Bo Liu wrote:
> The current code provokes some kernel-doc warnings:
> 	fs/ext2/dir.c:417: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>


Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/ext2/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 8f597753ac12..27873733ed8c 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -413,7 +413,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  	return de;
>  }
>  
> -/**
> +/*
>   * Return the '..' directory entry and the page in which the entry was found
>   * (as a parameter - p).
>   *

-- 
~Randy
