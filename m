Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE445B17DA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIHI6J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIHI6I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:58:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA67F7740
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:58:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q3so17094250pjg.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pdyhBZUaAo+ER9GYk+jaASHhMFffnCyLX6id27pqjbA=;
        b=TRVS8om6skDKPyy5cNODcgExt2ZzZguLsWTy1NxRr7a/D1C+iTGk92QfTagKEB4gzX
         LbVD9nCTUL1ZQKZ0eXz79e3B9e6tEzPdwOvckfqbiO7H6x/r/Uk0dyCatx9CSQGXHPD+
         hcE0CS1sCdpYNWjlybblHau5U7X7w+hHoGosgVYztQxuLeJ9U07njs4kUleIS6+dm1ES
         huw5KQFwv0VkiIwR+JCC5ong0JIqxiOhIaASPEQHmZv1bylhCHgT/b0hxBIxCk06Uyl1
         LZXa/fI0F8hNx8jCuGAiMxTVpykWQbo/mP4t5Qy4VMZK2qGJNgG/JoUkn16RlUbLAfPC
         MYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pdyhBZUaAo+ER9GYk+jaASHhMFffnCyLX6id27pqjbA=;
        b=w1ZjvISs1nwu/DEIPInkKpkV23kpaIONigdWfw2wYgOa8tBVTBjPTzP8CIhroChVRr
         5jC8YZLBPIVq3n7dYGswT7LaZVkAbMYX2915BO7sgRaBczcX5DhRZ4NlBBEWiagFiAMW
         TgoLUJMaFq8xPRJbIzhddC+iL4mjazfy37Z8kLGFyd3rYZoA3g11UZbo5ik2MJ+Bx1SG
         V/66T59FO8XiOEZBtP7DAgAWRLJe8wKHd/wC2bhXq1JBrKpy8+C8yzrHi3JIGH7xwK9n
         edhbe/8499R2+FTpC/DPJBFRGj4kHJPfPaHBbEEXeSLKuen5p5P2clOXMauYKEG8PtQ5
         qgQw==
X-Gm-Message-State: ACgBeo2Z7AKL7vx1pM4lXjvk2XpU1JiMYR9y2tFtKPLDjmGqRQcb84qG
        Rp2O9MW7AWlGYzJ5lnsgAQc=
X-Google-Smtp-Source: AA6agR7RPaVSr7/x1ClKX7XtrI4RMQzfdsA46Jbq1hWHccdR1bIrO5Lj0hcm9zflxRhGNxUGw60cKw==
X-Received: by 2002:a17:90b:17cc:b0:200:1df0:5130 with SMTP id me12-20020a17090b17cc00b002001df05130mr3104523pjb.125.1662627487699;
        Thu, 08 Sep 2022 01:58:07 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id a7-20020aa78e87000000b0053bb934eaa9sm10043217pfr.201.2022.09.08.01.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:58:07 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:28:02 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 09/13] ext4: factor out
 ext4_check_feature_compatibility()
Message-ID: <20220908085802.pc5sm4vvy6ll24td@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-10-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-10-yanaijie@huawei.com>
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
> Factor out ext4_check_feature_compatibility(). No functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 144 ++++++++++++++++++++++++++----------------------
>  1 file changed, 77 insertions(+), 67 deletions(-)
> 

Looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
