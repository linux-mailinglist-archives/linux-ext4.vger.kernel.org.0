Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4BB5448B5
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jun 2022 12:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbiFIKYL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jun 2022 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbiFIKYH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jun 2022 06:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40397814AA
        for <linux-ext4@vger.kernel.org>; Thu,  9 Jun 2022 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654770244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6a5SsgsnTuFo9sIZWQwmUlikCgiuGiGF/De3NllGDd0=;
        b=HgnVOqk99y30Ygo3ad+cVr2ACPR/FjDSX1jJW3hB92ChkzIWNogI/Y219F/0uyd378TPFl
        MYkX8Lgt7Lbzcv9Fygokif6+ZI+mbN3FvtKakuw1PjIJf+uHfXhMVlMIjbDXoCpvIc9I0H
        XXHdBhGJbPV0IdWFsh1YL60ukN2tbnE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-ADluPy2nOZe38i5tILvTsA-1; Thu, 09 Jun 2022 06:24:03 -0400
X-MC-Unique: ADluPy2nOZe38i5tILvTsA-1
Received: by mail-wm1-f71.google.com with SMTP id 130-20020a1c0288000000b0039c6608296dso1662613wmc.4
        for <linux-ext4@vger.kernel.org>; Thu, 09 Jun 2022 03:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6a5SsgsnTuFo9sIZWQwmUlikCgiuGiGF/De3NllGDd0=;
        b=SODo3yiZPZikzba/vN/PuppcBZlqBZ77eb/DslD1/QiWs3HN1+MEoaSLOOMl1kKOWy
         a9I2GiwbkEFUsez5BnI5RE43AS6f9zPdhdBn8Pa0ZJ75LKHDNolGSy6VrcDKoDnT9ncl
         qK5AvBacrwn1AenOvLxBIEeb3G8gFKyX9M3lqHKKdnk5opf90M1qBA1QHAQJoX8Z5ci1
         b4rdrwGiXklhtXOcL/lLDP/eVttRCKqMYYizpvCu438oQ5eyUqCgFtq2Jmy1bDPKQPUo
         JnFn0UgtvZzKBI+MnbYc5U0/yL9uHf+sLThRVGVJgJ0bTEIyIpfHLxPF+tLaGkeLPy3x
         uRsQ==
X-Gm-Message-State: AOAM530lwcLr30dqyUXJNXzOyQXtOY8BY8GQFl8fAmcm8bkWVztjjw9u
        PZieXs11yLtKsJU2qi5KGTVANYc/a5bYgSTYfC7Tww8OHtUJMqNogxrgI73zSCoRR/6G+tuJQS4
        V0UKOCM7fUXAgTcjUXBC45w==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr2594384wme.67.1654770241338;
        Thu, 09 Jun 2022 03:24:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy58rh3fuuccVM2J0IS1QrE1vJ3CH41QyKYHa1IrWm/Rvain2xs2JDw35eE5SOSwtsykjkKLA==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr2594345wme.67.1654770240948;
        Thu, 09 Jun 2022 03:24:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d460a000000b0021552eebde6sm17782568wrq.32.2022.06.09.03.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 03:23:59 -0700 (PDT)
Message-ID: <a079ed41-1978-0551-2b5c-6d61aff7ddf2@redhat.com>
Date:   Thu, 9 Jun 2022 12:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 02/19] mm: Convert all PageMovable users to
 movable_operations
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-3-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220608150249.3033815-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
> These drivers are rather uncomfortably hammered into the
> address_space_operations hole.  They aren't filesystems and don't behave
> like filesystems.  They just need their own movable_operations structure,
> which we can point to directly from page->mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/powerpc/platforms/pseries/cmm.c |  60 +---------------
>  drivers/misc/vmw_balloon.c           |  61 +---------------
>  drivers/virtio/virtio_balloon.c      |  47 +-----------
>  include/linux/balloon_compaction.h   |   6 +-
>  include/linux/fs.h                   |   2 -
>  include/linux/migrate.h              |  26 +++++--
>  include/linux/page-flags.h           |   2 +-
>  include/uapi/linux/magic.h           |   4 --
>  mm/balloon_compaction.c              |  10 ++-
>  mm/compaction.c                      |  29 ++++----
>  mm/migrate.c                         |  24 +++----
>  mm/util.c                            |   4 +-
>  mm/z3fold.c                          |  82 +++------------------
>  mm/zsmalloc.c                        | 102 ++++++---------------------
>  14 files changed, 94 insertions(+), 365 deletions(-)

You probably should have cc'ed the relevant maintainers (including me :P ).

For everything except z3fold.c and zsmalloc.c,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

