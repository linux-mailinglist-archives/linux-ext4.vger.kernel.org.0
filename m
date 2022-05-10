Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED15226DB
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiEJW2t (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiEJW2m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 18:28:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7852B3B
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 15:28:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so2769277pjb.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from:cc
         :subject:content-transfer-encoding;
        bh=wfPHY8O5lpAXCbOKekK8DfHBJ0WH0D1/nUeEmSt+v20=;
        b=z5+JwAqr5bItL7ZbzMQ0W/I1TkosIfL+BkwL9FvGWgGcgnRvYA+kho8sI0uuZtmw9h
         U1Dp4jz+YgVu4PrYB6U/nDairICKgp5B3qMmk4w3AIJYGHOkX5tlgWDKpwGZyxYoKYB0
         XZXHciGVY9/EeycnNPX2f4n+VkHfUs1chM6hTUDjM3QqUDSrsWrez0WBPQByjRJrNP1b
         A9E2gxwFAUVTDsGl6T68iL/kwe4ATYBVTcC5s3wdF/bNNmBVS/+md+OJ5frlqd8BEuI5
         BCffEznNIWLl1pF7aD9F170mFMM4IscmjQ5D2GAw310i2gP8cQIDyWCjVZ+X9hASxRcM
         V8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:cc:subject:content-transfer-encoding;
        bh=wfPHY8O5lpAXCbOKekK8DfHBJ0WH0D1/nUeEmSt+v20=;
        b=rWmg/q4pja3gAodmKvBO+CxG/yeiBZxbRebWDvK8pExE/IvBmJIu53JnwAvh9d/po6
         cfFxl8fBqk47I4CbibhziIYcp3gyRqklDuUGHuvvTaUdmUr6el5OW2Qg+ahnpAhirHkY
         K/fnMAeBQ5seNnCYebtOlhN66n0EDkVIvLPBVxJOXzMYwghOJQg/KWaMYkvdmAZs1wq9
         s8pDAbxZNik0MSs20ZV5PqTUoLIY9464aK3v0DMZR3LEvxRI7o2fwu7DCm4XSIyU6D5C
         iRHCdM3TCwe+jpWrcsfmdCEpU/h/pUE+gYB5SJQ4yxlCC6XBedd09HMfx9Z+As6Lq/5d
         zc8A==
X-Gm-Message-State: AOAM533x93eNpAEYnQOfSKv6rbr2XBy7R9z9bajwLPyeKs+q2pty/HQ2
        s6eOWNMkAHkCJZ8t4Qm53vksX9IORt2/CQ==
X-Google-Smtp-Source: ABdhPJxIlNn2Wj+2MuilRsO5BYUSZc7ybzcGHgfGbJI6n2IvJXDB35OlIpH+/GbDFCpAVdmq0z7RPA==
X-Received: by 2002:a17:90a:8914:b0:1dc:20c0:40f4 with SMTP id u20-20020a17090a891400b001dc20c040f4mr2016927pjn.11.1652221719446;
        Tue, 10 May 2022 15:28:39 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b001dcc0cb262asm197584pjb.17.2022.05.10.15.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:28:38 -0700 (PDT)
Message-ID: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
Date:   Tue, 10 May 2022 15:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-ext4@vger.kernel.org
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: kernel BUG in ext4_writepages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,
Syzbot found another BUG in ext4_writepages [1].
This time it complains about inode with inline data.
C reproducer can be found here [2]
I was able to trigger it on 5.18.0-rc6

[1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000

-- 
Thanks,
Tadeusz
