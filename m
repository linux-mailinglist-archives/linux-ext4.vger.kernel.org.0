Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAFC64F8BB
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Dec 2022 11:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQKoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Dec 2022 05:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQKoV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Dec 2022 05:44:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3895101DC
        for <linux-ext4@vger.kernel.org>; Sat, 17 Dec 2022 02:44:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so7188812lfb.1
        for <linux-ext4@vger.kernel.org>; Sat, 17 Dec 2022 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=Coinlc8Gx9sElaqeejBlx239SWzWBt2L0JyObo+oj8zD8XGXHezMkHnqfv2zn2KBWb
         3Bg4/Cpjs51qZYeqqSwGQ0XWqvQpXCM83CC8cpidqeo1TCg557gemSthz9ABlUf8HDFf
         elCfCZZsmlO2VPg9b6pqA2c/D4GfEa46743Kz1MWPOxZ26jc2ttkoaDPzu9Vrj/tnMQh
         LXkHucQPuWbq9xEsNocW//oB/gmJSdZnY070f5022jxUzez0GT6UMRtia/Nj8EjRWOWj
         /73lPajKP2LKOEY7IWh/Dz4OzetCpki4Kc34ry8R/I51hdbw02P+8m9cl02kzTzLUG1P
         Ij2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAVMql90nO7ZkFcVgMNu6fVpAbtsWgSiB+5IHPtWWmc=;
        b=BUC/YfxCZqCk3mn1xILGyt0JtU2YH9JEHeClbS1tAPeVx0WJT9fMRh/nsXXSEPl/rX
         09xCco3LWFZ4Cz3zpK8qlgETHDpoFyoFgStJ420BcSGPfwKK6+Br/VQo2i4dXpqQqNUS
         wMlm7BdXXZAN+5ZhNF5WqicDs1DpTxOxCbvunaKvltmSOFw6VaqOtC6eG77MKxeJj8S0
         z+LPVIbCJ18Ud3SyG4q3YTBWG7QeLmDVSxaUM6VYZ17tElrQQ/Cp5YxhBZMSWIci/2Nk
         DRqjB7qF7on7nIp30EspM80bB3JEaaXDkKG6MN+nsBl86kcr+Ucy23IPg4PEPZ+SjrOS
         zoOA==
X-Gm-Message-State: ANoB5pky2lxLdkvDHTGSCB4/z4a7bd2XF9MBSxazh9PpftuwQm/RKv+a
        5yMr3W1NjMRu5YsOGDpNe+Bne5Hl4Z8OgSSNvug=
X-Google-Smtp-Source: AA0mqf4F4oDhNdQ7jw5xPO68GnI6zSEc7HjVN3xrqhOhXQ2SS20RYg2GMblDqDyCwd29jLgBkptSq43WpQgHtqY91zU=
X-Received: by 2002:a05:6512:1093:b0:4b5:5a59:2036 with SMTP id
 j19-20020a056512109300b004b55a592036mr11616744lfg.235.1671273857682; Sat, 17
 Dec 2022 02:44:17 -0800 (PST)
MIME-Version: 1.0
Sender: mrsohallatif20@gmail.com
Received: by 2002:a2e:b614:0:0:0:0:0 with HTTP; Sat, 17 Dec 2022 02:44:17
 -0800 (PST)
From:   H mimi m <mimih6474@gmail.com>
Date:   Sat, 17 Dec 2022 10:44:17 +0000
X-Google-Sender-Auth: XFR_pRD4wtkvp7Orcv6Ch2hPeDc
Message-ID: <CAP+WkJZWg_KB6gJqFznsMPvTu5x3--yiLFmjumnESzwMiw5NoQ@mail.gmail.com>
Subject: REPLY ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

i am Mrs Mimi Hassan Abdul Mohammad and i was diagnosed with cancer
about 2 years
ago,before i go for a surgery  i  have to do this,so  If you are
interested to use the sum of US17.3Million)to help Poor,
Less-privileged and  ORPHANAGES and invest  in your country, get back
to me for more information on how you can  contact the COMPANY in
Ouagadougou Burkina Faso). for where the fund is
Warm Regards,
Mrs Mimi Hassan Abdul Mohammad
