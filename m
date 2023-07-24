Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B376375F208
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 12:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjGXKF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjGXKFg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 06:05:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521347EE2
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 02:57:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-682ae5d4184so1051753b3a.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192601; x=1690797401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=OlJHj1/yO42yQ42YyfDdqtfuDdXGGV/WQ0GpL38YIfO5RJZmkcdCx+PepLtkyGVzEN
         bTK4LhGsJI+OJKO7VuvlEDj/aPd3bZAexndKWivptO/xeLBD7J/JCOubjicjaVNWXLQ5
         H6fB+0YsEx63uc5TiCs20sSEjZ3JxRWkjZHG3LQbatv3J9k4pmh0VpqAg7R562nbzzly
         s71ebLgHH+wdbZuHYfqIuXfOS4H3wCLtxZ6Rqc556hBiF9jLddR68NJcthdMi5JsNo9F
         fUAZvFHEDsznNwsCMgykOwv5P0YMuteT/vvRsXd6nvRv9Clc/Ic3a7YeuRAtFe+vPCu7
         EZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192601; x=1690797401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am2eIoStEhYj6reS+R983QZxh6h3W0xYr71gNNToCQ8=;
        b=K4bD7xoPAOq7Yt8/umoQVG6xRdzk7EYE7iyuCpV3BA7n9ue8vXlXeoPzX5G0gwmmBZ
         gkTiBcnUp4ny3+66ALdyEYizB/S8gLkO+zloz64uyVPJVFgFSHJE9ch3Cx/19baINYof
         O6hOPqM5rOjQ5ciBKDAhduCrCPZCqgvm1or+721GndyDil4lKoAcbmGvwb12qPk5JNv0
         12Eh4HrL72zD8ctx/fVHY6U+kTOO4z8NXj0X10IgB9D3RREnHUNXJTpe48lGRChXnb/8
         WCSghXp0AkQ77dicl1V7MwN3OlBH9zZILWbhLLKonrc+btsL7wngKnUpP4/NEdUD4r+A
         RI0A==
X-Gm-Message-State: ABy/qLaSlwp0+YgOnsYtlQQQFJzaokBE/6llTyWMr550oSRHqiW0dGmF
        YUcD9sNMeWzB7PRzWFDtbdgfiw==
X-Google-Smtp-Source: APBJJlEtnCzvJ6I1rkWEELadVXHfZtUE/plpWIuGp/MFKpOvTS509ssN84iHDxA1POdeL3+D21rKQg==
X-Received: by 2002:a05:6a20:8e04:b0:137:3941:17b3 with SMTP id y4-20020a056a208e0400b00137394117b3mr14532126pzj.6.1690192601020;
        Mon, 24 Jul 2023 02:56:41 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b00682aac1e2b8sm7356787pfn.60.2023.07.24.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:56:40 -0700 (PDT)
Message-ID: <7b4eb3fa-1ebd-de07-1a16-9533b069a66e@bytedance.com>
Date:   Mon, 24 Jul 2023 17:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/47] binder: dynamically allocate the android-binder
 shrinker
Content-Language: en-US
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-6-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230724094354.90817-6-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


This patch depends on the patch: 
https://lore.kernel.org/lkml/20230625154937.64316-1-qi.zheng@linux.dev/

