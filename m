Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1556C757C4D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGRM4i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGRM4h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 08:56:37 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B4188;
        Tue, 18 Jul 2023 05:56:36 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-579dd20b1c8so54897237b3.1;
        Tue, 18 Jul 2023 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684995; x=1692276995;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a+0X0iJnqmGwLeZZKHvvTwxTTecPY5lyxNZQeh8dZFg=;
        b=hHDnz9GZY3LbhcWhRmlM9JlzfhIK4dF9EukEMjKsJeBsjHumsWBQHWfgm32KZbUETq
         rAhsK1Hle/ygFwxyHxlBXRLC/M36rAkGU1Z+hEjI8aZniAiQPsB4tOfjo3B8U5sO1hnZ
         gHyqZiSYhekBWbM1B1nyIuMhXyIc8X8RGxROx65S1POnb9oDFV6/vTs1FV94sOhgNg+i
         V+baPhFCkRxFHyVX2dk+CnxzLPohwNsErlpff9ivGVp1R2Izl7ObfN83ApIMSuIvTtoY
         Ggl/EVVnTKasoOH3MKTtpBV4llo5rHVHqnTV/daaBzGIGASIs6I1g/HGiqY+zS95Xsm1
         0PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684995; x=1692276995;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+0X0iJnqmGwLeZZKHvvTwxTTecPY5lyxNZQeh8dZFg=;
        b=Y03WAxCA1XX0+c4RxcqwtXAIc+bZF/9gQg42SzdhyQFmZ5gAfmGGXm2KlRQDRH2aUY
         vrdh4woGsAbguATjm80hOxx9GHP/pPd1EoFVUcYMbp354BLFGSZr7/PHaKGLfGUjnXvi
         1vjLJXsQFYbDjS1GRr/0C+pTVfEz8J5Y7SFtOeQvhq1F/MwrJgH9/9KmtrQ7J/vaHxmh
         gruQk5XGpECTUqldRo1F4mpvLeJictc3qFB7cMJrDq0gMqeXdyfZDP/jzkvBFcyzGC8p
         DweLfWMMPOxhYQNUioXfHV/YRJ17gWhADw3cjwFVqMlvS+lzLMFck3XhUcOR4HmU2fCs
         ZcSA==
X-Gm-Message-State: ABy/qLY+VfhZbSvctaoaALjdJIUDvE8i1KgGKKqs5BbT9XwZde70qp8I
        5Ca8crO1nI7UMhf2pSN52neCw/uZ7PtsTdxbn/WIJnwb7qQ=
X-Google-Smtp-Source: APBJJlGBp+5JYQ8bOuozx4yrJygeTAY50dwDQ7E9NrZdK+2yi1qtbmKH5Xu3Zq/ewQusx/ZrAy3f/VB59CoVOidMQKU=
X-Received: by 2002:a0d:c804:0:b0:577:3561:8a81 with SMTP id
 k4-20020a0dc804000000b0057735618a81mr15404153ywd.22.1689684995262; Tue, 18
 Jul 2023 05:56:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7886:b0:31a:16:342c with HTTP; Tue, 18 Jul 2023
 05:56:34 -0700 (PDT)
In-Reply-To: <20230718053017.GB6042@tomerius.de>
References: <20230717075035.GA9549@tomerius.de> <CAG4Y6eTU=WsTaSowjkKT-snuvZwqWqnH3cdgGoCkToH02qEkgg@mail.gmail.com>
 <20230718053017.GB6042@tomerius.de>
From:   "Alan C. Assis" <acassis@gmail.com>
Date:   Tue, 18 Jul 2023 09:56:34 -0300
Message-ID: <CAG4Y6eQX8wE6ErByZmWFN+a_ekR09q8NzP+jJyEey4Ficqdosg@mail.gmail.com>
Subject: Re: File system robustness
To:     Kai Tomerius <kai@tomerius.de>
Cc:     linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Kai,

I never used that, but please take a look at F2FS too.

BR,

Alan

On 7/18/23, Kai Tomerius <kai@tomerius.de> wrote:
> Hi Alan,
>
> thx a lot.
>
> I should have mentioned that I'll have a large NAND flash, so ext4
> might still be the file system of choice. The other ones you mentioned
> are interesting to consider, but seem to be more fitting for a smaller
> NOR flash.
>
> Regards
> Kai
>
>
>
> On Mon, Jul 17, 2023 at 10:50:50AM -0300, Alan C. Assis wrote:
>> Hi Kai,
>>
>> On 7/17/23, Kai Tomerius <kai@tomerius.de> wrote:
>> > Hi,
>> >
>> > let's suppose an embedded system with a read-only squashfs root file
>> > system, and a writable ext4 data partition with data=journal.
>> > Furthermore, the data partition shall be protected with dm-integrity.
>> >
>> > Normally, I'd umount the data partition while shutting down the
>> > system. There might be cases though where power is cut. In such a
>> > case, there'll be ext4 recoveries, which is ok.
>> >
>> > How robust would such a setup be? Are there chances that the ext4
>> > requires a fsck? What might happen if fsck is not run, ever? Is there
>> > a chance that the data partition can't be mounted at all? How often
>> > might that happen?
>> >
>>
>> Please take a look at this document:
>>
>> https://elinux.org/images/0/02/Filesystem_Considerations_for_Embedded_Devices.pdf
>>
>> In general EXT4 is fine, but it has some limitation, more info here:
>> https://opensource.com/article/18/4/ext4-filesystem
>>
>> I think Linux users suffer from the same problem we have with NuttX (a
>> Linux-like RTOS): which FS to use?
>>
>> So for deep embedded systems running NuttX I follow this logic:
>>
>> I need better performance and wear leveling, but I don't need to worry
>> about power loss: I choose SmartFS
>>
>> I need good performance, wear leveling and some power loss protection:
>> SPIFFS
>>
>> I need good performance, wear leveling and good protection for
>> frequent power loss: LittleFS
>>
>> In a NuttShell: There is no FS that 100% meets all user needs, select
>> the FS that meets your core needs and do lots of field testing to
>> confirm it works as expected.
>>
>> BR,
>>
>> Alan
>
