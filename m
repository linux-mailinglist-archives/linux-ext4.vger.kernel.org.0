Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181FB51DDAE
	for <lists+linux-ext4@lfdr.de>; Fri,  6 May 2022 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbiEFQkM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 May 2022 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349059AbiEFQkL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 May 2022 12:40:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3701FCE5
        for <linux-ext4@vger.kernel.org>; Fri,  6 May 2022 09:36:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id be20so9290055edb.12
        for <linux-ext4@vger.kernel.org>; Fri, 06 May 2022 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=QWAAaJxX8jRrJ0apu1RrbeiF3PM7RTRlGZm09fboSIjZhBVEZg7iiKvx4WRVQoQpHL
         rTCGqxXHn4HNXYtRFS7ir15BypF74UncZt9C6eCJlr0C/emJrimIXG8iMtWQD4mk7oWB
         nwk2iCUojoZeOPnrXg64q0hHLUBL5Tf/K8Rwk0oxPWPy5Dpz5cxeUrlGfsLm6gJ7fRgG
         3qvff3o7vAEVXrQlG6xWHDH0XxQLuEUXfRQu715wJj+RoW+YKqs6nVqd8OFayfH2jk0g
         FMxRQcxo9zG95WPhcc1KtQg0JuzowbTEYDFuEw5MC2UOolDsJLH1CadcUVY6xwsf/KOU
         q9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=r78V2PbSKXzQjvCpvUQUXAZzWIghyUZodFoB8Z8nn9mlonpWJqHIKPDmBujJq0EFHi
         mqy0owmHLHNZjyPD6akZDgb9xJdmcfLus+ZrhHWfG7V57dufAkWawvxRt0cGvLS/tIoQ
         8xBLlcolpU6+9K5Lie2ORbh7pEpA89X2viYVn6sQ/8/dCx0HWFl0GOZ6TzzUH3JT+U1j
         9cBlxoo++zdP/bqjSSLj2VyVd9EBY69kYm6625QBazuZ1U+hBBCWLeDB5rn9eiKSxG3q
         PU1pgar8GNJ4zB8lCyHN1sfQRPRYszHHE/DlBjz71keb5HxloJhf/VrSLCeV3ZOzBJuZ
         fAlQ==
X-Gm-Message-State: AOAM530YGG49OwXv9cWZjVN09K4rsDjuGv32UdtYDpv8IHKHW7Vievff
        SXM//e2iPGpaL6CRTdBze2rksqUr91XNAOYv8H4=
X-Google-Smtp-Source: ABdhPJw5oMM7Y2J3W/SQaquaa8Qxe3pgK7cB78z1ZbG1bxGdvVNh/Xrf1vxnXdap4px6rI5awExeVk/sADAUmVyO1FM=
X-Received: by 2002:a05:6402:1583:b0:425:de1e:d0ed with SMTP id
 c3-20020a056402158300b00425de1ed0edmr4314564edv.385.1651854986515; Fri, 06
 May 2022 09:36:26 -0700 (PDT)
MIME-Version: 1.0
Sender: amoudiatchakoura@gmail.com
Received: by 2002:ab4:a56a:0:0:0:0:0 with HTTP; Fri, 6 May 2022 09:36:26 -0700 (PDT)
From:   "Capt.Sherri" <sherrigallagher409@gmail.com>
Date:   Fri, 6 May 2022 16:36:26 +0000
X-Google-Sender-Auth: CATBu4_Zo1pyPO2p4JNKfODRjsU
Message-ID: <CAGZPmGHvCh3UQBWU6rU0H=_MNLWus--oPKJe2XNDqQjmatrBzA@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
