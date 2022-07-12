Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB349571A5F
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGLMr1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLMr0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 08:47:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81DB1859
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 05:47:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id o12so7381809pfp.5
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xlAffYbBebm4An6tkMQUL0oy1Dq1eBhPpLd4vo8iGDA=;
        b=E2/CJ3bLixHe425/VO6bJO2hbn8nfc5/N4rcHfQpUViApLMNj8I3J7AYShn2wUmYRH
         48CAUurm9qp/EimKbAkv8DYPPGPa/WrwNQ6axyWTwugO/NWBTg4XfgUsfi7udJxfivoC
         TXWVoa7H64+d5k8PLX+HrQnEKefXbFQH4nD5ZpG+mmXM+MijgYif1gxpAcb53BgU4Kwj
         vFczake9d18L1V/X3YU6ezDDHxbRy6lrGqKVSJMo5Pm0sryZ3VXoZ0YlKlI8RyR6uSwK
         03Cko6N2s0uRx8P6ZnvbW/WxMfFnb8VbWJ2QnN97LBzz7fOErNtwDJLzyYyIqNA/2kIE
         BYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xlAffYbBebm4An6tkMQUL0oy1Dq1eBhPpLd4vo8iGDA=;
        b=YlDafo/6aVFPn0e7VlRley66t3cifcHl4oO8OB2ygOYHaYkyJoJSEwrKqHJFV53KVH
         elyptLk9iVJOog4njPwVYrY8h/ewBa1yYYho7Qk60gWytLeLh2uUr6kPMcVVEnqYAJWK
         6/g5GTrRWy2m/WgY27wqXEM403bwGhRdOHQ8LKHM9UDsAs4qdSln/+4zYqdNVIr8eDrw
         sTdvJqbWDPlWZcK0g6enJZHNpjmUsY9kdmJezSEFZru6xqW2MN10ULA3673ygNBQge2W
         D0RQZATt832RhSqMsfCF37epO8vaYMg4siclf9BwFXad6C1OqR4gWBp/z/lEZZHQcp2n
         tyGQ==
X-Gm-Message-State: AJIora+/3UK43QBl3ds6YeMSpvzfPusqtw0b2/z5fVQ21kAoIGaWq8RX
        IXSSoo/Piglgb08cNMia0ik=
X-Google-Smtp-Source: AGRyM1vXc2Y7eVw9qLO4gxrQ590jfhwQGSGR8eMGVsEOwo7TCsAXbTwLcmlSoNiV98R1UZq2nyLjzw==
X-Received: by 2002:a63:8049:0:b0:414:e8aa:b6bd with SMTP id j70-20020a638049000000b00414e8aab6bdmr20598278pgd.10.1657630045787;
        Tue, 12 Jul 2022 05:47:25 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:f7d1:cf2:7048:cb24])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902b68700b001637997d0d4sm6648884pls.206.2022.07.12.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:47:25 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:17:19 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/10 v3] ext4: Fix possible fs corruption due to xattr
 races
Message-ID: <20220712124719.aatx5ya3fj7oxxxn@riteshh-domain>
References: <20220712104519.29887-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712104519.29887-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/07/12 12:54PM, Jan Kara wrote:
> Hello!
>
> I've noticed this series didn't get merged yet. I was waiting for more review
> feedback from Ritesh but somehow that didn't happen. So this is the third

Hello Jan,

I had reviewed this series till 05/10 which were meant for stable fixes too.
But I didn't quiet add any Reviewed-by because I didn't find any obvious
problem (also my familiarity with mbcache and revoke code paths are not as
good).

But fair point, I do wanted to continue reviewing the series of later patches
too. I will complete those before our next call (btw, I forgot to check on
these in last call actually)

But this doesn't has to delay picking this patch series for merge any further.
Please feel free to pick it up, if required.

Thanks again for your help!!
-ritesh

> submission of the series fixing the races of ext4 xattr block reuse with the
> few changes that have accumulated since v2. Ted, do you think you can add this
> series to your tree so that we can merge it during the merge window? Thanks!
>
> Changes since v1:
> * Reworked the series to fix all corner cases and make API less errorprone.
>
> Changes since v2:
> * Renamed mb_cache_entry_try_delete() to mb_cache_entry_delete_and_get()
> * Added Tested-by tag from Ritesh
>
> 								Honza
>
> Previous versions:
> Link: http://lore.kernel.org/r/20220606142215.17962-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20220614124146.21594-1-jack@suse.cz # v2
