Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DE43B158
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 13:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhJZLls (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 07:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230442AbhJZLls (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 Oct 2021 07:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635248364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XU5PbqeylwTiSdIqGz9zsvIHQQKvLuWqZdWiVf/qrQc=;
        b=S4bA+iUqgDYcWX5x2gH/0uyf8dMDO/ThELldO8445FkYZmh2WtCemVWisz1EW8xzjIziI5
        zAiCSgs9DMARmKOlxrpnzHIinUG2RbV51KKpMA4JB7mPgezX1/Nt4hFnGmAKqjPqJhtk9u
        +PaHKiz8W5XAL4xG5tJfgNbfnee+5OU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-jYnwZlVyPE-2GIrx_2nX3Q-1; Tue, 26 Oct 2021 07:39:23 -0400
X-MC-Unique: jYnwZlVyPE-2GIrx_2nX3Q-1
Received: by mail-wm1-f71.google.com with SMTP id a18-20020a1cf012000000b0032ca3eb2ac3so825120wmb.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 04:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XU5PbqeylwTiSdIqGz9zsvIHQQKvLuWqZdWiVf/qrQc=;
        b=KWsDBKz4YC7xcRM6qK05U+5e2Z/WqLpT+WNfkGgJG9jZax3QCDjIyLnYtfRlEO129H
         RDXqCIt2HqumkmvMi+5Di1jOBLNMZRoPtTkFHQnHzziUjmBAw2TNTU7DrUvUh36h3rXA
         cB18Zhwlet6qG+0ZNVQlfIwOzlzQYF26wFQAzb90LaYaVED4QK56egvIzQ8ppdXarE9x
         Fsxu+RPv/8CU9j/IxLn2HqwJ/P9b1cnfghFbHoxqnV8qMWVvmB+MM978lkXrtYzINj6U
         bYWsgzSkwe7EP2S82c3us1VUD0zg69/kQ1Omg15KahIaQkvyJ182+EKDrK/oC4YJszPr
         3AXg==
X-Gm-Message-State: AOAM530VF85SCUf4GEOjjKfGZW1xihuzOPL6bfBnqfz0t9rwPVxHkeNp
        jPL0OkmMGCjweBm0awROyYGF7kP48cz226GhXoinw1Eee80kDP4g3O0tN5xoL2gHuw6nCLiz4+d
        dpFZ3TU6PXhhp0c6zwEe9hQ==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr1042785wrk.275.1635248361981;
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJUJbTYohBTQQymnO98ec+X7Nnr+4h7GZESd8sTcS7uI/Cta5XQOX81blWxBzpk6/9pT/cNw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr1042749wrk.275.1635248361657;
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id k63sm366066wme.22.2021.10.26.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:39:21 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:39:19 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] ext4: new mount API conversion
Message-ID: <20211026113919.iw7ikkvcdgmrijhf@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
References: <20211021114508.21407-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021114508.21407-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 21, 2021 at 01:44:55PM +0200, Lukas Czerner wrote:
> After some time I am once again resurrecting the patchset to convert the
> ext4 to use the new mount API
> (Documentation/filesystems/mount_api.txt).
> 
> The series can be applied on top of the current mainline tree and the work
> is based on the patches from David Howells (thank you David). It was built
> and tested with xfstests and a new ext4 mount options regression test that
> was sent to the fstests list.
> 
> Lukas Czerner (13):
>   fs_parse: allow parameter value to be empty
>   ext4: Add fs parameter specifications for mount options
>   ext4: move option validation to a separate function
>   ext4: Change handle_mount_opt() to use fs_parameter
>   ext4: Allow sb to be NULL in ext4_msg()
>   ext4: move quota configuration out of handle_mount_opt()
>   ext4: check ext2/3 compatibility outside handle_mount_opt()
>   ext4: get rid of super block and sbi from handle_mount_ops()
>   ext4: Completely separate options parsing and sb setup
>   ext4: clean up return values in handle_mount_opt()
>   ext4: change token2str() to use ext4_param_specs
>   ext4: switch to the new mount api
>   ext4: Remove unused match_table_t tokens
> 

The patches seem ok. I can't review ext4 specific details as naming and code
style, but the logic applied to the patches are fine. There are a few typos in
some patches that I pointed, but the patches themselves are fine, so, feel free
to add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

-- 
Carlos

