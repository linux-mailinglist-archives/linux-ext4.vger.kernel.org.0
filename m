Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1770E5B1793
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIHIro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiIHIrT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:47:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8ABFD23E
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:46:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so10969354pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=b9+VGe+YlLkthqcPjjwAaMPszyKdFTqcWZWxyyl/qzk=;
        b=cd4/O/GHofn2au6C1a8XYr/3gZgFvX2pHR6odg93Nf/rgm1xuyvNE7FOIdCSmI3amr
         BWf+91jU/FP0mMSeTvtDEA2hqDR4FH3uzN+GG53SGiVVB6MwtReUFOfkIj150rZq+RqH
         PFKeWP76UFvIEIu6Gu9ApmyAjim3FGK3VL6wsCOMX2RhTo1wb1qApWY9Ezij1ctEeXLI
         B5rAIZWhyhG3axNUVq5eB1kHvvxb+WO/S/wClzt1aZ6eh3rfxYoIEMO7AroMi3K3PJYh
         +MIQlK6IYGFqCp64OVK9pzebtlo3ytMJWC0pcwrzEFIZpK8uZblAasxJnc4BzMtOrxe3
         ovqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b9+VGe+YlLkthqcPjjwAaMPszyKdFTqcWZWxyyl/qzk=;
        b=ky4SMkTKeGFo4HEuPEm4c+ilIwHW5ZvHJ9RbdEmAdiu3ccnRx1mWgPjrF1cz4Fz8vP
         Yz7jFfoewsxNQhIZTB0sYdbshlf+QlUyG3uO7BVRyZYSRu4I1PK5ZZB26tsNGfev3E6D
         XtO6FpVduM04o7uL67K/CcBHmXKDas7nZ6HVkusWZ1Mm/I22VT+g8ttc/C+hnArmULp+
         Ry4DN2VH/zHVFPN1mqeMHvWc9q4ptNmHhW1qVyhxAVbbIL2s8msUhfxzP1J1S0+f55kc
         ioYimdKJFBecGVNHp+1n6fAhO8NLHMnWzopveBmHDF4bo8lfqedSdVKf9gfu+0EfDvlA
         a+xw==
X-Gm-Message-State: ACgBeo1T2tcchyRiLOulDpq5MJdMasTsowYNFMpw5xDRMzBZivMofwZz
        jvLcGnEGq8gBf2T8PJ4OPoQ=
X-Google-Smtp-Source: AA6agR6JVjA8QJ0dyUL2nyJqd7gTBtWqVhlvVjwZ6l1g+YClDMibOVb/VgVwx27nrHri+8NYzGFdVg==
X-Received: by 2002:a17:902:b607:b0:170:c7fc:388a with SMTP id b7-20020a170902b60700b00170c7fc388amr7920526pls.29.1662626815269;
        Thu, 08 Sep 2022 01:46:55 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0c0100b001eee8998f2esm1194909pjs.17.2022.09.08.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:46:54 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:16:50 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 06/13] ext4: factor out ext4_inode_info_init()
Message-ID: <20220908084650.ujzyadgudvttom6j@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-7-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-7-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_inode_info_init(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 137 ++++++++++++++++++++++++++----------------------
>  1 file changed, 75 insertions(+), 62 deletions(-)

Changes looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
