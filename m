Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A176FA686
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjEHKUp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjEHKUO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 06:20:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0D9D864
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 03:20:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso7933163a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 03:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683541205; x=1686133205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vI6d0BPYY3HFvHWOAC5bS4eIW+XvXyqbEP1ni9lazuc=;
        b=JR9Ar+LBbn+pAr97slc/Fk3H3ctuK7jKOIeMBLfHYFt5+YuG2sMRxLTRBwUnm2ztP4
         Q+9Qni1Mm0wojsmv7mqN9hVOj4hLU0J6U4K1PC4o27o0yRfoOVuPQ5Pqkjhk+Rc/jFpu
         hZWNHarSkClaYVsAFOt7jqI5GlzhRcrNEZl07YnF9xR/qW6aysVSTSXmlmvZfenkCIZa
         s++gYXtB6rS2g1R6TcWk+hNEEvPp/4KPanWesqFdCpnOiMzY3/SpdLTAQ5N07gq+u2mH
         x0H8jWXdNy9mSHKlXitrDhFgdEvfV6EB5sWjWE1NJ1gvjWyOvyGlq/fMbIUg2PzwmuHO
         5dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683541205; x=1686133205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vI6d0BPYY3HFvHWOAC5bS4eIW+XvXyqbEP1ni9lazuc=;
        b=OSBXKz9TlZvo3doOhyWQRjZ+PfiOyi5CgPVYJlTdoQ61HEFwlgXZiQt0mCqy70UhfO
         e1xMLQ5oSdUQq5qMODlnWkSEe1yaDduetopkQ/k/bb2a9ZZ9Zgj51qURGDaTtGjCafU4
         EMkjKLYqHX2PQvfnYwK7MSz62TFADnuZYElFXniVMHBZtDaD/tBDZZSol5eGRp1BphC+
         U7FFzb/iQjaB7MMyv4344jOQf0FcNMuL0Hn8YhzEgf3/SNePX95dGGgfW3VmP8NcIPWQ
         Zh8qRviCwpTeYmnQ0wmFzbgwPYI5zgwZieyP282xjS+PoYr0mBQxtOz04omfN8EgHuDE
         mkww==
X-Gm-Message-State: AC+VfDxoKtFjrNPDBMxfCSPAfQ6bedF9YQ7XwhszFclLLXRKd1+1dSbT
        +JFfFdxqegctwuI5GWJsWPc31A==
X-Google-Smtp-Source: ACHHUZ7Kio9UcPXO9QFXeQHbJ+NM8Xz3iyRkWf9227pTZjU3qSw+nBA1dIzfB4XaRn7GD3iduFFIwQ==
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id he31-20020a1709073d9f00b0095954541db7mr9099467ejc.3.1683541205191;
        Mon, 08 May 2023 03:20:05 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id ci17-20020a170907267100b0096609d11c83sm3555430ejc.60.2023.05.08.03.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 03:20:03 -0700 (PDT)
Message-ID: <d84ff5f8-771e-3f03-bd2d-bc71fec6bd81@linaro.org>
Date:   Mon, 8 May 2023 11:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ext4: fix invalid free tracking in
 ext4_xattr_move_to_block()
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com,
        syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com,
        Lee Jones <joneslee@google.com>
References: <20230430160426.581366-1-tytso@mit.edu>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230430160426.581366-1-tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/30/23 17:04, Theodore Ts'o wrote:
> In ext4_xattr_move_to_block(), the value of the extended attribute
> which we need to move to an external block may be allocated by
> kvmalloc() if the value is stored in an external inode.  So at the end
> of the function the code tried to check if this was the case by
> testing entry->e_value_inum.
> 
> However, at this point, the pointer to the xattr entry is no longer
> valid, because it was removed from the original location where it had
> been stored.  So we could end up calling kvfree() on a pointer which
> was not allocated by kvmalloc(); or we could also potentially leak
> memory by not freeing the buffer when it should be freed.  Fix this by
> storing whether it should be freed in a separate variable.
> 
> Link: https://syzkaller.appspot.com/bug?id=5c2aee8256e30b55ccf57312c16d88417adbd5e1
> Link: https://syzkaller.appspot.com/bug?id=41a6b5d4917c0412eb3b3c3c604965bed7d7420b
> Reported-by: syzbot+64b645917ce07d89bde5@syzkaller.appspotmail.com
> Reported-by: syzbot+0d042627c4f2ad332195@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/xattr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 767454d74cd6..e33a323faf3c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2615,6 +2615,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  		.in_inode = !!entry->e_value_inum,
>  	};
>  	struct ext4_xattr_ibody_header *header = IHDR(inode, raw_inode);
> +	int needs_kvfree = 0;
>  	int error;
>  
>  	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
> @@ -2637,7 +2638,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  			error = -ENOMEM;
>  			goto out;
>  		}
> -
> +		needs_kvfree = 1;
>  		error = ext4_xattr_inode_get(inode, entry, buffer, value_size);
>  		if (error)
>  			goto out;
> @@ -2676,7 +2677,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
>  
>  out:
>  	kfree(b_entry_name);
> -	if (entry->e_value_inum && buffer)
> +	if (needs_kvfree && buffer)

If buffer is null, no operation should be performed, so we may get rid
of the buffer check.

We should also add the Fixes tag and Cc: stable@vger.kernel.org, as the
blamed commit fixes another bug and it was backported to 4.14+, thus
this one needs to be backported as well.

Fixes: 1e9d62d25281 ("ext4: optimize ea_inode block expansion")

Anyway:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Cheers,
ta
>  		kvfree(buffer);
>  	if (is)
>  		brelse(is->iloc.bh);
