Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58535199E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDARzt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbhDARs0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:48:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2BC061794;
        Thu,  1 Apr 2021 04:20:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso845860pjb.3;
        Thu, 01 Apr 2021 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zXfV8oRhx+bc0ds8pc35Wa8gp6VUw0JHGi/VZK5I26w=;
        b=rrr96NT5yosU4KhE5Je52XVfBf8huDRcdQXTh4h5tKyZncZumIBcC5NOaQ/f6I/Sq5
         b+xCeEC86OaFbZbpZz12UXBRJBrm4Dxit/LnrcsR4cwL4WlmrEu6kfVsBNQf9nCZoU7C
         ujEaoS5577c3HEr2VgbmsL/GRbrwMz//JXkipxq+INzLYXucWnRe4Kug4EEs/HiFLgoN
         0ENCbsFyEa+F6ubYzdmEKA4fgayZOKt19ZGuY8KnaTtJUouLTgVvati73E15IOiaJlEl
         8//95HMOCdV4HwHJiP1t4X3/eHqYqXxbQRBBdRvBbEXOKX+JNP5EqWvT8H+FhASt+3uH
         JJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXfV8oRhx+bc0ds8pc35Wa8gp6VUw0JHGi/VZK5I26w=;
        b=a+69NGi9g6/onYdWjvDCVMXxeziHlyM3lzq3dDyJuX6NN7uyxXnGHeGxmtR86fyG2A
         TwjJKWVrlfD4szXDYZEctZ+6Qt7laSA2458z/8Gg/8lLBNU8JeKVYUfKD7/V2U6c1KEb
         rRm2KRORYPC/JHciWeJlNAasuuOfozZeqrKQiiAk0bG9LQPYTUiMeBVO41QBJvINktUv
         kBltCn8OkeHHXbG4Vdsw7oVySvZ1dPp+4mPTltXiXVjVz6lHWFA8bO7UM9rxX8kXRSxL
         n3/8AClwtIsNsWF3qUHEjotddoJ0IG5L1TKuvXGRsksM5KOqSXzfQyYbdXrqCYcEiVaV
         OJSw==
X-Gm-Message-State: AOAM532s2PmvxtGIIx0LEQWiwPHnPRgdXjcJqF9VgX2R67eFgULmEATi
        ksp2JaMJTKO846mAM3PjW7I=
X-Google-Smtp-Source: ABdhPJz0dSfw5SvKtvD/uBISNA9vNtgipmBOmmaG18gV3KIdTpHQu1JHKEZJAAXh10th80qWYy/fAA==
X-Received: by 2002:a17:90a:d90a:: with SMTP id c10mr8481837pjv.13.1617276003735;
        Thu, 01 Apr 2021 04:20:03 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id s17sm5180631pjn.44.2021.04.01.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 04:20:03 -0700 (PDT)
Date:   Thu, 1 Apr 2021 16:50:01 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] ext4: Delete redundant uptodate check for buffer
Message-ID: <20210401112001.tjwjfrno4ygwwzh2@riteshh-domain>
References: <1617260610-29770-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617260610-29770-1-git-send-email-zhangshaokun@hisilicon.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/04/01 03:03PM, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
>
> The buffer uptodate state has been checked in function set_buffer_uptodate,
> there is no need use buffer_uptodate before calling set_buffer_uptodate and
> delete it.
>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  fs/ext4/inode.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks for the patch. Changes looks good and trivial.

Feel free to add -
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
