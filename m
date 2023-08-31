Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0678F094
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjHaPvJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 11:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHaPvJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 11:51:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBB1A3;
        Thu, 31 Aug 2023 08:51:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a41035828so742289b3a.1;
        Thu, 31 Aug 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693497065; x=1694101865; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdwr7+BCtSdvPxCRL9mZngIpfkQTZa7hs6/YpPSAEPw=;
        b=j7KOoGOpw+4VmMjrRZnd8u98Qmp/Bm4CQjc0hCHZTG+OqjUR9EmRdpXW+3JM1jumxn
         eBmBL3vEVMzEce/6gKjhHjX66WUJABmeKg50oeuzlqwhyN9JLqJg44ik8Ojqj1M4ws8G
         h4gQxx+slHntGrEnTlEnAVRng4VJFnKRiNizJ/Woc6HZUemviaQS5RHTNNKZj2EZ8uIw
         kIv5zt9R0y6cha619HkS/ao+ViPXpCLmpzBzHYXatXhy+lqoxV3g1t1GYKfDrx9ir40R
         lnJf0Fp6VI6fGSrkLiYUnru2LBkFZ5Gd2EcJzEbeCjsoJqruTqqwIovgoTflMOEwaWOf
         7onQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693497065; x=1694101865;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qdwr7+BCtSdvPxCRL9mZngIpfkQTZa7hs6/YpPSAEPw=;
        b=hJwa2Je2KFGJhVLAcfz2sNePniypLLfDe5HWv9PLHViCcBNnSzic00zuYqPBPl/MDj
         ePOpU/SqeQJwAWb0pYwCRM1xJpN/G0lYDJI3+N+u2qjShJ1rK8VRl5VF36QBVb+TIFbV
         BkrPsfMyb6NyWbdHsBkBZcdU/duVdoVcWg5THed7gTfnDLlDJa2rbfYi8lvQ591odEk3
         LZmjR3pu5NqtLPqwgzOlxD05pdbxaEkIRNQMqx2abdjoKpY9X/liY7TKwCU1bFoHVlHj
         YVETBQ/pb60lcIok6+7aAagOAFqlp45MnSaUoPkozWsQSFINKUMa+lygPODqSkZYh+zb
         ms2A==
X-Gm-Message-State: AOJu0YwwmhgHdod6FEAaAiuhsC8hqyKYr8dB5nQCzLzm0nTAABT6/ij0
        vgM/ZEtgnQve4OXqRHIllnQ1XCglTCQ=
X-Google-Smtp-Source: AGHT+IHAnG1X05ZxWJzTarPOu0+Ao3hB2xzUp8JPnRbWaQZ37RL503J/dls6Jzb1Du5IMvSCYLsVBw==
X-Received: by 2002:a05:6a20:158e:b0:13e:9dba:ea52 with SMTP id h14-20020a056a20158e00b0013e9dbaea52mr88481pzj.13.1693497065432;
        Thu, 31 Aug 2023 08:51:05 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b0063f00898245sm1521520pfo.146.2023.08.31.08.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:51:04 -0700 (PDT)
Date:   Thu, 31 Aug 2023 21:21:00 +0530
Message-Id: <87edjj8b2z.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/11] ext4: extent ext4_mb_mark_context to support allocation under journal
In-Reply-To: <20230826155028.4019470-4-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

commit: extent ext4_mb_mark_context to support allocation under journal
        ^^^ extend

> Previously, ext4_mb_mark_context is only called under fast commit
> replay path, so there is no valid handle when we update block bitmap
> and group descriptor. This patch try to extent ext4_mb_mark_context

                                          ^^^^ extend

> to be used by code under journal. There are several improves:
                                                       ^^^ improvement:            
> 1. add "handle_t *handle" to struct ext4_mark_context to accept handle
> to journal block bitmap and group descriptor update inside
> ext4_mb_mark_context (the added journal caode is based on journal
                                          ^^^ code
                            (we can remove the next "journal code in")

> code in ext4_mb_mark_diskspace_used where ext4_mb_mark_context
> is going to be used.)
> 2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
> bitmap are already marked as allocation code under journal asserts that
> all bits to be changed are not marked before.
> 3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
> of bits in block bitmap has changed.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

The patch functionally looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


-ritesh
