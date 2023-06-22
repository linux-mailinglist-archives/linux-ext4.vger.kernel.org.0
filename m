Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FACE7399CC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jun 2023 10:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFVIcX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jun 2023 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFVIcR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jun 2023 04:32:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ACA1FEE
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jun 2023 01:31:43 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1aa25c5cf0eso1108875fac.1
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jun 2023 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687422703; x=1690014703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRx5u0dIx9qFXm7I93dXe9q/QmQ9W+wUToPS3aLpk1M=;
        b=BLxeO0dy+qXx3mtPibK1S1/Or5zgBKyR+cJ+WdJudKlQtS/Nsabue7QFfygOG9X37C
         JNC/knOS3tjYOQOseW33zi2F030DsgTWZcCvwE6mko6OoqIenxumjcv5Z8/rnxAjBO3/
         xtucKEfCtZqg/VNDj8oOitF8gRCgoGC+eaFgizTMA41zH3SGC3RP8SzsV7WNcZX8qR+q
         6s7WskcQisgXsEcLIkuFshZF5uF8hpqRK404CDzKPS3hFNRImlWGDWKvxDEmNrhw0M34
         cglWSueSHGyZNjK3S6DZy/VJBgyCTc7gX8Qm2fkIbSjNxChukxDTKOPYSzno2UgfFI9l
         y7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422703; x=1690014703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRx5u0dIx9qFXm7I93dXe9q/QmQ9W+wUToPS3aLpk1M=;
        b=PoufvOyvQpd2Cle72Ew21mVh0WWhdmB4R7Zuk/2mYzhvLYdNYWfdLLaA89TgjYw4DL
         rpUZuJYKlC9rhKbrQoKr77EAGrqhLYkRRd+YlDcf1wSiB+ovEkzqVUlqGJl52Us7XOtm
         Md5ZcNqLAMIgQvtIh0h7eW/W/POnIo5BTDAIJNcv47uDXCazFqYoeq4AOa2bV+n62Cnb
         FDZb/f/ZEM4TgLyecir1Yn+bvwSZTowKAiKuQ7Ln7K7aS6PjC2CEzEX4k6H8WlmSDTqM
         ybdyxGXXBaC63iZ3AnuYhuTunaj9qFIR1STrAPvd/++GaKX+Bqi4Tb2OTpSCyAgzobzj
         EscA==
X-Gm-Message-State: AC+VfDzSr+KC+enOSJQRF0EyYoEKappEf5Jh8EF6fmfIKlAyGpNhgQ+P
        GsJmL5R912jnLOM6U/FHZHV0wg==
X-Google-Smtp-Source: ACHHUZ4rJo+IPtTRaPya+U1JdMgc+u3gA3krnJKF3F08hxGt0uoHrxZAqg1izlNZ+SOIkOa4AMphOQ==
X-Received: by 2002:a05:6830:19c1:b0:6b1:6db4:556f with SMTP id p1-20020a05683019c100b006b16db4556fmr10609999otp.3.1687422702698;
        Thu, 22 Jun 2023 01:31:42 -0700 (PDT)
Received: from [10.4.168.167] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y17-20020a63e251000000b0050a0227a4bcsm4369684pgj.57.2023.06.22.01.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:31:42 -0700 (PDT)
Message-ID: <52bf599c-3c3a-7dfc-30b3-f3a2af5f29a8@bytedance.com>
Date:   Thu, 22 Jun 2023 16:31:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] [PATCH 00/29] use refcount+RCU method to implement
 lockless slab shrink
To:     Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
        david@fromorbit.com, tkhai@ya.ru, vbabka@suse.cz,
        roman.gushchin@linux.dev, djwong@kernel.org, brauner@kernel.org,
        paulmck@kernel.org, tytso@mit.edu
Cc:     airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, marijn.suijten@somainline.org, robh@kernel.org,
        tomeu.vizoso@collabora.com, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org, colyli@suse.de,
        kent.overstreet@gmail.com, namit@vmware.com,
        gregkh@linuxfoundation.org, mst@redhat.com, david@redhat.com,
        jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca, jack@suse.com,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        minchan@kernel.org, senozhatsky@chromium.org, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, christian.koenig@amd.com,
        ray.huang@amd.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20230622082454.4090236-1-qi.zheng@linux.dev>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230622082454.4090236-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch set failed to send due to the following reasons, please ignore.

	4.7.1 Error: too many recipients from 49.7.199.65
