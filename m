Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007E678EF9E
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 16:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjHaOfn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbjHaOfn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 10:35:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCAB1B1;
        Thu, 31 Aug 2023 07:35:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68bed2c786eso722284b3a.0;
        Thu, 31 Aug 2023 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693492539; x=1694097339; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCVGuZJFjGiSusw+0qmRf+39DSazJywnKT4fxkeSTLY=;
        b=C/fhDC9mYzKffPhao0DkeBozqPz490JRj5oupFdxuD3k7YCklre7EzfXF+ibl8nJKn
         r5x2q27c50P+ls2O1vviLq/JCwARB1yh1qjooLVAI+qVZwzIe8BcAWIA32QGcNRw4jK8
         o0vZsWF5lTOe4R4+1g4cTCRAObQ6+jAWw+uAi5c9cRCi8uEOWd/+psFEOTUO3DidXKEm
         aFNr8pEHvsARgIlNF/IMJByxDjyabrLOYwpEbOHGfZlFXVS7sXbSVNOEyBI30eHktwst
         RITr/RVRHOeOySAIpkWmqQMQg+87sYb784pOMa8EHybX3Sl94hojClsQS0zMfFIV+49w
         7l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492539; x=1694097339;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FCVGuZJFjGiSusw+0qmRf+39DSazJywnKT4fxkeSTLY=;
        b=KDaCcWK1Hx/8p2uv0JUQ9srN8tnqKqLiqKhZKH+OTwtMdWFK+D4f5NUvMwgFAvGM8q
         H8hq+qrLZNWjN3LlxCH9Jg02iHjF0K3Ve0GUL6OWohalC0MSzLYiRyH5mMAKBQ763oak
         A5KcrPoQS2PomkwZgsoJJkZ8uGfsNW9IqtPsshNB4euwl7+4j4R6qPw8oEHDDBmXlV7k
         PaEs3ue4yxwtMbuDd6Bbpud/1cxZunLdj/nxBCm9rmtrJKSe9aoYNHsnWKnzQX8RICGN
         sq+5UvWkYQqfHSO8sVT/qxstfKIU0Euo58iJpR9FuAV9zv+P7WEBEfZhR0y1igYk93oq
         Ruew==
X-Gm-Message-State: AOJu0Yw/42uuCDBmi1NOLndHJ1a0MwENg622af3XlbubpTmjjxp1TbXV
        zmt8VJzROFNT90HodBugTuluNtweH2E=
X-Google-Smtp-Source: AGHT+IGJ4yZQKVl5a7y8dwUaviX74mCrEAmaMyeZi9ERxuWVUkuKPmXiWVQZyA5TX38a0/mZJnYbrg==
X-Received: by 2002:a05:6a00:218a:b0:68c:70f:ee3f with SMTP id h10-20020a056a00218a00b0068c070fee3fmr6103526pfi.13.1693492539534;
        Thu, 31 Aug 2023 07:35:39 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b0068aca503b9fsm1395446pff.114.2023.08.31.07.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:35:38 -0700 (PDT)
Date:   Thu, 31 Aug 2023 20:05:35 +0530
Message-Id: <87h6of8eko.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/11] cleanups and unit test for mballoc
In-Reply-To: <c92574b5-1441-645c-4824-723545e45845@huaweicloud.com>
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

> on 8/30/2023 3:02 AM, Ritesh Harjani wrote:
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>> 
>>> v5-v6:
>>>
>> 
>> Hi Kemeng,
>> 
>> Sorry for the delay in getting started on this. I am going through the
>> series now.
>> 
>>> 1. Separate block bitmap and buddy bitmap freeing in individual patch
>>> and rewrite the descriptions.
>>> 2. Remove #ifdef around KUNIT_STATIC_STUB_REDIRECT which should be
>>> only defined when CONFIG_KUNIT is enabled after fix [7] which was merged
>>> into kunit-next/kunit
> Hi ritesh, thanks for feedback. I think the compilation problem below is
> relevant to this change which relie on fix [7]. I'm not sure if I need to
> include fix [7] in this set to fix the compilation error. Would like to
> hear any advise!
>

No, we need not include [7] in this series. I should have noticed that
in your above updates. I generally also provide a separate note or at
the top section about which branch and/or changes are requried for
testing the patch series, hence I overlooked it.

Thanks for pointing out.

-ritesh
